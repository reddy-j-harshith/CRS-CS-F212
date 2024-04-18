// Navbar.js
import React from 'react';
import { Link } from 'react-router-dom';
import './Navbar.css';

export default function Navbar() {
  return (
    <nav className="navbar navbar-expand-lg navbar-dark bg-black">
      <div className="container-fluid d-flex justify-content-between align-items-center">
        <div>
          <Link to="/" className="navbar-brand d-flex align-items-center">
            <img src="/bitshyd.jpeg" alt="Bitshyd Logo" width="40" height="40" className="mr-2" />
            <span className="h4 mb-0 text-white">Cycle Rental System</span>
          </Link>
        </div>
        <div className="options-container">
          <Link to="/options" className="btn btn-options btn-blue rounded-pill">Business Logic</Link> {/* Added rounded-pill class */}
        </div>
      </div>
    </nav>
  );
}
