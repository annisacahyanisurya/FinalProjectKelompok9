CREATE OR ALTER PROCEDURE usp_delete_country
	@countryId CHAR(3)
AS
BEGIN
    IF @countryId IS NULL
        RAISERROR('Please input Country ID', 16, 1)
    ELSE
        DELETE FROM tbl_countries WHERE id = @countryId
END

EXEC usp_delete_country 'IND'

SELECT * FROM tbl_countries;