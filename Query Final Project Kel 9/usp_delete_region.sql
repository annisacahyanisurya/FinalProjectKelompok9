CREATE PROCEDURE usp_delete_region
	@regionId int
AS
BEGIN
	IF EXISTS (SELECT 1 FROM regions WHERE region_id = @regionId)
	BEGIN
		DELETE regions
		WHERE region_id = @regionId
		PRINT 'Region Deleted Successfully'
	END
	ELSE
	BEGIN
		PRINT 'Region Id Not Found!'
	END
END


EXEC dbo.usp_delete_region 5