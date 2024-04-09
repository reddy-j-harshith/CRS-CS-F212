-- Primary key constraint for User table
ALTER TABLE User_Table ADD CONSTRAINT pk_user_id PRIMARY KEY (User_Id);

-- Primary key constraint for Feedback_System table
ALTER TABLE Feedback_System ADD CONSTRAINT pk_feedback_id PRIMARY KEY (Feedback_Id);

-- Primary key constraint for Maintenance_Schedule table
ALTER TABLE Maintenance_Schedule ADD CONSTRAINT pk_maintenance_id PRIMARY KEY (Maintenance_Id);

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
