CREATE OR ALTER PROCEDURE usp_add_country
	@countryId CHAR(3),
    @countryName VARCHAR(40),
    @region INT
AS
BEGIN
    IF (SELECT [dbo].func_country_format(@countryName)) = 0
        RAISERROR('Country cant contain special character or too long (max 30 character)', 16, 1)
    ELSE
        INSERT INTO tbl_countries(id, name, region)
        VALUES (@countryId, @countryName, @region)
END

-- EXEC usp_add_country 'IND', 'Indonesi@', 3;

SELECT * FROM tbl_countries;