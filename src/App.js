// App.js

import React from 'react';
import Home from './pages/Home'; // Adjust the path to Home.js
import Navbar from './layout/Navbar'; // Adjust the path to Navbar.js

function App() {
  return (
    <div>
      <Navbar /> {/* Ensure Navbar component is used */}
      <Home />
    </div>
  );
}

export default App;
