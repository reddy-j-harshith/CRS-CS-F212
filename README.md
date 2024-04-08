# CRS-CS-F212
CRS is web application developed as CS F212 Database System Project, which offers an amazing interface to interact with the database schema for renting a bicycle and also providing your own bicycle for rental too! The web application is made in react.js with the server powered by fastAPI connected with Oracle database (XE) for our database worries.

Features

1. A querying field where you can give out both DDL and DML queries or can even get back desired records with DQL queries.

2. Business logic functionalities to display the database in field action.

Prerequisites:

  -Oracle Instant Client
  -Oracle 21c XE
  -SQL Developer

Installation:
  
  -pip install fastAPI[all]
  -pip install cx_Oracle

Starting up the appliction:

  -uvicorn app.main:app
