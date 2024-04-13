import React, { useState, useEffect } from 'react';

export default function Home() {
  const [query, setQuery] = useState('');
  const [data, setData] = useState([]);

  const handleQueryChange = (event) => {
    setQuery(event.target.value);
  };

  useEffect(() => {
    // Fetch JSON data from backend when query changes
    fetchData();
  }, [query]);

  const fetchData = async () => {
    try {
      const response = await fetch('your-backend-api-url');
      const jsonData = await response.json();
      setData(jsonData);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  const renderTableHeader = () => {
    if (data.length === 0) return null;

    const header = Object.keys(data[0]);
    return header.map((key, index) => <th key={index}>{key}</th>);
  };

  const renderTableRows = () => {
    return data.map((item, index) => {
      return (
        <tr key={index}>
          {Object.values(item).map((value, index) => (
            <td key={index}>{value}</td>
          ))}
        </tr>
      );
    });
  };

  return (
    <div className='container' style={{backgroundImage: `url('/bitshydbgd.jpg')`, backgroundSize: '100% auto', backgroundPosition: 'center', backgroundColor: 'rgba(0, 0, 0, 0.9)', color: '#fff'}}>
      <div className='text-center'> {/* Center align the content */}
        <div className="py-4 textarea-container">
          <p>Write your Query:</p>
          <textarea className="form-control" name="postContent" value={query} onChange={handleQueryChange} rows={10} cols={80} />
        </div>
        <button className="btn btn-dark mt-3 go-button">Go</button> {/* Apply custom style */}
        {/* Render the dynamic table */}
        <table>
          <thead>
            <tr>{renderTableHeader()}</tr>
          </thead>
          <tbody>{renderTableRows()}</tbody>
        </table>
      </div>
    </div>
  );
}
