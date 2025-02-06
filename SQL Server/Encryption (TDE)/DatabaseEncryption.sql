-- Create Master Key
USE master;
GO 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'WebPortal@1004';
GO

-- Verify Master Key
SELECT name,create_date,modify_date FROM sys.symmetric_keys;
GO

-- Create The Certificate in Master Database
CREATE CERTIFICATE webportal_certi WITH SUBJECT = 'WebPortal';
GO

-- Verify Certificate
SELECT name,issuer_name,start_date,expiry_date FROM sys.certificates WHERE issuer_name = 'WebPortal';
GO

-- Backup Master Key
USE master;
GO
BACKUP SERVICE MASTER KEY TO FILE = 'D:\Ronak\Encryption\MasterKey.key' ENCRYPTION BY PASSWORD = 'WebPortal@1004';
GO

-- Backup Data Master Key
BACKUP MASTER KEY TO FILE = 'D:\Ronak\Encryption\DBMasterKey.key' ENCRYPTION BY PASSWORD = 'WebPortal@1004';
GO

-- Backup Certificate 
BACKUP CERTIFICATE webportal_certi TO FILE = 'D:\Ronak\Encryption\certificate.cert'
WITH PRIVATE KEY (FILE = 'D:\Ronak\Encryption\certificatekey.prvk', ENCRYPTION BY PASSWORD = 'WebPortal@1004');
GO

-- Create Database Encryption Key in the User Database
USE DbRonak;
GO
CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE webportal_certi;
GO

-- Turn On Database Encryption
ALTER DATABASE DbRonak SET ENCRYPTION ON;
GO

-- Verify Database Encryption 
SELECT DB_NAME(database_id),encryption_state,encryptor_type FROM sys.dm_database_encryption_keys;
GO