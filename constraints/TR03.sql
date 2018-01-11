--
--  Test data
--
DROP TABLE IF EXISTS Product;GO
DROP TABLE IF EXISTS Supply;GO
DROP TABLE IF EXISTS StorageCube;GO
DROP TABLE IF EXISTS Article;GO

CREATE TABLE Article(
    articleNo INT,
    weight DECIMAL,

    CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE StorageCube(
    Location_address VARCHAR(5),
    referenceNo INT,
    maxWeight DECIMAL,

    CONSTRAINT pk_StorageCube PRIMARY KEY (Location_address, referenceNo)
);

CREATE TABLE Supply (
    supplyNo INT,
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(5),
    StorageCube_referenceNo INT,
    amount DECIMAL,

    CONSTRAINT PK_Supply PRIMARY KEY (supplyNo),
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

INSERT INTO Article VALUES (1, 4.3), (2, 3.4), (3, 5);
INSERT INTO StorageCube VALUES ('add', 1, 9.0), ('add', 2, 8.0), ('add', 3, 1.0);
INSERT INTO Supply VALUES (1, 1, 'add', 1, 3), (2, 2, 'add', 2, 1), (3, 3, 'add', 3, 100);
INSERT INTO Product VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);

--
-- In table ArticleInStorageCube FOR EACH sum of weight for the records
-- WHERE StorageCube is x, the sum of weight cannot exceed the maxWeight
-- of StorageCube.
--
DROP TRIGGER IF EXISTS TR03_Product;GO
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

--
--  Test
--
BEGIN TRAN
    BEGIN TRY
        -- Insert one article with a total weight of 4.3
        -- into storageCube with maxWeight of 100.0
        -- with already inserted weight of 0.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo)
            VALUES (1, 12345, 2);
        PRINT 'Test BR01 - TR02 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        ;THROW
        PRINT 'Test BR01 - TR02 - 01 Failed'
    END CATCH

    BEGIN TRY
        -- Insert four articles with a total weight of 13.1
        -- into storageCube with maxWeight of 8.0
        -- with already inserted weight of 12.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo)
            VALUES (1, 12347, 1), (1, 12348, 1),
                   (1, 12349, 1), (1, 12350, 1);
        PRINT 'Test BR01 - TR02 - 02 Failed'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 02 Succeeded'
    END CATCH
ROLLBACK TRAN

--
-- Check if there are records in Product where the total weight exceeds the max allowed weight in
-- the storage cube
--
SELECT
    a.articleNo,
    (s.amount * a.weight) as [Total Weight],
    sc.Location_address,
    sc.referenceNo,
    sc.maxWeight
FROM
    Article a INNER JOIN Product p
    ON p.Article_articleNo = a.articleNo
    INNER JOIN Supply s ON
    s.supplyNo = p.Supply_supplyNo
    INNER JOIN StorageCube sc
    ON sc.Location_address = s.StorageCube_Location_address
        AND sc.referenceNo = s.StorageCube_referenceNo
WHERE
    (s.amount * a.weight) > sc.maxWeight;