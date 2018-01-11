Business rule 4 zal worden bewaakt door middel van een trigger op de INSERT en 
UPDATE statements op de PurchaseOrder en SalesOrder tabel. Deze business rule is geïmplementeerd in TR06 en TR07.
TR06
In tabel PurchaseOrderLine FOR EACH sum of amount WHERE articleNo is x AND orderNo is orderNo in PurchaseOrder AND in PurchaseOrder WHERE superOrder is y <= amount in PurchaseOrderLine WHERE orderNo = y
TR07
In tabel SalesOrderLine FOR EACH sum of amount WHERE articleNo is x AND orderNo is orderNo in SalesOrder AND in SalesOrder WHERE superOrder is y <= amount in SalesOrderLine WHERE orderNo = y


--
-- Test Data
--

DROP TABLE IF EXISTS Article;GO
DROP TABLE IF EXISTS PurchaseOrder;GO
DROP TABLE IF EXISTS PurchaseOrderLine;GO

CREATE TABLE Article(
    articleNo INT

    CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

CREATE TABLE PurchaseOrder(
    orderNo INT,
    referenceNo INT,
	superOderNo INT,
	superOderReferenceNo INT

    CONSTRAINT PK_PurchaseOrder PRIMARY KEY (orderNo,referenceNo),
	CONSTRAINT FK_PurchaseOrder_SuperOrder FOREIGN KEY (superOderNo,superOderReferenceNo) REFERENCES PurchaseOrder(orderNo,referenceNo)
);


CREATE TABLE PurchaseOrderLine(
    PurchaseOrder_orderNo INT,
    PurchaseOrder_referenceNo INT,
	PurchaseOrderLineNo INT,
	Article_articleNo INT,
	Amount INT

    CONSTRAINT PK_PurchaseOrderLine PRIMARY KEY (PurchaseOrder_orderNo,PurchaseOrder_referenceNo,PurchaseOrderLineNo),
	CONSTRAINT FK_PurchaseOrderLine_Article FOREIGN KEY (Article_articleNo) REFERENCES Article(articleNo),
    CONSTRAINT FK_PurchaseOrderLine_PurchaseOrder FOREIGN KEY (PurchaseOrder_orderNo, PurchaseOrder_referenceNo) REFERENCES PurchaseOrder (orderNo, referenceNo)
);


INSERT INTO Article VALUES (1), (2), (3);
INSERT INTO PurchaseOrder VALUES (6, 5,3,1), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);
INSERT INTO PurchaseOrderLine VALUES (3, 1, 10, 1, 30), (1, 5, 2, 2, 1), (3, 1,1, 3, 100);

--
-- In tabel PurchaseOrderLine FOR EACH sum of amount WHERE articleNo is x
-- AND orderNo is orderNo in PurchaseOrder AND in PurchaseOrder WHERE
-- superOrder is y <= amount in PurchaseOrderLine WHERE orderNo = y.
--

DROP TRIGGER TR06_PurchaseOrder_Amount

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

select * from PurchaseOrder
select * from PurchaseOrderLine 

--
--  Test
--
BEGIN TRAN
    BEGIN TRY
        -- Insert two purchaseOrderLines with a total amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO PurchaseOrderLine VALUES (2, 8, 2, 1, 7), (3, 1,4, 1, 45);
        PRINT 'Test BR04 - TR06 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 01 Failed'
    END CATCH

ROLLBACK TRAN 

BEGIN TRAN
    BEGIN TRY
        -- Insert two purchaseOrderLines with a total amount under 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO PurchaseOrderLine VALUES (2, 8, 2, 1, 3), (3, 1,4, 3, 35);
        PRINT 'Test BR04 - TR06 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 02 Failed'
    END CATCH

ROLLBACK TRAN 

BEGIN TRAN
	BEGIN TRY
        -- Insert two purchaseOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO PurchaseOrderLine VALUES (2, 8, 2, 1, 30), (3, 1,4, 1, 35);
        PRINT 'Test BR04 - TR06 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 03 Failed'
    END CATCH

ROLLBACK TRAN


BEGIN TRAN
	BEGIN TRY
        -- Insert two purchaseOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50 6, 5,3,1
        INSERT INTO PurchaseOrderLine VALUES (6, 5, 12, 1, 40), (3, 1,4, 1, 75);
        PRINT 'Test BR04 - TR06 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR06 - 04 Failed'
    END CATCH

ROLLBACK TRAN

