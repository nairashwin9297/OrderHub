import logo from './logo.svg';
import './App.css';
import React, { useState,useEffect } from "react";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import HomePage from './HomePage';
import Login from './Login/Login'
import Restaurant from './Restaurant';
import RestaurantMenu from './RestaurantMenu';
import Payment from './Payment';

function App() {
  return (
    <div>
      <BrowserRouter>
        <Routes>
        <Route path="/" exact element={<HomePage />} />
        <Route path="/login" exact element={<Login />} />
        <Route path="/restaurant/:customerID" exact element={<Restaurant />} />
        <Route path="/menu/:customerID/:restaurantID" exact element={<RestaurantMenu />} />
        <Route path="/menu/:customerID/:restaurantID/:customerOrderID" exact element={<RestaurantMenu />} />
        <Route path="/payment/:customerOrderID" exact element={<Payment />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
