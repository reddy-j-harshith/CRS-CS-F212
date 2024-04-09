CREATE OR REPLACE TRIGGER CustomizationRequestTrigger
BEFORE INSERT ON Customization_Request
FOR EACH ROW
BEGIN
    :NEW.Custom_Id := SYS_GUID();
    :NEW.Approval_Status := 'Pending'; -- Set the default approval status to 'Pending'
END;
/
