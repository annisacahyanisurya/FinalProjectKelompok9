CREATE OR ALTER PROCEDURE usp_generate_otp
	@email VARCHAR(40)
AS
BEGIN
	DECLARE @otp INT

	-- check email valid 
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE email = @email)
    BEGIN
        RAISERROR('Account not registered', 16, 1)
    END
	ELSE 
	BEGIN 
		SET @otp = FLOOR(RAND() * 10000) + 1000

		UPDATE Accounts
		SET otp = @otp, is_expired = DATEADD(minute, 10, GETDATE()), is_used = 0
		WHERE id = (SELECT employee_id FROM Employees WHERE email = @email)
	END

END

EXEC sp_CheckEmail 'steven.king@gmail.com'


