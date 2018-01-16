'/*
=======================================================
-- Create DB & Tables ==
=======================================================
*/'

SET NOCOUNT ON
GO

USE master
GO

/**DROP DATABASE TjirpTest
GO**/

CREATE DATABASE TjirpTest
GO

USE TjirpTest
GO

CREATE TABLE Article(
	articleNo						INT,
	amount							INT,
	maxTemperature					DECIMAL,
	minTemperature					DECIMAL,
    "weight"						DECIMAL,

	CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE Unit(
	name							VARCHAR(100),
	CONSTRAINT PK_Unit PRIMARY KEY (name)
)

CREATE TABLE ArticleInLocation (
    Article_ArticleNo INT,
    Location_address VARCHAR(150),
    amount INT,

    CONSTRAINT PK_ArticleInLocation PRIMARY KEY (Article_ArticleNo, Location_address),
    CONSTRAINT FK_ArticleInLocation_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo)
);

CREATE TABLE StorageCube(
    Location_address VARCHAR(150),
    referenceNo INT,
    maxWeight DECIMAL,

    CONSTRAINT pk_StorageCube PRIMARY KEY (Location_address, referenceNo)
);

CREATE TABLE ArticleInStorageCube (
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(150),
    StorageCube_referenceNo INT,
    amount INT,

    CONSTRAINT PK_ArticleInCube PRIMARY KEY (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_Article_Cube FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
    CONSTRAINT FK_Article_StorageCube FOREIGN KEY (StorageCube_Location_address, StorageCube_referenceNo) REFERENCES StorageCube (Location_address, referenceNo)
);

CREATE TABLE Supply (
    supplyNo INT,
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(150),
    StorageCube_referenceNo INT,
    amount DECIMAL,

    CONSTRAINT PK_SupplyNo PRIMARY KEY (supplyNo),
    CONSTRAINT FK_Supply_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
    CONSTRAINT FK_Supply_StorageCube FOREIGN KEY (StorageCube_Location_address, StorageCube_referenceNo) REFERENCES StorageCube (Location_address, referenceNo)
);

CREATE TABLE Product (
    Article_articleNo INT,
    serialNo INT,
    Supply_supplyNo INT,

    CONSTRAINT PK_Product PRIMARY KEY (Article_articleNo, serialNo),
    CONSTRAINT FK_Product_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_Product_Supply FOREIGN KEY (Supply_supplyNo) REFERENCES Supply (supplyNo)
);

CREATE TABLE PurchaseInvoice(
	invoiceNo		INT,
	referenceNo		VARCHAR(30),
	date			DATETIME,
	paymentDate		DATETIME,
	CONSTRAINT PK_PurchaseInvoice PRIMARY KEY (invoiceNo, referenceNo)
);

CREATE TABLE PurchaseInvoiceLine(
	PurchaseInvoice_invoiceNo		INT,
	PurchaseInvoice_referenceNo		VARCHAR(30),
	lineNum							INT,
	Article_articleNo				INT,
	amount							INT,
	CONSTRAINT PK_PurchaseInvoiceLine PRIMARY KEY (lineNum),
	CONSTRAINT FK_PurchaseInvoiceLine_PurchaseInvoice FOREIGN KEY (PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo) REFERENCES PurchaseInvoice(invoiceNo, referenceNo)
);

CREATE TABLE PurchasePayment(
	paymentNo						INT,
	PurchaseInvoice_invoiceNo		INT,
	PurchaseInvoice_referenceNo		VARCHAR(30),
	amount							INT,
	date							DATETIME,
	CONSTRAINT PK_PurchasePayment PRIMARY KEY (paymentNo),
	CONSTRAINT FK_PurchasePayment_PurchaseInvoice FOREIGN KEY (PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo) REFERENCES PurchaseInvoice(invoiceNo, referenceNo)
);

CREATE TABLE SalesInvoice(
	invoiceNo		INT,
	referenceNo		VARCHAR(30),
	date			DATETIME,
	paymentDate		DATETIME,
	CONSTRAINT PK_SalesInvoice PRIMARY KEY (invoiceNo, referenceNo)
);

CREATE TABLE SalesInvoiceLine(
	SalesInvoice_invoiceNo		INT,
	SalesInvoice_referenceNo		VARCHAR(30),
	lineNum							INT,
	Article_articleNo				INT,
	amount							INT,
	CONSTRAINT PK_SalesInvoiceLine PRIMARY KEY (lineNum),
	CONSTRAINT FK_SalesInvoiceLine_SalesInvoice FOREIGN KEY (SalesInvoice_invoiceNo, SalesInvoice_referenceNo) REFERENCES SalesInvoice(invoiceNo, referenceNo)
);

CREATE TABLE SalesPayment(
	paymentNo						INT,
	SalesInvoice_invoiceNo			INT,
	SalesInvoice_referenceNo		VARCHAR(30),
	amount							INT,
	date							DATETIME,
	CONSTRAINT PK_SalesPayment PRIMARY KEY (paymentNo),
	CONSTRAINT FK_SalesPayment_SalesInvoice FOREIGN KEY (SalesInvoice_invoiceNo, SalesInvoice_referenceNo) REFERENCES SalesInvoice(invoiceNo, referenceNo)
);

CREATE TABLE PurchaseOrder(
    orderNo INT,
    referenceNo INT,
	superOderNo INT,
	superOderReferenceNo INT

    CONSTRAINT PK_PurchaseOrder PRIMARY KEY (orderNo,referenceNo),
	CONSTRAINT FK_PurchaseOrder_SuperOrder FOREIGN KEY (superOderNo,superOderReferenceNo) REFERENCES PurchaseOrder(orderNo,referenceNo)
);


CREATE TABLE Article_in_Unit(
	Article_articleNo				INT,
	Unit_name						VARCHAR(100),
	CONSTRAINT PK_Article_in_Unit PRIMARY KEY (Article_articleNo, Unit_name),
	CONSTRAINT FK_Article_in_Unit_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
	CONSTRAINT FK_Article_in_Unit_Unit FOREIGN KEY (Unit_name) REFERENCES Unit(name)
)

CREATE TABLE PurchaseOrderLine (
    PurchaseOrder_orderNo INT,
    PurchaseOrder_referenceNo VARCHAR(30),
    "lineNo" INT, -- lineNo is a reserved keyword
    Supply_supplyNo INT,
    Article_articleNo INT,
    ArticleInStorageCube_StorageCube_Location_address VARCHAR(150),
    ArticleInStorageCube_StorageCube_referenceNo INT,
    ArticleInLocation_Location_address VARCHAR (150),
    amount INT,
	Unit_name						VARCHAR(100),

    CONSTRAINT PK_PurchaseOrderLine PRIMARY KEY (PurchaseOrder_OrderNo, PurchaseOrder_referenceNo, "lineNo"),
    CONSTRAINT FK_PurchaseOrderLine_Supply FOREIGN KEY (Supply_supplyNo) REFERENCES Supply (supplyNo),
    CONSTRAINT FK_PurchaseOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_PurchaseOrderLine_ArticleInStorageCube FOREIGN KEY (Article_articleNo, ArticleInStorageCube_StorageCube_Location_address, ArticleInStorageCube_StorageCube_referenceNo)
        REFERENCES ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_PurchaseOrderLine_ArticleInLocation FOREIGN KEY (Article_articleNo, ArticleInLocation_Location_address) REFERENCES ArticleInLocation (Article_articleNo, Location_address),
	CONSTRAINT FK_PurchaseOrderLine_Unit FOREIGN KEY (Unit_name) REFERENCES Unit(name)
);

CREATE TABLE SalesOrder(
    orderNo INT,
    referenceNo VARCHAR(30),
	superOderNo INT,
	superOderReferenceNo INT

    CONSTRAINT PK_SalesOrder PRIMARY KEY (orderNo,referenceNo),
	CONSTRAINT FK_SalesOrder_SuperOrder FOREIGN KEY (superOderNo,superOderReferenceNo) REFERENCES SalesOrder(orderNo,referenceNo)
);


CREATE TABLE SalesOrderLine(
    SalesOrder_orderNo INT,
    SalesOrder_referenceNo VARCHAR(30),
	"lineNo" INT, -- lineNo is a reserved keyword
	Supply_supplyNo INT,
    Article_articleNo INT,
    ArticleInStorageCube_StorageCube_Location_address VARCHAR(150),
    ArticleInStorageCube_StorageCube_referenceNo INT,
    ArticleInLocation_Location_address VARCHAR (150),
    amount INT,
	Unit_name						VARCHAR(100),

   CONSTRAINT PK_SalesOrderLine PRIMARY KEY (SalesOrder_OrderNo, SalesOrder_referenceNo, "lineNo"),
    CONSTRAINT FK_SalesOrderLine_Supply FOREIGN KEY (Supply_supplyNo) REFERENCES Supply (supplyNo),
    CONSTRAINT FK_SalesOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_SalesOrderLine_ArticleInStorageCube FOREIGN KEY (Article_articleNo, ArticleInStorageCube_StorageCube_Location_address, ArticleInStorageCube_StorageCube_referenceNo)
        REFERENCES ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_SalesOrderLine_ArticleInLocation FOREIGN KEY (Article_articleNo, ArticleInLocation_Location_address) REFERENCES ArticleInLocation (Article_articleNo, Location_address),
	CONSTRAINT FK_SalesOrderLine_Unit FOREIGN KEY (Unit_name) REFERENCES Unit(name)
);




'/*
=======================================================
-- Constraints 1 t/m 11 ==
=======================================================
*/'


/** CK 1 **/

ALTER TABLE Article
ADD CONSTRAINT CK01_TEMPERATURE
	CHECK (maxTemperature >= minTemperature)
GO



/** Constraint 1 **/

CREATE TRIGGER
    TR01_Supply
ON Supply
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
                        Article a INNER JOIN inserted i
                        ON i.Article_articleNo = a.articleNo
                        INNER JOIN StorageCube sc
                        ON sc.Location_address = i.StorageCube_Location_address
                            AND sc.referenceNo = i.StorageCube_referenceNo
                    WHERE
                        (i.amount * a.weight) + (
                            SELECT
                                s.amount * art.weight
                            FROM
                                Article art INNER JOIN Supply s
                                ON s.Article_articleNo = art.articleNo
                            WHERE
                                art.articleNo = a.articleNo
                            AND
                                s.supplyNo = i.supplyNo
                        ) > sc.maxWeight)
        BEGIN
            ;THROW 50000, 'The total weight of the supply cannot exceed the total maximum weight allowed in the storagecube', 1
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 2 **/

CREATE TRIGGER
    TR02_ArticleInStorageCube
ON ArticleInStorageCube
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
                        Article a INNER JOIN inserted i
                        ON i.Article_articleNo = a.articleNo
                        INNER JOIN StorageCube sc
                        ON sc.Location_address = i.StorageCube_Location_address
                            AND sc.referenceNo = i.StorageCube_referenceNo
                    WHERE
                        (i.amount * a.weight) > sc.maxWeight)
        BEGIN
            ;THROW 50000, 'The total weight of the ArticleInStorageCube cannot exceed the total maximum weight allowed in the storagecube', 1
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 3 **/

CREATE TRIGGER
    TR03_Product
ON Product
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
                        Article a inner join inserted i
                        ON i.Article_articleNo = a.articleNo
                        INNER JOIN Supply s
                        ON s.supplyNo = i.Supply_supplyNo
                        INNER JOIN StorageCube sc
                        ON sc.Location_address = s.StorageCube_Location_address
                            AND sc.referenceNo = s.StorageCube_referenceNo
                    WHERE
                        (s.amount * a.weight) + (
                            SELECT
                                (sup.amount * art.weight)
                            FROM
                                Article art INNER JOIN Supply sup ON
                                sup.Article_articleNo = art.articleNo
                            WHERE
                                art.articleNo = a.articleNo
                            AND
                                sup.supplyNo = s.supplyNo
                        ) > sc.maxWeight)
        BEGIN
            ;THROW 50000, 'The total weight of the products cannot exceed the total maximum weight allowed in the storagecube', 1
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 4 **/

CREATE TRIGGER TR04_PURCHASE_PAYMENT_INVOICE_SUM_MATCH
	ON PurchasePayment
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
	IF EXISTS (SELECT 1 FROM PurchaseInvoice PI 
					INNER JOIN Inserted I
					ON PI.invoiceNo = I.PurchaseInvoice_invoiceNo 
					AND PI.referenceNo = I.PurchaseInvoice_referenceNo
					WHERE I.amount != 
					(SELECT SUM(amount) FROM PurchaseInvoiceLine
					WHERE PurchaseInvoice_invoiceNo = I.PurchaseInvoice_invoiceNo
					AND PurchaseInvoice_referenceNo = I.PurchaseInvoice_referenceNo))
		BEGIN
			;THROW 50001,'The specified amount in the payment must be equal to the sum of the amount of each article in the invoice',1
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/**Constraint 5 **/

CREATE TRIGGER TR04_SALES_PAYMENT_INVOICE_SUM_MATCH
	ON SalesPayment
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
	IF EXISTS (SELECT 1 FROM SalesInvoice PI 
					INNER JOIN Inserted I
					ON PI.invoiceNo = I.SalesInvoice_invoiceNo 
					AND PI.referenceNo = I.SalesInvoice_referenceNo
					WHERE I.amount != 
					(SELECT SUM(amount) FROM SalesInvoiceLine
					WHERE SalesInvoice_invoiceNo = I.SalesInvoice_invoiceNo
					AND SalesInvoice_referenceNo = I.SalesInvoice_referenceNo))
		BEGIN
			;THROW 50001,'The specified amount in the payment must be equal to the sum of the amount of each article in the invoice',1
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

/**Constraint 6 **/

CREATE TRIGGER TR06_PurchaseOrder_Amount
ON PurchaseOrderLine
AFTER INSERT, UPDATE
AS

Declare @amount INT
Declare @superOrderNo INT
Declare @superRef INT
Declare @ArticleNo INT

BEGIN
    IF @@ROWCOUNT = 0
        RETURN
    SET NOCOUNT ON

    BEGIN TRY
	
	Select @superOrderNo = Po.superOderNo, @superRef = Po.superOderReferenceNo, @amount = Pl.Amount ,@ArticleNo = Pl.Article_articleNo
	From PurchaseOrder Po inner join inserted i on Po.orderNo = i.PurchaseOrder_orderNo AND Po.referenceNo = i.PurchaseOrder_referenceNo inner join PurchaseOrderLine Pl
		 on Po.superOderNo = Pl.PurchaseOrder_orderNo AND Po.superOderReferenceNo = Pl.PurchaseOrder_referenceNo 

	if((Select SUM(Amount) From PurchaseOrderLine pl inner join PurchaseOrder po on pl.PurchaseOrder_orderNo = po.orderNo AND pl.PurchaseOrder_referenceNo = po.referenceNo
		Where po.superOderNo = @superOrderNo AND po.superOderReferenceNo = @superRef AND pl.Article_articleNo = @ArticleNo) > @amount)

	
        BEGIN
            ;THROW 50000, 'The combination of products in the suborders may not be more than the products in the superorder', 1
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 7 **/


CREATE TRIGGER TR06_SalesOrder_Amount
ON SalesOrderLine
AFTER INSERT, UPDATE
AS

Declare @amount INT
Declare @superOrderNo INT
Declare @superRef INT
Declare @ArticleNo INT

BEGIN
    IF @@ROWCOUNT = 0
        RETURN
    SET NOCOUNT ON

    BEGIN TRY
	
	Select @superOrderNo = So.superOderNo, @superRef = So.superOderReferenceNo, @amount = Sl.Amount, @ArticleNo = Sl.Article_articleNo
	From SalesOrder So inner join inserted i on So.orderNo = i.SalesOrder_orderNo AND So.referenceNo = i.SalesOrder_referenceNo inner join SalesOrderLine Sl
		 on So.superOderNo = Sl.SalesOrder_orderNo AND So.superOderReferenceNo = Sl.SalesOrder_referenceNo 

	if((Select SUM(Amount) From SalesOrderLine Sl inner join SalesOrder So on Sl.SalesOrder_orderNo = So.orderNo AND Sl.SalesOrder_referenceNo = So.referenceNo
		Where So.superOderNo = @superOrderNo AND So.superOderReferenceNo = @superRef AND Sl.Article_articleNo = @ArticleNo) > @amount)

	
        BEGIN
            ;THROW 50000, 'The combination of products in the suborders may not be more than the products in the superorder', 1
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 8 **/

CREATE TRIGGER
    TR08_SalesOrderLine
ON SalesOrderLine
AFTER INSERT, UPDATE
AS
BEGIN
    IF @@ROWCOUNT = 0
        RETURN
    SET NOCOUNT ON

    BEGIN TRY
        -- Update Article table if it has an amount
        -- attribute
        IF COL_LENGTH('[dbo].Article', 'amount') IS NOT NULL  
        BEGIN
            UPDATE
                Article
            SET
                amount -= i.amount
            FROM
                Article a INNER JOIN inserted i
                ON a.articleNo = i.Article_articleNo;
        END

        -- Update ArticleInStorageCube if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArticleInStorageCube')
        BEGIN
            UPDATE
                ArticleInStorageCube
            SET
                amount -= i.amount
            FROM
                ArticleInStorageCube aisc INNER JOIN inserted i
                ON aisc.Article_articleNo = i.Article_articleNo
                    AND aisc.StorageCube_Location_address = i.ArticleInStorageCube_StorageCube_Location_address
                    AND aisc.StorageCube_referenceNo = i.ArticleInStorageCube_StorageCube_referenceNo;
        END

        -- Update ArticleInLocation if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArticleInLocation')
        BEGIN -- (Article_ArticleNo, Location_address)
            UPDATE
                ArticleInLocation
            SET
                amount -= i.amount
            FROM
                ArticleInLocation ail INNER JOIN inserted i
                ON ail.Article_articleNo = i.Article_articleNo
                    AND ail.Location_address = i.ArticleInLocation_Location_address;
        END

        -- Update Supply if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Supply')
        BEGIN
            UPDATE
                Supply
            SET
                amount -= i.amount
            FROM
                Supply s INNER JOIN inserted i
                ON s.supplyNo = i.Supply_supplyNo;
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 9 **/

CREATE TRIGGER
    TR09_PurchaseOrderLine
ON PurchaseOrderLine
AFTER INSERT, UPDATE
AS
BEGIN
    IF @@ROWCOUNT = 0
        RETURN
    SET NOCOUNT ON

    BEGIN TRY
        -- Update Article table if it has an amount
        -- attribute
        IF COL_LENGTH('[dbo].Article', 'amount') IS NOT NULL
        BEGIN
            UPDATE
                Article
            SET
                amount -= i.amount
            FROM
                Article a INNER JOIN inserted i
                ON a.articleNo = i.Article_articleNo;
        END

        -- Update ArticleInStorageCube if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArticleInStorageCube')
        BEGIN
            UPDATE
                ArticleInStorageCube
            SET
                amount -= i.amount
            FROM
                ArticleInStorageCube aisc INNER JOIN inserted i
                ON aisc.Article_articleNo = i.Article_articleNo
                    AND aisc.StorageCube_Location_address = i.ArticleInStorageCube_StorageCube_Location_address
                    AND aisc.StorageCube_referenceNo = i.ArticleInStorageCube_StorageCube_referenceNo;
        END

        -- Update ArticleInLocation if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArticleInLocation')
        BEGIN -- (Article_ArticleNo, Location_address)
            UPDATE
                ArticleInLocation
            SET
                amount -= i.amount
            FROM
                ArticleInLocation ail INNER JOIN inserted i
                ON ail.Article_articleNo = i.Article_articleNo
                    AND ail.Location_address = i.ArticleInLocation_Location_address;
        END

        -- Update Supply if it exists
        IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Supply')
        BEGIN
            UPDATE
                Supply
            SET
                amount -= i.amount
            FROM
                Supply s INNER JOIN inserted i
                ON s.supplyNo = i.Supply_supplyNo;
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END
GO

/**Constraint 10 **/

CREATE TRIGGER TR10_SALES_UNIT_NAME_IN_UNIT_IN_ARTICLE
	ON SalesOrderLine
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
	IF EXISTS (SELECT 1
					FROM Inserted I
					WHERE Unit_name = 
					(SELECT Unit_name
					FROM Article_in_Unit
					WHERE Article_articleNo != I.Article_articleNo
					AND Unit_name != I.Unit_name
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

/**Constraint 11 **/

CREATE TRIGGER TR10_PURCHASE_UNIT_NAME_IN_UNIT_IN_ARTICLE
	ON PurchaseOrderLine
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0
		RETURN
	SET NOCOUNT ON
	BEGIN TRY
	IF EXISTS (SELECT 1
					FROM Inserted I
					WHERE Unit_name = 
					(SELECT Unit_name
					FROM Article_in_Unit
					WHERE Article_articleNo != I.Article_articleNo
					AND Unit_name != I.Unit_name
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
