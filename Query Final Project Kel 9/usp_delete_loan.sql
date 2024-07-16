CREATE PROCEDURE usp_delete_loan
    @loan_id INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Check loan id
    IF EXISTS (SELECT 1 FROM loans WHERE id = @loan_id)
    BEGIN
        -- If it exists, delete loan
        DELETE FROM loans WHERE id = @loan_id;
        SELECT CONCAT('Loan with id ', @loan_id, ' has been deleted.') AS result_message;
    END
    ELSE
    BEGIN
        -- If it does not exist, show an appropriate message
        SELECT CONCAT('Loan with id ', @loan_id, ' Not Found.') AS result_message;
    END

    -- Commit the transaction if no errors
    COMMIT TRANSACTION;
END
GO

EXEC usp_delete_loan @loan_id = 1002;
