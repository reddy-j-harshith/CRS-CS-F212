import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios'; // Import Axios library
import './Extension.css'; // Import Extension.css file

const Extension = () => {
  const navigate = useNavigate();
  const [rentalId, setRentalId] = useState('');
  const [numberOfDays, setNumberOfDays] = useState('');

  const handleRentalIdChange = (event) => {
    setRentalId(event.target.value);
  };

  const handleNumberOfDaysChange = (event) => {
    setNumberOfDays(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      // Convert rentalId and numberOfDays to integers
      const rentalIdInt = parseInt(rentalId);
      const numberOfDaysInt = parseInt(numberOfDays);
  
      // Send data to the backend
      await axios.post('http://localhost:8000/extension', { rental_id: rentalIdInt, extra_duration: numberOfDaysInt });
      console.log('Extension request submitted successfully.');
      // Redirect to options page after submission
      navigate('/options');
    } catch (error) {
      console.error('Error submitting extension request:', error);
    }
  };

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Extension</h2> {/* Extension heading */}
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="rentalId" className="form-label">Rental ID</label>
              <input
                type="text"
                className="form-control"
                id="rentalId"
                value={rentalId}
                onChange={handleRentalIdChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="numberOfDays" className="form-label">Number of Days</label>
              <input
                type="number"
                className="form-control"
                id="numberOfDays"
                value={numberOfDays}
                onChange={handleNumberOfDaysChange}
                required
              />
            </div>
            <button type="submit" className="btn btn-primary btn-block">Submit</button>
            <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Extension;
