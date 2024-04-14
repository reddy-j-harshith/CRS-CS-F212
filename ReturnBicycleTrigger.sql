CREATE OR REPLACE TRIGGER ReturnBicycleTrigger
AFTER UPDATE OF Return_Date ON Rental
FOR EACH ROW
DECLARE
  v_bicycle_id VARCHAR2(100);
BEGIN
  -- Get the Bicycle_Id associated with the returned rental
  SELECT Bicycle_Id INTO v_bicycle_id FROM Rental WHERE Rental_Id = :OLD.Rental_Id;

  -- Update the Bicycle_Status to 'Available'
  UPDATE Bicycle
  SET Bicycle_Status = 'Available'
  WHERE Bicycle_Id = v_bicycle_id;
END ReturnBicycleTrigger;
/
