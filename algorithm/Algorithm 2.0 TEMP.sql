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
	CONSTRAINT PK_Modules PRIMARY KEY (name),
);

CREATE TABLE "Table" (
	name					VARCHAR(128)	NOT NULL,
	moduleName				VARCHAR(255)	NOT NULL,
	CONSTRAINT PK_Tables PRIMARY KEY (name),
	CONSTRAINT FK_Tables_Modules FOREIGN KEY (moduleName) REFERENCES Module (name)
);

CREATE TABLE "Column" (
	name					VARCHAR(128)	NOT NULL,
	CONSTRAINT PK_Column PRIMARY KEY(name)
);

CREATE TABLE TableColumn (
	tableName				VARCHAR(128)	NOT NULL,
	columnName				VARCHAR(128)	NOT NULL,
	moduleName				VARCHAR(255)	NULL,
	columnType				VARCHAR(128)	NOT NULL,
	mandatory				BIT				NOT NULL,
	CONSTRAINT PK_TableColumn PRIMARY KEY (tableName, columnName),
	CONSTRAINT FK_TableColumn_Table FOREIGN KEY (tableName) REFERENCES "Table"(name),
	CONSTRAINT FK_TableColumn_Column FOREIGN KEY (columnName) REFERENCES "Column"(name),
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
	constraintName				VARCHAR(128)	NOT NULL	PRIMARY KEY,
	tableName					VARCHAR(128)	NOT NULL,
	referencedTableName			VARCHAR(128)	NULL,
	constraintType				VARCHAR(128)	NULL,	
	constraintLogic				VARCHAR(MAX)	NULL,
	CONSTRAINT FK_DeclarativeConstraint_TableColumn FOREIGN KEY (tableName) REFERENCES "Table" (name),
	CONSTRAINT CK_TypeDeclarative CHECK (constraintType IN ('UNIQUE', 'PRIMARY KEY', 'CHECK', 'FOREIGN KEY'))
);

CREATE TABLE DeclarativeConstraintColumns (
	constraintName				VARCHAR(128)	NOT NULL,
	columnName					VARCHAR(128)	NOT NULL,
	isReferenced				BIT	DEFAULT 0	NOT NULL,
	CONSTRAINT PK_DeclarativeConstraintColumns PRIMARY KEY (constraintName, columnName, isReferenced),
	CONSTRAINT FK_DeclarativeConstraintColumns_Column FOREIGN KEY (columnName) REFERENCES "Column"(name),
	CONSTRAINT FK_DeclarativeConstraint FOREIGN KEY (constraintName) REFERENCES DeclarativeConstraint (constraintName),
);
GO

CREATE TYPE PreferenceTable AS TABLE (
	moduleName VARCHAR(255) PRIMARY KEY
); 
GO 

INSERT INTO Module (name, mandatory) VALUES																									('Sales', 0),
																																			('Purchase', 0),
																																			('Stock', 1),
																																			('Employee', 0)

INSERT INTO "Table" (name, moduleName) VALUES																								('Article', 'Stock'),
																																			('Component', 'Stock'),
																																			('SalesOrder', 'Sales'),
																																			('Employee', 'Employee'),
																																			('PurchaseOrder', 'Purchase')

INSERT INTO "Column" (name) VALUES																											('productId'), 
																																			('productIdBackup'),
																																			('productIdBackup2'),
																																			('productIdBackupOtherModule')

INSERT INTO TableColumn (tableName, columnName, moduleName, columnType, mandatory) VALUES													('Article', 'productId', 'Stock', 'INT', 1),
																																			('Article', 'productIdBackup', 'Stock', 'INT', 1),
																																			('Article', 'productIdBackup2', 'Stock', 'INT', 1),
																																			('Article', 'productIdBackupOtherModule', NULL, 'INT', 1),
																																			('Component', 'productIdBackupOtherModule', NULL, 'INT', 1)

INSERT INTO ProceduralConstraint (constraintName, moduleName, constraintType, tableName, constraintLogic, constraintMetaData) VALUES		('ProcConstraint1', 'Employee', 'TRIGGER', 'Article', 'BEGIN TRY PRINT'''' END TRY BEGIN CATCH ;THROW END CATCH', 'AFTER UPDATE'),
																																			('ProcConstraint2', 'Stock', 'PROC', 'Article', 'BEGIN TRY PRINT'''' END TRY BEGIN CATCH ;THROW END CATCH', '@VAR1 INT')

INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType, constraintLogic) VALUES					('CK_TEST1', 'Article', NULL, 'CHECK', '1 = 1'),
																																			('AK_TEST2', 'Article', NULL, 'UNIQUE', NULL),
																																			('FK_TEST3', 'Article', 'Component', 'FOREIGN KEY', NULL)

INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES													('AK_TEST2', 'productIdBackup', 0),
																																			('AK_TEST2', 'productIdBackup2', 0),
																																			('FK_TEST3', 'productIdBackupOtherModule', 0),
																																			('FK_TEST3', 'productIdBackupOtherModule', 1)

GO

CREATE PROC GenerateDDL
	@PREFERENCEDMODULES PreferenceTable READONLY,
	@SQLOUTPUT VARCHAR(MAX) OUTPUT
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Declare the preference table containing all the modules that must be generated
		DECLARE @PREFERENCES PreferenceTable,
				@SQL VARCHAR(MAX) = ''

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
				-- Add the code and insert the metadata
				SET @SQL += 'CREATE TABLE ' + @TABLENAME + ' ('
				-- Columns
				SELECT @SQL = (@SQL + CHAR(13)+CHAR(10) + columnName + ' ' + columnType + ' ' + CASE WHEN mandatory = 1 THEN 'NOT NULL' ELSE 'NULL' END + ',')
					FROM TableColumn
					WHERE tableName = @TABLENAME
					AND (moduleName IN (SELECT moduleName FROM @PREFERENCES) OR moduleName IS NULL)
				-- Constraints
				SELECT @SQL = (@SQL + CHAR(13)+CHAR(10) + 'CONSTRAINT ' + constraintName + ' ' + constraintType + ' (' + CASE WHEN constraintLogic IS NULL THEN (SELECT (STUFF((SELECT ', ' + DCC.columnName FROM DeclarativeConstraintColumns DCC JOIN DeclarativeConstraint DC ON DC.constraintName = DCC.constraintName WHERE DC.constraintName = D.constraintName FOR XML PATH('')), 1, 2, '')) AS StringValue) ELSE constraintLogic END + '),')
					FROM DeclarativeConstraint D
					WHERE tableName = @TABLENAME
					AND constraintType <> 'FOREIGN KEY'
				SET @SQL += ',' + CHAR(13)+CHAR(10) + ');'
				-- Add two linebreaks
				SET @SQL += CHAR(13)+CHAR(10) + 'GO' + CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)

				-- Get the next record ready
				FETCH NEXT FROM CUR_TABLES INTO @TABLENAME 
			END
		CLOSE CUR_TABLES DEALLOCATE CUR_TABLES

		-- Generate the foreign key constraints
		-- Loopt through all the constraints that are in an module that we need to generate
		DECLARE @FOREIGNKEYNAME VARCHAR(128)
		DECLARE CUR_FOREIGNKEYS CURSOR DYNAMIC FOR SELECT constraintName FROM DeclarativeConstraint WHERE (tableName IN (SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES)) AND referencedTableName IN (SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES))) AND constraintType = 'FOREIGN KEY'
		OPEN CUR_FOREIGNKEYS
		FETCH FIRST FROM CUR_FOREIGNKEYS INTO @FOREIGNKEYNAME 
		WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				DECLARE @FOREIGNKEYCOLUMNS VARCHAR(MAX) = ',',
						@FOREIGNKEYREFERENCEDCOLUMNS VARCHAR(MAX) = ','
				SELECT @FOREIGNKEYCOLUMNS = (@FOREIGNKEYCOLUMNS + ', ' + columnName) FROM DeclarativeConstraintColumns DC JOIN DeclarativeConstraint D ON D.constraintName = DC.constraintName WHERE DC.isReferenced = 0 AND D.constraintName = @FOREIGNKEYNAME
				SELECT @FOREIGNKEYREFERENCEDCOLUMNS = (@FOREIGNKEYREFERENCEDCOLUMNS + ', ' + columnName) FROM DeclarativeConstraintColumns DC JOIN DeclarativeConstraint D ON D.constraintName = DC.constraintName WHERE DC.isReferenced = 1 AND D.constraintName = @FOREIGNKEYNAME
				SELECT @SQL = (@SQL + 'ALTER TABLE ' + tableName + ' ADD CONSTRAINT ' + constraintName + ' FOREIGN KEY (' + @FOREIGNKEYCOLUMNS + ') REFERENCES ' + referencedTableName + ' (' + @FOREIGNKEYREFERENCEDCOLUMNS + ')')
					FROM DeclarativeConstraint
					WHERE constraintName = @FOREIGNKEYNAME
				SET @SQL = REPLACE(@SQL, ',,', '')
				SET @SQL += CHAR(13)+CHAR(10) + 'GO' + CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)

			-- Get the next record ready
				FETCH NEXT FROM CUR_FOREIGNKEYS INTO @FOREIGNKEYNAME 
			END
		CLOSE CUR_FOREIGNKEYS DEALLOCATE CUR_FOREIGNKEYS

		-- Generate the procedural constraints
		-- Loopt through all the constraints that are in an module that we need to generate
		DECLARE @PROCEDURALCONSTRAINTNAME VARCHAR(128)
		DECLARE CUR_PROCEDURALCONSTRAINT CURSOR DYNAMIC FOR SELECT constraintName FROM ProceduralConstraint WHERE (tableName IN (SELECT name FROM "Table" WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES)) OR tableName IS NULL) AND moduleName IN (SELECT moduleName FROM @PREFERENCES)
		OPEN CUR_PROCEDURALCONSTRAINT
		FETCH FIRST FROM CUR_PROCEDURALCONSTRAINT INTO @PROCEDURALCONSTRAINTNAME 
		WHILE (@@FETCH_STATUS <> -1)
			BEGIN
				-- The variable to store the create constraint sql in
				SELECT @SQL = (@SQL + 'CREATE ' + constraintType + ' ' + @PROCEDURALCONSTRAINTNAME + CHAR(13)+CHAR(10))
					FROM ProceduralConstraint
					WHERE constraintName = @PROCEDURALCONSTRAINTNAME
				
				-- Add the ON TABLENAME if the constraint is of type TRIGGER
				IF 'TRIGGER' = (SELECT constraintType FROM ProceduralConstraint WHERE constraintName = @PROCEDURALCONSTRAINTNAME)
					BEGIN
						SELECT @SQL = (@SQL + 'ON ' + tableName + CHAR(13)+CHAR(10))
							FROM ProceduralConstraint
							WHERE constraintName = @PROCEDURALCONSTRAINTNAME
					END

				SELECT @SQL = (@SQL + constraintMetaData + CHAR(13)+CHAR(10) + 'AS BEGIN' + CHAR(13)+CHAR(10) + constraintLogic + CHAR(13)+CHAR(10) + 'END')
					FROM ProceduralConstraint
					WHERE constraintName = @PROCEDURALCONSTRAINTNAME
				SET @SQL += CHAR(13)+CHAR(10) + 'GO' + CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10)

				-- Get the next record ready
				FETCH NEXT FROM CUR_PROCEDURALCONSTRAINT INTO @PROCEDURALCONSTRAINTNAME 
			END

			--PRINT @SQL
			SET @SQLOUTPUT = @SQL

		CLOSE CUR_PROCEDURALCONSTRAINT DEALLOCATE CUR_PROCEDURALCONSTRAINT
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

DECLARE @PREFERENCES AS PreferenceTable,
		@OUTPUT VARCHAR(MAX)
INSERT INTO @PREFERENCES (moduleName) VALUES	('Stock'),
												('Purchase'),
												('Employee'),
												('Sales')

EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
PRINT @OUTPUT