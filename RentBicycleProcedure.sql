CREATE OR REPLACE PROCEDURE RentBicycleProcedure (
  p_borrower_id IN VARCHAR2,
  p_bicycle_id IN VARCHAR2,
  p_rental_duration IN NUMBER
) AS
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Bicycle WHERE Bicycle_Id = p_bicycle_id AND Bicycle_Status = 'Available') THEN
    RAISE_APPLICATION_ERROR(-20002, 'Bicycle not available for rental.');
  END IF;

  INSERT INTO Rental (Borrower_Id, Bicycle_Id, Deadline, Rental_Status)
  VALUES (p_borrower_id, p_bicycle_id, SYSDATE + p_rental_duration, 'Rented');

  UPDATE Bicycle
  SET Bicycle_Status = 'Unavailable'
  WHERE Bicycle_Id = p_bicycle_id;

  COMMIT;
END RentBicycleProcedure;
/
