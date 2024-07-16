CREATE PROCEDURE usp_edit_loan
    @loan_id INT,
    @employee_id INT,
    @total_loan DECIMAL(10, 2),
    @loan_date DATE,
    @payment_date DATE,
    @due_date DATE,
    @status VARCHAR(10) = 'Belum Lunas'
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @days_late INT;
    DECLARE @penalty_amount DECIMAL(10, 2);

    -- Validasi dan update employee_id jika parameter tidak null
    IF @employee_id IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM Employees WHERE employee_id = @employee_id)
            UPDATE loans SET employee_id = @employee_id WHERE id = @loan_id;
        ELSE
        BEGIN
            SELECT 'Employee Id Not Found !!!' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update total_loan jika parameter tidak null
    IF @total_loan IS NOT NULL
    BEGIN
        UPDATE loans SET total_loan = @total_loan WHERE id = @loan_id;
    END

    -- Update loan_date jika parameter tidak null
    IF @loan_date IS NOT NULL
    BEGIN
        UPDATE loans SET loan_date = @loan_date WHERE id = @loan_id;
    END

    -- Update payment_date jika parameter tidak null dan lebih besar atau sama dengan loan_date
    IF @payment_date IS NOT NULL
    BEGIN
        IF @payment_date >= @loan_date
            UPDATE loans SET payment_date = @payment_date WHERE id = @loan_id;
        ELSE
        BEGIN
            SELECT 'Payment Date is Less Than Loan Date' AS ErrorMessage;
            RETURN;
        END
    END

    -- Update due_date jika parameter tidak null
    IF @due_date IS NOT NULL
    BEGIN
        UPDATE loans SET due_date = @due_date WHERE id = @loan_id;
    END

    -- Menghitung day_late
    IF @payment_date IS NOT NULL AND @due_date IS NOT NULL
    BEGIN
        SET @days_late = DATEDIFF(DAY, @due_date, @payment_date);
    END
    ELSE
    BEGIN
        SET @days_late = 0;
    END

    -- Menghitung penalty_amount
    SET @penalty_amount = CASE
                              WHEN @days_late > 0 THEN @days_late * 5000
                              ELSE 0
                          END;

    -- Update status
    IF @payment_date IS NOT NULL
    BEGIN
        SET @status = 'Lunas';
    END

    -- Update atau insert data pinjaman
    IF EXISTS (SELECT 1 FROM loans WHERE id = @loan_id)
    BEGIN
        UPDATE loans
        SET employee_id = @employee_id,
            total_loan = @total_loan,
            loan_date = @loan_date,
            payment_date = @payment_date,
            due_date = @due_date,
            status = @status,
			days_late = @days_late
        WHERE id = @loan_id;
    END
    ELSE
    BEGIN
        INSERT INTO loans(id, employee_id, total_loan, loan_date, payment_date, due_date, status)
        VALUES (@loan_id, @employee_id, @total_loan, @loan_date, @payment_date, @due_date, @status);
    END

    -- Insert atau update penalty
    IF EXISTS (SELECT 1 FROM penalty WHERE id = @loan_id)
    BEGIN
        UPDATE penalty SET penalty_amount = @penalty_amount WHERE id = @loan_id;
    END
    ELSE
    BEGIN
        INSERT INTO penalty(id, penalty_amount)
        VALUES (@loan_id, @penalty_amount);
    END

    SELECT 'Loan data has been successfully updated.' AS SuccessMessage;
END

EXEC usp_edit_loan
	@loan_id = 1003,
    @employee_id = 110,
	@total_loan = 5000000,
	@loan_date = '2024/06/15',
	@payment_date = '2024/06/21',
	@due_date = '2024/06/20'

EXEC usp_edit_loan
	@loan_id = 1001,
    @employee_id = 207,
	@total_loan = 1000000,
	@loan_date = '2024/06/14',
	@payment_date = '2024/06/22',
	@due_date = '2024/06/16'

EXEC usp_edit_loan
	@loan_id = 1002,
    @employee_id = 205,
	@total_loan = 5000,
	@loan_date = '2024/06/15',
	@payment_date = '2024/06/22',
	@due_date = '2024/06/20'
