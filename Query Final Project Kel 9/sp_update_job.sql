USE EmployeeMS
GO

CREATE PROCEDURE UpdateJob
    @job_id NVARCHAR(10),
    @new_job_title NVARCHAR(50) = NULL,
    @new_min_salary INT = NULL,
    @new_max_salary INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if job_id exists
    IF NOT EXISTS (SELECT 1 FROM Jobs WHERE JOB_ID = @job_id)
    BEGIN
        SELECT 'Job with ID ' + @job_id + ' does not exist.' AS ErrorMessage;
        RETURN;
    END

    -- Update Job_Title if input is not NULL
    IF @new_job_title IS NOT NULL
    BEGIN
        -- Check if new Job_Title contains special characters other than whitespace
        IF dbo.IsValidJobTitle(@new_job_title) = 0
        BEGIN
            SELECT 'New Job title cannot contain special characters other than whitespace.' AS ErrorMessage;
            RETURN;
        END

        -- Check if new Job_Title length does not exceed 50 characters
        IF LEN(@new_job_title) > 50
        BEGIN
            SELECT 'New Job title cannot exceed 50 characters.' AS ErrorMessage;
            RETURN;
        END

        -- Update Job_Title
        UPDATE Jobs SET JOB_TITLE = @new_job_title WHERE JOB_ID = @job_id;
    END

    -- Update Min_Salary if input is not NULL
    IF @new_min_salary IS NOT NULL
    BEGIN
        -- Check if new Min_Salary is greater than 0
        IF @new_min_salary <= 0
        BEGIN
            SELECT 'New Min_Salary must be greater than 0.' AS ErrorMessage;
            RETURN;
        END

        -- Update Min_Salary
        UPDATE Jobs SET MIN_SALARY = @new_min_salary WHERE JOB_ID = @job_id;
    END

    -- Update Max_Salary if input is not NULL
    IF @new_max_salary IS NOT NULL
    BEGIN
        -- Check if new Max_Salary is greater than 0
        IF @new_max_salary <= 0
        BEGIN
            SELECT 'New Max_Salary must be greater than 0.' AS ErrorMessage;
            RETURN;
        END

        -- Update Max_Salary
        UPDATE Jobs SET MAX_SALARY = @new_max_salary WHERE JOB_ID = @job_id;
    END

    SELECT 'Job data has been successfully updated.' AS SuccessMessage;
END;
