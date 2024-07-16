CREATE OR ALTER VIEW [dbo].[vw_accounts]
AS
SELECT      id AS EmployeeID, 
			username AS Username, 
			CONVERT(VARCHAR(15), HASHBYTES('SHA2_256', password)) AS Password, 
			otp AS OTP,
			is_expired AS 'Time Expire',
			CASE 
				WHEN is_used = 0 THEN 'Not Used'
				ELSE 'Used'
			END AS 'Status'

FROM            dbo.Accounts
GO

SELECT * FROM [dbo].[vw_accounts]


