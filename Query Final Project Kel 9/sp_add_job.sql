USE EmployeeMS
GO

CREATE PROCEDURE AddJob
    @job_id NVARCHAR(10),
    @job_title NVARCHAR(50),
    @min_salary INT,
    @max_salary INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any input is NULL
    IF @job_id IS NULL OR @job_title IS NULL OR @min_salary IS NULL OR @max_salary IS NULL
    BEGIN
        SELECT 'None of the inputs can be NULL !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if the job title contains special characters
    IF dbo.IsValidJobTitle(@job_title) = 0
    BEGIN
        SELECT 'Job title cannot contain special characters other than underscores !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if the job title length exceeds 50 characters
    IF dbo.IsJobTitleLengthValid(@job_title) = 0
    BEGIN
        SELECT 'Job title cannot exceed 50 characters !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check if min_salary and max_salary are greater than 0
    IF dbo.AreSalariesValid(@min_salary, @max_salary) = 0
    BEGIN
        SELECT 'Min_Salary and Max_Salary must be > 0 !!!' AS ErrorMessage;
        RETURN;
    END

    -- If all checks pass, insert the data into the Jobs table
    INSERT INTO Jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
    VALUES (@job_id, @job_title, @min_salary, @max_salary);

    SELECT 'Job data has been successfully added.' AS SuccessMessage;
END;
GO
