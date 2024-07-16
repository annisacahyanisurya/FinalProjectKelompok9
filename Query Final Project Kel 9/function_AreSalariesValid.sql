USE EmployeeMS
GO

CREATE FUNCTION AreSalariesValid (@min_salary INT, @max_salary INT)
RETURNS BIT
AS
BEGIN
    -- Check if min_salary and max_salary are bigger than 0 (positive)
    IF @min_salary > 0 AND @max_salary > 0
        RETURN 1; -- Valid
    RETURN 0; -- Invalid
END;
GO