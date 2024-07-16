USE EmployeeMS
GO

CREATE TRIGGER tr_update_employee_job
ON Employees
AFTER UPDATE
AS
BEGIN
    -- Check if the job_id column is being updated
    IF UPDATE(job_id)
    BEGIN
        UPDATE Job_Histories
        SET 
            status = 'Hand Over',
            end_date = GETDATE()
        FROM 
            Job_Histories jh
        INNER JOIN 
            inserted i ON jh.employee_id = i.employee_id
        INNER JOIN 
            deleted d ON jh.employee_id = d.employee_id
        WHERE 
            i.job_id <> d.job_id;
    END
END;
