CREATE PROCEDURE usp_delete_role
	@roleId int
AS
BEGIN
IF EXISTS (SELECT 1 FROM roles WHERE role_id = @roleId)
	BEGIN
		DELETE roles
	WHERE role_id = @roleId
		PRINT 'Role Deleted Successfully'
	END
	ELSE
	BEGIN
		PRINT 'Role Id Not Found!'
	END	
END



EXEC dbo.usp_delete_role 5