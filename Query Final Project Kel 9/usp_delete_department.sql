CREATE OR ALTER PROCEDURE usp_delete_department
	@departmentId INT
AS
BEGIN
    IF @departmentId IS NULL OR @departmentId = 0 
        RAISERROR('Please input Department ID Correctly', 16, 1)
    ELSE
        DELETE FROM tbl_department WHERE id = @departmentId
END

EXEC usp_delete_department 260

SELECT * FROM tbl_department;