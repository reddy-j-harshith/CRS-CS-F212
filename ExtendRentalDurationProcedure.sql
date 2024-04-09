CREATE OR REPLACE PROCEDURE ExtendRentalDurationProcedure(
    p_Rental_Id IN Rental.Rental_Id%TYPE,
    p_Extra_Duration IN Extension.Extra_Duration%TYPE,
    p_Extended_Charges IN Extension.Extended_Charges%TYPE
) AS
    v_New_Deadline DATE;
BEGIN
    -- Calculate the new deadline by adding the extra duration to the current deadline
    SELECT Deadline + p_Extra_Duration INTO v_New_Deadline
    FROM Rental
    WHERE Rental_Id = p_Rental_Id;
    
    -- Update the deadline in the Rental table
    UPDATE Rental
    SET Deadline = v_New_Deadline
    WHERE Rental_Id = p_Rental_Id;
    
    -- Insert the extension details into the Extension table
    INSERT INTO Extension (Extension_Id, Rental_Id, Extra_Duration, Extended_Charges)
    VALUES (SYS_GUID(), p_Rental_Id, p_Extra_Duration, p_Extended_Charges);
    
    -- Committing the transaction to save the changes
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Rental ID does not exist.');
    WHEN OTHERS THEN
        -- Rolling back in case of any exception
        ROLLBACK;
        
        -- Re-raising the caught exception
        RAISE;
END ExtendRentalDurationProcedure;
/
