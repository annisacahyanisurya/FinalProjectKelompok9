-- Select All
SELECT [employee_id]
      ,[first_name]
      ,[last_name]
      ,[gender]
      ,[email]
      ,[phone_number]
      ,[hire_date]
      ,[job_id]
      ,[salary]
      ,[manager_id]
      ,[department_id]
  FROM [dbo].[v_employee]

  --Select Detail
 SELECT [employee_id]
      ,[first_name]
      ,[gender]
      ,[last_name]
      ,[email]
      ,[phone_number]
      ,[hire_date]
      ,[JOB_TITLE]
      ,[MIN_SALARY]
      ,[MAX_SALARY]
      ,[salary]
      ,[manager_id]
      ,[name]
      ,[location]
 FROM [dbo].[v_detail_employee]
 WHERE employee_id = 126