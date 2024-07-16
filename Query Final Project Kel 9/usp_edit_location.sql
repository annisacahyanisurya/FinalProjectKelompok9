CREATE OR ALTER PROCEDURE usp_edit_location
    @street_address varchar(40), 
	@postalcode varchar(12),
    @city varchar(30),
	@state_province varchar(25),
    @country char(3),
    @id int
AS
BEGIN
	-- Mengecek penginputan data Street Address
    IF @street_address IS NULL 
		UPDATE tbl_locations
		SET street_address = street_address, postal_code = @postalcode, city = @city, state_province = @state_province, country = @country
		WHERE id = @id
	ELSE IF (SELECT [dbo].func_street_address_length(@street_address)) = 0
        RAISERROR('Street Address too long', 16, 1)

	-- Mengecek penginputan data Postal Code 
	ELSE IF @postalcode IS NULL 
		UPDATE tbl_locations
		SET street_address = @street_address, postal_code = postal_code, city = @city, state_province = @state_province, country = @country
		WHERE id = @id

	-- Mengecek penginputan data City
	ELSE IF @city IS NULL 
		UPDATE tbl_locations
		SET street_address = @street_address, postal_code = @postalcode, city = city, state_province = @state_province, country = @country
		WHERE id = @id
	ELSE IF (SELECT [dbo].func_city_format(@city)) = 0
        RAISERROR('City name cant contain special character or too long', 16, 1)

	-- Mengecek penginputan data State Province
	ELSE IF @state_province IS NULL 
		UPDATE tbl_locations
		SET street_address = @street_address, postal_code = @postalcode, city = @city, state_province = state_province, country = @country
		WHERE id = @id
	ELSE IF (SELECT [dbo].func_state_province_format(@state_province)) = 0
        RAISERROR('State Province cant contain special character or too long', 16, 1)

	-- Mengecek penginputan data Country
	ELSE IF @country IS NULL 
		UPDATE tbl_locations
		SET street_address = @street_address, postal_code = @postalcode, city = @city, state_province = @state_province, country = country
		WHERE id = @id
	
    ELSE 
		UPDATE tbl_locations
		SET street_address = @street_address, postal_code = @postalcode, city = @city, state_province = @state_province, country = @country
		WHERE id = @id
END

-- EXEC usp_edit_location 'Jl.Melati No.14', '15336', 'Tangerang Selatan', 'Banten', 'JP', 3500

SELECT * FROM tbl_locations