----Check TDE on SQL Server Instance
SELECT DB_Name(database_id) As DBName, encryption_state, encryption_state_desc
FROM sys.dm_database_encryption_keys;
GO

SELECT name, is_encrypted
FROM sys.databases;
GO

-- Turn Off Database Encryption
USE master;
GO
ALTER DATABASE DbRonak SET ENCRYPTION OFF;
GO

-- Drop Database Encryption Key
USE DbRonak;
GO
DROP DATABASE ENCRYPTION KEY;
GO

-- Drop Certificate
USE master;
GO
DROP CERTIFICATE webportal_certi;
GO

-- Drop Master Key
USE master;
GO
DROP MASTER KEY;
GO