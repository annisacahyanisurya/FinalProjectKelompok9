USE EmployeeMS
GO

CREATE TRIGGER tr_insert_employee
ON Employees
AFTER INSERT
AS
BEGIN
    -- Insert the new record into Job_Histories
    INSERT INTO Job_Histories (employee_id, start_date, end_date, status, job_id, department_id)
    SELECT 
        inserted.employee_id,
        inserted.hire_date,
        NULL, -- end_date is set to NULL
        'Active', -- status is set to 'Active'
        inserted.job_id,
        inserted.department_id
    FROM 
        inserted;
END;
