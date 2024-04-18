import React, { useState } from 'react';

import './Home.css';

export default function Home() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);

  const handleQueryChange = (event) => {
    setQuery(event.target.value);
  };

  const handleQuerySubmit = async () => {
    try {
      const response = await fetch('http://localhost:8000/query', { // Changed port to 3000
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ query: query }) // Added query: query
      });
      const jsonData = await response.json();
      setResults(jsonData.Data); // Changed to jsonData.Data
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  return (
    <div className='container' style={{backgroundImage: `url('/bitshydbgd.jpg')`, backgroundSize: '100% auto', backgroundPosition: 'center', backgroundColor: 'rgba(0, 0, 0, 0.9)', color: '#fff'}}>
      <div className='text-center'>
        <div className="py-4 textarea-container">
          <p>Write your Query:</p>
          <textarea className="form-control" name="postContent" value={query} onChange={handleQueryChange} rows={10} cols={80} />
        </div>
        <button className="btn btn-dark mt-3 go-button" onClick={handleQuerySubmit}>Go</button>
        {results.length > 0 && (
          <table>
            <thead>
              <tr>
                {Object.keys(results[0]).map((key, index) => (
                  <th key={index}>{key}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {results.map((row, rowIndex) => (
                <tr key={rowIndex}>
                  {Object.values(row).map((value, colIndex) => (
                    <td key={colIndex}>{value}</td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );

}