--
--  Test data
--
DROP TABLE IF EXISTS ArticleInStorageCube;GO
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

CREATE TABLE ArticleInStorageCube (
    Article_articleNo INT,
    StorageCube_Location_address VARCHAR(5),
    StorageCube_referenceNo INT,
    amount DECIMAL,

    CONSTRAINT PK_Supply PRIMARY KEY (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo),
    CONSTRAINT FK_Supply_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
    CONSTRAINT FK_Supply_StorageCube FOREIGN KEY (StorageCube_Location_address, StorageCube_referenceNo) REFERENCES StorageCube (Location_address, referenceNo)
);

INSERT INTO Article VALUES (1, 4.3), (2, 3.4), (3, 5);
INSERT INTO StorageCube VALUES ('add', 1, 9.0), ('add', 2, 8.0), ('add', 3, 1.0), ('add', 4, 9.0), ('add', 5, 8.0);
INSERT INTO ArticleInStorageCube VALUES (1, 'add', 1, 3), (2, 'add', 2, 1), (3, 'add', 3, 100);

--
-- In table ArticleInStorageCube FOR EACH sum of weight for the records
-- WHERE StorageCube is x, the sum of weight cannot exceed the maxWeight
-- of StorageCube.
--
DROP TRIGGER IF EXISTS TR02_ArticleInStorageCube;GO
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

--
--  Test
--
BEGIN TRAN
    BEGIN TRY
        -- Insert two articles with a total weight of 8.6
        -- into storageCube with maxWeight of 9.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (1, 'add', 4, 2);
        PRINT 'Test BR01 - TR02 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        ;THROW
        PRINT 'Test BR01 - TR02 - 01 Failed'
    END CATCH

    BEGIN TRY
        -- Insert four articles with a total weight of 13.1
        -- into storageCube with maxWeight of 8.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (1, 'add', 5, 4);
        PRINT 'Test BR01 - TR02 - 02 Failed'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 02 Succeeded'
    END CATCH
ROLLBACK TRAN

--
-- Check if there are records in ArticleInStorageCube where the total weight exceeds the max allowed weight in
-- the storage cube
--
SELECT
    a.articleNo,
    (aisc.amount * a.weight) as [Total Weight],
    sc.maxWeight
FROM
    Article a INNER JOIN ArticleInStorageCube aisc
    ON aisc.Article_articleNo = a.articleNo
    INNER JOIN StorageCube sc
    ON sc.Location_address = aisc.StorageCube_Location_address
        AND sc.referenceNo = aisc.StorageCube_referenceNo
WHERE
    (aisc.amount * a.weight) > sc.maxWeight;