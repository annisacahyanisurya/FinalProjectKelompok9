CREATE OR ALTER PROCEDURE usp_add_department
    @departmentName varchar(30),
    @location int
AS
BEGIN
    IF (SELECT [dbo].func_department_format(@departmentName)) = 0
        RAISERROR('Department cant contain special character or too long (max 30 character)', 16, 1)
    ELSE
        INSERT INTO tbl_department(name, location)
        VALUES (@departmentName, @location)
END

-- EXEC usp_add_department 'Database & Administrator', 1200;

select * from tbl_department