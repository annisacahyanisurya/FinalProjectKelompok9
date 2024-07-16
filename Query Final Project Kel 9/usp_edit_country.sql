CREATE OR ALTER PROCEDURE usp_edit_country
    @countryName varchar(40),
    @region int,
    @id CHAR(3)
AS
BEGIN
	-- Mengecek penginputan data Department Name
    IF @countryName IS NULL 
		UPDATE tbl_countries
		SET name = name, region = @region
		WHERE id = @id
	ELSE IF (SELECT [dbo].func_country_format(@countryName)) = 0
        RAISERROR('Country cant contain special character or too long', 16, 1)

	-- Mengecek penginputan data Location
	ELSE IF @region IS NULL OR @region = 0 
		UPDATE tbl_countries
		SET name = @countryName, region = region
		WHERE id = @id

    ELSE
        UPDATE tbl_countries
        SET name = @countryName, region = @region
        WHERE id = @id
END

-- EXEC usp_edit_country "Indi@", 3, 'IN'

SELECT * FROM tbl_countries