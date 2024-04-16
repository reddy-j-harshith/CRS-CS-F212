import React, { useState } from 'react';
import './Home.css';

export default function Home() {
  const [query, setQuery] = useState('');
  const [tableData, setTableData] = useState([]);

  const handleQueryChange = (event) => {
    setQuery(event.target.value);
  }

  const handleQuerySubmit = async () => {
    try {
      const response = await fetch('your-backend-api-url', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ query }),
      });

      if (!response.ok) {
        throw new Error('Bad Request');
      }

      const responseData = await response.json();

      // Check if the query is a SELECT query
      if (query.trim().toUpperCase().startsWith('SELECT')) {
        setTableData(responseData);
      } else {
        // Display message for executed queries other than SELECT
        setTableData([]);
      }
    } catch (error) {
      console.error('Error:', error.message);
      setTableData([]);
    }
  }

  return (
    <div className='container' style={{backgroundImage: `url('/bitshydbgd.jpg')`, backgroundSize: '100% auto', backgroundPosition: 'center', backgroundColor: 'rgba(0, 0, 0, 0.9)', color: '#fff'}}>
      <div className='text-center'> {/* Center align the content */}
        <div className="py-4 textarea-container">
          <p>Write your Query:</p>
          <textarea className="form-control" name="postContent" value={query} onChange={handleQueryChange} rows={10} cols={80} />
        </div>
        <button className="btn btn-dark mt-3 go-button" onClick={handleQuerySubmit}>Go</button> {/* Apply custom style */}
        {tableData.length > 0 && (
          <div className="mt-3">
            <h3>Query Result:</h3>
            <table className="table table-striped">
              <thead>
                <tr>
                  {Object.keys(tableData[0]).map((key, index) => (
                    <th key={index}>{key}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {tableData.map((row, rowIndex) => (
                  <tr key={rowIndex}>
                    {Object.values(row).map((value, colIndex) => (
                      <td key={colIndex}>{value}</td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
