--BR02 - CK01

IF DB_ID('BR02_CK01') IS NULL
     CREATE DATABASE BR02_CK01
GO

USE BR02_CK01
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Article'))
    DROP TABLE Article
GO

CREATE TABLE Article(
	articleNo					INT,
	minTemperature				DECIMAL,
	maxTemperature				DECIMAL,
	CONSTRAINT PK_Article PRIMARY KEY (articleNo)
)

INSERT INTO Article 
	VALUES (1, 99.3, 101.8), 
		(2, 17.1, 23.9);

ALTER TABLE Article
ADD CONSTRAINT CK01_TEMPERATURE
	CHECK (maxTemperature >= minTemperature)
GO

BEGIN TRAN
    BEGIN TRY
        -- Insert article with a minimum temperature of 99.3 and a maximum temperature of 101.8
        INSERT INTO Article
            VALUES (3, 99.3, 101.8)
        PRINT 'Test BR03 - CK01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 01 Failed'
    END CATCH

    BEGIN TRY
        -- Insert article with a minimum temperature of 23.9 and a maximum temperature of 17.1
        INSERT INTO Article
            VALUES (4, 23.9, 17.1)
        PRINT 'Test BR03 - CK01 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 02 Failed'
    END CATCH
ROLLBACK TRAN
