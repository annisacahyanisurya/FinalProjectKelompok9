CREATE OR ALTER PROCEDURE usp_change_password
    @username VARCHAR(50),
    @password VARCHAR(50),
    @newpassword VARCHAR(50),
	@confirm_password VARCHAR(50)
AS
BEGIN
    -- check username and password correct 
    IF EXISTS (SELECT 1 FROM Accounts WHERE username = @username AND password = @password)
    BEGIN
		-- check is password valid  
		IF dbo.IsPasswordValid(@newpassword) = 0
		BEGIN 
			RAISERROR('Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character !!!', 16, 1)
		END
		-- check is password match 
		ELSE IF @newpassword <> @confirm_password
		BEGIN
			RAISERROR('Password do not match !!!', 16, 1)
		END	
		ELSE 
		BEGIN 
			-- update new password 
			UPDATE Accounts
			SET password = @newpassword
			WHERE username = @username;
		END    
    END
    ELSE
    BEGIN
        -- failed login 
        RAISERROR('Invalid username or password!', 16, 1);
    END
END;


-- SELECT * FROM Accounts
-- EXEC usp_change_password '3raveneyes', 'Wh1tewalkers!', 'hOLDtheD00R!', 'hOLDtheD00R!'
