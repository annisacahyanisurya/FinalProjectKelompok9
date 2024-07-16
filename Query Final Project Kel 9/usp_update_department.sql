CREATE OR ALTER PROCEDURE usp_update_department
    @departmentName varchar(30),
    @location int,
    @id int
AS
BEGIN
	-- Mengecek penginputan data Department Name
    IF @departmentName IS NULL 
		UPDATE tbl_department
		SET name = name, location = @location
		WHERE id = @id
	ELSE IF (SELECT [dbo].func_department_format(@departmentName)) = 0
        RAISERROR('Department cant contain special character or too long', 16, 1)

	-- Mengecek penginputan data Location
	ELSE IF @location IS NULL OR @location = 0 
		UPDATE tbl_department
		SET name = @departmentName, location = location
		WHERE id = @id

    ELSE
        UPDATE tbl_department
        SET name = @departmentName, location = @location
        WHERE id = @id
END

-- EXEC usp_update_department "Data Engineer", NULL, 270

SELECT * FROM tbl_department