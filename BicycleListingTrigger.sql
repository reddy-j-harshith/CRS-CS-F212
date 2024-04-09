CREATE OR REPLACE TRIGGER BicycleListingTrigger
BEFORE INSERT ON Bicycle
FOR EACH ROW
BEGIN
    -- Generate a unique Bicycle_Id using SYS_GUID()
    :NEW.Bicycle_Id := SYS_GUID();
END;
/
