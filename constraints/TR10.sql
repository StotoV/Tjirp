--BR07 - TR10

IF DB_ID('BR07_TR10') IS NULL
     CREATE DATABASE BR07_TR10
GO

USE BR07_TR10
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Article_in_Unit'))
    DROP TABLE Article_in_Unit
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'SalesOrderLine'))
    DROP TABLE SalesOrderLine
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Article'))
    DROP TABLE Article
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Unit'))
    DROP TABLE Unit
GO

CREATE TABLE Article(
	articleNo						INT
	CONSTRAINT PK_Article PRIMARY KEY (articleNo)
)

CREATE TABLE Unit(
	name							VARCHAR(100),
	CONSTRAINT PK_Unit PRIMARY KEY (name)
)

CREATE TABLE Article_in_Unit(
	Article_articleNo				INT,
	Unit_name						VARCHAR(100),
	CONSTRAINT PK_Article_in_Unit PRIMARY KEY (Article_articleNo, Unit_name),
	CONSTRAINT FK_Article_in_Unit_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
	CONSTRAINT FK_Article_in_Unit_Unit FOREIGN KEY (Unit_name) REFERENCES Unit(name)
)

CREATE TABLE SalesOrderLine(
	PurchaseOrder_orderNo			INT,
	PurchaseOrder_referenceNo		VARCHAR(30),
	lineNum							INT,
	Article_articleNo				INT,
	Unit_name						VARCHAR(100),
	CONSTRAINT PK_SalesOrderLine PRIMARY KEY (PurchaseOrder_orderNo, PurchaseOrder_referenceNo, lineNum),
	CONSTRAINT FK_SalesOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
	CONSTRAINT FK_SalesOrderLine_Unit FOREIGN KEY (Unit_name) REFERENCES Unit(name)
);

INSERT INTO Article(articleNo) 
	VALUES(1), 
		(2), 
		(3),
		(4),
		(5);
INSERT INTO Unit(name)
	VALUES('unit1'),
		('unit2')
INSERT INTO Article_in_Unit
	VALUES(1, 'unit1'),
		(2, 'unit1'),
		(3, 'unit1'),
		(4, 'unit1'),
		(5, 'unit1')
INSERT INTO SalesOrderLine VALUES (1, 'ref1', 1, 1, 'unit1'), (2, 'ref2', 2, 2, 'unit2');
GO

DROP TRIGGER IF EXISTS TR10_PURCHASE_UNIT_NAME_IN_UNIT_IN_ARTICLE;GO
CREATE TRIGGER TR10_PURCHASE_UNIT_NAME_IN_UNIT_IN_ARTICLE
	ON SalesOrderLine
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY

	IF EXISTS (SELECT
						1
					FROM
						inserted i
					WHERE Unit_name = (
						SELECT
							Unit_name
						FROM
							Article_in_Unit
						WHERE
							Article_articleNo != i.Article_articleNo
						AND
							Unit_name != i.Unit_name
					))
		BEGIN
			;THROW 50001,'The specified unit name in the order line does not exist with the specified article number',1
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

BEGIN TRAN
    BEGIN TRY
		-- Success scenario
        -- Insert order line with article 1 and 2 that belong to unit1
		INSERT INTO SalesOrderLine
			VALUES(1, '1A', 6, 1, 'unit1'),
				(1, '1A', 7, 2, 'unit1')
        PRINT 'Test BR07 - TR10 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 01 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert order line with article 3 and 4 that belong to unit2
		-- None of the records should get inserted
		INSERT INTO SalesOrderLine
		-- Insert order line with article 3 that belongs to unit1 (which should not violate the constraint by itself)
			VALUES(1, '1A', 8, 3, 'unit1'),
				-- Insert order line with article 4 and 5 that don't belong to unit2
				(1, '1A', 9, 4, 'unit2'),
				(1, '1A', 10, 5, 'unit2')
        PRINT 'Test BR07 - TR10 - 02 Failed'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 02 Succeeded'
    END CATCH
ROLLBACK TRAN

SELECT * FROM Article
SELECT * FROM Unit
SELECT * FROM Article_in_Unit
SELECT * FROM SalesOrderLine

--DELETE FROM SalesOrderLine
--DELETE FROM Article_in_Unit
--DELETE FROM Article
--DELETE FROM Unit

SELECT * FROM Unit;
SELECT * FROM Article_in_Unit
WHERE Article_articleNo = 1;