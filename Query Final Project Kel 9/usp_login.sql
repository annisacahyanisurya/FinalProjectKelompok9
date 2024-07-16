CREATE OR ALTER PROCEDURE usp_login
    @username_email VARCHAR(50),
    @password VARCHAR(50)
AS
BEGIN
    -- check username and password correct 
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE username = @username_email AND password = @password)
    BEGIN
		-- check email is valid
		IF NOT EXISTS(SELECT 1 FROM Employees WHERE email = @username_email)
		BEGIN
			-- when email not valid, return error message 
			RAISERROR('Account not registered !!!', 16, 1)
		END
		ELSE 
		BEGIN
			-- when email valid check password is valid
			IF EXISTS(SELECT 1 FROM Accounts WHERE password = @password)
			BEGIN 
				-- Success login 
				SELECT 'Login Success!' AS SuccessMessage;
			END
			ELSE 
			BEGIN 
				-- Password not valid, login failed
				RAISERROR('Username/email or Password incorrect !!!', 16, 1)
			END 
		END	
    END
    ELSE
    BEGIN
        -- Success login 
        SELECT 'Login Success!' AS SuccessMessage;
        RETURN;
    END
END;


EXEC usp_login 'brandonstark', 'hOLDtheD00R!'
SELECT * FROM Accounts
