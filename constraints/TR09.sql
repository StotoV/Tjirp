USE master;GO DROP DATABASE IF EXISTS tr09;GO CREATE DATABASE tr09;GO USE tr09;GO
--
-- Test data
--
DROP TABLE IF EXISTS PurchaseOrderLine;
DROP TABLE IF EXISTS Supply;
DROP TABLE IF EXISTS ArticleInLocation;
DROP TABLE IF EXISTS ArticleInStorageCube;
DROP TABLE IF EXISTS Article;

CREATE TABLE Article (
    articleNo INT,
    amount INT,

    CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE ArticleInStorageCube (
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(150),
    StorageCube_referenceNo INT,
    amount INT,

    CONSTRAINT PK_ArticleInStorageCube PRIMARY KEY (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_ArticleInStorageLocation_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo)
);

CREATE TABLE ArticleInLocation (
    Article_ArticleNo INT,
    Location_address VARCHAR(150),
    amount INT,

    CONSTRAINT PK_ArticleInLocation PRIMARY KEY (Article_ArticleNo, Location_address),
    CONSTRAINT FK_ArticleInLocation_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo)
);

CREATE TABLE Supply (
    supplyNo INT,
    amount INT,

    CONSTRAINT PK_Supply PRIMARY KEY (supplyNo)
);

CREATE TABLE PurchaseOrderLine (
    PurchaseOrder_orderNo INT,
    PurchaseOrder_referenceNo VARCHAR(30),
    "lineNo" INT, -- lineNo is a reserved keyword
    Article_articleNo INT,
    ArticleInStorageCube_StorageCube_Location_address VARCHAR(150),
    ArticleInStorageCube_StorageCube_referenceNo INT,
    ArticleInLocation_Location_address VARCHAR (150),
    amount INT,

    CONSTRAINT PK_PurchaseOrderLine PRIMARY KEY (PurchaseOrder_OrderNo, PurchaseOrder_referenceNo, "lineNo"),
    CONSTRAINT FK_PurchaseOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_PurchaseOrderLine_ArticleInStorageCube FOREIGN KEY (Article_articleNo, ArticleInStorageCube_StorageCube_Location_address, ArticleInStorageCube_StorageCube_referenceNo)
        REFERENCES ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_SalesOrderLine_ArticleInLocation FOREIGN KEY (Article_articleNo, ArticleInLocation_Location_address) REFERENCES ArticleInLocation (Article_articleNo, Location_address)
);

ALTER TABLE Supply
    ADD PurchaseOrderLine_PurchaseOrder_OrderNo INT NULL,
    PurchaseOrderLine_PurchaseOrder_referenceNo VARCHAR(30) NULL,
    PurchaseOrderLine_lineNo INT NULL;

ALTER TABLE Supply
    ADD CONSTRAINT PK_Supply_PurchaseOrderLine FOREIGN KEY (PurchaseOrderLine_PurchaseOrder_OrderNo, PurchaseOrderLine_PurchaseOrder_referenceNo, PurchaseOrderLine_lineNo)
            REFERENCES PurchaseOrderLine (PurchaseOrder_OrderNo, PurchaseOrder_referenceNo, "lineNo");

INSERT INTO Article VALUES (1, 3), (2, 4), (3, 5);
INSERT INTO ArticleInStorageCube VALUES (1, 'addr', 1, 3), (2, 'addr', 2, 4), (3, 'addr', 3, 5);
INSERT INTO ArticleInLocation VALUES (1, 'addr', 3), (2, 'addr', 4), (3, 'addr', 5);
INSERT INTO PurchaseOrderLine VALUES (1, 'ref1', 1, 1, 'addr', 1, 'addr', 3), (2, 'ref2', 2, 2, 'addr', 2, 'addr', 4), (3, 'ref3', 3, 3, 'addr', 3, 'addr', 5);
INSERT INTO Supply VALUES (1, 3, 1, 'ref1', 1), (2, 4, 2, 'ref2', 2), (3, 5, 3, 'ref3', 3);

--
-- In Table SalesOrderLine FOR EACH record reduce amount in table Article
-- OR ArticleInStorageCube OR ArticleInLocation OR Supply WHERE
-- articleNo is y with the amount of de SalesOrderLine WHERE orderNo in
-- x AND articleNo is y
--
DROP TRIGGER IF EXISTS TR09_PurchaseOrderLine;GO
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
                ON s.PurchaseOrderLine_PurchaseOrder_OrderNo = i.PurchaseOrder_OrderNo
                    AND s.PurchaseOrderLine_PurchaseOrder_referenceNo = i.PurchaseOrder_referenceNo
                    AND s.PurchaseOrderLine_lineNo = i."lineNo";
        END

    END TRY
    BEGIN CATCH
        ;THROW
    END CATCH
END

--
-- Test
--
BEGIN TRAN
    -- Reduce amount by 2
    -- Old amount in every table was 3
    INSERT INTO PurchaseOrderLine (PurchaseOrder_orderNo, PurchaseOrder_referenceNo, "lineNo", Article_articleNo, ArticleInStorageCube_StorageCube_Location_address,
                                ArticleInStorageCube_StorageCube_referenceNo, ArticleInLocation_Location_address, amount)
        VALUES (4, 'ref1', 1, 1, 'addr', 1, 'addr', 2);

    -- Reduce amount from Article
    IF (SELECT amount FROM Article WHERE articleNo = 1) = 1
        PRINT 'Test BR05 - TR08 - 01 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR08 - 01 Failed'

    -- Reduce amount from ArticleInStorageCube
    IF (SELECT amount FROM ArticleInStorageCube WHERE Article_articleNo = 1) = 1
        PRINT 'Test BR05 - TR08 - 02 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR08 - 02 Failed'

    -- Reduce amount from ArticleInLocation
    IF (SELECT amount FROM ArticleInLocation WHERE Article_ArticleNo = 1) = 1
        PRINT 'Test BR05 - TR08 - 03 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR08 - 03 Failed'

    -- Reduce amount from Supply
    UPDATE PurchaseOrderLine SET amount = 2 WHERE PurchaseOrder_orderNo = 1 AND PurchaseOrder_referenceNo = 'ref1' AND "lineNo" = 1
    IF (SELECT amount FROM Supply WHERE supplyNo = 1) = 1
        PRINT 'Test BR05 - TR08 - 04 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR08 - 04 Failed'
ROLLBACK TRAN
