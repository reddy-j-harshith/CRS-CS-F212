CREATE TABLE User (
    User_Id VARCHAR(100),
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100),
    Email_Address VARCHAR(100),
    Phno INT,
    User_Type VARCHAR(1),
    Gender VARCHAR(1)
);

CREATE TABLE Rental (
    Borrower_Id VARCHAR(100),
    Rental_Id VARCHAR(100),
    Deadline DATE,
    Return_Date DATE,
    Return_Status VARCHAR(100),
    Late_Fees INT,
    Damage_Fees INT,
    Amount_Due INT,
    Bicycle_Id VARCHAR(100)
);

CREATE TABLE Feedback_System (
    Feedback_Id VARCHAR(100),
    User_Id VARCHAR(100),
    Rating INT,
    Comments VARCHAR(255)
);

CREATE TABLE Maintenance_Schedule (
    Maintenance_Id VARCHAR(100),
    Maintenance_Date DATE,
    Maintenance_Task VARCHAR(255),
    Bicycle_Id VARCHAR(100)
);

CREATE TABLE Bicycle (
    Bicycle_Id VARCHAR(100),
    Bicycle_Type VARCHAR(100),
    Lender_Id VARCHAR(100),
    Model_Id VARCHAR(100),
    Color VARCHAR(100),
    Bicycle_Status VARCHAR(100)
);

CREATE TABLE Extension (
    Extension_Id VARCHAR(100),
    Rental_Id VARCHAR(100),
    Extra_Duration INT,
    Extended_Charges INT
);

CREATE TABLE Customization_Request (
    Custom_Id VARCHAR(100),
    Request_Type VARCHAR(100),
    Requirements VARCHAR(255),
    Approval_Status VARCHAR(100),
    Extra_Charges INT
);

CREATE TABLE Rental_Custom (
    Rental_Id VARCHAR(100),
    Custom_Id VARCHAR(100)
);
