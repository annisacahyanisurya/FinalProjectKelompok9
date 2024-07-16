USE EmployeeMS
GO

CREATE PROCEDURE UpdateEmployee
    @employee_id INT,
    @new_first_name NVARCHAR(50) = NULL,
    @new_last_name NVARCHAR(50) = NULL,
    @new_gender NVARCHAR(10) = NULL,
    @new_email NVARCHAR(255) = NULL,
    @new_phone_number NVARCHAR(20) = NULL,
    @new_hire_date DATE = NULL,
    @new_job_id NVARCHAR(10) = NULL,
    @new_salary INT = NULL,
    @new_manager_id INT = NULL,
    @new_department_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if employee_id exists
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE employee_id = @employee_id)
    BEGIN
        SELECT 'Employee ID does not exist.' AS ErrorMessage;
        RETURN;
    END

    -- Update first name if provided
    IF @new_first_name IS NOT NULL
    BEGIN
        UPDATE Employees SET first_name = @new_first_name WHERE employee_id = @employee_id;
    END

    -- Update last name if provided
    IF @new_last_name IS NOT NULL
    BEGIN
        UPDATE Employees SET last_name = @new_last_name WHERE employee_id = @employee_id;
    END

    -- Update gender if provided and valid
    IF @new_gender IS NOT NULL
    BEGIN
        IF dbo.isGenderValid(@new_gender) = 1
            UPDATE Employees SET gender = @new_gender WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Gender Input Should be "Male" or "Female" !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update email if provided and valid
    IF @new_email IS NOT NULL
    BEGIN
        IF dbo.isEmailValid(@new_email) = 1
            UPDATE Employees SET email = @new_email WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Email should be in Correct Format !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update phone number if provided and valid
    IF @new_phone_number IS NOT NULL
    BEGIN
        IF dbo.isPhoneNumberValid(@new_phone_number) = 1
            UPDATE Employees SET phone_number = @new_phone_number WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Phone Number must not contain text !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update hire date if provided
    IF @new_hire_date IS NOT NULL
    BEGIN
        UPDATE Employees SET hire_date = @new_hire_date WHERE employee_id = @employee_id;
    END

    -- Update job ID if provided and valid
    IF @new_job_id IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM Jobs WHERE job_id = @new_job_id)
            UPDATE Employees SET job_id = @new_job_id WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Job_ID Not Found !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update salary if provided and valid
    IF @new_salary IS NOT NULL
    BEGIN
        DECLARE @min_salary INT, @max_salary INT;
        SELECT @min_salary = min_salary, @max_salary = max_salary FROM Jobs WHERE job_id = (SELECT job_id FROM Employees WHERE employee_id = @employee_id);

        IF @new_salary BETWEEN @min_salary AND @max_salary
            UPDATE Employees SET salary = @new_salary WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Salary must be between the Min_Salary and Max_Salary !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update manager ID if provided and valid
    IF @new_manager_id IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM Employees WHERE employee_id = @new_manager_id)
            UPDATE Employees SET manager_id = @new_manager_id WHERE employee_id = @employee_id;
        ELSE
        BEGIN
            SELECT 'Manager_ID Not Found !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update department ID if provided
    IF @new_department_id IS NOT NULL
    BEGIN
        UPDATE Employees SET department_id = @new_department_id WHERE employee_id = @employee_id;
    END

    SELECT 'Employee data has been successfully updated.' AS SuccessMessage;
END;
GO
