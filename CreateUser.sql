DELIMITER //

CREATE PROCEDURE RegisterUserProcedure (
    IN p_First_Name VARCHAR(100),
    IN p_User_Id VARCHAR(100),
    IN p_Last_Name VARCHAR(100),
    IN p_Email_Address VARCHAR(100),
    IN p_Phno INT,
    IN p_Gender VARCHAR(1),
    IN p_User_Type VARCHAR(1)
)
BEGIN
    INSERT INTO User (
        User_Id,
        First_Name,
        Last_Name,
        Email_Address,
        Phno,
        User_Type,
        Gender
    ) VALUES (
        p_User_Id,
        p_First_Name,
        p_Last_Name,
        p_Email_Address,
        p_Phno,
        p_User_Type,
        p_Gender
    );
END //

DELIMITER ;
