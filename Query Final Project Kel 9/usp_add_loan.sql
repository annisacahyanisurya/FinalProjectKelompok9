CREATE PROCEDURE usp_add_loan
	@employee_id INT,
	@total_loan INT,
	@payment_date DATE = NULL,
	@due_date DATE,
	@status VARCHAR(10) = 'Belum Lunas',
	@days_late INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @loan_date DATE
	SET @loan_date = GETDATE()

    -- Check if any mandatory input is NULL
    IF @employee_id IS NULL OR @total_loan IS NULL OR @due_date IS NULL 
    BEGIN
        SELECT 'None of the inputs except can be NULL!' AS ErrorMessage;
        RETURN;
    END

	-- Check if Employee Id exists
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE employee_id = @employee_id)
    BEGIN
        SELECT 'Employee Id Not Found !!!' AS ErrorMessage;
        RETURN;
    END

    -- Check Status
    IF @payment_date IS NOT NULL
    BEGIN
        SET @status = 'Lunas'
        RETURN;
    END

    INSERT INTO loans(employee_id, total_loan, loan_date, payment_date, due_date, status)
    VALUES (@employee_id, @total_loan, @loan_date, NULL, @due_date, @status);

    SELECT 'Loan data has been successfully added.' AS SuccessMessage;
END;
GO

EXEC usp_add_loan
    @employee_id = 110,
	@total_loan = 5000000,
	@due_date = '2024/06/20'

EXEC usp_add_loan
    @employee_id = 207,
	@total_loan = 1000000,
	@due_date = '2024/06/10'

EXEC usp_add_loan
    @employee_id = 205,
	@total_loan = 5000,
	@due_date = '2024/06/20'