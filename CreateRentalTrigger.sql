CREATE OR REPLACE TRIGGER RentalIdTrigger
BEFORE INSERT ON Rental
FOR EACH ROW
BEGIN
    -- Generates a unique Rental_Id using SYS_GUID
    :NEW.Rental_Id := REPLACE(SYS_GUID(), '-', '');
END;
/
