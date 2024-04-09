CREATE OR REPLACE PROCEDURE ReportLostOrStolenBicycleProcedure (
    p_rental_id IN VARCHAR2
) AS
    v_bicycle_id VARCHAR2(100);
BEGIN
    -- Retrieve the bicycle_id associated with the rental_id
    SELECT Bicycle_Id INTO v_bicycle_id
    FROM Rental
    WHERE Rental_Id = p_rental_id;
    
    -- Update Bicycle_Status in the Bicycle table to 'Lost'
    UPDATE Bicycle
    SET Bicycle_Status = 'Lost'
    WHERE Bicycle_Id = v_bicycle_id;
    
    -- Update Return_Status in the Rental table to 'Reported Lost/Stolen'
    UPDATE Rental
    SET Return_Status = 'Reported Lost/Stolen'
    WHERE Rental_Id = p_rental_id;

    -- Commit the transaction to save the changes
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle cases where the rental_id does not exist or does not return a valid bicycle_id
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Invalid rental ID or rental does not exist.');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        ROLLBACK;
        RAISE;
END ReportLostOrStolenBicycleProcedure;
/
