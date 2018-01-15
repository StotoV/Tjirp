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
	moduleName					VARCHAR(255)	NOT NULL,
	constraintType				VARCHAR(128)    NOT NULL,
	constraintLogic				VARCHAR(MAX)	NOT NULL,
	constraintMetaData			VARCHAR(MAX)	NULL,
	CONSTRAINT PK_ProceduralConstraint PRIMARY KEY (constraintName),
	CONSTRAINT FK_ProceduralConstraint_Table FOREIGN KEY (tableName) REFERENCES "Table" (name),
	CONSTRAINT FK_ProceduralConstraint_Module FOREIGN KEY (moduleName) REFERENCES Module(name),
	CONSTRAINT CK_TypeProcedural CHECK (constraintType IN ('TRIGGER', 'PROC'))
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
	CONSTRAINT FK_DeclarativeConstraint_Super FOREIGN KEY (superConstraint) REFERENCES DeclarativeConstraint (ID),
	CONSTRAINT CK_TypeDeclarative CHECK (constraintType IN ('UNIQUE', 'PRIMARY KEY', 'CHECK', 'FOREIGN KEY', 'DEFAULT'))
);
GO

CREATE TYPE PreferenceTable AS TABLE (
	moduleName VARCHAR(255) PRIMARY KEY
); 
GO 

INSERT INTO Module (name, mandatory, superModule) VALUES																					('Sales', 0, NULL),
																																			('Purchase', 0, NULL),
																																			('Stock', 1, NULL),
																																			('Employee', 0, 'Sales')

INSERT INTO "Table" (name, moduleName) VALUES																								('Article', 'Stock'),
																																			('Component', 'Stock'),
																																			('SalesOrder', 'Sales'),
																																			('Employee', 'Employee'),
																																			('PurchaseOrder', 'Purchase')

INSERT INTO TableColumn (tableName, columnName, columnSequenceNumber, moduleName, columnType, mandatory) VALUES								('Article', 'productId', 1, 'Stock', 'INT', 1),
																																			('Article', 'productIdBackup', 2, 'Stock', 'INT', 1),
																																			('Article', 'productIdBackup2', 3, 'Stock', 'INT', 1),
																																			('Article', 'productIdBackupOtherModule', 4, 'Purchase', 'INT', 1)

INSERT INTO ProceduralConstraint (constraintName, moduleName, constraintType, tableName, constraintLogic, constraintMetaData) VALUES		('ProcConstraint1', 'Employee', 'TRIGGER', 'Article', 'BEGIN TRY PRINT'''' END TRY BEGIN CATCH ;THROW END CATCH', 'AFTER UPDATE'),
																																			('ProcConstraint2', 'Stock', 'PROC', 'Article', 'BEGIN TRY PRINT'''' END TRY BEGIN CATCH ;THROW END CATCH', '@VAR1 INT')
GO

CREATE PROC GenerateDDL
	@PREFERENCEDMODULES PreferenceTable READONLY
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Declare the preference table containing all the modules that must be generated
		DECLARE @PREFERENCES PreferenceTable

		-- Insert all the mandatory modules and preferenced modules into the preferences variable
		INSERT INTO @PREFERENCES (moduleName) SELECT name FROM (SELECT name FROM Module WHERE mandatory = 1 UNION SELECT moduleName AS name FROM @PREFERENCEDMODULES) AS ALLMODULES

		-- Generate the tables of the modules
		-- Loopt through all the tables that are in an module that we need to generate
		DECLARE @TABLENAME VARCHAR(128)
		DECLARE CUR_TABLES CURSOR DYNAMIC FOR SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES)
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
					AND moduleName IN (SELECT moduleName FROM @PREFERENCES)
				SET @TABLESQL += ',' + CHAR(13)+CHAR(10) + ');'
				SET @TABLESQL = REPLACE(@TABLESQL, ',,', '')
				-- Add two linebreaks
				SET @TABLESQL += CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)

				PRINT @TABLESQL

				-- Get the next record ready
				FETCH NEXT FROM CUR_TABLES INTO @TABLENAME 
			END
		CLOSE CUR_TABLES DEALLOCATE CUR_TABLES

		-- Generate the procedural constraints
		-- Loopt through all the constraints that are in an module that we need to generate
		DECLARE @PROCEDURALCONSTRAINTNAME VARCHAR(128)
		DECLARE CUR_PROCEDURALCONSTRAINT CURSOR DYNAMIC FOR SELECT constraintName FROM ProceduralConstraint WHERE (tableName IN (SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES)) OR tableName IS NULL) AND moduleName IN (SELECT moduleName FROM @PREFERENCES)
		OPEN CUR_PROCEDURALCONSTRAINT
		FETCH FIRST FROM CUR_PROCEDURALCONSTRAINT INTO @PROCEDURALCONSTRAINTNAME 
		WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				-- The variable to store the create constraint sql in
				DECLARE @PROCEDURALCONSTRAINTSQL VARCHAR(MAX) = ''
				SELECT @PROCEDURALCONSTRAINTSQL = (@PROCEDURALCONSTRAINTSQL + 'CREATE ' + constraintType + ' ' + @PROCEDURALCONSTRAINTNAME + CHAR(13)+CHAR(10))
					FROM ProceduralConstraint
					WHERE constraintName = @PROCEDURALCONSTRAINTNAME
				
				-- Add the ON TABLENAME if the constraint is of type TRIGGER
				IF 'TRIGGER' = (SELECT constraintType FROM ProceduralConstraint WHERE constraintName = @PROCEDURALCONSTRAINTNAME)
					BEGIN
						SELECT @PROCEDURALCONSTRAINTSQL = (@PROCEDURALCONSTRAINTSQL + 'ON ' + tableName + CHAR(13)+CHAR(10))
							FROM ProceduralConstraint
							WHERE constraintName = @PROCEDURALCONSTRAINTNAME
					END

				SELECT @PROCEDURALCONSTRAINTSQL = (@PROCEDURALCONSTRAINTSQL + constraintMetaData + CHAR(13)+CHAR(10) + 'AS BEGIN' + CHAR(13)+CHAR(10) + constraintLogic + CHAR(13)+CHAR(10) + 'END')
					FROM ProceduralConstraint
					WHERE constraintName = @PROCEDURALCONSTRAINTNAME
				SET @PROCEDURALCONSTRAINTSQL += CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)
				PRINT @PROCEDURALCONSTRAINTSQL

				-- Get the next record ready
				FETCH NEXT FROM CUR_PROCEDURALCONSTRAINT INTO @PROCEDURALCONSTRAINTNAME 
			END
		CLOSE CUR_PROCEDURALCONSTRAINT DEALLOCATE CUR_PROCEDURALCONSTRAINT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

DECLARE @PREFERENCES AS PreferenceTable
INSERT INTO @PREFERENCES (moduleName) VALUES	('Stock'),
												('Purchase'),
												('Employee'),
												('Sales')
EXEC GenerateDDL @PREFERENCES