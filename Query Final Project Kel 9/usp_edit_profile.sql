CREATE OR ALTER PROCEDURE usp_edit_profile
    @username VARCHAR(50),
    @password VARCHAR(50),
    @new_username VARCHAR(50)
AS
BEGIN
    -- check username and password correct 
    IF EXISTS (SELECT 1 FROM Accounts WHERE username = @username AND password = @password)
    BEGIN
		-- check username format is correct 
		IF (SELECT [dbo].func_username_format(@new_username)) = 0
		BEGIN 
			RAISERROR('Do not contain spesial character and spasi on Username!!', 16, 1)
		END 
		ELSE 
		BEGIN 
			-- check new username 
			IF NOT EXISTS (SELECT 1 FROM Accounts WHERE username = @new_username)
			BEGIN
				-- update new username
				UPDATE Accounts
				SET username = @new_username
				WHERE username = @username;
			END
			ELSE
			BEGIN
				RAISERROR('Username already exists!', 16, 1);
			END
		END    
    END
    ELSE
    BEGIN
        -- failed login 
        RAISERROR('Invalid username or password!', 16, 1);
    END
END;


-- EXEC usp_edit_profile '3raveneyes', 'hOLDtheD00R!', 'brandonstark'
-- SELECT * FROM Accounts