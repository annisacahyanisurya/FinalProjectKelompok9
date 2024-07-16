USE EmployeeMS
GO

CREATE PROCEDURE DeleteEmployee
    @employee_id INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Check if the employee_id exists
    IF EXISTS (SELECT 1 FROM Employees WHERE employee_id = @employee_id)
    BEGIN
        -- If it exists, delete the employee
        DELETE FROM Employees WHERE employee_id = @employee_id;
        SELECT CONCAT('Employee with ID ', @employee_id, ' has been deleted.') AS result_message;
    END
    ELSE
    BEGIN
        -- If it does not exist, show an appropriate message
        SELECT CONCAT('Employee with ID ', @employee_id, ' Not Found.') AS result_message;
    END

    -- Commit the transaction if no errors
    COMMIT TRANSACTION;
END
GO
