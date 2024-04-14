CREATE OR REPLACE TRIGGER MaintenanceTrigger
BEFORE INSERT ON DBS_Maintenance_Schedule
FOR EACH ROW
BEGIN
  SELECT Maintenance_ID_SEQ.NEXTVAL INTO :NEW.Maintenance_Id FROM DUAL;
END;
/
