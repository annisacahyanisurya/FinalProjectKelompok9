CREATE OR ALTER FUNCTION func_username_format
(
        @username VARCHAR(50)
)
RETURNS VARCHAR
AS
BEGIN

    DECLARE @result BIT
        SET @result = (CASE WHEN @username COLLATE Latin1_General_BIN LIKE '%[^a-zA-Z0-9_.]%'  THEN 0 ELSE 1 END )
    RETURN @result

END
GO

SELECT dbo.func_username_format('John$now')
SELECT dbo.func_username_format('John_Snow')
