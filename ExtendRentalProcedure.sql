CREATE OR REPLACE PROCEDURE ExtendRentalDurationProcedure (
  p_rental_id IN NUMBER,
  p_extra_duration IN NUMBER
) AS
BEGIN
  UPDATE Rental
  SET Rental_Duration = Rental_Duration + p_extra_duration
  WHERE Rental_Id = p_rental_id;

  COMMIT;
END ExtendRentalDurationProcedure;
/
