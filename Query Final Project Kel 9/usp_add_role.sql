CREATE PROCEDURE usp_add_role
	@roleName varchar(50)
AS
BEGIN
	INSERT INTO roles (role_name)
	VALUES (@roleName)
	PRINT 'Role has been successfully added'
END
GO

EXEC dbo.usp_add_role 'Guest'