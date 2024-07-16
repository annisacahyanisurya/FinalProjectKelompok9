CREATE PROCEDURE usp_edit_permission
        @permissionId int,
        @permissionName varchar(100)
AS
BEGIN
        IF EXISTS (SELECT 1 FROM permissions WHERE permission_id = @permissionId)
        BEGIN
                UPDATE permissions
                SET permission_name = @permissionName
                WHERE permission_id = @permissionId
                PRINT 'Permission Updated Successfully'
        END
        ELSE
        BEGIN
                PRINT 'Permission Id Not Exist!'
        END
END

EXEC dbo.usp_edit_permission @permissionId = 27, @permissionName = 'Ubah Password';