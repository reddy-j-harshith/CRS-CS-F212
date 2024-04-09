CREATE OR REPLACE PROCEDURE SubmitFeedbackProcedure (
    p_User_Id IN Feedback_System.User_Id%TYPE,
    p_Rating IN Feedback_System.Rating%TYPE,
    p_Comments IN Feedback_System.Comments%TYPE
) AS
BEGIN
    -- Insert the feedback into the Feedback_System table
    INSERT INTO Feedback_System (Feedback_Id, User_Id, Rating, Comments)
    VALUES (SYS_GUID(), p_User_Id, p_Rating, p_Comments);
    
    -- Commit the transaction to save the changes
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rolling back in case of any exception
        ROLLBACK;
        
        -- Re-raising the caught exception
        RAISE;
END SubmitFeedbackProcedure;
/
