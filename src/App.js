import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Navbar from './layout/Navbar';
import Options from './pages/Options';
import User from './pages/User';
import Bicycle from './pages/Bicycle';
import Rent from './pages/Rent';
import Feedback from './pages/Feedback';
import Extension from './pages/Extension';
import DelUser from './pages/DelUser';
import DelBicycle from './pages/DelBicycle';
import Confirmation from './pages/Confirmation'; // Import Confirmation component

function App() {
  return (
    <Router>
      <div>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/options" element={<Options />} />
          <Route path="/user" element={<User />} />
          <Route path="/bicycle" element={<Bicycle />} />
          <Route path="/rent" element={<Rent />} />
          <Route path="/feedback" element={<Feedback />} />
          <Route path="/extension" element={<Extension />} />
          <Route path="/deluser" element={<DelUser />} />
          <Route path="/delbicycle" element={<DelBicycle />} />
          <Route path="/confirmation" element={<Confirmation />} /> {/* Add Confirmation route */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;
