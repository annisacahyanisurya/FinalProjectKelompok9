USE EmployeeMS;
GO

CREATE FUNCTION dbo.IsGenderValid (@gender NVARCHAR(10))
RETURNS BIT
AS
BEGIN
    IF @gender IN ('Male', 'Female')
        RETURN 1;
    RETURN 0;
END;
GO
