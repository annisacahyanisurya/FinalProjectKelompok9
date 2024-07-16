CREATE OR ALTER PROCEDURE usp_add_location
	@street_address varchar(40), 
	@postalcode varchar(12),
    @city varchar(30),
	@state_province varchar(25),
    @country char(3)
AS
BEGIN
    IF (SELECT [dbo].func_street_address_length(@street_address)) = 0
        RAISERROR('Street Address too long', 16, 1)
	ELSE IF (SELECT [dbo].func_city_format(@city)) = 0
        RAISERROR('City name cant contain special character or too long', 16, 1)
	ELSE IF (SELECT [dbo].func_state_province_format(@state_province)) = 0
        RAISERROR('State Province cant contain special character or too long', 16, 1)
    ELSE
        INSERT INTO tbl_locations(street_address, postal_code, city, state_province, country)
        VALUES (@street_address, @postalcode, @city, @state_province, @country)
END

-- EXEC usp_add_location 'Jl.Melati No.14', '15337', 'Tangerang &Selatan', 'Banten', 'US'

select * from tbl_locations
