import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import "./Login.css";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isEmailValid, setIsEmailValid] = useState(true);
  const [isPasswordValid, setIsPasswordValid] = useState(true);
  const [isLoading, setIsLoading] = useState(false);
  const [isLoginValid, setIsLoginValid] = useState(true); // This will control the display of login error

  const navigate = useNavigate();

  const validateEmail = (email) => {
    return /\S+@\S+\.\S+/.test(email);
  };

  const handleEmailChange = (e) => {
    setIsEmailValid(true);
    setEmail(e.target.value);
  };

  const handlePasswordChange = (e) => {
    setIsPasswordValid(true);
    setPassword(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    const emailValid = validateEmail(email);
    const passwordValid = !!password;

    setIsEmailValid(emailValid);
    setIsPasswordValid(passwordValid);

    if (emailValid && passwordValid) {
      try {
        const response = await axios.post("http://localhost:3000/api/users/login", { email, password });
        const data = response.data;
        if (data.success) {
          navigate(`/restaurant/${data.userId}`); // Navigate to restaurant page with customer ID
        } else {
          setIsLoginValid(false); // Set login valid state to false to show error
        }
      } catch (error) {
        console.error("Error during login:", error);
        setIsLoginValid(false); // Set login valid state to false to show error
      }
    } else {
      setIsLoginValid(true); // Assume credentials are valid unless proven otherwise
    }
    setIsLoading(false);
  };

  return (
    <div className="login-container">
      <div className="container d-flex align-items-center justify-content-center vh-100">
        <div className="card p-4 login-card">
          <h1 className="card-title text-center mb-4">Login</h1>
          {!isLoginValid && (
            <div className="alert alert-danger" role="alert">
              Invalid Credentials! Please try again.
            </div>
          )}
          <form onSubmit={handleSubmit}>
            <div className="mb-3">
              <label htmlFor="email" className="form-label">
                Email address<span style={{ color: "red" }}>*</span>
              </label>
              <input
                type="email"
                className={`form-control ${!isEmailValid && 'is-invalid'}`}
                id="email"
                placeholder="Enter email"
                value={email}
                onChange={handleEmailChange}
              />
              {!isEmailValid && (
                <div className="invalid-feedback">
                  Invalid email format
                </div>
              )}
            </div>
            <div className="mb-3">
              <label htmlFor="password" className="form-label">
                Password<span style={{ color: "red" }}>*</span>
              </label>
              <input
                type="password"
                className={`form-control ${!isPasswordValid && 'is-invalid'}`}
                id="password"
                placeholder="Enter password"
                value={password}
                onChange={handlePasswordChange}
              />
              {!isPasswordValid && (
                <div className="invalid-feedback">
                  Password field is mandatory!
                </div>
              )}
            </div>
            <button
              type="submit"
              className="btn btn-success w-100 mb-3"
              disabled={isLoading}
            >
              {isLoading ? (
                <div className="spinner-border text-light" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
              ) : (
                "Login"
              )}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Login;
