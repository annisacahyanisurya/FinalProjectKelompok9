CREATE OR ALTER PROCEDURE usp_forgot_password
	@email VARCHAR(40),
	@newpassword VARCHAR(50),
	@confirm_password VARCHAR(50), 
	@otp INT
AS
BEGIN
	DECLARE @is_expired DATETIME, @is_used BIT
	SET @is_used = (SELECT is_used FROM Accounts WHERE id = (SELECT employee_id FROM Employees WHERE email = @email))
	SET @is_expired = (SELECT is_expired FROM Accounts WHERE id = (SELECT employee_id FROM Employees WHERE email = @email))

	-- Check Email Valid 
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE email = @email)
    BEGIN
        RAISERROR('Account not registered', 16, 1)
    END

	-- Check Password
	ELSE IF dbo.IsPasswordValid(@newpassword) = 0
    BEGIN
        RAISERROR('Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character !!!', 16, 1)
    END

    -- Check if Password and Confirm_Password match
    ELSE IF @newpassword <> @confirm_password
    BEGIN
		RAISERROR('Password do not match !!!', 16, 1)
    END

	-- Check OTP incorrect
	ELSE IF @otp != (SELECT otp FROM Accounts WHERE id = (SELECT employee_id FROM Employees WHERE email = @email))
    BEGIN
        RAISERROR('OTP is incorrect!', 16, 1)
    END

	-- Check OTP is used

	ELSE IF @is_used = 1
    BEGIN
        RAISERROR('OTP already used!', 16, 1)
    END

	-- Check OTP is expired

	ELSE IF (DATEDIFF(MINUTE, GETDATE(), @is_expired)) < 0
	BEGIN 
		 RAISERROR('OTP already expired!', 16, 1)
	END 

	-- Update Account Table
	ELSE 
	BEGIN 
		UPDATE Accounts
		SET password = @newpassword, is_used = 1
		WHERE id = (SELECT employee_id FROM Employees WHERE email = @email)
	END
END