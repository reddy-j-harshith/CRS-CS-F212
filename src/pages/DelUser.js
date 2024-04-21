import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios'; // Import Axios library
import './DelUser.css'; // Import DelUser.css file

const DelUser = () => {
  const navigate = useNavigate();
  const [userId, setUserId] = useState('');

  const handleUserIdChange = (event) => {
    setUserId(event.target.value);
  };

  const handleDeleteUser = async () => {
    try {
      // Send delete request to the backend
      await axios.delete(`http://localhost:8000/deluser`);
      console.log('User deleted successfully.');
      // Redirect to options page after deletion
      navigate('/options');
    } catch (error) {
      console.error('Error deleting user:', error);
    }
  };

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Delete User</h2> {/* Delete User heading */}
          <div className="form-group">
            <label htmlFor="userId" className="form-label">User ID</label>
            <input
              type="text"
              className="form-control"
              id="userId"
              value={userId}
              onChange={handleUserIdChange}
              required
            />
          </div>
          <button type="button" className="btn btn-primary btn-block" onClick={handleDeleteUser}>Delete</button>
          <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default DelUser;
