CREATE PROCEDURE usp_edit_role
	@roleId int,
	@roleName varchar(50)
AS
BEGIN
IF EXISTS (SELECT 1 FROM roles WHERE role_id = @roleId)
	BEGIN
		UPDATE roles
		SET role_name = @roleName
		WHERE role_id = @roleId
		PRINT 'Role Updated Successfully'
	END
	ELSE
	BEGIN
		PRINT 'Role Id Not Exist!'
	END
END


EXEC dbo.usp_edit_role @roleId = 3, @roleName = 'Manager';
EXEC dbo.usp_edit_role @roleId = 5, @roleName = 'Guest';
