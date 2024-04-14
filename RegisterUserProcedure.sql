CREATE OR REPLACE PROCEDURE RegisterUserProcedure (
  p_user_id IN VARCHAR2,
  p_first_name IN VARCHAR2,
  p_last_name IN VARCHAR2,
  p_email IN VARCHAR2,
  p_phno IN NUMBER,
  p_user_type IN CHAR,
  p_gender IN CHAR
) AS
BEGIN
  INSERT INTO User_Info (User_Id, First_Name, Last_Name, Email_Address, Phno, User_Type, Gender)
  VALUES (p_user_id, p_first_name, p_last_name, p_email, p_phno, p_user_type, p_gender);
  COMMIT;
END RegisterUserProcedure;
/
