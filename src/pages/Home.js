// Home.js

import React, { useState } from 'react';
import './Home.css';

export default function Home() {
  const [query, setQuery] = useState('');

  const handleQueryChange = (event) => {
    setQuery(event.target.value);
  }

  return (
    <div className='container' style={{backgroundImage: `url('/bitshydbgd.jpg')`, backgroundSize: '100% auto', backgroundPosition: 'center', backgroundColor: 'rgba(0, 0, 0, 0.9)', color: '#fff'}}>
      <div className='text-center'> {/* Center align the content */}
        <div className="py-4 textarea-container">
          <p>Write your Query:</p>
          <textarea className="form-control" name="postContent" value={query} onChange={handleQueryChange} rows={10} cols={80} />
        </div>
        <button className="btn btn-dark mt-3 go-button">Go</button> {/* Apply custom style */}
      </div>
    </div>
  );
}
