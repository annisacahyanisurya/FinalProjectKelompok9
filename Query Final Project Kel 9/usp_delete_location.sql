CREATE OR ALTER PROCEDURE usp_delete_location
	@locationId INT
AS
BEGIN
    IF @locationId IS NULL OR @locationId = 0 
        RAISERROR('Please input Location ID Correctly', 16, 1)
    ELSE
        DELETE FROM tbl_locations WHERE id = @locationId
END

EXEC usp_delete_location 3400

SELECT * FROM tbl_locations;
