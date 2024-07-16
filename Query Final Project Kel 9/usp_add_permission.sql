CREATE PROCEDURE usp_add_permission
        @permissionName varchar(100)
AS
BEGIN
        INSERT INTO permissions (permission_name)
        VALUES (@permissionName);
        PRINT 'Permission has been successfully added'
END
GO

EXEC dbo.usp_add_permission @permissionName = 'Edit Profile';
EXEC dbo.usp_add_permission @permissionName = 'Change Password';
EXEC dbo.usp_add_permission @permissionName = 'Change Photo';
