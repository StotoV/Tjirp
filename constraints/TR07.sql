Business rule 4 zal worden bewaakt door middel van een trigger op de INSERT en 
UPDATE statements op de SalesOrder en SalesOrder tabel. Deze business rule is geïmSlementeerd in TR06 en TR07.
TR06
In tabel SalesOrderLine FOR EACH sum of amount WHERE articleNo is x AND orderNo is orderNo in SalesOrder AND in SalesOrder WHERE superOrder is y <= amount in SalesOrderLine WHERE orderNo = y
TR07
In tabel SalesOrderLine FOR EACH sum of amount WHERE articleNo is x AND orderNo is orderNo in SalesOrder AND in SalesOrder WHERE superOrder is y <= amount in SalesOrderLine WHERE orderNo = y


--
-- Test Data
--

DROP TABLE IF EXISTS Article;GO
DROP TABLE IF EXISTS SalesOrder;GO
DROP TABLE IF EXISTS SalesOrderLine;GO

CREATE TABLE Article(
    articleNo INT

    CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE SalesOrder(
    orderNo INT,
    referenceNo INT,
	superOderNo INT,
	superOderReferenceNo INT

    CONSTRAINT PK_SalesOrder PRIMARY KEY (orderNo,referenceNo),
	CONSTRAINT FK_SalesOrder_SuperOrder FOREIGN KEY (superOderNo,superOderReferenceNo) REFERENCES SalesOrder(orderNo,referenceNo)
);


CREATE TABLE SalesOrderLine(
    SalesOrder_orderNo INT,
    SalesOrder_referenceNo INT,
	SalesOrderLineNo INT,
	Article_articleNo INT,
	Amount INT

    CONSTRAINT PK_SalesOrderLine PRIMARY KEY (SalesOrder_orderNo,SalesOrder_referenceNo,SalesOrderLineNo),
	CONSTRAINT FK_SalesOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
    CONSTRAINT FK_SalesOrderLine_SalesOrder FOREIGN KEY (SalesOrder_orderNo, SalesOrder_referenceNo) REFERENCES SalesOrder (orderNo, referenceNo)
);


INSERT INTO Article VALUES (1), (2), (3);
INSERT INTO SalesOrder VALUES (6, 5,3,1), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);
INSERT INTO SalesOrderLine VALUES (3, 1, 10, 1, 30), (1, 5, 2, 2, 1), (3, 1,1, 3, 100);

--
-- In tabel SalesOrderLine FOR EACH sum of amount WHERE articleNo is x
-- AND orderNo is orderNo in SalesOrder AND in SalesOrder WHERE
-- superOrder is y <= amount in SalesOrderLine WHERE orderNo = y.
--

DROP TRIGGER TR06_SalesOrder_Amount

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

select * from SalesOrder
select * from SalesOrderLine 

--
--  Test
--
BEGIN TRAN
    BEGIN TRY
        -- Insert two SalesOrderLines with a total amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2, 1, 70), (3, 1,4, 3, 100);
        PRINT 'Test BR04 - TR06 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 01 Failed'
    END CATCH

ROLLBACK TRAN 

BEGIN TRAN
    BEGIN TRY
        -- Insert two SalesOrderLines with a total amount under 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2, 1, 3), (3, 1,4, 3, 35);
        PRINT 'Test BR04 - TR06 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 02 Failed'
    END CATCH

ROLLBACK TRAN 

BEGIN TRAN
	BEGIN TRY
        -- Insert two SalesOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2, 1, 30), (3, 1,4, 1, 35);
        PRINT 'Test BR04 - TR06 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 03 Failed'
    END CATCH

ROLLBACK TRAN


BEGIN TRAN
	BEGIN TRY
        -- Insert two SalesOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50 6, 5,3,1
        INSERT INTO SalesOrderLine VALUES (6, 5, 12, 1, 40), (3, 1,4, 1, 75);
        PRINT 'Test BR04 - TR06 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 04 Failed'
    END CATCH

ROLLBACK TRAN

