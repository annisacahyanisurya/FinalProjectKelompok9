USE EmployeeMS
GO

CREATE PROCEDURE DeleteJob
    @job_id VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if the job_id exists
    IF EXISTS (SELECT 1 FROM Jobs WHERE JOB_ID = @job_id)
    BEGIN
        -- If it exists, delete the job
        DELETE FROM Jobs WHERE JOB_ID = @job_id;
        SELECT CONCAT('Job with ID ', @job_id, ' has been deleted.') AS result_message;
    END
    ELSE
    BEGIN
        -- If it does not exist, show an appropriate message
        SELECT CONCAT('Job with ID ', @job_id, ' Not Found.') AS result_message;
    END
END;
