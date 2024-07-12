import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom'; // Import useNavigate
import { Container, Card, Table, Button, Toast } from 'react-bootstrap';

const RestaurantMenu = () => {
    const { customerID, restaurantID, customerOrderID: initialCustomerOrderID } = useParams();
    const [customerOrderID, setCustomerOrderID] = useState(initialCustomerOrderID);
    const [menus, setMenus] = useState([]);
    const [cart, setCart] = useState([]);
    const [showError, setShowError] = useState(false);
    const [errorMessage, setErrorMessage] = useState('');

    const navigate = useNavigate(); 

    useEffect(() => {
        const fetchMenus = async () => {
            try {
                const response = await axios.get(`http://localhost:3000/api/restaurants/${restaurantID}/menus`);
                setMenus(response.data);
            } catch (error) {
                console.error('Error fetching menus:', error);
            }
        };

        const fetchCartItems = async () => {
            if (customerOrderID?.length>0) {
                try {
                    const response = await axios.get(`http://localhost:3000/api/orderItems/${customerOrderID}`);
                    setCart(response.data.map(item => ({
                        ...item,
                        quantity: item.Quantity // Assuming API returns quantity as Quantity
                    })));
                } catch (error) {
                    console.error('Error fetching cart items:', error);
                }
            }
        };

        const initializeOrderIfNeeded = async () => {
            if (!customerOrderID && customerID) {
                try {
                    const response = await axios.post('http://localhost:3000/api/orders/new', {
                        customerID: parseInt(customerID),
                        restaurantID: parseInt(restaurantID)
                    });
                    setCustomerOrderID(response.data.customerOrderID);
                } catch (error) {
                    console.error('Error creating new order:', error);
                }
            }
        };

        fetchMenus();
        fetchCartItems();
        // initializeOrderIfNeeded();
    }, [restaurantID, customerID, customerOrderID]);

    // const initializeOrderIfNeeded = async () => {
    //     if (!customerOrderID && customerID) {
    //         try {
    //             const response = await axios.post('http://localhost:3000/api/orders/new', {
    //                 customerID: parseInt(customerID),
    //                 restaurantID: parseInt(restaurantID)
    //             });
    //             setCustomerOrderID(response.data.customerOrderID);
    //         } catch (error) {
    //             console.error('Error creating new order:', error);
    //         }
    //     }
    // };

    const addToCart = async (item) => {
        let localCustomerOrderID = customerOrderID;
    
        if (!localCustomerOrderID && customerID) {
            try {
                const orderResponse = await axios.post('http://localhost:3000/api/orders/new', {
                    customerID: parseInt(customerID),
                    restaurantID: parseInt(restaurantID)
                });
                if (orderResponse.data.customerOrderID) {
                    localCustomerOrderID = orderResponse.data.customerOrderID;
                    setCustomerOrderID(localCustomerOrderID); // Update state for future use
                } else {
                    console.error('No order ID returned');
                    setErrorMessage('Failed to create a new order.');
                    setShowError(true);
                    return; // Exit function if no order ID was created
                }
            } catch (error) {
                console.error('Error creating new order:', error);
                setErrorMessage('Error initializing order: ' + error.message);
                setShowError(true);
                return; // Exit function on failure
            }
        }
    
        try {
            const addItemResponse = await axios.post('http://localhost:3000/api/orderItems/add', {
                customerOrderID: parseInt(localCustomerOrderID), // Use the local variable
                menuItemsID: item.MenuItemsID,
                quantity: 1
            });
            console.log(addItemResponse.data)
            if (addItemResponse.data.success) {
                const updatedCart = [...cart];
                const index = updatedCart.findIndex(cartItem => cartItem.MenuItemsID === item.MenuItemsID);
                if (index !== -1) {
                    updatedCart[index].quantity++;
                } else {
                    updatedCart.push({ ...item, quantity: 1 });
                }
                setCart(updatedCart);
            } else {
                setErrorMessage('Cannot add item to the order.');
                setShowError(true);
            }
        } catch (error) {
            console.error('Error adding item to cart:', error);
            setErrorMessage('Cannot add items, restaurant is closed.');
            setShowError(true);
        }
    };

    const handleProceedToCheckout = () => {
        navigate(`/payment/${customerOrderID}`);
    };
    

    const removeFromCart = async (item) => {
        try {
            const response = await axios.post('http://localhost:3000/api/orderItems/remove', {
                customerOrderID: parseInt(customerOrderID),
                menuItemsID: item.MenuItemsID,
                quantity: 1 // This example assumes removing one item at a time; adjust if necessary.
            });

            if (response.data.success) {
                const updatedCart = [...cart].filter(cartItem => cartItem.MenuItemsID !== item.MenuItemsID || cartItem.quantity > 1);
                if (updatedCart.some(cartItem => cartItem.MenuItemsID === item.MenuItemsID)) {
                    const index = updatedCart.findIndex(cartItem => cartItem.MenuItemsID === item.MenuItemsID);
                    updatedCart[index].quantity--;
                }
                setCart(updatedCart);
            }
        } catch (error) {
            console.error('Error removing item from cart:', error);
        }
    };

    return (
        <Container>
            <h2 className="mt-4">Restaurant Menu</h2>
            {menus.map(menu => (
                <Card key={menu.MenuID} className="mb-4">
                    <Card.Header className="bg-primary text-white">{menu.MenuType}</Card.Header>
                    <Card.Body>
                        <Table striped bordered hover responsive>
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {menu.MenuItems.map(item => (
                                    <tr key={item.MenuItemsID}>
                                        <td>{item.ItemName}</td>
                                        <td>{item.ItemDescription}</td>
                                        <td>${item.ItemPrice}</td>
                                        <td>
                                            <Button variant="primary" onClick={() => addToCart(item)}>Add to Cart</Button>
                                            <Button variant="danger" onClick={() => removeFromCart(item)}>Remove</Button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </Table>
                    </Card.Body>
                </Card>
            ))}
            {cart.length > 0 && (
                <>
                    <div>
                        <h3>Cart</h3>
                        <Table striped bordered hover responsive>
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                {cart.map(item => (
                                    <tr key={item.MenuItemsID}>
                                        <td>{item.ItemName}</td>
                                        <td>{item.quantity}</td>
                                        <td>${(item.ItemPrice * item.quantity).toFixed(2)}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </Table>
                    </div>
                    <Button variant="success" onClick={handleProceedToCheckout}>Proceed to Checkout</Button>
                </>
            )}
            <Toast show={showError} onClose={() => setShowError(false)} style={{ position: 'fixed', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', backgroundColor: 'red', color: 'white' }}>
                <Toast.Header closeButton={false}>
                    <strong className="me-auto">Error</strong>
                </Toast.Header>
                <Toast.Body>{errorMessage}</Toast.Body>
            </Toast>
        </Container>
    );
};

export default RestaurantMenu;
