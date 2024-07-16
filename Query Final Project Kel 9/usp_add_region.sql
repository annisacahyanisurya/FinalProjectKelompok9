CREATE PROCEDURE usp_add_region
	@regionName varchar(25)
AS
BEGIN
	INSERT INTO regions (region_name)
	VALUES (@regionName)
	PRINT 'Region has been successfully added'
END

EXEC dbo.usp_add_region @regionName = 'Australia';