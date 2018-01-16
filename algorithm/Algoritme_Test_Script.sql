'/*
=======================================================
-- Algoritme Test Scripts	 ==
=======================================================
*/'


	-- Check if algoritme generates Database Script
	-- Should generate all Table: Article, Component, SalesOrder, Employee, PurchaseOrder
	BEGIN TRY
	DECLARE @PREFERENCES AS PreferenceTable,@OUTPUT VARCHAR(MAX)
	INSERT INTO @PREFERENCES (moduleName) VALUES ('Stock'), ('Purchase'), ('Employee'), ('Sales')
	EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
	PRINT @OUTPUT
		PRINT 'Script generation Succeeded'
	END TRY
	BEGIN CATCH
		PRINT 'Script generation Failed'
		;THROW
	END CATCH

	-- Check if correct tables are generated for selected module
	-- Module: Stock should only produce Table: Article & Component
	BEGIN TRY
	DECLARE @PREFERENCES AS PreferenceTable,@OUTPUT VARCHAR(MAX)
	INSERT INTO @PREFERENCES (moduleName) VALUES ('Stock')
	EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
	PRINT @OUTPUT
		PRINT 'Script generation Succeeded'
	END TRY
	BEGIN CATCH
		PRINT 'Script generation Failed'
		;THROW
	END CATCH

	-- Check if correct tables are generated for selected module
	-- Module: Sales should produce Table: SalesOrder & Mandatory Tables: Article & Component
	BEGIN TRY
	DECLARE @PREFERENCES AS PreferenceTable,@OUTPUT VARCHAR(MAX)
	INSERT INTO @PREFERENCES (moduleName) c
	EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
	PRINT @OUTPUT
		PRINT 'Script generation Succeeded'
	END TRY
	BEGIN CATCH
		PRINT 'Script generation Failed'
		;THROW
	END CATCH


	-- Check if correct tables are generated for selected module
	-- Module: None should always produce the mandatory Tables: Article & Component
	BEGIN TRY
	DECLARE @PREFERENCES AS PreferenceTable,@OUTPUT VARCHAR(MAX) 
	EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
	PRINT @OUTPUT
		PRINT 'Script generation Succeeded'
	END TRY
	BEGIN CATCH
		PRINT 'Script generation Failed'
		;THROW
	END CATCH

	-- Check if table has the correct colomns
	-- Module: None should always produce the mandatory Tables: Article & Component
	-- Table: Article should have colomns: productId, productIdBackup, productIdBackup2, productIdBackupOtherModule
	-- Table: Component should have colomn: productIdBackupOtherModule
	BEGIN TRY
	DECLARE @PREFERENCES AS PreferenceTable,@OUTPUT VARCHAR(MAX) 
	EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT
	PRINT @OUTPUT
		PRINT 'Script generation Succeeded'
	END TRY
	BEGIN CATCH
		PRINT 'Script generation Failed'
		;THROW
	END CATCH


