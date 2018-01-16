--
-- Test data
--
DROP TABLE IF EXISTS SalesOrderLine;
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

CREATE TABLE SalesOrderLine (
    SalesOrder_orderNo INT,
    SalesOrder_referenceNo VARCHAR(30),
    "lineNo" INT, -- lineNo is a reserved keyword
    Supply_supplyNo INT,
    Article_articleNo INT,
    ArticleInStorageCube_StorageCube_Location_address VARCHAR(150),
    ArticleInStorageCube_StorageCube_referenceNo INT,
    ArticleInLocation_Location_address VARCHAR (150),
    amount INT,

    CONSTRAINT PK_SalesOrderLine PRIMARY KEY (SalesOrder_OrderNo, SalesOrder_referenceNo, "lineNo"),
    CONSTRAINT FK_SalesOrderLine_Supply FOREIGN KEY (Supply_supplyNo) REFERENCES Supply (supplyNo),
    CONSTRAINT FK_SalesOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_SalesOrderLine_ArticleInStorageCube FOREIGN KEY (Article_articleNo, ArticleInStorageCube_StorageCube_Location_address, ArticleInStorageCube_StorageCube_referenceNo)
        REFERENCES ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_SalesOrderLine_ArticleInLocation FOREIGN KEY (Article_articleNo, ArticleInLocation_Location_address) REFERENCES ArticleInLocation (Article_articleNo, Location_address)
);

INSERT INTO Article VALUES (1, 3), (2, 4), (3, 5);
INSERT INTO ArticleInStorageCube VALUES (1, 'addr', 1, 3), (2, 'addr', 2, 4), (3, 'addr', 3, 5);
INSERT INTO ArticleInLocation VALUES (1, 'addr', 3), (2, 'addr', 4), (3, 'addr', 5);
INSERT INTO Supply VALUES (1, 3), (2, 4), (3, 5);
INSERT INTO SalesOrderLine VALUES (1, 'ref1', 1, 1, 1, 'addr', 1, 'addr', 3), (2, 'ref2', 2, 2, 2, 'addr', 2, 'addr', 4), (3, 'ref3', 3, 3, 3, 'addr', 3, 'addr', 5);

--
-- In Table SalesOrderLine FOR EACH record reduce amount in table Article
-- OR ArticleInStorageCube OR ArticleInLocation OR Supply WHERE
-- articleNo is y with the amount of de SalesOrderLine WHERE orderNo in
-- x AND articleNo is y
--
DROP TRIGGER IF EXISTS TR08_SalesOrderLine;GO
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

            -- Check if the amount isn't going to be less than 0
            IF EXISTS (
                SELECT 1
                FROM Article a INNER JOIN inserted i
                ON a.articleNo = i.Article_articleNo
                WHERE a.amount - i.amount < 0
            )
            BEGIN
                ;THROW 50000, 'The amount is going to be less than 0', 1
            END

            -- Update the amount
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

            -- Check if the amount isn't going to be less than 0
            IF EXISTS (
                SELECT 1
                FROM ArticleInStorageCube aisc INNER JOIN inserted i
                ON aisc.Article_articleNo = i.Article_articleNo
                    AND aisc.StorageCube_Location_address = i.ArticleInStorageCube_StorageCube_Location_address
                    AND aisc.StorageCube_referenceNo = i.ArticleInStorageCube_StorageCube_referenceNo
                WHERE aisc.amount - i.amount < 0
            )
            BEGIN
                ;THROW 50000, 'The amount is going to be less than 0', 1
            END

            -- Update the amount
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
        BEGIN

            -- Check if the amount isn't going to be less than 0
            IF EXISTS (
                SELECT 1
                FROM ArticleInLocation ail INNER JOIN inserted i
                ON ail.Article_articleNo = i.Article_articleNo
                    AND ail.Location_address = i.ArticleInLocation_Location_address
                WHERE ail.amount - i.amount < 0
            )
            BEGIN
                ;THROW 50000, 'The amount is going to be less than 0', 1
            END

            -- Update the amount
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

            -- Check if the amount isn't going to be less than 0
            IF EXISTS (
                SELECT 1
                FROM Supply s INNER JOIN inserted i
                ON s.supplyNo = i.Supply_supplyNo
                WHERE s.amount - i.amount < 0
            )
            BEGIN
                ;THROW 50000, 'The amount is going to be less than 0', 1
            END

            -- Update the amount
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

--
-- Test
--
BEGIN TRAN
    -- Reduce amount by 2
    -- Old amount in every table was 3
    INSERT INTO SalesOrderLine (SalesOrder_orderNo, SalesOrder_referenceNo, "lineNo", Supply_supplyNo, Article_articleNo, ArticleInStorageCube_StorageCube_Location_address,
                                ArticleInStorageCube_StorageCube_referenceNo, ArticleInLocation_Location_address, amount)
        VALUES (4, 'referentie', 1, 1, 1, 'addr', 1, 'addr', 2);

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
    IF (SELECT amount FROM Supply WHERE supplyNo = 1) = 1
        PRINT 'Test BR05 - TR08 - 04 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR08 - 04 Failed'

    -- Set amount to 0
    BEGIN TRY
        INSERT INTO SalesOrderLine (SalesOrder_orderNo, SalesOrder_referenceNo, "lineNo", Supply_supplyNo, Article_articleNo, ArticleInStorageCube_StorageCube_Location_address,
                                ArticleInStorageCube_StorageCube_referenceNo, ArticleInLocation_Location_address, amount)
        VALUES (4, 'referentie', 1, 1, 1, 'addr', 1, 'addr', 3);

        PRINT 'Test BR05 - TR08 - 05 Failed'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR05 - TR08 - 05 Succeeded'
    END CATCH
ROLLBACK TRAN