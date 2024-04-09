CREATE OR REPLACE PROCEDURE MarkBicycleReturnedProcedure(
    p_Rental_Id IN Rental.Rental_Id%TYPE
) AS
BEGIN
    -- Update the Rental table to mark the bicycle as returned and set the return date
    UPDATE Rental
    SET Return_Status = 'Returned',
        Return_Date = SYSDATE,
        Bicycle_Id = NULL -- Assuming you want to remove the association with the bicycle upon return
    WHERE Rental_Id = p_Rental_Id;
    
    -- Update the Bicycle table to mark the bicycle as available
    UPDATE Bicycle
    SET Bicycle_Status = 'Available'
    WHERE Bicycle_Id = (SELECT Bicycle_Id FROM Rental WHERE Rental_Id = p_Rental_Id);
    
    -- Commit the transaction to save the changes
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Rental ID does not exist.');
    WHEN OTHERS THEN
        -- Rolling back in case of any exception
        ROLLBACK;
        
        -- Re-raising the caught exception
        RAISE;
END MarkBicycleReturnedProcedure;
/
