USE EmployeeMS
GO

CREATE PROCEDURE AddEmployee
    @first_name NVARCHAR(50),
    @last_name NVARCHAR(50),
    @gender NVARCHAR(10),
    @email NVARCHAR(255),
    @phone_number NVARCHAR(20),
    @hire_date DATE,
    @salary INT,
    @manager_id INT,
    @job_id NVARCHAR(10),
    @department_id INT = NULL,
    @password NVARCHAR(50),
    @confirm_password NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any mandatory input is NULL
    IF @first_name IS NULL OR @last_name IS NULL OR @gender IS NULL OR @email IS NULL OR 
       @phone_number IS NULL OR @hire_date IS NULL OR @salary IS NULL OR 
       @manager_id IS NULL OR @job_id IS NULL OR @password IS NULL OR @confirm_password IS NULL
    BEGIN
        SELECT 'None of the inputs except Department_ID can be NULL!' AS ErrorMessage;
        RETURN;
    END

    -- Check Gender
    IF dbo.IsGenderValid(@gender) = 0
    BEGIN
        SELECT 'Gender Input Should be "Male" or "Female" !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check Email format
    IF dbo.IsEmailValid(@email) = 0
    BEGIN
        SELECT 'Email should be in Correct Format !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check Phone Number
    IF dbo.IsPhoneNumberValid(@phone_number) = 0
    BEGIN
        SELECT 'Phone Number must not contain text !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check Password
    IF dbo.IsPasswordValid(@password) = 0
    BEGIN
        SELECT 'Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if Password and Confirm_Password match
    IF @password <> @confirm_password
    BEGIN
        SELECT 'Password do not match !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if Manager_ID exists
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE employee_id = @manager_id)
    BEGIN
        SELECT 'Manager_ID Not Found !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if Job_ID exists
    IF NOT EXISTS (SELECT 1 FROM Jobs WHERE job_id = @job_id)
    BEGIN
        SELECT 'Job_ID Not Found !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if Salary is within the range for the Job_ID
    IF NOT EXISTS (
        SELECT 1 
        FROM Jobs 
        WHERE job_id = @job_id 
          AND @salary BETWEEN min_salary AND max_salary
    )
    BEGIN
        SELECT 'Salary must be between the Min_Salary and Max_Salary !!!' AS ErrorMessage;
        RETURN;
    END

    -- If all checks pass, insert the data into the Employees table
    INSERT INTO Employees (FIRST_NAME, LAST_NAME, GENDER, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, JOB_ID, DEPARTMENT_ID)
    VALUES (@first_name, @last_name, @gender, @email, @phone_number, @hire_date, @salary, @manager_id, @job_id, @department_id);

    -- Get the employee_id of the newly inserted employee
    DECLARE @employee_id INT;
    SET @employee_id = SCOPE_IDENTITY();

    -- Insert the data into the Accounts table
    INSERT INTO Accounts (employee_id, username, password, otp, is_expired, is_used)
    VALUES (@employee_id, CONCAT(@first_name, @last_name), @password, 0, NULL, 0);

    SELECT 'Employee data has been successfully added.' AS SuccessMessage;
END;
GO
