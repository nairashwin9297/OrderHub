import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useNavigate, useParams } from 'react-router-dom';
import { Container, Row, Col, Card, Table } from 'react-bootstrap';
import backgroundImage from './images/food.jpeg';

const Restaurant = () => {
    const navigate = useNavigate();
    const { customerID } = useParams();
    const [restaurants, setRestaurants] = useState([]);
    const [orderHistory, setOrderHistory] = useState(null);

    useEffect(() => {
        const fetchRestaurants = async () => {
            try {
                const response = await axios.get('http://localhost:3000/api/restaurants');
                setRestaurants(response.data);
            } catch (error) {
                console.error('Error fetching restaurants:', error);
            }
        };
        fetchRestaurants();

        fetchOrderHistory(); // Fetch order history when component mounts
    }, []);

    const fetchOrderHistory = async () => {
        try {
            const response = await axios.get(`http://localhost:3000/api/getOrderHistory/${customerID}`);
            if (response.data.length > 0) {
                setOrderHistory(response.data);
            }
        } catch (error) {
            console.error('Error fetching order history:', error);
        }
    };

    const handleRestaurantClick = (restaurantId) => {
        navigate(`/menu/${customerID}/${restaurantId}`);
    };

    return (
        <Container fluid style={{
            minHeight: '100vh',
            backgroundImage: `url(${backgroundImage})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            backgroundRepeat: 'no-repeat'
        }}>
            <h2 className="my-4 text-center" style={{ color: 'white' }}>Explore Restaurants</h2>
            <Row xs={1} md={2} lg={3} className="g-4">
                {restaurants.map((restaurant, index) => (
                    <Col key={index}>
                        <Card className="custom-card" onClick={() => handleRestaurantClick(restaurant.RestaurantID)} style={{ backgroundColor: 'rgba(255, 255, 255, 0.8)' }}>
                            <Card.Body>
                                <Card.Title className="text-primary">{restaurant.RestaurantName}</Card.Title>
                                <Card.Text><strong>Contact No:</strong> {restaurant.RestaurantContactNo}</Card.Text>
                                <Card.Text><strong>Address:</strong> {restaurant.RestaurantStreet}, {restaurant.RestaurantCity}, {restaurant.RestaurantState} - {restaurant.RestaurantZipCode}</Card.Text>
                                <Card.Text><strong>Type:</strong> {restaurant.RestaurantType}</Card.Text>
                                <Card.Text><strong>Is Open:</strong> {restaurant.IsOpen}</Card.Text>
                                {/* Additional fields from RestaurantOrderSummary */}
                                <Card.Text><strong>Total Orders:</strong> {restaurant.TotalOrders}</Card.Text>
                                <Card.Text><strong>Total Revenue:</strong> ${restaurant.TotalRevenue?.toFixed(2)}</Card.Text>
                                <Card.Text><strong>Average Order Value:</strong> ${restaurant.AverageOrderValue?.toFixed(2)}</Card.Text>
                            </Card.Body>
                        </Card>
                    </Col>
                ))}
            </Row>
            {orderHistory && (
                <Container className="mt-4">
                    <h2 className="text-center">Order History</h2>
                    <Table striped bordered hover>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Restaurant Name</th>
                                <th>Order Date</th>
                                <th>Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            {orderHistory.map(order => (
                                <tr key={order.CustomerOrderID}>
                                    <td>{order.CustomerOrderID}</td>
                                    <td>{order.RestaurantName}</td>
                                    <td>{order.OrderDate}</td>
                                    <td>${order.TotalPrice?.toFixed(2)}</td>
                                </tr>
                            ))}
                        </tbody>
                    </Table>
                </Container>
            )}
        </Container>
    );
};

export default Restaurant;
