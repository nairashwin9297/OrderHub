import React from 'react';
import { Button } from 'react-bootstrap';
import { useNavigate } from "react-router-dom";
import backgroundImage from './images/homepage.webp'; // Adjust the path according to where you saved your image

function HomePage() {
  const navigate = useNavigate();
  
  return (
    <div style={{
      height: '100vh',
      background: `url(${backgroundImage}) no-repeat center center fixed`,
      backgroundSize: 'cover',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
      alignItems: 'center',
    }}>
      <div style={{ marginTop: '230px' }}> 
        <Button
          variant="primary"
          size="lg"
          onClick={() => navigate("/login")}
          style={{
            fontWeight: 'bold', // Makes the font bold
            boxShadow: '0px 4px 8px rgba(0, 0, 0, 0.1)', // Adds a subtle shadow to the button
            borderRadius: '10px', // Rounds the corners of the button
          }}
        >
          Login to continue
        </Button>
      </div>
    </div>
  );
}

export default HomePage;
