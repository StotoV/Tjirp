USE tjirp;
GO

--
-- CK01
--
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType, constraintLogic)
    VALUES ('CK01_TEMPERATURE', 'Article', 'CHECK', 'maxTemperature >= minTemperature');

--
-- TR01
--
INSERT INTO ProceduralConstraint (constraintName, tableName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('Supply', 'TR01_Supply', 'TRIGGER', 'Stock',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50000, ''The total weight of the supply cannot exceed the total maximum weight allowed in the storagecube'', 1
                END

            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
      'AFTER INSERT, UPDATE');

--
-- TR02
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('ArticleInStorageCube', 'TR02_ArticleInStorageCube', 'TRIGGER', 'StockCubes',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50000, ''The total weight of the ArticleInStorageCube cannot exceed the total maximum weight allowed in the storagecube'', 1
                END

            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR03
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('Product', 'TR03_Product', 'TRIGGER', 'Stock',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50000, ''The total weight of the products cannot exceed the total maximum weight allowed in the storagecube'', 1
                END

            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR04
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('PurchasePayment', 'TR04_PURCHASE_PAYMENT_INVOICE_SUM_MATCH', 'TRIGGER', 'Purchase',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50001,''The specified amount in the payment must be equal to the sum of the amount of each article in the invoice'',1
                END
            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT');

--
-- TR05
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('SalesPayment', 'TR05_SALES_PAYMENT_INVOICE_SUM_MATCH', 'TRIGGER', 'Sales',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50001,''The specified amount in the payment must be equal to the sum of the amount of each article in the invoice'',1
                END
            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT');

--
-- TR06
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('PurchaseOrderLine', 'TR06_PurchaseOrder_Amount', 'TRIGGER', 'Purchase',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY

            Select @superOrderNo = Po.superOderNo, @superRef = Po.superOderReferenceNo, @amount = Pl.Amount ,@ArticleNo = Pl.Article_articleNo
            From PurchaseOrder Po inner join inserted i on Po.orderNo = i.PurchaseOrder_orderNo AND Po.referenceNo = i.PurchaseOrder_referenceNo inner join PurchaseOrderLine Pl
                 on Po.superOderNo = Pl.PurchaseOrder_orderNo AND Po.superOderReferenceNo = Pl.PurchaseOrder_referenceNo

            if((Select SUM(Amount) From PurchaseOrderLine pl inner join PurchaseOrder po on pl.PurchaseOrder_orderNo = po.orderNo AND pl.PurchaseOrder_referenceNo = po.referenceNo
                Where po.superOderNo = @superOrderNo AND po.superOderReferenceNo = @superRef AND pl.Article_articleNo = @ArticleNo) > @amount)


                BEGIN
                    ;THROW 50000, ''The combination of products in the suborders may not be more than the products in the superorder'', 1
                END

            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR07
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('SalesOrderLine', 'TR07_SalesOrder_Amount', 'TRIGGER', 'Sales',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY
            Declare @amount INT
            Declare @superOrderNo INT
            Declare @superRef INT
            Declare @ArticleNo INT
            Select @superOrderNo = So.superOderNo, @superRef = So.superOderReferenceNo, @amount = Sl.Amount, @ArticleNo = Sl.Article_articleNo
            From SalesOrder So inner join inserted i on So.orderNo = i.SalesOrder_orderNo AND So.referenceNo = i.SalesOrder_referenceNo inner join SalesOrderLine Sl
                 on So.superOderNo = Sl.SalesOrder_orderNo AND So.superOderReferenceNo = Sl.SalesOrder_referenceNo

            if((Select SUM(Amount) From SalesOrderLine Sl inner join SalesOrder So on Sl.SalesOrder_orderNo = So.orderNo AND Sl.SalesOrder_referenceNo = So.referenceNo
                Where So.superOderNo = @superOrderNo AND So.superOderReferenceNo = @superRef AND Sl.Article_articleNo = @ArticleNo) > @amount)


                BEGIN
                    ;THROW 50000, ''The combination of products in the suborders may not be more than the products in the superorder'', 1
                END

            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR08
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('SalesOrderLine', 'TR08_SalesOrderLine', 'TRIGGER', 'Sales',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY
                -- Update Article table if it has an amount
                -- attribute
                IF COL_LENGTH(''[dbo].Article'', ''amount'') IS NOT NULL
                BEGIN

                    -- Check if the amount isn''t going to be less than 0
                    IF EXISTS (
                        SELECT 1
                        FROM Article a INNER JOIN inserted i
                        ON a.articleNo = i.Article_articleNo
                        WHERE a.amount - i.amount < 0
                    )
                    BEGIN
                        ;THROW 50000, ''The amount is going to be less than 0'', 1
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''ArticleInStorageCube'')
                BEGIN

                    -- Check if the amount isn''t going to be less than 0
                    IF EXISTS (
                        SELECT 1
                        FROM ArticleInStorageCube aisc INNER JOIN inserted i
                        ON aisc.Article_articleNo = i.Article_articleNo
                            AND aisc.StorageCube_Location_address = i.ArticleInStorageCube_StorageCube_Location_address
                            AND aisc.StorageCube_referenceNo = i.ArticleInStorageCube_StorageCube_referenceNo
                        WHERE aisc.amount - i.amount < 0
                    )
                    BEGIN
                        ;THROW 50000, ''The amount is going to be less than 0'', 1
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''ArticleInLocation'')
                BEGIN

                    -- Check if the amount isn''t going to be less than 0
                    IF EXISTS (
                        SELECT 1
                        FROM ArticleInLocation ail INNER JOIN inserted i
                        ON ail.Article_articleNo = i.Article_articleNo
                            AND ail.Location_address = i.ArticleInLocation_Location_address
                        WHERE ail.amount - i.amount < 0
                    )
                    BEGIN
                        ;THROW 50000, ''The amount is going to be less than 0'', 1
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''Supply'')
                BEGIN

                    -- Check if the amount isn''t going to be less than 0
                    IF EXISTS (
                        SELECT 1
                        FROM Supply s INNER JOIN inserted i
                        ON s.supplyNo = i.Supply_supplyNo
                        WHERE s.amount - i.amount < 0
                    )
                    BEGIN
                        ;THROW 50000, ''The amount is going to be less than 0'', 1
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
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR09
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('PurchaseOrderLine', 'TR09_PurchaseOrderLine', 'TRIGGER', 'Purchase',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY
                -- Update Article table if it has an amount
                -- attribute
                IF COL_LENGTH(''[dbo].Article'', ''amount'') IS NOT NULL
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''ArticleInStorageCube'')
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''ArticleInLocation'')
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
                IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''Supply'')
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
        END CATCH',
        'AFTER INSERT, UPDATE');

--
-- TR10
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('SalesOrderLine', 'TR10_SALES_UNIT_NAME_IN_UNIT_IN_ARTICLE', 'TRIGGER', 'Sales',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50001,''The specified unit name in the order line does not exist with the specified article number'',1
                END
            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
      'AFTER INSERT, UPDATE');

--
-- TR11
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('PurchaseOrderLine', 'TR11_PURCHASE_UNIT_NAME_IN_UNIT_IN_ARTICLE', 'TRIGGER', 'Purchase',
            'IF @@ROWCOUNT = 0
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
                    ;THROW 50001,''The specified unit name in the order line does not exist with the specified article number'',1
                END
            END TRY
            BEGIN CATCH
                ;THROW
        END CATCH',
        'AFTER INSERT, UPDATE');