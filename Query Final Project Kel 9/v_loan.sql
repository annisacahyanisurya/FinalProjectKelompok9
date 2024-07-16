USE [EmployeeMS]
GO

SELECT [id]
      ,[employee_id]
      ,[first_name]
      ,[last_name]
      ,[total_loan]
      ,[loan_date]
      ,[payment_date]
      ,[due_date]
      ,[status]
      ,[days_late]
  FROM [dbo].[v_loan]

GO
