import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Navbar from './layout/Navbar';
import Options from './pages/Options';
import User from './pages/User'; // Import User component
import Bicycle from './pages/Bicycle'; // Import Bicycle component
import Rent from './pages/Rent'; // Import Rent component

function App() {
  return (
    <Router>
      <div>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/options" element={<Options />} />
          <Route path="/user" element={<User />} /> {/* Add User route */}
          <Route path="/bicycle" element={<Bicycle />} /> {/* Add Bicycle route */}
          <Route path="/rent" element={<Rent />} /> {/* Add Rent route */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;
