CREATE TABLE Module (
	name					VARCHAR(255)	NOT NULL,
	toBeGenerated			BIT				NOT NULL,
	mandatory				BIT				NOT NULL
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
	columnSequenceNumber	INT				NOT NULL,
	moduleName				VARCHAR(255)	NOT NULL,
	columnType				VARCHAR(128)	NOT NULL,
	mandatory				BIT				NOT NULL,
	referentialTableName	VARCHAR(128)	NULL,		--parent table
	referentialColumnName	VARCHAR(128)	NULL,
	CONSTRAINT PK_TableColumn PRIMARY KEY (tableName, columnName),
	CONSTRAINT AK_TableColumn UNIQUE (tableName, columnSequenceNumber),
	CONSTRAINT FK_TableColumn_Table FOREIGN KEY (tableName) REFERENCES "Table"(name),
	CONSTRAINT FK_TableColumn_Module FOREIGN KEY (moduleName) REFERENCES Module(name)
);

CREATE TABLE TableConstraint (
	tableName				VARCHAR(128)	NOT NULL,
	constraintName			VARCHAR(128)	NOT NULL,
	constraintCode			VARCHAR(MAX)	NOT NULL,
	CONSTRAINT PK_TableConstraint PRIMARY KEY (tableName, constraintName),
	CONSTRAINT FK_TableConstraint_Table FOREIGN KEY (tableName) REFERENCES "Table" (name)
);

CREATE TABLE TableColumnConstraint (
	tableName				VARCHAR(128)	NOT NULL,
	columnName				VARCHAR(128)	NOT NULL,
	constraintName			VARCHAR(128)	NOT NULL,
	constraintType			VARCHAR(128)	NOT NULL,	--zou CHECK kunnen zijn of PK/AK/FK (maar deze laatste drie zouden ook attributen kunnen zijn)
	--primaryKey			BIT				NOT NULL,
	--uniqueKey				BIT				NOT NULL,
	--foreignKey			BIT				NOT NULL,	--is 1 als referentialColumnName en referentialTableName beide ingevuld zijn
	--"check"				BIT				NOT NULL,
	constraintCode			VARCHAR(MAX)	NULL,
	CONSTRAINT PK_TableOrColumnConstraint PRIMARY KEY (tableName, columnName, constraintName),
	CONSTRAINT FK_TableOrColumnConstraint_TableColumn FOREIGN KEY (tableName, columnName) REFERENCES "TableColumn" (tableName, columnName)
);