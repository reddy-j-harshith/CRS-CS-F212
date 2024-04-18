import React from 'react';
import { Link } from 'react-router-dom';

const Options = () => {
  return (
    <div style={containerStyle}>
      <h1 style={headingStyle}>Business Logic</h1>
      {/* Adding rectangular buttons */}
      <div style={buttonContainerStyle}>
        <Link to="/user" style={buttonStyle}>Insert User</Link> {/* Link to User.js */}
        <Link to="/bicycle" style={buttonStyle}>Insert Bicycle</Link> {/* Link to Bicycle.js */}
        <Link to="/rent" style={buttonStyle}>Rent a Cycle</Link> {/* Link to Rent.js */}
      </div>
    </div>
  );
}

// CSS styles
const containerStyle = {
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
};

const headingStyle = {
  textAlign: 'center',
};

const buttonContainerStyle = {
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  marginTop: '20px',
};

const buttonStyle = {
  backgroundColor: '#007bff',
  color: '#fff',
  border: 'none',
  borderRadius: '10px', // Increased button border radius
  padding: '15px 30px', // Increased button padding
  margin: '10px 0', // Increased margin between buttons
  cursor: 'pointer',
  textDecoration: 'none', // Remove default underline from Link
};

export default Options;
