CREATE OR REPLACE PROCEDURE ReportLostOrStolenBicycle (
  p_bicycle_id IN VARCHAR2,
  p_status IN VARCHAR2 -- 'Lost' or 'Stolen'
) AS
BEGIN
  UPDATE Bicycle
  SET Bicycle_Status = p_status
  WHERE Bicycle_Id = p_bicycle_id;

  COMMIT;
END ReportLostOrStolenBicycle;
/
