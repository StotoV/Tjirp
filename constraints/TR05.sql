--BR03 - TR05

IF DB_ID('BR03_TR05') IS NULL
     CREATE DATABASE BR03_TR05
GO

USE BR03_TR05
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'Article'))
    DROP TABLE Article
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'SalesPayment'))
    DROP TABLE SalesPayment
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'SalesInvoiceLine'))
    DROP TABLE SalesInvoiceLine
GO

IF (EXISTS (SELECT * from sys.tables WHERE name = 'SalesInvoice'))
    DROP TABLE SalesInvoice
GO

CREATE TABLE SalesInvoice(
	invoiceNo		INT,
	referenceNo		VARCHAR(30),
	date			DATETIME,
	paymentDate		DATETIME,
	CONSTRAINT PK_SalesInvoice PRIMARY KEY (invoiceNo, referenceNo)
);

CREATE TABLE SalesInvoiceLine(
	SalesInvoice_invoiceNo		INT,
	SalesInvoice_referenceNo		VARCHAR(30),
	lineNum							INT,
	Article_articleNo				INT,
	amount							INT,
	CONSTRAINT PK_SalesInvoiceLine PRIMARY KEY (lineNum),
	CONSTRAINT FK_SalesInvoiceLine_SalesInvoice FOREIGN KEY (SalesInvoice_invoiceNo, SalesInvoice_referenceNo) REFERENCES SalesInvoice(invoiceNo, referenceNo)
);

CREATE TABLE SalesPayment(
	paymentNo						INT,
	SalesInvoice_invoiceNo			INT,
	SalesInvoice_referenceNo		VARCHAR(30),
	amount							INT,
	date							DATETIME,
	CONSTRAINT PK_SalesPayment PRIMARY KEY (paymentNo),
	CONSTRAINT FK_SalesPayment_SalesInvoice FOREIGN KEY (SalesInvoice_invoiceNo, SalesInvoice_referenceNo) REFERENCES SalesInvoice(invoiceNo, referenceNo)
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
INSERT INTO SalesInvoice(invoiceNo, referenceNo, date, paymentDate) 
	VALUES(1, '1A', convert(datetime,'2014-11-01T00:00:00.000'), convert(datetime,'2014-11-02T00:00:00.000'));
INSERT INTO SalesInvoiceLine(SalesInvoice_invoiceNo, SalesInvoice_referenceNo, lineNum, Article_articleNo, amount) 
	VALUES(1, '1A', 1, 1, 7), 
		(1, '1A', 2, 2, 2), 
		(1, '1A', 3, 3, 11);
INSERT INTO SalesPayment(paymentNo, SalesInvoice_invoiceNo, SalesInvoice_referenceNo, amount, date) 
	VALUES(6, 1, '1A', 20, convert(datetime,'2014-11-01T08:00:00.000'));
GO

CREATE TRIGGER TR04_SALES_PAYMENT_INVOICE_SUM_MATCH
	ON SalesPayment
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0
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
        PRINT 'Test BR01 - TR04 - 02 Succeeded'
    END TRY
    BEGIN CATCH
        PRINT 'Test BR01 - TR04 - 02 Failed'
    END CATCH
ROLLBACK TRAN

SELECT * FROM Article
SELECT * FROM SalesInvoice
SELECT * FROM SalesPayment
SELECT * FROM SalesInvoiceLine

--DELETE FROM SalesPayment
--DELETE FROM SalesInvoiceLine
--DELETE FROM SalesInvoice
--DELETE FROM Article