# CRS-CS-F212
CRS is web application developed as CS F212 Database System Project, which offers an amazing interface to interact with the database schema for renting a bicycle and also providing your own bicycle for rental too! The web application is made in react.js with the server powered by fastAPI connected with Oracle database (XE) for our database worries.
Features
1. A querying field where you can give out both DDL and DML queries or can even get back desired records with DQL queries.
2. Business logic functionalities to display the database in field action.

Prerequisites:

1. Oracle Instant Client
2. Oracle 21c XE
3. SQL Developer

Installation:

1. pip install fastAPI[all]
2. pip install cx_Oracle
3. Prior to using the application, please implement all the relevant database triggers, procedures, functions, etc.,

Starting up the appliction:

1. uvicorn app.main:app --reload.
2. The server starts at "http://localhost:8080".
