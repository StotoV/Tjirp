--
--  Test data
--
DROP TABLE IF EXISTS ArticleInStorageCube;GO
DROP TABLE IF EXISTS StorageCube;GO
DROP TABLE IF EXISTS Supply;GO
DROP TABLE IF EXISTS Article;GO

CREATE TABLE Article(
    articleNo INT,
    weight DECIMAL,

    CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE Supply (
    supplyNo INT,
    Article_articleNo INT,
    amount DECIMAL,

    CONSTRAINT PK_Supply PRIMARY KEY (supplyNo),
    CONSTRAINT FK_SupplyArticle FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo)
);

CREATE TABLE StorageCube(
    Location_address VARCHAR(5),
    referenceNo INT,
    maxWeight DECIMAL,

    CONSTRAINT pk_StorageCube PRIMARY KEY (Location_address, referenceNo)
);

CREATE TABLE ArticleInStorageCube (
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(5),
    StorageCube_referenceNo INT,

    CONSTRAINT PK_ArticleInStorageCube PRIMARY KEY (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_ArticleInStorageCube_Article FOREIGN KEY (Article_articleNo) REFERENCES Article (articleNo),
    CONSTRAINT FK_ArticleInStorageCube_Supply FOREIGN KEY (StorageCube_Location_address, StorageCube_referenceNo) REFERENCES StorageCube (Location_address, referenceNo)
);

INSERT INTO Article VALUES (1, 4.3), (2, 3.4), (3, 5);
INSERT INTO Supply VALUES (1, 1, 3), (2, 2, 1), (3, 3, 100);
INSERT INTO StorageCube VALUES ('add', 1,9.0), ('add', 2, 8.0), ('add', 3, 1.0);
INSERT INTO ArticleInStorageCube VALUES (1, 'add', 1), (2, 'add', 2), (3, 'add', 3);

--
-- In table Supply FOR EACH sum of weight for the records WHERE
-- StorageCube is x, the sum of weight cannot exceed the maxWeight
-- of StorageCube.
--
DROP TRIGGER IF EXISTS TR01_Supply;GO
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
                        INNER JOIN ArticleInStorageCube aisc
                        ON aisc.Article_articleNo = a.articleNo
                        INNER JOIN StorageCube sc
                        ON sc.Location_address = aisc.StorageCube_Location_address
                            AND sc.referenceNo = aisc.StorageCube_referenceNo
                    WHERE
                        (i.amount * a.weight) > sc.maxWeight)
        BEGIN
            ;THROW 50000, 'The total weight of the supply cannot exceed the total maximum weight allowed in the storagecube', 1
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
        INSERT INTO Supply (supplyNo, Article_articleNo, amount)
            VALUES (5, 1, 2)
        PRINT 'Test BR01 - TR01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 01 Failed'
    END CATCH

    BEGIN TRY
        INSERT INTO Supply (supplyNo, Article_articleNo, amount)
            VALUES (6, 1, 4)
        PRINT 'Test BR01 - TR01 - 02 Failed'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 02 Succeeded'
    END CATCH
ROLLBACK TRAN

--
-- Check if there are records in Supply where the total weight exceeds the max allowed weight in
-- the storage cube
--
SELECT
    *
FROM
    Article a INNER JOIN Supply s
    ON s.Article_articleNo = a.articleNo
    INNER JOIN ArticleInStorageCube aisc
    ON aisc.Article_articleNo = a.articleNo
    INNER JOIN StorageCube sc
    ON sc.Location_address = aisc.StorageCube_Location_address
        AND sc.referenceNo = aisc.StorageCube_referenceNo
WHERE
    (s.amount * a.weight) > sc.maxWeight;