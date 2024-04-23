import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios'; // Import Axios library
import './DelBicycle.css'; // Import DelBicycle.css file

const DelBicycle = () => {
  const navigate = useNavigate();
  const [bicycleId, setBicycleId] = useState('');

  const handleBicycleIdChange = (event) => {
    setBicycleId(event.target.value);
  };

  const handleDeleteBicycle = async () => {
    try {
      // Send delete request to the backend with bicycleId as a path parameter
      await axios.delete(`http://localhost:8000/delete-bicycle/${bicycleId}`);
      console.log('Bicycle deleted successfully.');
      // Redirect to options page after deletion
      navigate('/options');
    } catch (error) {
      console.error('Error deleting bicycle:', error);
    }
  };

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Delete Bicycle</h2> {/* Delete Bicycle heading */}
          <div className="form-group">
            <label htmlFor="bicycleId" className="form-label">Bicycle ID</label>
            <input
              type="text"
              className="form-control"
              id="bicycleId"
              value={bicycleId}
              onChange={handleBicycleIdChange}
              required
            />
          </div>
          <button type="button" className="btn btn-primary btn-block" onClick={handleDeleteBicycle}>Delete</button>
          <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default DelBicycle;
