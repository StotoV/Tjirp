CREATE TABLE Module (
	name					VARCHAR(255)	NOT NULL,
	mandatory				BIT		NOT NULL,
	superModule				VARCHAR(255)    NULL,
	CONSTRAINT PK_Modules PRIMARY KEY (name)
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

CREATE TABLE NonDeclarativeConstraint (
	constraintName				VARCHAR(128)	NOT NULL,
	tableName				VARCHAR(128)	NULL,
	constraintType				VARCHAR(128)    NOT NULL,
	constraintLogic				VARCHAR(MAX)	NOT NULL,
	constraintMetaData			VARCHAR(MAX)	NULL,
	CONSTRAINT PK_TableConstraint PRIMARY KEY (constraintName),
	CONSTRAINT FK_TableConstraint_Table FOREIGN KEY (tableName) REFERENCES "Table" (name)
);

CREATE TABLE DeclarativeConstraint (
	ID 					INT IDENTITY	NOT NULL,
	tableName				VARCHAR(128)	NOT NULL,
	columnName				VARCHAR(128)	NOT NULL,
	constraintName				VARCHAR(128)	NOT NULL,
	superConstraint				INT		NULL,
	constraintType				VARCHAR(128)	NULL,	
	constraintLogic				VARCHAR(MAX)	NULL,
	CONSTRAINT AK_TableOrColumnConstraint UNIQUE (tableName, columnName, constraintName),
	CONSTRAINT FK_TableOrColumnConstraint_TableColumn FOREIGN KEY (tableName, columnName) REFERENCES "TableColumn" (tableName, columnName),
	CONSTRAINT FK_SuperConstraint FOREIGN KEY (superConstraint) REFERENCES DeclarativeConstraint (ID)
);
