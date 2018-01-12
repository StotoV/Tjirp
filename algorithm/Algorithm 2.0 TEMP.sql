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
	columnSequenceNumber			INT		NOT NULL,
	moduleName				VARCHAR(255)	NOT NULL,
	columnType				VARCHAR(128)	NOT NULL,
	mandatory				BIT		NOT NULL,
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

CREATE PROC GenerateDDL
	@MODULE1 BIT,
	@MODULE2 BIT
AS BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- Create and fill the temporary database with the preferences
		DECLARE @PREFERENCES TABLE (moduleName VARCHAR(255) PRIMARY KEY)

		-- Generate the collumns of the selected tables
		SELECT * FROM TableColumn WHERE moduleName IN (SELECT moduleName FROM @PREFERENCES)
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO