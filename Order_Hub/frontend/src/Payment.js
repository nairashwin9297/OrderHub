import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';  // Import useNavigate
import { Container, Form, Button, Toast, Row, Col } from 'react-bootstrap';
import backgroundImage from './images/payment.jpeg';

const Payment = () => {
    const { customerOrderID } = useParams();
    const navigate = useNavigate();  // Initialize navigate function
    const [totalPrice, setTotalPrice] = useState(0);
    const [typeOfPayment, setTypeOfPayment] = useState('');
    const [showToast, setShowToast] = useState(false);
    const [invoice, setInvoice] = useState(null);

    useEffect(() => {
        const fetchTotalPrice = async () => {
            try {
                const response = await axios.get(`http://localhost:3000/api/getTotalPrice/${customerOrderID}`);
                if (response.data.success) {
                    setTotalPrice(response.data.totalPrice);
                }
            } catch (error) {
                console.error('Error fetching total price:', error);
            }
        };

        fetchTotalPrice();
    }, [customerOrderID]);

    const handlePayment = async () => {
        try {
            const paymentResponse = await axios.post('http://localhost:3000/api/processPayment', {
                customerOrderID,
                typeOfPayment,
                paymentAmount: totalPrice
            });
            if (paymentResponse.data.success) {
                fetchInvoice();  // Fetch the invoice after successful payment
                setTimeout(() => {
                    navigate(-2);  // Navigate back two screens after 10 seconds
                }, 10000);
            }
        } catch (error) {
            console.error('Error processing payment:', error);
        }
    };

    const fetchInvoice = async () => {
        try {
            const invoiceResponse = await axios.get(`http://localhost:3000/api/generateInvoice/${customerOrderID}`);
            if (invoiceResponse.data.success) {
                setInvoice(invoiceResponse.data.invoice);
                setShowToast(true);  // Show the toast after fetching the invoice
            } else {
                console.error('Failed to fetch invoice');
            }
        } catch (error) {
            console.error('Error fetching invoice:', error);
        }
    };

    return (
        <Container className="d-flex justify-content-center align-items-center" style={{
            minHeight: '100vh', 
            backgroundImage: `url(${backgroundImage})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center center'
        }}>
            <div className="payment-card shadow-lg p-4 bg-white rounded" style={{ width: '100%', maxWidth: '600px' }}>
                <Row>
                    <Col>
                        <h1 className="mb-4 text-center" style={{ color: '#4A90E2' }}>Process Payment</h1>
                        <h3 className="mb-3 text-center" style={{ color: '#5C6166' }}>Total to Pay: ${totalPrice.toFixed(2)}</h3>
                        <Form>
                            <Form.Group controlId="paymentType">
                                <Form.Label>Select Payment Type:</Form.Label>
                                <Form.Control as="select" value={typeOfPayment} onChange={e => setTypeOfPayment(e.target.value)}>
                                    <option value="">Choose...</option>
                                    <option value="Credit Card">Credit Card</option>
                                    <option value="Debit Card">Debit Card</option>
                                    <option value="PayPal">PayPal</option>
                                    <option value="Apple Pay">Apple Pay</option>
                                </Form.Control>
                            </Form.Group>
                            <Button variant="primary" className="w-100 mt-4" onClick={handlePayment} disabled={!typeOfPayment}>
                                Process Payment
                            </Button>
                        </Form>
                    </Col>
                </Row>
                {showToast && (
                    <Toast
                        show={showToast}
                        onClose={() => setShowToast(false)}
                        style={{
                            position: 'fixed',
                            top: '50%',
                            left: '50%',
                            transform: 'translate(-50%, -50%)',
                            zIndex: 1050,
                            backgroundColor: '#5cb85c',
                            color: 'white',
                            maxWidth: '300px'
                        }}
                        delay={5000}
                        autohide
                    >
                        <Toast.Header closeButton={true}>
                            <strong className="me-auto">Order Confirmation</strong>
                        </Toast.Header>
                        <Toast.Body>
                            Payment successful! Expect your delicious delivery in approximately 40 minutes.
                            {invoice && (
                                <div>
                                    <p><strong>Invoice Details:</strong></p>
                                    <p>Order ID: {invoice.OrderID}</p>
                                    <p>Customer Name: {invoice.CustomerName}</p>
                                    <p>Restaurant Name: {invoice.RestaurantName}</p>
                                    <p>Total Price: ${invoice.TotalPrice}</p>
                                </div>
                            )}
                        </Toast.Body>
                    </Toast>
                )}
            </div>
        </Container>
    );
};

export default Payment;
