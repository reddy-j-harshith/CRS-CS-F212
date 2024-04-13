CREATE TABLE User_Info ( User_Id VARCHAR2(100), First_Name VARCHAR2(100), Last_Name VARCHAR2(100), Email_Address VARCHAR2(100), Phno NUMBER,
User_Type CHAR(1),
Gender CHAR(1) );
CREATE TABLE Rental ( Borrower_Id VARCHAR2(100), Rental_Id VARCHAR2(100), Deadline DATE,
Return_Date DATE, Return_Status VARCHAR2(100), Late_Fees NUMBER, Damage_Fees NUMBER, Amount_Due NUMBER, Bicycle_Id VARCHAR2(100)
);
CREATE TABLE Feedback_System (
Feedback_Id VARCHAR2(100),
User_Id VARCHAR2(100),
Rating NUMBER(2,0) CHECK (Rating >= 1 AND Rating <= 10), Comments VARCHAR2(255)
);
CREATE TABLE DBS_Maintenance_Schedule (
Maintenance_Id VARCHAR2(100), Maintenance_Date DATE, Maintenance_Task VARCHAR2(255), Bicycle_Id VARCHAR2(100)
);
CREATE TABLE Bicycle (
Bicycle_Id VARCHAR2(100), Bicycle_Type VARCHAR2(100), Lender_Id VARCHAR2(100), Model_Id VARCHAR2(100), Color VARCHAR2(100), Bicycle_Status VARCHAR2(100)
);
CREATE TABLE Extension (
Extension_Id VARCHAR2(100),
Rental_Id VARCHAR2(100),
Extra_Duration INTERVAL DAY TO SECOND,

 Extended_Charges NUMBER );
CREATE TABLE Customization_Request ( Custom_Id VARCHAR2(100), Request_Type VARCHAR2(100), Requirements VARCHAR2(255), Approval_Status VARCHAR2(100), Extra_Charges NUMBER
);
CREATE TABLE Rental_Custom (
Rental_Id VARCHAR2(100),
Custom_Id VARCHAR2(100) );
-- Primary key constraint for User table
ALTER TABLE User_info ADD CONSTRAINT pk_user_id PRIMARY KEY (User_Id);
-- Primary key constraint for Feedback_System table
ALTER TABLE Feedback_System ADD CONSTRAINT pk_feedback_id PRIMARY KEY (Feedback_Id);
-- Primary key constraint for dbs_Maintenance_Schedule table
ALTER TABLE dbs_Maintenance_Schedule ADD CONSTRAINT pk_maintenance_id PRIMARY KEY (Maintenance_Id);
-- Primary key constraint for Bicycle table
ALTER TABLE Bicycle ADD CONSTRAINT pk_bicycle_id PRIMARY KEY (Bicycle_Id);
-- Primary key constraint for Rental table
ALTER TABLE Rental ADD CONSTRAINT pk_rental_id PRIMARY KEY (Rental_Id);
-- Primary key constraint for Extension table
ALTER TABLE Extension ADD CONSTRAINT pk_extension_id PRIMARY KEY (Extension_Id);
-- Primary key constraint for Customization_Request table
ALTER TABLE Customization_Request ADD CONSTRAINT pk_custom_id PRIMARY KEY (Custom_Id);
-- Primary key constraint for Rental_Custom table
ALTER TABLE Rental_Custom ADD CONSTRAINT pk_rental_custom_id PRIMARY KEY (Rental_Id, Custom_Id);

 -- Borrower_Id foreign key constraint referencing User_Id primary key in User table 
ALTER TABLE Rental ADD CONSTRAINT fk_borrower_id FOREIGN KEY (Borrower_Id) REFERENCES User_info(User_Id);
-- User_Id foreign key constraint in Feedback_System referencing User_Id primary key in User table
ALTER TABLE Feedback_System ADD CONSTRAINT fk_user_id_feedback FOREIGN KEY (User_Id) REFERENCES User_info(User_Id);
-- Lender_Id foreign key constraint in Bicycle referencing User_Id primary key in User table 
ALTER TABLE Bicycle ADD CONSTRAINT fk_lender_id FOREIGN KEY (Lender_Id) REFERENCES User_info(User_Id);
-- Rental_Id foreign key constraint in Extension referencing Rental_Id primary key in Rental table
ALTER TABLE Extension ADD CONSTRAINT fk_rental_id_extension FOREIGN KEY (Rental_Id) REFERENCES Rental(Rental_Id);
-- Bicycle_Id foreign key constraint in Maintenance_Schedule referencing Bicycle_Id primary key in Bicycle table
ALTER TABLE dbs_Maintenance_Schedule ADD CONSTRAINT fk_bicycle_id_maintenance FOREIGN KEY (Bicycle_Id) REFERENCES Bicycle(Bicycle_Id);
-- Bicycle_Id foreign key constraint in Rental referencing Bicycle_Id primary key in Bicycle table
ALTER TABLE Rental ADD CONSTRAINT fk_bicycle_id_rental FOREIGN KEY (Bicycle_Id) REFERENCES Bicycle(Bicycle_Id);
-- Custom_Id foreign key constraint in Rental_Custom referencing Custom_Id primary key in Customization_Request table
ALTER TABLE Rental_Custom ADD CONSTRAINT fk_custom_id_rental_custom FOREIGN KEY (Custom_Id) REFERENCES Customization_Request(Custom_Id);
ALTER TABLE Rental_Custom ADD CONSTRAINT fk_rental_id_rental_custom FOREIGN KEY (rental_Id) REFERENCES rental(rental_Id);
