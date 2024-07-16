USE EmployeeMS
GO

CREATE FUNCTION dbo.IsEmailValid (@email NVARCHAR(255))
RETURNS BIT
AS
BEGIN
    -- Basic pattern to check if email is valid
    IF (@email = '' OR @email NOT LIKE '%_@__%.__%')
    BEGIN
        RETURN 0;
    END
    RETURN 1;
END;
GO