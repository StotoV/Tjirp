--BR03 - TR04

IF DB_ID('BR03_TR04') IS NULL
     CREATE DATABASE BR03_TR04
GO

USE BR03_TR04
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Article'))
    DROP TABLE Article
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'PurchasePayment'))
    DROP TABLE PurchasePayment
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'PurchaseInvoiceLine'))
    DROP TABLE PurchaseInvoiceLine
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'PurchaseInvoice'))
    DROP TABLE PurchaseInvoice
GO

CREATE TABLE PurchaseInvoice(
	invoiceNo		INT,
	referenceNo		VARCHAR(30),
	date			DATETIME,
	paymentDate		DATETIME,
	CONSTRAINT PK_PurchaseInvoice PRIMARY KEY (invoiceNo, referenceNo)
);

CREATE TABLE PurchaseInvoiceLine(
	PurchaseInvoice_invoiceNo		INT,
	PurchaseInvoice_referenceNo		VARCHAR(30),
	lineNum							INT,
	Article_articleNo				INT,
	amount							INT,
	CONSTRAINT PK_PurchaseInvoiceLine PRIMARY KEY (lineNum),
	CONSTRAINT FK_PurchaseInvoiceLine_PurchaseInvoice FOREIGN KEY (PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo) REFERENCES PurchaseInvoice(invoiceNo, referenceNo)
);

CREATE TABLE PurchasePayment(
	paymentNo						INT,
	PurchaseInvoice_invoiceNo		INT,
	PurchaseInvoice_referenceNo		VARCHAR(30),
	amount							INT,
	date							DATETIME,
	CONSTRAINT PK_PurchasePayment PRIMARY KEY (paymentNo),
	CONSTRAINT FK_PurchasePayment_PurchaseInvoice FOREIGN KEY (PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo) REFERENCES PurchaseInvoice(invoiceNo, referenceNo)
);

CREATE TABLE Article(
	articleNo						INT,
	amount							INT,
	CONSTRAINT PK_Article PRIMARY KEY (articleNo)
);

INSERT INTO Article(articleNo, amount) 
	VALUES(1, 100), 
		(2, 75), 
		(3, 16);
INSERT INTO PurchaseInvoice(invoiceNo, referenceNo, date, paymentDate) 
	VALUES(1, '1A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
INSERT INTO PurchaseInvoiceLine(PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo, lineNum, Article_articleNo, amount) 
	VALUES(1, '1A', 1, 1, 7), 
		(1, '1A', 2, 2, 2), 
		(1, '1A', 3, 3, 11);
INSERT INTO PurchasePayment(paymentNo, PurchaseInvoice_invoiceNo, PurchaseInvoice_referenceNo, amount, date) 
	VALUES(6, 1, '1A', 20, convert(datetime,'2014-11-01T08:00:00.000'));
GO

CREATE TRIGGER TR04_PURCHASE_PAYMENT_INVOICE_SUM_MATCH
	ON PurchasePayment
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
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
			;THROW 50001,'The specified amount in the payment must be equal to the sum of the amount of each article in the invoice',1
		END
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

BEGIN TRAN
    BEGIN TRY
		-- Success scenario
        -- Insert a payment amount of 22 and an invoice line with 3 different article amounts of 3, 7 and 12, adding up to 22
		INSERT INTO Article 
			VALUES(4, 100), 
				(5, 75), 
				(6, 16);
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
			VALUES(7, 100), 
				(8, 75), 
				(9, 16);
		INSERT INTO PurchaseInvoice 
			VALUES(3, '3A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
		INSERT INTO PurchaseInvoiceLine 
			-- Insert an invoice line with 3 different article amounts of 2, 10 and 15, adding up to 27
			VALUES(3, '3A', 7, 7, 2), 
				(3, '3A', 8, 8, 10), 
				(3, '3A', 9, 9, 15);
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

SELECT * FROM Article
SELECT * FROM PurchaseInvoice
SELECT * FROM PurchasePayment
SELECT * FROM PurchaseInvoiceLine

--DELETE FROM PurchasePayment
--DELETE FROM PurchaseInvoiceLine
--DELETE FROM PurchaseInvoice
--DELETE FROM Article