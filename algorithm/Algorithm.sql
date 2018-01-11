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

CREATE TABLE modules (
	id						INT				NOT NULL	PRIMARY KEY		IDENTITY(1,1),
	moduleName				VARCHAR(255)	NOT NULL	UNIQUE,
	superModule				INT				NULL,
	toBeGenerated			BIT				NOT NULL,
	SQLCode					VARCHAR(MAX)	NOT NULL
);

CREATE TABLE relations (
	relationName			VARCHAR(255)	NOT NULL	PRIMARY KEY,
	tableOne				VARCHAR(128)	NOT NULL,
	tableTwo				VARCHAR(128)	NOT NULL,
	SQLCode					VARCHAR(MAX)	NOT NULL
);

CREATE TABLE constraints (
	id						INT				NOT NULL	PRIMARY KEY		IDENTITY(1,1),
	tableOfConstraint		VARCHAR(128)	NOT NULL,
	SQLCode					VARCHAR(MAX)	NOT NULL
);

CREATE TABLE constraintsInTables (
	constraintId			INT				NOT NULL,
	tableOfConstraint		VARCHAR(128)	NOT NULL,
	CONSTRAINT PK_constraintsInTables PRIMARY KEY (constraintId, tableOfConstraint)
);
GO

CREATE PROC GenerateDDL
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Loop through the modules table to generate the modules
		DECLARE @COUNT INT = 1
		WHILE @COUNT <= (SELECT COUNT(*) FROM modules)
			BEGIN
				-- Print SQL code if the record needs to be generated and the record is has no superrecords
				IF (SELECT toBeGenerated FROM modules WHERE id = @COUNT) = 1 AND (SELECT superModule FROM modules WHERE id = @COUNT) IS NULL
					BEGIN
						DECLARE @SQL VARCHAR(MAX) = (SELECT SQLCode FROM modules WHERE id = @COUNT)
						PRINT @SQL
						EXEC (@SQL)

						-- Loop through the records that has the current record as superrecord by creating a temp table with all the subrecords
						DECLARE @COUNTSUB INT = 1;
						SELECT subId = ROW_NUMBER() OVER(ORDER BY(SELECT NULL)), * INTO TempWithSubs FROM modules WHERE superModule = @COUNT
						WHILE @COUNTSUB <= (SELECT COUNT(*) FROM TempWithSubs)
							BEGIN
								DECLARE @SUBSQL VARCHAR(MAX) = (SELECT SQLCode FROM TempWithSubs WHERE subId = @COUNTSUB)

								PRINT @SUBSQL
								EXEC (@SUBSQL)

								-- Increase count
								SET @COUNTSUB = @COUNTSUB + 1
							END

						DROP TABLE TempWithSubs
					END

				-- Increase count
				SET @COUNT = @COUNT + 1
			END

		-- Select all the relations of which the tables exist and add them to te variable
		DECLARE @RELATIONSQL VARCHAR(MAX) = ''
		SELECT @RELATIONSQL = (@RELATIONSQL + SQLCode + CHAR(13)+CHAR(10)) FROM relations
			WHERE EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = tableOne)
			AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = tableTwo)

		PRINT @RELATIONSQL
		EXEC(@RELATIONSQL)

		-- Select all the constraints of which the needed tables exists
		DECLARE @CONSTRAINTSQL VARCHAR(MAX) = ''
		SELECT @CONSTRAINTSQL = (@CONSTRAINTSQL + SQLCode + CHAR(13)+CHAR(10)) FROM constraints C
			WHERE EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = tableOfConstraint)
			AND NOT EXISTS (SELECT *
								FROM constraintsInTables CT
								WHERE CT.constraintId = C.id
								AND CT.tableOfConstraint NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES))

		PRINT @CONSTRAINTSQL
		EXEC (@CONSTRAINTSQL)
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

CREATE PROC InsertSQLAndPreferences
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Insert SQL code and the preferences
		INSERT INTO modules (moduleName, toBeGenerated, SQLCode, superModule) VALUES	('test', 1, 'CREATE TABLE ONE (id INT NOT NULL PRIMARY KEY);', NULL),
																						('test2', 1, 'CREATE TABLE TWO (id INT NOT NULL PRIMARY KEY);', NULL),
																						('test3', 0, 'CREATE TABLE THREE (id INT NOT NULL PRIMARY KEY);', NULL),
																						('test4', 1, 'ALTER TABLE ONE ADD test1 INT NOT NULL', 1),
																						('test5', 1, 'ALTER TABLE ONE ADD test2 INT NOT NULL', 1),
																						('test6', 1, 'ALTER TABLE THREE ADD test1 INT NOT NULL', 3)

		INSERT INTO relations (relationName, tableOne, tableTwo, SQLCode) VALUES		('oneTwo', 'ONE', 'TWO', 'ALTER TABLE ONE ADD FOREIGN KEY (id) REFERENCES TWO(id)'),
																						('oneThree', 'ONE', 'THREE', 'ALTER TABLE ONE ADD FOREIGN KEY (id) REFERENCES THREE(id)')

		INSERT INTO constraints (tableOfConstraint, SQLCode) VALUES						('ONE', 'ALTER TABLE ONE ADD CONSTRAINT CK_TEST1 CHECK(id != 0)'),
																						('TWO', 'ALTER TABLE TWO ADD CONSTRAINT CK_TEST2 CHECK(id != 0)')

		INSERT INTO constraintsInTables (constraintId, tableOfConstraint) VALUES		(1, 'ONE'),
																						(1, 'TWO'),
																						(1, 'THREE'),
																						(2, 'TWO')

		-- Execute the GenerateDDL proc
		EXEC GenerateDDL
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

EXEC InsertSQLAndPreferences