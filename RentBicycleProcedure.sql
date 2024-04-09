CREATE OR REPLACE PROCEDURE RentBicycleProcedure(
    p_Borrower_Id IN Rental.Borrower_Id%TYPE,
    p_Rental_Id IN Rental.Rental_Id%TYPE,
    p_Deadline IN Rental.Deadline%TYPE,
    p_Bicycle_Id IN Rental.Bicycle_Id%TYPE
) AS
BEGIN
    -- Check if the bicycle is available for rent
    DECLARE
        v_Bicycle_Status Bicycle.Bicycle_Status%TYPE;
    BEGIN
        SELECT Bicycle_Status INTO v_Bicycle_Status FROM Bicycle WHERE Bicycle_Id = p_Bicycle_Id FOR UPDATE;
        
        IF v_Bicycle_Status = 'Available' THEN
            -- Inserting the new rental record into the Rental table
            INSERT INTO Rental (Borrower_Id, Rental_Id, Deadline, Bicycle_Id, Return_Status)
            VALUES (p_Borrower_Id, p_Rental_Id, p_Deadline, p_Bicycle_Id, 'Not Returned');
            
            -- Updating the Bicycle's status to 'Rented'
            UPDATE Bicycle SET Bicycle_Status = 'Rented' WHERE Bicycle_Id = p_Bicycle_Id;
            
            -- Committing the transaction to save the changes
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Bicycle is not available for rent');
        END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'The specified bicycle does not exist.');
    WHEN OTHERS THEN
        -- Rolling back in case of any exception
        ROLLBACK;
        
        -- Re-raising the caught exception
        RAISE;
END RentBicycleProcedure;
/
