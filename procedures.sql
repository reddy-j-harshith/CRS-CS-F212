--Procedure to confirm rental completion (confirm_rental_completion):  


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

