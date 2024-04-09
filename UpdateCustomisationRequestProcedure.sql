CREATE OR REPLACE PROCEDURE UpdateCustomizationRequestProcedure(
    p_Custom_Id IN Customization_Request.Custom_Id%TYPE,
    p_Approval_Status IN Customization_Request.Approval_Status%TYPE
) AS
BEGIN
    UPDATE Customization_Request
    SET Approval_Status = p_Approval_Status
    WHERE Custom_Id = p_Custom_Id;
    
    COMMIT; -- Commit the transaction
END;
/
