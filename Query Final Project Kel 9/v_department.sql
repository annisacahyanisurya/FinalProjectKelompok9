SELECT [id]
      ,[name]
      ,[location]
  FROM [dbo].[v_department]

SELECT [id]
      ,[name]
      ,[location]
      ,[street_address]
      ,[postal_code]
      ,[city]
      ,[state_province]
      ,[country]
 FROM [dbo].[v_dep_loc]
 WHERE id = 210