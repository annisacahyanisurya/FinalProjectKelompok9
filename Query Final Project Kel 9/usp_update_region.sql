CREATE OR ALTER PROCEDURE usp_edit_region
	@regionId int,
	@regionName varchar (25)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM regions WHERE region_id = @regionId)
	BEGIN
		UPDATE regions
		SET region_name = @regionName
		WHERE region_id = @regionId
		PRINT 'Region Updated Successfully'
	END
	ELSE
	BEGIN
		PRINT 'Region Id Not Exist!'
	END
END


EXEC dbo.usp_edit_region @regionId = 4, @regionName = 'Africa';
