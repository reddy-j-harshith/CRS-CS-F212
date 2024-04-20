import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Feedback.css';

const Feedback = () => {
  const navigate = useNavigate();
  const [userId, setUserId] = useState('');
  const [rating, setRating] = useState('');
  const [comments, setComments] = useState('');

  const handleRentalIdChange = (event) => {
    setUserId(event.target.value);
  };

  const handleRatingChange = (event) => {
    setRating(event.target.value);
  };

  const handleCommentsChange = (event) => {
    setComments(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      await axios.post('http://localhost:8000/feedback', { userId, rating, comments });
      console.log('Feedback submitted successfully.');
      navigate('/options');
    } catch (error) {
      console.error('Error submitting feedback:', error);
    }
  };

  return (
    <div className='container'>
      <div className="row">
        <div className="col-md-6 offset-md-3 border rounded p-4 mt-2 shadow">
          <h2 className="text-center m-4">Feedback</h2>
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="userId" className="form-label">User ID</label>
              <input
                type="text"
                className="form-control"
                id="userId"
                value={userId}
                onChange={handleRentalIdChange}
                required
              />
            </div>
            <div className="form-group">
              <label className="form-label">Rating</label>
              <div className="rating-options">
                {[1, 2, 3, 4, 5].map((value) => (
                  <label key={value} className="rating-option">
                    <input
                      type="radio"
                      name="rating"
                      value={value}
                      onChange={handleRatingChange}
                      checked={rating === value.toString()}
                    />
                    {value}
                  </label>
                ))}
              </div>
            </div>
            <div className="form-group">
              <label htmlFor="comments" className="form-label">Comments</label>
              <textarea
                id="comments"
                className="form-control"
                value={comments}
                onChange={handleCommentsChange}
              ></textarea>
            </div>
            <button type="submit" className="btn btn-primary btn-block">Submit</button>
            <button className="btn btn-danger btn-block mt-2" onClick={() => navigate("/options")}>Cancel</button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Feedback;
