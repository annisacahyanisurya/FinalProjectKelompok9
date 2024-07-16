-- =============================================
-- Author:		Annisa Cahyani Surya
-- Create date: 5-6-24
-- Description:	Value input tidak boleh memiliki karakter spesial AND panjangnya tidak lebih dari yg sudah ditentukan
-- =============================================
CREATE OR ALTER FUNCTION func_state_province_format 
(
	-- Add the parameters for the function here
	@StateProvince VARCHAR(25)
)
RETURNS VARCHAR
AS
BEGIN

    DECLARE @result VARCHAR
	SET @result = (CASE WHEN @StateProvince COLLATE Latin1_General_BIN LIKE '%[(<-=+*~!@/#$%^&>)]%' OR LEN(@StateProvince) > 25 THEN 0 ELSE 1 END )
    RETURN @result

END
GO

SELECT [dbo].func_state_province_format('Sulawesi Selatan')
