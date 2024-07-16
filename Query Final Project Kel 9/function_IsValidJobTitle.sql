USE EmployeeMS
GO

CREATE FUNCTION IsValidJobTitle (@job_title NVARCHAR(50))
RETURNS BIT
AS
BEGIN
    -- Check for special characters other than underscore
    IF @job_title LIKE '%[^a-zA-Z0-9_ ]%' 
        RETURN 0; -- Invalid
    RETURN 1; -- Valid
END;
GO