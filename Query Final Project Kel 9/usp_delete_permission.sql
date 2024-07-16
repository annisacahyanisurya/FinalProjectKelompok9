CREATE PROCEDURE usp_delete_permission
        @permissionId int
AS
BEGIN
        IF EXISTS (SELECT 1 FROM permissions WHERE permission_id = @permissionId)
        BEGIN
                DELETE permissions
                WHERE permission_id = @permissionId
                PRINT 'Permission Deleted Successfully'
        END
        ELSE
        BEGIN
                PRINT 'Permission Id Not Found!'
        END        
END

EXEC dbo.usp_delete_permission 30