-- adding and deleting procedures
------------------------------------------------------------------------------------
-- 1)   user creation
CREATE OR REPLACE PROCEDURE create_user(
    p_user_id IN VARCHAR2,
    p_firstname IN VARCHAR2,
    p_lastname IN VARCHAR2,
    p_email_address IN VARCHAR2,
    p_gender IN CHAR,
    p_user_type IN CHAR
)
IS
BEGIN
    -- Insert user information into user_info table
    INSERT INTO user_info(user_id, firstname, lastname, email_address, gender, user_type)
    VALUES (p_user_id, p_firstname, p_lastname, p_email_address, p_gender, p_user_type);
    -- Output success message
    DBMS_OUTPUT.PUT_LINE('User created successfully. User ID: ' || p_user_id);

END;
/


--example check for user_creation procedure.
BEGIN
    create_user('2022A7PS0001H', 'John', 'Doe', 'john.doe@example.com', 'M', 'S');
END;
/



-------------------------------------------------------------------------------------------------------------------  

  
-- 2) delete_user procedure
  CREATE OR REPLACE PROCEDURE delete_user(
    p_user_id IN VARCHAR2
)
IS
BEGIN
    -- Delete user from user_info table
    DELETE FROM user_info
    WHERE user_id = p_user_id;

    -- Commit the transaction
    COMMIT;
    
    -- Output success message
    DBMS_OUTPUT.PUT_LINE('User with user_id ' || p_user_id || ' deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        -- Error handling
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/


  --EXAMPLE USAGE
  BEGIN
    delete_user('2022A7PS0001H');
END;
/


-------------------------------------------------------------------------------------------------------------
--3) bicycle record creation (a person listing/registering their bicycle for rental)
CREATE OR REPLACE PROCEDURE create_bicycle_record(
    p_lender_id IN VARCHAR2,
    p_bicycle_type IN VARCHAR2,
    p_model_type IN VARCHAR2,
    p_color IN VARCHAR2
)
IS
    v_bicycle_id NUMBER;
BEGIN
    -- Insert record into bicycle table
    INSERT INTO bicycle(bicycle_id, bicycle_type, lender_id, model_type)
    VALUES (bicycle_seq.NEXTVAL, p_bicycle_type, p_lender_id, p_model_type)
    RETURNING bicycle_id INTO v_bicycle_id;

    -- Insert record into bicycle_color table
    INSERT INTO bicycle_color(bicycle_id, color)
    VALUES (v_bicycle_id, p_color);
--output message
 DBMS_OUTPUT.PUT_LINE('Bicycle record created successfully. Bicycle ID: ' || v_bicycle_id);

END;
/

--example
BEGIN
    create_bicycle_record('2022A7PS0001H', 'Mountain Bike', 'Model XYZ', 'Red');
END;
/



------------------------------------------------------------------------------------------------------------


-- 4) deletion of bicycle record (a person deleted/delists their bicycle from the system

CREATE OR REPLACE PROCEDURE delete_bicycle(
    p_bicycle_id IN NUMBER
)
IS
BEGIN
    -- Delete bicycle from bicycle table
    DELETE FROM bicycle
    WHERE bicycle_id = p_bicycle_id;

    -- Delete corresponding records from bicycle_color table
    DELETE FROM bicycle_color
    WHERE bicycle_id = p_bicycle_id;
    -- Output success message
    DBMS_OUTPUT.PUT_LINE('Bicycle with bicycle_id ' || p_bicycle_id || ' deleted successfully.');

END;
/



    --example 
    BEGIN
    delete_bicycle(123); -- Replace 123 with the actual bicycle_id
END;
/


----------------------------------------------------------------------------------------------------------
-- BUSINESS LOGIC
--     PROCEDURES

-------------------------------------------------------------------------------------------------------------
  --1) RENT A BICYCLE (CREATES A RECORD IN RENTAL TABLE WITH GIVEN VALUES AND OTHER DEFAULT VALUES)
 

















    
--Procedure to confirm rental completion (confirm_rental_completion):  
  
 /* The confirm_rental_completion procedure updates the return date and rental status of a specified rental
 based on the provided parameters. If the 'damaged' flag is 'Y', it marks the rental as 'damaged'; otherwise, 
it marks it as 'inactive'. Finally, it commits the transaction to save the changes to the database.*/
  CREATE OR REPLACE PROCEDURE confirm_rental_completion ( 
      p_rental_id IN rental.rental_id%TYPE,
      p_return_date IN rental.return_date%TYPE,
      p_damaged_flag IN VARCHAR2
  )
  IS
  BEGIN
      -- Update return date
      UPDATE rental
      SET return_date = p_return_date,
          rental_status = CASE
                              WHEN p_damaged_flag = 'Y' THEN 'damaged'
                              ELSE 'inactive'
                         END
      WHERE rental_id = p_rental_id;
      
      COMMIT;
  END confirm_rental_completion;
  /



    
  
  /* The `rental_extension_eligibility` procedure checks if a rental, 
identified by the provided rental ID, is eligible for an extension by verifying if its return date is null
 and if the current date is before the rental deadline. It then outputs whether the user is eligible for a
 rental extension or not.*/
  
  CREATE OR REPLACE PROCEDURE rental_extension_eligibility (
    p_rental_id IN rental.rental_id%TYPE,
    p_eligible OUT BOOLEAN
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM rental
    WHERE rental_id = p_rental_id
    AND return_date IS NULL
    AND SYSDATE <= deadline;

    p_eligible := (v_count > 0);

    IF p_eligible THEN
        DBMS_OUTPUT.PUT_LINE('User is eligible for rental extension.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User is not eligible for rental extension.');
    END IF;
END rental_extension_eligibility;
/

  
  
          
  
  --procedure to fetch all bicycles(bicycle_id) with bicycle_status "available"
  CREATE OR REPLACE PROCEDURE fetch_available_bicycles
  IS
  BEGIN
      FOR bike_rec IN (
          SELECT bicycle_id
          FROM bicycle
          WHERE bicycle_status = 'available'
      ) LOOP
          DBMS_OUTPUT.PUT_LINE('Available Bicycle ID: ' || bike_rec.bicycle_id);
      END LOOP;
  END fetch_available_bicycles;
  /
  
  
  
    
  --procedure to fetch all bicycles related to one user
  --input is user_id output is bicycle_ids
  CREATE OR REPLACE PROCEDURE list_bicycles (
      p_user_id IN user_info.user_id%TYPE
  )
  IS
  BEGIN
      FOR bike_rec IN (
          SELECT bicycle_id
          FROM bicycle
          WHERE lender_id = p_user_id
      ) LOOP
          DBMS_OUTPUT.PUT_LINE('Bicycle ID: ' || bike_rec.bicycle_id);
      END LOOP;
  END list_bicycles;
  /
  
  
  
  
  --procedure to request extension for ongoing rental.
          
  CREATE OR REPLACE PROCEDURE request_extension (
      p_rental_id IN rental.rental_id%TYPE,
      p_extra_duration IN NUMBER
  )
  IS
      v_extension_id rental.extension_id%TYPE;
  BEGIN
      INSERT INTO extension (extension_id, rental_id, extra_duration)
      VALUES (extension_seq.NEXTVAL, p_rental_id, SYSDATE + p_extra_duration);
  
      -- Retrieve the generated extension ID
      SELECT extension_seq.CURRVAL INTO v_extension_id FROM DUAL;
      
      DBMS_OUTPUT.PUT_LINE('Extension requested. Extension ID: ' || v_extension_id);
      
      COMMIT;
  END request_extension;
  /
  


