'/*
=======================================================
-- Constraints 1 t/m 11 Test Scripts	 ==
=======================================================
*/'


/** CK 1 Test **/

BEGIN TRAN
    BEGIN TRY
		-- Success scenario
        -- Insert article with a minimum temperature of 99.3 and a maximum temperature of 101.8
        INSERT INTO Article VALUES (3,null, 99.3, 101.8,null)
        PRINT 'Test BR03 - CK01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Success scenario
        -- Insert article with a minimum temperature of 70.3 and a maximum temperature of 70.4
        INSERT INTO Article VALUES (3,null, 70.3, 70.4,null)
        PRINT 'Test BR03 - CK01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Fail scenario
        -- Insert article with a minimum temperature of 70.3 and a maximum temperature of 70
        INSERT INTO Article VALUES (3,null, 70.3, 70,null)
        PRINT 'Test BR03 - CK01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 01 Failed'
    END CATCH

    BEGIN TRY
		-- Success scenario
		-- Fail scenario
        -- Insert article with a minimum temperature of 23.9 and a maximum temperature of 17.1
		-- None of the records should get inserted
        INSERT INTO Article
			-- Insert article with a minimum temperature of 13.9 and a maximum temperature of 17.1 (which should not violate the constraint by itself)
            VALUES (4, null,13.9, 17.1,null),
				-- Insert article with a minimum temperature of 23.9 and a maximum temperature of 17.1
				(5, null,23.9, 17.1,null)
        PRINT 'Test BR03 - CK01 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR03 - CK01 - 02 Failed'
    END CATCH
ROLLBACK TRAN



/** Constraint 1 Test **/

BEGIN TRAN
	INSERT INTO Article VALUES (1,1,null,null,4.3), (2,1,null,null,3.4), (3,1,null,null,5);
	INSERT INTO StorageCube VALUES ('add', 1, 21.0), ('add', 2, 8.0), ('add', 3, 1.0);

    BEGIN TRY
		-- Success scenario
        -- Insert two articles with a total weight of 8.6
        -- into storageCube with maxWeight of 21.0
        -- with an inserted weight of 12.0
        INSERT INTO Supply (supplyNo, Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (5, 1, 'add', 1, 2)
        PRINT 'Test BR01 - TR01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Fail scenario
        -- Insert two articles with a total weight of 17.2
        -- into storageCube with maxWeight of 21.0
        -- with an inserted weight of 12.0
        INSERT INTO Supply (supplyNo, Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (5, 1, 'add', 1, 4)
        PRINT 'Test BR01 - TR01 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Fail scenario
        -- Insert four articles with a total weight of 32.75
        -- into storageCube with maxWeight of 8.0
        -- with a inserted weight of 0.0
        INSERT INTO Supply (supplyNo, Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (6, 1, 'add', 2, 10)
        PRINT 'Test BR01 - TR01 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 02 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert four articles with a total weight of 13.1
        -- into storageCube with maxWeight of 8.0
        -- with a inserted weight of 0.0
        INSERT INTO Supply (supplyNo, Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (6, 1, 'add', 2, 4)
        PRINT 'Test BR01 - TR01 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR01 - 02 Failed'
    END CATCH
ROLLBACK TRAN

/** Constraint 2 **/

BEGIN TRAN
	INSERT INTO Article VALUES (6,1,null,null,4.3), (8,1,null,null,3.4), (7,1,null,null,5);
	INSERT INTO StorageCube VALUES ('add', 1, 9.0), ('add', 2, 8.0), ('add', 3, 1.0), ('add', 4, 10.0), ('add', 5, 9.0);

    BEGIN TRY
		-- Success scenario
        -- Insert two articles with a total weight of 8.6
        -- into storageCube with maxWeight of 10.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (6, 'add', 4, 2);
        PRINT 'Test BR01 - TR02 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Success scenario
        -- Insert two articles with a total weight of 8.6
        -- into storageCube with maxWeight of 9.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (6, 'add', 5, 2);
        PRINT 'Test BR01 - TR02 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 02 Failed'
    END CATCH

	BEGIN TRY
		-- Fail scenario
        -- Insert two articles with a total weight of 10.0
        -- into storageCube with maxWeight of 9.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (7, 'add', 5, 2);
        PRINT 'Test BR01 - TR02 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 03 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert four articles with a total weight of 13.2
        -- into storageCube with maxWeight of 8.0
        INSERT INTO ArticleInStorageCube (Article_articleNo, StorageCube_Location_address, StorageCube_referenceNo, amount)
            VALUES (8, 'add', 5, 4);
        PRINT 'Test BR01 - TR02 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR02 - 04 Failed'
    END CATCH
ROLLBACK TRAN


/** Constraint 3 Test **/
	
BEGIN TRAN
	INSERT INTO Article VALUES (9,1,null,null, 4.3), (10,1,null,null, 3.4), (11,1,null,null, 5);
	INSERT INTO StorageCube VALUES ('add', 11, 9.0), ('add', 12, 8.0), ('add', 13, 100);
	INSERT INTO Supply VALUES (1, 9, 'add', 12, 1), (2, 10, 'add', 13, 1), (3, 11, 'add', 13, 10);
	INSERT INTO Product VALUES (9, 1343, 1), (9, 2556, 3), (10, 3578, 3);

    BEGIN TRY
        -- Insert one article with a total weight of 4.3
        -- into storageCube with maxWeight of 100.0
        -- with already inserted weight of 0.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo) VALUES (9, 12345, 2);
        PRINT 'Test BR01 - TR03 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR03 - 01 Failed'
    END CATCH

	   BEGIN TRY
        -- Insert two article with a total weight of 8.6
        -- into storageCube with maxWeight of 100.0
        -- with already inserted weight of 0.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo)
            VALUES (9, 12345, 2),(9, 12354, 2);
        PRINT 'Test BR01 - TR03 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR03 - 01 Failed'
    END CATCH

	BEGIN TRY
        -- Insert four articles with a total weight of 13.1
        -- into storageCube with maxWeight of 8.0
        -- with already inserted weight of 12.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo)
            VALUES (1, 12347, 1), (1, 12348, 1),
                   (1, 12349, 1), (1, 12350, 1);
        PRINT 'Test BR01 - TR03 - 02 Succeeded '
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR03 - 02 Failed'
    END CATCH

    BEGIN TRY
        -- Insert three articles with a total weight of 12.9
        -- into storageCube with maxWeight of 8.0
        -- with already inserted weight of 12.0
        INSERT INTO Product (Article_articleNo, serialNo, Supply_supplyNo)
            VALUES (9, 12347, 1), (9, 12348, 1),
                   (9, 12349, 1);
        PRINT 'Test BR01 - TR03 - 02 Succeeded '
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR03 - 02 Failed'
    END CATCH
ROLLBACK TRAN

/** Constraint 4 Test **/ 

BEGIN TRAN
	INSERT INTO Article VALUES(1, 100,null,null, 4.3), (2, 75,null,null, 4.3), (3, 16,null,null, 4.3);
	INSERT INTO PurchaseInvoice(invoiceNo, referenceNo, date, paymentDate) 
	VALUES(1, '1A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
	INSERT INTO PurchaseInvoiceLine(PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo, lineNum, Article_articleNo, amount) 
	VALUES(1, '1A', 1, 1, 7), (1, '1A', 2, 2, 2), (1, '1A', 3, 3, 11);
	INSERT INTO PurchasePayment(paymentNo, PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo, amount, date) 
	VALUES(6, 1, '1A', 20, convert(datetime,'2014-11-01T08:00:00.000'));

    BEGIN TRY
		-- Success scenario
        -- Insert a payment amount of 22 and an invoice line with 3 different article amounts of 3, 7 and 12, adding up to 22
		INSERT INTO Article 
			VALUES(4, 100,null,null, 4.3), (5, 75,null,null, 4.3), (6, 16,null,null, 4.3);
		INSERT INTO PurchaseInvoice 
			VALUES(2, '2A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
		INSERT INTO PurchaseInvoiceLine
			-- Insert an invoice line with 3 different article amounts of 3, 7 and 12, adding up to 22
			VALUES(2, '2A', 4, 4, 3), 
				(2, '2A', 5, 5, 7), 
				(2, '2A', 6, 6, 12);
        INSERT INTO PurchasePayment 
			-- Insert a payment amount of 22
			VALUES(7, 2, '2A', 22, convert(datetime,'2014-11-01T08:00:00.000'));
        PRINT 'Test BR01 - TR04 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR04 - 01 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert a payment amount of 16 and an invoice line with 3 different article amounts of 2, 10 and 15, adding up to 27
		-- None of the records should get inserted
		INSERT INTO Article
			VALUES(7, 100,null,null, 4.3), (8, 75,null,null, 4.3), (9, 16,null,null, 4.3);
		INSERT INTO PurchaseInvoice 
			VALUES(3, '3A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
		INSERT INTO PurchaseInvoiceLine 
			-- Insert an invoice line with 3 different article amounts of 2, 10 and 15, adding up to 27
			VALUES(3, '3A', 7, 7, 2), (3, '3A', 8, 8, 10), (3, '3A', 9, 9, 15);
        INSERT INTO PurchasePayment 
			--Insert a payment amount of 27 (which should not violate the constraint by itself)
			VALUES(8, 3, '3A', 27, convert(datetime,'2014-11-01T08:00:00.000')),
				--Insert a payment amount of 16
				(9, 3, '3A', 16, convert(datetime,'2014-11-01T08:00:00.000'));
        PRINT 'Test BR01 - TR04 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR04 - 02 Failed'
    END CATCH
ROLLBACK TRAN


/** Constraint 5 **/

BEGIN TRAN
	INSERT INTO Article VALUES(1, 100,null,null, 4.3), (2, 75,null,null, 4.3), (3, 16,null,null, 4.3);
	INSERT INTO SalesInvoice(invoiceNo, referenceNo, date, paymentDate) 
	VALUES(1, '1A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
	INSERT INTO SalesInvoiceLine(SalesInvoice_invoiceNo, SalesInvoice_referenceNo, lineNum, Article_articleNo, amount) 
	VALUES(1, '1A', 1, 1, 7), (1, '1A', 2, 2, 2), (1, '1A', 3, 3, 11);
	INSERT INTO SalesPayment(paymentNo, SalesInvoice_invoiceNo, SalesInvoice_referenceNo, amount, date) 
	VALUES(6, 1, '1A', 20, convert(datetime,'2014-11-01T08:00:00.000'));

    BEGIN TRY
		-- Success scenario
        -- Insert a payment amount of 22 and an invoice line with 3 different article amounts of 3, 7 and 12, adding up to 22
		INSERT INTO Article 
			VALUES(4, 100,null,null, 4.3), (5, 75,null,null, 4.3), (6, 16,null,null, 4.3);
		INSERT INTO SalesInvoice 
			VALUES(2, '2A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
		INSERT INTO SalesInvoiceLine
			-- Insert an invoice line with 3 different article amounts of 3, 7 and 12, adding up to 22
			VALUES(2, '2A', 4, 4, 3), 
				(2, '2A', 5, 5, 7), 
				(2, '2A', 6, 6, 12);
        INSERT INTO SalesPayment 
			-- Insert a payment amount of 22
			VALUES(7, 2, '2A', 22, convert(datetime,'2014-11-01T08:00:00.000'));
        PRINT 'Test BR05 - TR05 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR05 - TR05 - 01 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert a payment amount of 16 and an invoice line with 3 different article amounts of 2, 10 and 15, adding up to 27
		-- None of the records should get inserted
		INSERT INTO Article
			VALUES(7, 100,null,null, 4.3), (8, 75,null,null, 4.3), (9, 16,null,null, 4.3);
		INSERT INTO SalesInvoice 
			VALUES(3, '3A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
		INSERT INTO SalesInvoiceLine 
			-- Insert an invoice line with 3 different article amounts of 2, 10 and 15, adding up to 27
			VALUES(3, '3A', 7, 7, 2), 
				(3, '3A', 8, 8, 10), 
				(3, '3A', 9, 9, 15);
        INSERT INTO SalesPayment 
			--Insert a payment amount of 27 (which should not violate the constraint by itself)
			VALUES(8, 3, '3A', 27, convert(datetime,'2014-11-01T08:00:00.000')),
				--Insert a payment amount of 16
				(9, 3, '3A', 16, convert(datetime,'2014-11-01T08:00:00.000'));
        PRINT 'Test BR01 - TR05 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR05 - 02 Failed'
    END CATCH
ROLLBACK TRAN


/** Constraint 6 **/ 

 BEGIN TRAN
		INSERT INTO Article VALUES (1,1,null,null, 4.3), (2,1,null,null, 4.3), (3,1,null,null, 4.3);
		INSERT INTO PurchaseOrder VALUES (6, 5,3,1), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);
		INSERT INTO PurchaseOrderLine VALUES (3, 1, 10,null, 1,null,null,null, 30,null), (1, 5, 2,null, 2,null,null,null, 1,null), (3, 1,1,null,3,null,null,null, 100,null);

		BEGIN TRY
			-- Insert two purchaseOrderLines with a total amount over 50
			-- Super order with nr 1 referenceNo 9 has max amount 50
			INSERT INTO PurchaseOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 7,null), (3, 1,4,null, 1,null,null,null, 45,null);
			PRINT 'Test BR04 - TR06 - 01 Succeeded'
		END TRY
		BEGIN CATCH
			PRINT 'Test BR04 - TR06 - 01 Failed'
		END CATCH

		BEGIN TRY
			-- Insert two purchaseOrderLines with a total amount under 50
			-- Super order with nr 1 referenceNo 9 has max amount 50
			INSERT INTO PurchaseOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 3,null), (3, 1,4,null, 3,null,null,null, 35,null);
			PRINT 'Test BR04 - TR06 - 02 Succeeded'
		END TRY
		BEGIN CATCH
			PRINT 'Test BR04 - TR06 - 02 Failed'
		END CATCH

		BEGIN TRY
			-- Insert two purchaseOrderLines with a total combination of amount over 50
			-- Super order with nr 1 referenceNo 9 has max amount 50
			INSERT INTO PurchaseOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 30,null), (3, 1,4,null, 1,null,null,null, 35,null);
			PRINT 'Test BR04 - TR06 - 03 Succeeded'
		END TRY
		BEGIN CATCH
			PRINT 'Test BR04 - TR06 - 03 Failed'
		END CATCH

		BEGIN TRY
			-- Insert two purchaseOrderLines with a total combination of amount over 50
			-- Super order with nr 1 referenceNo 9 has max amount 50 6, 5,3,1
			INSERT INTO PurchaseOrderLine VALUES (6, 5, 12,null, 1,null,null,null, 40,null), (3, 1,4,null, 1,null,null,null, 75,null);
			PRINT 'Test BR04 - TR06 - 04 Succeeded'
		END TRY
		BEGIN CATCH
			PRINT 'Test BR04 - TR06 - 04 Failed'
		END CATCH

ROLLBACK TRAN

/** Constraint 7 **/ 

BEGIN TRAN
	INSERT INTO Article VALUES (1,1,null,null, 4.3), (2,1,null,null, 4.3), (3,1,null,null, 4.3);
	INSERT INTO SalesOrder VALUES (6, 5,3,1), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);
	INSERT INTO SalesOrderLine VALUES (3, 1, 10,null, 1,null,null,null, 30,null), (1, 5, 2,null, 2,null,null,null, 1,null), (3, 1,1,null,3,null,null,null, 100,null);

    BEGIN TRY
        -- Insert two SalesOrderLines with a total amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 70,null), (3, 1,4,null, 3,null,null,null, 100,null);
        PRINT 'Test BR04 - TR07 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR07 - 01 Failed'
    END CATCH

    BEGIN TRY
        -- Insert two SalesOrderLines with a total amount under 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 3,null), (3, 1,4,null, 3,null,null,null, 35,null);
        PRINT 'Test BR04 - TR07 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR07 - 02 Failed'
    END CATCH

	BEGIN TRY
        -- Insert two SalesOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50
        INSERT INTO SalesOrderLine VALUES (2, 8, 2,null, 1,null,null,null, 30,null), (3, 1,4,null,1,null,null,null, 35,null);
        PRINT 'Test BR04 - TR07 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR07 - 03 Failed'
    END CATCH

	BEGIN TRY
        -- Insert two SalesOrderLines with a total combination of amount over 50
        -- Super order with nr 1 referenceNo 9 has max amount 50 6, 5,3,1
        INSERT INTO SalesOrderLine VALUES (6, 5, 12,null, 1,null,null,null, 40,null), (3, 1,4,null, 1,null,null,null, 75,null);
        PRINT 'Test BR04 - TR07 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR04 - TR07 - 04 Failed'
    END CATCH

ROLLBACK TRAN


/** Constraint 8 **/ 

BEGIN TRAN
	INSERT INTO Article VALUES (1,3,null,null, 4.3), (2, 3,null,null, 4.3), (3, 3,null,null, 4.3);
	INSERT INTO StorageCube VALUES ('addr', 1, 100.0), ('addr', 2, 100.0), ('addr', 3, 100.0);
	INSERT INTO ArticleInStorageCube VALUES (1, 'addr', 1, 3), (2, 'addr', 2, 4), (3, 'addr', 3, 5);
	INSERT INTO ArticleInLocation VALUES (1, 'addr', 3), (2, 'addr', 4), (3, 'addr', 5);
	INSERT INTO Supply VALUES (1, 1, 'addr', 2, 3), (2, 1, 'addr', 3, 4), (3, 1, 'addr', 3, 5);
	INSERT INTO SalesOrder VALUES (1, 1,null,null), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);

    -- Reduce amount by 2
    -- Old amount in every table was 3
    INSERT INTO SalesOrderLine (SalesOrder_orderNo, SalesOrder_referenceNo, "lineNo", Supply_supplyNo, Article_articleNo, ArticleInStorageCube_StorageCube_Location_address,
                                ArticleInStorageCube_StorageCube_referenceNo, ArticleInLocation_Location_address, amount,Unit_name)
	VALUES (1, 1, 6, 1, 1, 'addr', 1, 'addr', 2,null);

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
	
ROLLBACK TRAN


/** Constraint 9 **/ 

BEGIN TRAN
	INSERT INTO Article VALUES (1, 3,null,null, 4.3), (2, 4,null,null, 4.3), (3, 5,null,null, 4.3);
	INSERT INTO StorageCube VALUES ('addr', 1, 100.0), ('addr', 2, 100.0), ('addr', 3, 100.0);
	INSERT INTO ArticleInStorageCube VALUES (1, 'addr', 1, 3), (2, 'addr', 2, 4), (3, 'addr', 3, 5);
	INSERT INTO ArticleInLocation VALUES (1, 'addr', 3), (2, 'addr', 4), (3, 'addr', 5);
	INSERT INTO Supply VALUES (1, 1, 'addr', 2, 3), (2, 1, 'addr', 3, 4), (3, 1, 'addr', 3, 5);
	INSERT INTO PurchaseOrder VALUES (1, 1,null,null), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);

    -- Reduce amount by 2
    -- Old amount in every table was 3
    INSERT INTO PurchaseOrderLine (PurchaseOrder_orderNo, PurchaseOrder_referenceNo, "lineNo", Supply_supplyNo, Article_articleNo, ArticleInStorageCube_StorageCube_Location_address,
                                ArticleInStorageCube_StorageCube_referenceNo, ArticleInLocation_Location_address, amount)
        VALUES (1, 8, 1, 1, 1, 'addr', 1, 'addr', 2);

    -- Reduce amount from Article
    IF (SELECT amount FROM Article WHERE articleNo = 1) = 1
        PRINT 'Test BR05 - TR09 - 01 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR09 - 01 Failed'

    -- Reduce amount from ArticleInStorageCube
    IF (SELECT amount FROM ArticleInStorageCube WHERE Article_articleNo = 1) = 1
        PRINT 'Test BR05 - TR09 - 02 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR09 - 02 Failed'

    -- Reduce amount from ArticleInLocation
    IF (SELECT amount FROM ArticleInLocation WHERE Article_ArticleNo = 1) = 1
        PRINT 'Test BR05 - TR09 - 03 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR09 - 03 Failed'

    -- Reduce amount from Supply
    IF (SELECT amount FROM Supply WHERE supplyNo = 1) = 1
        PRINT 'Test BR05 - TR09 - 04 Succeeded'
    ELSE
        PRINT 'Test BR05 - TR09 - 04 Failed'
ROLLBACK TRAN


/** Constraint 10 **/

BEGIN TRAN
	INSERT INTO Article VALUES(1,3,null,null, 4.3), (2, 3,null,null, 4.3), (3, 3,null,null, 4.3),(4, 3,null,null, 4.3),(5, 3,null,null, 4.3);
	INSERT INTO Unit VALUES('unit1'),('unit2')
	INSERT INTO Article_in_Unit VALUES(1, 'unit1'),(2, 'unit1'),(3, 'unit2'),(4, 'unit1'),(5, 'unit1')
	INSERT INTO SalesOrder VALUES (1, 1,null,null), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);

    BEGIN TRY
		-- Success scenario
        -- Insert order line with article 1 and 2 that belong to unit1
		INSERT INTO SalesOrderLine VALUES(1, 1,1, null, 1,null,null,null,null,'unit1'),(1, 9,1, null, 2,null,null,null,null,'unit1')
        PRINT 'Test BR07 - TR10 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 01 Failed'
    END CATCH

	 BEGIN TRY
		-- Success scenario
        -- Insert order line with article 4 and 5 that belong to unit1
		INSERT INTO SalesOrderLine VALUES(2, 8,1, null, 5,null,null,null,null,'unit1'),(1, 5,2, null, 4,null,null,null,null,'unit1')
        PRINT 'Test BR07 - TR10 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 02 Failed'
    END CATCH

	BEGIN TRY
		-- Fail scenario
        -- Insert order line with article 4 and 5 that belong to unit1
		-- None of the records should get inserted
		INSERT INTO SalesOrderLine
		-- Insert order line with article 3 that belongs to unit3 (which should not violate the constraint by itself)
			VALUES(1, 9,2, null, 3,null,null,null,null,'unit1'),
				-- Insert order line with article 4 and 5 that belong to unit1
				(1, 9,3, null, 4,null,null,null,null, 'unit2'),
				(1, 1,4, null, 5,null,null,null,null, 'unit2')
        PRINT 'Test BR07 - TR10 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 03 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert order line with article 3 and 4 that belong to unit2
		-- None of the records should get inserted
		INSERT INTO SalesOrderLine
		-- Insert order line with article 3 that belongs to unit2 (which should not violate the constraint by itself)
			VALUES(1, 1,2, null, 3,null,null,null,null,'unit2'),
				-- Insert order line with article 4 and 5 that belong to unit1
				(1, 9,3, null, 4,null,null,null,null, 'unit1'),
				(1, 9,4, null, 5,null,null,null,null, 'unit1')
        PRINT 'Test BR07 - TR10 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR10 - 04 Failed'
    END CATCH
ROLLBACK TRAN


/** Constraint 11 **/

BEGIN TRAN
	INSERT INTO Article VALUES(1,3,null,null, 4.3), (2, 3,null,null, 4.3), (3, 3,null,null, 4.3),(4, 3,null,null, 4.3),(5, 3,null,null, 4.3);
	INSERT INTO Unit VALUES('unit1'),('unit2')
	INSERT INTO Article_in_Unit VALUES(1, 'unit1'),(2, 'unit1'),(3, 'unit2'),(4, 'unit1'),(5, 'unit1')	
	INSERT INTO PurchaseOrder VALUES (1, 1,null,null), (1, 9,null,null), (2, 8,1,9), (3, 1,1,9),(1,5,1,9);

    BEGIN TRY
		-- Success scenario
        -- Insert order line with article 1 and 2 that belong to unit1
		INSERT INTO PurchaseOrderLine
			VALUES(1, 1,1, null, 1,null,null,null,null,'unit1'),
				(1, 1,2, null, 2,null,null,null,null, 'unit1')
        PRINT 'Test BR07 - TR11 - 01 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR11 - 01 Failed'
    END CATCH

	BEGIN TRY
		-- Success scenario
        -- Insert order line with article 4 and 5 that belong to unit1
		INSERT INTO PurchaseOrderLine
			VALUES(1, 9,1, null, 5,null,null,null,null,'unit1'),
				(1, 9,2, null, 4,null,null,null,null, 'unit1')
        PRINT 'Test BR07 - TR11 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR11 - 02 Failed'
    END CATCH

	  BEGIN TRY
		-- Fail scenario
        -- Insert order line with article 1 and 2 that belong to unit1
		-- None of the records should get inserted
		INSERT INTO PurchaseOrderLine
		-- Insert order line with article 3 that belongs to unit2 (which should not violate the constraint by itself)
			VALUES(1, 1,1, null, 3,null,null,null,null, 'unit2'),
				-- Insert order line with article 1 and 2 that belong to unit1
				(1, 9,2, null, 1,null,null,null,null, 'unit2'),
				(1, 1,3, null, 2,null,null,null,null, 'unit2')
        PRINT 'Test BR07 - TR11 - 03 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR11 - 03 Failed'
    END CATCH

    BEGIN TRY
		-- Fail scenario
        -- Insert order line with article 5 and 4 that belong to unit1
		-- None of the records should get inserted
		INSERT INTO PurchaseOrderLine
		-- Insert order line with article 3 that belongs to unit2 (which should not violate the constraint by itself)
			VALUES(1, 9,1, null, 3,null,null,null,null, 'unit1'),
				-- Insert order line with article 4 and 5 that belong to unit1
				(1, 9,2, null, 4,null,null,null,null, 'unit2'),
				(1, 1,3, null, 5,null,null,null,null, 'unit2')
        PRINT 'Test BR07 - TR11 - 04 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR07 - TR11 - 04 Failed'
    END CATCH
ROLLBACK TRAN