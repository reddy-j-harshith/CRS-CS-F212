
CREATE TABLE user_info (
    user_id VARCHAR2(20) PRIMARY KEY,
    firstname VARCHAR2(50) NOT NULL,
    lastname VARCHAR2(50) NOT NULL,
    email_address VARCHAR2(100) DEFAULT 'example@example.com' NOT NULL,
    gender CHAR(1) CHECK (gender IN ('F', 'M')),
   
    user_type CHAR(1) CHECK (user_type IN ('S', 'F'))
);


ALTER TABLE user_info ADD CONSTRAINT user_id_format_check
CHECK (
    REGEXP_LIKE(user_id, '^20[0-9]{2}[A-Z][0-9]PS[0-9]{4}H$')
);


CREATE TABLE rental (
    rental_id NUMBER PRIMARY KEY,
    borrower_id VARCHAR2(20) NOT NULL,
    rental_date DATE NOT NULL,
    deadline DATE,
    return_date DATE,
    rental_status VARCHAR2(10) DEFAULT 'active' CHECK (rental_status IN ('active', 'inactive','damaged')),
    late_fees NUMBER DEFAULT 0,
    damage_fees NUMBER DEFAULT 0,
    amount_due NUMBER DEFAULT 0,
    bicycle_id NUMBER NOT NULL
);


CREATE TABLE bicycle (
    bicycle_id NUMBER PRIMARY KEY,
    bicycle_type VARCHAR2(100) NOT NULL,
    lender_id VARCHAR2(20) NOT NULL,
    model_type VARCHAR2(100) NOT NULL,
    bicycle_status VARCHAR2(20) DEFAULT 'available' CHECK (bicycle_status IN ('available', 'unavailable', 'damaged', 'stolen')),
    CONSTRAINT bicycle_lender_fk FOREIGN KEY (lender_id) REFERENCES user_info(user_id) ON DELETE CASCADE
);

ALTER TABLE rental
ADD CONSTRAINT fk_bicycle_id FOREIGN KEY (bicycle_id) REFERENCES bicycle(bicycle_id) ON DELETE CASCADE;
ALTER TABLE rental
ADD CONSTRAINT fk_borrower_id FOREIGN KEY (borrower_id) REFERENCES user_info(user_id) ON DELETE CASCADE;




CREATE OR REPLACE TRIGGER calculate_deadline
BEFORE INSERT ON rental
FOR EACH ROW
BEGIN
    :NEW.deadline := :NEW.rental_date + 1; -- Assuming deadline is set exactly one day after rental_date
END;
/


CREATE OR REPLACE TRIGGER update_rental_status_and_return_date
AFTER INSERT ON rental
FOR EACH ROW
BEGIN
    IF :NEW.return_date IS NOT NULL THEN
        UPDATE rental
        SET rental_status = 'inactive'
        WHERE rental_id = :NEW.rental_id;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER calculate_late_fees
BEFORE INSERT OR UPDATE OF return_date ON rental
FOR EACH ROW
BEGIN
    IF :NEW.return_date IS NOT NULL AND :NEW.return_date > :NEW.deadline THEN
        :NEW.late_fees := (:NEW.return_date - :NEW.deadline) * 100; -- Assuming late fees of 100 units per day
    END IF;
END;
/

CREATE OR REPLACE TRIGGER update_damage_fees
BEFORE INSERT OR UPDATE OF rental_status ON rental
FOR EACH ROW
BEGIN
    IF :NEW.rental_status = 'damage' THEN
        :NEW.damage_fees := 1000; -- Assuming flat damage fee of 1000 units
    END IF;
END;
/

CREATE OR REPLACE TRIGGER calculate_amount_due
BEFORE INSERT OR UPDATE OF return_date, damage_fees ON rental
FOR EACH ROW
BEGIN
    :NEW.amount_due := 100 + :NEW.late_fees + :NEW.damage_fees;
END;
/




CREATE TABLE feedback (
    feedback_id NUMBER PRIMARY KEY,
    user_id VARCHAR2(20) NOT NULL,
    rating NUMBER CHECK (rating >= 1 AND rating <= 10),
    comments VARCHAR2(1000),
    CONSTRAINT feedback_user_fk FOREIGN KEY (user_id) REFERENCES user_info(user_id) ON DELETE CASCADE
);


CREATE TABLE maintenance_schedule (
    maintenance_id NUMBER PRIMARY KEY,
    maintenance_date DATE DEFAULT SYSDATE NOT NULL,
    maintenance_task VARCHAR2(255) NOT NULL,
    bicycle_id NUMBER NOT NULL,
    CONSTRAINT maintenance_bicycle_fk FOREIGN KEY (bicycle_id) REFERENCES bicycle(bicycle_id) ON DELETE CASCADE
);


 CREATE OR REPLACE TRIGGER update_bicycle_status
AFTER INSERT OR UPDATE OF rental_status ON rental
FOR EACH ROW
DECLARE
    v_bicycle_status VARCHAR2(20);
BEGIN
    -- Get the bicycle status based on the return status
    IF :NEW.rental_status = 'inactive' THEN
        v_bicycle_status := 'available';
    ELSIF :NEW.rental_status = 'damaged' THEN
        v_bicycle_status := 'damaged';
    END IF;

    -- Update the bicycle status
    UPDATE bicycle
    SET bicycle_status = v_bicycle_status
    WHERE bicycle_id = :NEW.bicycle_id;
END;
/




CREATE TABLE extension (
    extension_id NUMBER PRIMARY KEY,
    rental_id NUMBER NOT NULL,
    extra_duration NUMBER NOT NULL,
    extra_charges NUMBER,
    CONSTRAINT extension_rental_fk FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE
);
CREATE OR REPLACE TRIGGER calculate_extra_charges
BEFORE INSERT ON extension
FOR EACH ROW
BEGIN
    :NEW.extra_charges := 100 * (EXTRACT(DAY FROM :NEW.extra_duration));
END;
/




CREATE TABLE customization_request (
    custom_id NUMBER PRIMARY KEY,
    request_type VARCHAR2(100),
    requirements VARCHAR2(1000),
    approval_status VARCHAR2(20) CHECK (approval_status IN ('approved', 'not approved')),
    extra_charges NUMBER DEFAULT 100
);

CREATE TABLE rental_custom (
    rental_id NUMBER,
    custom_id NUMBER,
    CONSTRAINT pk_rental_custom PRIMARY KEY (rental_id, custom_id),
    CONSTRAINT fk_rental FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE,
    CONSTRAINT fk_customization_request FOREIGN KEY (custom_id) REFERENCES customization_request(custom_id) ON DELETE CASCADE
);



CREATE TABLE user_phno (
    user_id VARCHAR2(20),
    phno VARCHAR2(10) UNIQUE CHECK (LENGTH(phno) = 10),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES user_info(user_id) ON DELETE CASCADE
);


CREATE TABLE bicycle_color (
    bicycle_id NUMBER,
    color VARCHAR2(50),
    CONSTRAINT fk_bicycle FOREIGN KEY (bicycle_id) REFERENCES bicycle(bicycle_id) ON DELETE CASCADE
);










-- Create sequence
CREATE SEQUENCE rental_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER rental_trigger
BEFORE INSERT ON rental
FOR EACH ROW
BEGIN
    :NEW.rental_id := rental_seq.NEXTVAL;
END;
/








-- Create sequence
CREATE SEQUENCE feedback_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER feedback_trigger
BEFORE INSERT ON feedback
FOR EACH ROW
BEGIN
    :NEW.feedback_id := feedback_seq.NEXTVAL;
END;
/





-- Create sequence
CREATE SEQUENCE maintenance_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER maintenance_trigger
BEFORE INSERT ON maintenance_schedule
FOR EACH ROW
BEGIN
    :NEW.maintenance_id := maintenance_seq.NEXTVAL;
END;
/





-- Create sequence
CREATE SEQUENCE bicycle_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER bicycle_trigger
BEFORE INSERT ON bicycle
FOR EACH ROW
BEGIN
    :NEW.bicycle_id := bicycle_seq.NEXTVAL;
END;
/





-- Create sequence
CREATE SEQUENCE extension_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER extension_trigger
BEFORE INSERT ON extension
FOR EACH ROW
BEGIN
    :NEW.extension_id := extension_seq.NEXTVAL;
END;
/





-- Create sequence
CREATE SEQUENCE custom_seq
START WITH 1
INCREMENT BY 1;

-- Create trigger
CREATE OR REPLACE TRIGGER custom_trigger
BEFORE INSERT ON customization_request
FOR EACH ROW
BEGIN
    :NEW.custom_id := custom_seq.NEXTVAL;
END;
/

