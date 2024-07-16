USE EmployeeMS
GO

CREATE FUNCTION dbo.IsPasswordValid (@password NVARCHAR(50))
RETURNS BIT
AS
BEGIN
    IF LEN(@password) >= 8 AND
       PATINDEX('%[A-Z]%', @password COLLATE Latin1_General_BIN) > 0 AND
       PATINDEX('%[a-z]%', @password COLLATE Latin1_General_BIN) > 0 AND
       PATINDEX('%[0-9]%', @password COLLATE Latin1_General_BIN) > 0 AND
       PATINDEX('%[!@#$%^&*(),.?":{}|<>]%', @password COLLATE Latin1_General_BIN) > 0
    BEGIN
        RETURN 1;
    END
    RETURN 0;
END;
GO
