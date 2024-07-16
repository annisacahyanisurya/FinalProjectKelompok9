-- =============================================
-- Author:		Annisa Cahyani Surya
-- Create date: 5-6-24
-- Description:	Value input tidak boleh memiliki karakter spesial AND panjangnya tidak lebih dari yg sudah ditentukan
-- =============================================
CREATE OR ALTER FUNCTION func_street_address_length
(
	-- Add the parameters for the function here
	@StreetAddress VARCHAR(40)
)
RETURNS VARCHAR
AS
BEGIN

    DECLARE @result VARCHAR
	SET @result = (CASE WHEN LEN(@StreetAddress) > 40 THEN 0 ELSE 1 END )
    RETURN @result

END
GO

SELECT [dbo].func_street_address_length
('Jl.Melati No.14 RT011 RW 008 Kelurahan Pondok Jagung, Kecamatan Serpong Utara, Tangerang Selatan, Banten, Indonesia, 15337')
