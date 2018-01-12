SET NOCOUNT ON
GO

USE master
GO

DROP DATABASE IF EXISTS Tjirp
GO

CREATE DATABASE Tjirp
GO

USE Tjirp
GO

CREATE TABLE Module (
	name					VARCHAR(255)	NOT NULL,
	mandatory				BIT				NOT NULL,
	superModule				VARCHAR(255)    NULL,
	CONSTRAINT PK_Modules PRIMARY KEY (name),
	CONSTRAINT FK_Module_Super FOREIGN KEY (superModule) REFERENCES Module (name)

);

CREATE TABLE "Table" (
	name					VARCHAR(128)	NOT NULL,
	moduleName				VARCHAR(255)	NOT NULL,
	CONSTRAINT PK_Tables PRIMARY KEY (name),
	CONSTRAINT FK_Tables_Modules FOREIGN KEY (moduleName) REFERENCES Module (name)
);

CREATE TABLE TableColumn (
	tableName				VARCHAR(128)	NOT NULL,
	columnName				VARCHAR(128)	NOT NULL,
	columnSequenceNumber	INT				NOT NULL,
	moduleName				VARCHAR(255)	NOT NULL,
	columnType				VARCHAR(128)	NOT NULL,
	mandatory				BIT				NOT NULL,
	CONSTRAINT PK_TableColumn PRIMARY KEY (tableName, columnName),
	CONSTRAINT AK_TableColumn UNIQUE (tableName, columnSequenceNumber),
	CONSTRAINT FK_TableColumn_Table FOREIGN KEY (tableName) REFERENCES "Table"(name),
	CONSTRAINT FK_TableColumn_Module FOREIGN KEY (moduleName) REFERENCES Module(name)
);

CREATE TABLE ProceduralConstraint (
	constraintName				VARCHAR(128)	NOT NULL,
	tableName					VARCHAR(128)	NULL,
	constraintType				VARCHAR(128)    NOT NULL,
	constraintLogic				VARCHAR(MAX)	NOT NULL,
	constraintMetaData			VARCHAR(MAX)	NULL,
	CONSTRAINT PK_ProceduralConstraint PRIMARY KEY (constraintName),
	CONSTRAINT FK_ProceduralConstraint_Table FOREIGN KEY (tableName) REFERENCES "Table" (name)
);

CREATE TABLE DeclarativeConstraint (
	ID 							INT IDENTITY	NOT NULL	PRIMARY KEY,
	tableName					VARCHAR(128)	NOT NULL,
	columnName					VARCHAR(128)	NOT NULL,
	constraintName				VARCHAR(128)	NOT NULL,
	superConstraint				INT				NULL,
	constraintType				VARCHAR(128)	NULL,	
	constraintLogic				VARCHAR(MAX)	NULL,
	CONSTRAINT AK_DeclarativeConstraint UNIQUE (tableName, columnName, constraintName),
	CONSTRAINT FK_DeclarativeConstraint_TableColumn FOREIGN KEY (tableName, columnName) REFERENCES "TableColumn" (tableName, columnName),
	CONSTRAINT FK_DeclarativeConstraint_Super FOREIGN KEY (superConstraint) REFERENCES DeclarativeConstraint (ID)
);
GO

INSERT INTO Module (name, mandatory, superModule) VALUES														('Sales', 1, NULL),
																												('Purchase', 0, NULL),
																												('Stock', 1, NULL),
																												('Employee', 0, 'Sales')

INSERT INTO "Table" (name, moduleName) VALUES																	('Article', 'Stock'),
																												('Component', 'Stock'),
																												('SalesOrder', 'Sales'),
																												('Employee', 'Employee'),
																												('PurchaseOrder', 'Purchase')

INSERT INTO TableColumn (tableName, columnName, columnSequenceNumber, moduleName, columnType, mandatory) VALUES ('Article', 'productId', 1, 'Stock', 'INT', 1),
																												('Article', 'productIdBackup', 2, 'Stock', 'INT', 1),
																												('Article', 'productIdBackup2', 3, 'Stock', 'INT', 1),
																												('Article', 'productIdBackupOtherModule', 4, 'Purchase', 'INT', 1)

GO

CREATE PROC GenerateDDL
	@MODULE1 BIT,
	@MODULE2 BIT,
	@MODULE3 BIT,
	@MODULE4 BIT
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Create and fill the temporary database with the preferences
		DECLARE @PREFERENCES TABLE (moduleName VARCHAR(255) PRIMARY KEY, toBeGenerated INT NOT NULL)
		INSERT INTO @PREFERENCES (moduleName, toBeGenerated) VALUES ('Stock', @MODULE1), ('Purchase', @MODULE2), ('Sales', @MODULE3), ('Employee', @MODULE4)

		-- Generate the tables of the modules
		-- Loopt through all the tables that are in an module that we need to generate
		DECLARE @TABLENAME VARCHAR(128)
		DECLARE CUR_TABLES CURSOR DYNAMIC FOR SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES WHERE toBeGenerated = 1)
		OPEN CUR_TABLES
		FETCH FIRST FROM CUR_TABLES INTO @TABLENAME 
		WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				-- The variable to store the create table sql in
				DECLARE @TABLESQL VARCHAR(MAX) = ''

				-- Add the code and insert the metadata
				SET @TABLESQL += 'CREATE TABLE ' + @TABLENAME + ' ('
				SELECT @TABLESQL = (@TABLESQL + CHAR(13)+CHAR(10) + columnName + ' ' + columnType + ' ' + CASE WHEN mandatory = 1 THEN 'NOT NULL' ELSE 'NULL' END + ',')
					FROM TableColumn
					WHERE tableName = @TABLENAME
					AND moduleName IN (SELECT moduleName FROM @PREFERENCES WHERE toBeGenerated = 1)
				SET @TABLESQL += ',' + CHAR(13)+CHAR(10) + ');'
				SET @TABLESQL = REPLACE(@TABLESQL, ',,', '')
				-- Add two linebreaks
				SET @TABLESQL += CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)

				PRINT @TABLESQL

				-- Get the next record ready
				FETCH NEXT FROM CUR_TABLES INTO @TABLENAME 
			END
			CLOSE CUR_TABLES DEALLOCATE CUR_TABLES
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

EXEC GenerateDDL 1, 0, 1, 1