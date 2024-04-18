import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Bicycle.css'; // Import Bicycle.css file

export default function AddBicycle() {
  const navigate = useNavigate();

  const [bicycle, setBicycle] = useState({
    bicycle_type: "",
    lender_id: "",
    model_type: ""
  });

  const { bicycle_type, lender_id, model_type } = bicycle;

  const onInputChange = (e) => {
    setBicycle({ ...bicycle, [e.target.name]: e.target.value });
  }

  const onSubmit = async (e) => {
    e.preventDefault();
    
    await axios.post("http://localhost:8000/bicycle", bicycle); // Update the endpoint URL if necessary
    navigate("/home");
  }

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Add Bicycle</h2>
          <form onSubmit={onSubmit}>
            <div className="mb-3">
              <label htmlFor="bicycle_type" className="form-label">Bicycle Type</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter bicycle type"
                name="bicycle_type"
                value={bicycle_type}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="lender_id" className="form-label">Lender ID</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter lender ID"
                name="lender_id"
                value={lender_id}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="model_type" className="form-label">Model Type</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter model type"
                name="model_type"
                value={model_type}
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
