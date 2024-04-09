CREATE OR REPLACE TRIGGER MaintenanceTrigger
BEFORE INSERT ON Maintenance_Schedule
FOR EACH ROW
BEGIN
    :NEW.Maintenance_Id := Maintenance_Id_SEQ.NEXTVAL;
END;
/
