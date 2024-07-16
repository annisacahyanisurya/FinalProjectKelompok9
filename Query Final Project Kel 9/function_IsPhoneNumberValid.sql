USE EmployeeMS;
GO

CREATE FUNCTION dbo.IsPhoneNumberValid (@phone NVARCHAR(20))
RETURNS BIT
AS
BEGIN
    IF @phone LIKE '%[^0-9]%'
    BEGIN
        RETURN 0;
    END
    RETURN 1;
END;
GO