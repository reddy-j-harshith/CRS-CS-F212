import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

import './Bicycle.css'; // Import Bicycle.css file

export default function AddBicycle() {
  const navigate = useNavigate();

  const [bicycle, setBicycle] = useState({
    bicycle_type: "",
    lender_id: "",
    model_type: "",
    phones: [''], // Initialize with one phone number input
    colors: [''] // Initialize with one color input
  });

  const { bicycle_type, lender_id, model_type, phones, colors } = bicycle;

  const onInputChange = (e) => {
    setBicycle({ ...bicycle, [e.target.name]: e.target.value });
  }

  const handlePhoneChange = (e, index) => {
    const newPhones = [...phones];
    newPhones[index] = e.target.value;
    setBicycle({ ...bicycle, phones: newPhones });
  }

  const handleColorChange = (e, index) => {
    const newColors = [...colors];
    newColors[index] = e.target.value;
    setBicycle({ ...bicycle, colors: newColors });
  }

  const addPhoneInput = () => {
    setBicycle({ ...bicycle, phones: [...phones, ''] }); // Add a new empty phone number input
  }

  const addColorInput = () => {
    setBicycle({ ...bicycle, colors: [...colors, ''] }); // Add a new empty color input
  }

  const onSubmit = async (e) => {
    e.preventDefault();
    
    // Your submission logic
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
            <div>
              {phones.map((phone, index) => (
                <div className="mb-3" key={index}>
                  <label htmlFor={`phone${index}`} className="form-label">Phone Number {index + 1}</label>
                  <input
                    type="tel"
                    className="form-control"
                    placeholder="Enter phone number"
                    name={`phone${index}`}
                    value={phone}
                    onChange={(e) => handlePhoneChange(e, index)}
                    required
                  />
                </div>
              ))}
              <button className="btn btn-success" onClick={addPhoneInput}>Add Phone Number</button>
            </div>
            <div>
              {colors.map((color, index) => (
                <div className="mb-3" key={index}>
                  <label htmlFor={`color${index}`} className="form-label">Color {index + 1}</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Enter color"
                    name={`color${index}`}
                    value={color}
                    onChange={(e) => handleColorChange(e, index)}
                    required
                  />
                </div>
              ))}
              <button className="btn btn-success" onClick={addColorInput}>Add Color</button>
            </div>
            <button type="submit" className="btn btn-primary btn-block mt-3">Submit</button>
            <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
          </form>
        </div>
      </div>
    </div>
  );
}
