import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Rent.css'; // Import Rent.css file

export default function Rent() {
  const navigate = useNavigate();

  const [rental, setRental] = useState({
    borrower_id: "",
    bicycle_id: "",
    deadline: "",
    late_fees: "",
    damage_fees: "",
    amt_due: ""
  });

  const { borrower_id, bicycle_id, deadline, late_fees, damage_fees, amt_due } = rental;

  const onInputChange = (e) => {
    setRental({ ...rental, [e.target.name]: e.target.value });
  }

  const onSubmit = async (e) => {
    e.preventDefault();
    
    await axios.post("http://localhost:8000/rental", rental); // Update the endpoint URL if necessary
    navigate("/home");
  }

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Rent Bicycle</h2>
          <form onSubmit={onSubmit}>
            <div className="mb-3">
              <label htmlFor="borrower_id" className="form-label">Borrower ID</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter borrower ID"
                name="borrower_id"
                value={borrower_id}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="bicycle_id" className="form-label">Bicycle ID</label>
              <input
                type="number"
                className="form-control"
                placeholder="Enter bicycle ID"
                name="bicycle_id"
                value={bicycle_id}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="deadline" className="form-label">Deadline</label>
              <input
                type="date"
                className="form-control"
                name="deadline"
                value={deadline}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="late_fees" className="form-label">Late Fees</label>
              <input
                type="number"
                className="form-control"
                placeholder="Enter late fees"
                name="late_fees"
                value={late_fees}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="damage_fees" className="form-label">Damage Fees</label>
              <input
                type="number"
                className="form-control"
                placeholder="Enter damage fees"
                name="damage_fees"
                value={damage_fees}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="amt_due" className="form-label">Amount Due</label>
              <input
                type="number"
                className="form-control"
                placeholder="Enter amount due"
                name="amt_due"
                value={amt_due}
                onChange={onInputChange}
                required
              />
            </div>
            <button type="submit" className="btn btn-primary btn-block">Submit</button> {/* Make submit button blue */}
            <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button> {/* Make cancel button red */}
          </form>
        </div>
      </div>
    </div>
  );
}
