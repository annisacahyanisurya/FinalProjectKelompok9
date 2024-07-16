USE EmployeeMS
GO

CREATE FUNCTION IsJobTitleLengthValid (@job_title NVARCHAR(50))
RETURNS BIT
AS
BEGIN
    -- Check if the length of job title is less than or equal to 50 characters
    IF LEN(@job_title) <= 50
        RETURN 1; -- Valid
    RETURN 0; -- Invalid
END;
GO