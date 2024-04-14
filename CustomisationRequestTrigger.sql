CREATE OR REPLACE TRIGGER CustomizationRequestTrigger
BEFORE INSERT ON Customization_Request
FOR EACH ROW
BEGIN
  -- Log the new customization request
  INSERT INTO Customization_Request_Log (Custom_Id, Request_Details, Request_Date)
  VALUES (:NEW.Custom_Id, :NEW.Requirements, SYSDATE);
END;
/
