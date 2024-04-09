CREATE OR REPLACE PROCEDURE RegisterUserProcedure(
    p_User_Id IN User.User_Id%TYPE,
    p_First_Name IN User.First_Name%TYPE,
    p_Last_Name IN User.Last_Name%TYPE,
    p_Email_Address IN User.Email_Address%TYPE,
    p_Phno IN VARCHAR, -- Changing to VARCHAR based on the recommendation
    p_User_Type IN User.User_Type%TYPE,
    p_Gender IN User.Gender%TYPE
) AS
BEGIN
    -- Inserting the new user record into the User table
    INSERT INTO User (User_Id, First_Name, Last_Name, Email_Address, Phno, User_Type, Gender)
    VALUES (p_User_Id, p_First_Name, p_Last_Name, p_Email_Address, p_Phno, p_User_Type, p_Gender);
    
    -- Committing the transaction to save the new user
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rolling back in case of any exception
        ROLLBACK;
        
        -- Re-raising the caught exception
        RAISE;
END RegisterUserProcedure;
/