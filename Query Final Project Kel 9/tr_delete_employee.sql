USE EmployeeMS
GO

CREATE TRIGGER tr_delete_employee
ON Employees
AFTER DELETE
AS
BEGIN
    -- Update the corresponding record in Job_Histories
    UPDATE Job_Histories
    SET 
        status = 'Resign',
        end_date = GETDATE()
    FROM 
        Job_Histories jh
    INNER JOIN 
        deleted d ON jh.employee_id = d.employee_id
END;