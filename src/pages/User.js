import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './User.css'; // Import User.css file

export default function AddUser() {
  const navigate = useNavigate();

  const [user, setUser] = useState({
    user_id: "",
    first_name: "",
    last_name: "",
    email_address: "",
    user_type: "",
    gender: ""
  });

  const { user_id, first_name, last_name, email_address, user_type, gender } = user;

  const onInputChange = (e) => {
    setUser({ ...user, [e.target.name]: e.target.value });
  }

  const onSubmit = async (e) => {
    e.preventDefault();
    
    await axios.post("http://localhost:8000/user", user); // Update the endpoint URL if necessary
    navigate("/home");
  }

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Register User</h2>
          <form onSubmit={onSubmit}>
            <div className="form-group">
              <label htmlFor="user_id" className="form-label">User ID</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter user ID"
                name="user_id"
                value={user_id}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="first_name" className="form-label">First Name</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter first name"
                name="first_name"
                value={first_name}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="last_name" className="form-label">Last Name</label>
              <input
                type="text"
                className="form-control"
                placeholder="Enter last name"
                name="last_name"
                value={last_name}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="email_address" className="form-label">Email Address</label>
              <input
                type="email"
                className="form-control"
                placeholder="Enter email address"
                name="email_address"
                value={email_address}
                onChange={onInputChange}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="user_type" className="form-label">User Type</label>
              <select
                className="form-control"
                name="user_type"
                value={user_type}
                onChange={onInputChange}
                required
              >
                <option value="">Select User Type</option>
                <option value="Student">Student</option>
                <option value="Faculty">Faculty</option>
              </select>
            </div>
            <div className="form-group">
              <label htmlFor="gender" className="form-label">Gender</label>
              <select
                className="form-control"
                name="gender"
                value={gender}
                onChange={onInputChange}
                required
              >
                <option value="">Select Gender</option>
                <option value="M">Male</option>
                <option value="F">Female</option>
              </select>
            </div>
            <button type="submit" className="btn btn-primary btn-block rounded">Submit</button> {/* Make submit button blue and rounded */}
            <button className="btn btn-danger btn-block rounded mt-2" onClick={() => navigate("/options")}>Cancel</button> {/* Make cancel button red and rounded */}
          </form>
        </div>
      </div>
    </div>
  );
}
