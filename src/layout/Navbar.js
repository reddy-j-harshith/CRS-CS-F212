// Navbar.js

import React from 'react';
import './Navbar.css'; // Import the Navbar.css file

export default function Navbar() {
  return (
    <nav className="navbar navbar-expand-lg navbar-dark">
      <div className="container-fluid">
        <img src="bitshyd.jpeg" alt="Logo" width="80"  height="80" className="navbar-img" /> {/* Add your image here */}
        <span className="navbar-brand">Cycle Rental System</span>
        <div className="options-container">
          <button className="btn btn-options">Options</button>
        </div>
      </div>
    </nav>
  );
}
