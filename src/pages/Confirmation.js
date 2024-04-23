import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Confirmation.css'; // Import Confirmation.css file

const Confirmation = () => {
  const navigate = useNavigate();
  const [rentalId, setRentalId] = useState('');
  const [returnDate, setReturnDate] = useState('');
  const [damagedFlag, setDamagedFlag] = useState('');

  const handleRentalIdChange = (event) => {
    setRentalId(event.target.value);
  };

  const handleReturnDateChange = (event) => {
    setReturnDate(event.target.value);
  };

  const handleDamagedFlagChange = (event) => {
    setDamagedFlag(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch('http://localhost:8000/rent-confirm', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          rental_id: rentalId, // Corrected field name
          return_date: returnDate, // Corrected field name
          damaged_flag: damagedFlag, // Corrected field name
        }),
      });

      if (response.ok) {
        console.log('Rental confirmed successfully');
        navigate('/options');
      } else {
        console.error('Failed to confirm rental');
      }
    } catch (error) {
      console.error('Error occurred:', error);
    }
  };

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Confirmation</h2> {/* Confirmation heading */}
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
              <label htmlFor="returnDate" className="form-label">Return Date</label>
              <input
                type="date"
                className="form-control"
                id="returnDate"
                value={returnDate}
                onChange={handleReturnDateChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="damagedFlag" className="form-label">Damaged Flag</label>
              <select
                className="form-control"
                id="damagedFlag"
                value={damagedFlag}
                onChange={handleDamagedFlagChange}
                required
              >
                <option value="">Select Damaged Flag</option>
                <option value="Y">Y</option>
                <option value="N">N</option>
              </select>
            </div>
            <button type="submit" className="btn btn-primary btn-block">Submit</button>
            <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Confirmation;
