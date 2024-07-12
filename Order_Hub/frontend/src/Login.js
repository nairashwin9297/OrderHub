import React, { useState } from 'react';
import { Form, Button } from 'react-bootstrap';

function Login() {
    // State and handlers remain the same
    
    return (
        <Form  className="w-25 mx-auto mt-5">
            <Form.Group controlId="formBasicEmail">
                <Form.Label>Email address</Form.Label>
                <Form.Control type="email" placeholder="Enter email"  required />
            </Form.Group>

            <Form.Group controlId="formBasicPassword">
                <Form.Label>Password</Form.Label>
                <Form.Control type="password" placeholder="Password"  required />
            </Form.Group>

            <Button variant="primary" type="submit">Login</Button>
        </Form>
    );
}
export default Login
