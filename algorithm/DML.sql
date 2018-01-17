USE Tjirp;
GO

SET NOCOUNT ON

INSERT INTO Module ("name", mandatory) VALUES ('Purchase', 0);
INSERT INTO Module ("name", mandatory) VALUES ('Sales', 0);
INSERT INTO Module ("name", mandatory) VALUES ('Stock', 1);
INSERT INTO Module ("name", mandatory) VALUES ('StockCubes', 0);
INSERT INTO Module ("name", mandatory) VALUES ('StockLocation', 0);
INSERT INTO "table" ("name", moduleName) VALUES ('"ARTICLE"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"ARTICLE_IN_UNIT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"ARTICLEDISCOUNT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"ARTICLEINLOCATION"', 'StockLocation');
INSERT INTO "table" ("name", moduleName) VALUES ('"ARTICLEINSTORAGECUBE"', 'StockCubes');
INSERT INTO "table" ("name", moduleName) VALUES ('"COMPONENT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"CUSTOMER"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"CUSTOMERDISCOUNT"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"EMPLOYEE"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"LOCATION"', 'StockLocation');
INSERT INTO "table" ("name", moduleName) VALUES ('"PRODUCT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEINVOICE"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEINVOICELINE"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEORDER"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEORDERLINE"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEPAYMENT"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEQUOTE"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"PURCHASEQUOTELINE"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESINVOICE"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESINVOICELINE"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESORDER"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESORDERDISCOUNT"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESORDERLINE"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESPAYMENT"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESQUOTE"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SALESQUOTELINE"', 'Sales');
INSERT INTO "table" ("name", moduleName) VALUES ('"SHELFLIFE"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"STORAGECUBE"', 'StockCubes');
INSERT INTO "table" ("name", moduleName) VALUES ('"STORAGEMETHOD"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"SUPPLIER"', 'Purchase');
INSERT INTO "table" ("name", moduleName) VALUES ('"SUPPLY"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"SUPPLYDISCOUNT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"UNIT"', 'Stock');
INSERT INTO "table" ("name", moduleName) VALUES ('"VATTYPE"', 'Stock');
INSERT INTO "Column" ("name") VALUES ('"ADDRESS"');
INSERT INTO "Column" ("name") VALUES ('"AMOUNT"');
INSERT INTO "Column" ("name") VALUES ('"ARRIVALDATE"');
INSERT INTO "Column" ("name") VALUES ('"ARTICLE_ARTICLENO"');
INSERT INTO "Column" ("name") VALUES ('"ARTICLEINLOCATION_LOCATION_ADDRESS"');
INSERT INTO "Column" ("name") VALUES ('"ARTICLEINSTORAGECUBE_STORAGECUBE_LOCATION_ADDRESS"');
INSERT INTO "Column" ("name") VALUES ('"ARTICLEINSTORAGECUBE_STORAGECUBE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"ARTICLENO"');
INSERT INTO "Column" ("name") VALUES ('"BACKORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"BACKORDERREFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"CATEGORY"');
INSERT INTO "Column" ("name") VALUES ('"COLOR"');
INSERT INTO "Column" ("name") VALUES ('"COMPONENT_ARTICLE_ARTICLENO"');
INSERT INTO "Column" ("name") VALUES ('"COMPONENT_ORDER"');
INSERT INTO "Column" ("name") VALUES ('"CUSTOMER_RELATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"DATE"');
INSERT INTO "Column" ("name") VALUES ('"DESCRIPTION"');
INSERT INTO "Column" ("name") VALUES ('"DISCOUNTCODE"');
INSERT INTO "Column" ("name") VALUES ('"EMAIL"');
INSERT INTO "Column" ("name") VALUES ('"EMPLOYEE_EMPLOYEEID"');
INSERT INTO "Column" ("name") VALUES ('"EMPLOYEEID"');
INSERT INTO "Column" ("name") VALUES ('"ENDDATE"');
INSERT INTO "Column" ("name") VALUES ('"FLAMMABLE"');
INSERT INTO "Column" ("name") VALUES ('"FRAGILE"');
INSERT INTO "Column" ("name") VALUES ('"FUNCTION"');
INSERT INTO "Column" ("name") VALUES ('"HEIGHT"');
INSERT INTO "Column" ("name") VALUES ('"INVOICENO"');
INSERT INTO "Column" ("name") VALUES ('"ISCANCELLED"');
INSERT INTO "Column" ("name") VALUES ('"ISSELLABLESTOCK"');
INSERT INTO "Column" ("name") VALUES ('"ISUSED"');
INSERT INTO "Column" ("name") VALUES ('"LENGTH"');
INSERT INTO "Column" ("name") VALUES ('"LINENO"');
INSERT INTO "Column" ("name") VALUES ('"LOCATION_ADDRESS"');
INSERT INTO "Column" ("name") VALUES ('"MARGIN"');
INSERT INTO "Column" ("name") VALUES ('"MAXTEMPERATURE"');
INSERT INTO "Column" ("name") VALUES ('"MAXWEIGHT"');
INSERT INTO "Column" ("name") VALUES ('"MINTEMPERATURE"');
INSERT INTO "Column" ("name") VALUES ('"NAME"');
INSERT INTO "Column" ("name") VALUES ('"ORDER"');
INSERT INTO "Column" ("name") VALUES ('"ORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"PAYMENTDATE"');
INSERT INTO "Column" ("name") VALUES ('"PAYMENTNO"');
INSERT INTO "Column" ("name") VALUES ('"PHONENO"');
INSERT INTO "Column" ("name") VALUES ('"PRICE"');
INSERT INTO "Column" ("name") VALUES ('"PRODUCTIONLOCATION"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEINVOICE_INVOICENO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEINVOICE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEORDER_ORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEORDER_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEORDERLINE_LINENO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEORDERLINE_PURCHASEORDER_ORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEORDERLINE_PURCHASEORDER_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEPRICE"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEQUOTE_QUOTATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"PURCHASEQUOTE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"QUOTATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"RELATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"SALESINVOICE_INVOICENO"');
INSERT INTO "Column" ("name") VALUES ('"SALESINVOICE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"SALESORDER_ORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"SALESORDER_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"SALESORDERLINE_LINENO"');
INSERT INTO "Column" ("name") VALUES ('"SALESORDERLINE_SALESORDER_ORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"SALESORDERLINE_SALESORDER_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"SALESQUOTE_QUOTATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"SALESQUOTE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"SEASON"');
INSERT INTO "Column" ("name") VALUES ('"SERIALNO"');
INSERT INTO "Column" ("name") VALUES ('"SHELFLIFE_SHELFLIFETYPE"');
INSERT INTO "Column" ("name") VALUES ('"SHELFLIFETIME"');
INSERT INTO "Column" ("name") VALUES ('"SHELFLIFETYPE"');
INSERT INTO "Column" ("name") VALUES ('"STARTDATE"');
INSERT INTO "Column" ("name") VALUES ('"STORAGECUBE_LOCATION_ADDRESS"');
INSERT INTO "Column" ("name") VALUES ('"STORAGECUBE_REFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"STORAGEMETHOD_NAME"');
INSERT INTO "Column" ("name") VALUES ('"SUPERORDERNO"');
INSERT INTO "Column" ("name") VALUES ('"SUPERORDERREFERENCENO"');
INSERT INTO "Column" ("name") VALUES ('"SUPPLIER_RELATIONNO"');
INSERT INTO "Column" ("name") VALUES ('"SUPPLY_SUPPLYNO"');
INSERT INTO "Column" ("name") VALUES ('"SUPPLYNO"');
INSERT INTO "Column" ("name") VALUES ('"TEMPERATURE"');
INSERT INTO "Column" ("name") VALUES ('"UNIT_NAME"');
INSERT INTO "Column" ("name") VALUES ('"VALUTA"');
INSERT INTO "Column" ("name") VALUES ('"VAT"');
INSERT INTO "Column" ("name") VALUES ('"VATTYPE_CATEGORY"');
INSERT INTO "Column" ("name") VALUES ('"WEIGHT"');
INSERT INTO "Column" ("name") VALUES ('"WIDTH"');
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"SHELFLIFE_SHELFLIFETYPE"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"COMPONENT_ARTICLE_ARTICLENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"COMPONENT_ORDER"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"DESCRIPTION"', 'text', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"MARGIN"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"PURCHASEPRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"LENGTH"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"WIDTH"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"HEIGHT"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"WEIGHT"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"MINTEMPERATURE"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"MAXTEMPERATURE"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"FRAGILE"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"COLOR"', 'varchar(8)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE"', '"FLAMMABLE"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE_IN_UNIT"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLE_IN_UNIT"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEDISCOUNT"', '"DISCOUNTCODE"', 'varchar(1024)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEDISCOUNT"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEDISCOUNT"', '"STARTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEDISCOUNT"', '"ENDDATE"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEDISCOUNT"', '"ISUSED"', 'bit', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINLOCATION"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINLOCATION"', '"LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINLOCATION"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINSTORAGECUBE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINSTORAGECUBE"', '"STORAGECUBE_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINSTORAGECUBE"', '"STORAGECUBE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"ARTICLEINSTORAGECUBE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"COMPONENT"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"COMPONENT"', '"ORDER"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"COMPONENT"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMER"', '"RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMER"', '"ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMER"', '"EMAIL"', 'varchar(254)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMER"', '"PHONENO"', 'varchar(20)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMER"', '"NAME"', 'varchar(100)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMERDISCOUNT"', '"DISCOUNTCODE"', 'varchar(1024)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMERDISCOUNT"', '"CUSTOMER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMERDISCOUNT"', '"STARTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMERDISCOUNT"', '"ENDDATE"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"CUSTOMERDISCOUNT"', '"ISUSED"', 'bit', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"EMPLOYEE"', '"EMPLOYEEID"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"EMPLOYEE"', '"NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"EMPLOYEE"', '"ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"EMPLOYEE"', '"FUNCTION"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"LOCATION"', '"ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"LOCATION"', '"DESCRIPTION"', 'varchar(255)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"SERIALNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"STORAGECUBE_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"STORAGECUBE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PRODUCT"', '"SUPPLY_SUPPLYNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICE"', '"INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICE"', '"REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICE"', '"SUPPLIER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICE"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICE"', '"PAYMENTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PURCHASEINVOICE_INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PURCHASEINVOICE_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PURCHASEORDERLINE_PURCHASEORDER_ORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PURCHASEORDERLINE_PURCHASEORDER_REFERENCENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PURCHASEORDERLINE_LINENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEINVOICELINE"', '"PRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"ORDERNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"PURCHASEINVOICE_INVOICENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"PURCHASEINVOICE_REFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"EMPLOYEE_EMPLOYEEID"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"SUPPLIER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"SUPERORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"SUPERORDERREFERENCENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDER"', '"ISCANCELLED"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"PURCHASEORDER_ORDERNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"PURCHASEORDER_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"ARTICLEINSTORAGECUBE_STORAGECUBE_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"ARTICLEINSTORAGECUBE_STORAGECUBE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"ARTICLEINLOCATION_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEORDERLINE"', '"PRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"PAYMENTNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"PURCHASEINVOICE_INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"PURCHASEINVOICE_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"VALUTA"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEPAYMENT"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"QUOTATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"PURCHASEORDER_ORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"PURCHASEORDER_REFERENCENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"EMPLOYEE_EMPLOYEEID"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"SUPPLIER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTE"', '"ISCANCELLED"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"PURCHASEQUOTE_QUOTATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"PURCHASEQUOTE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"PURCHASEQUOTELINE"', '"PRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICE"', '"INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICE"', '"REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICE"', '"CUSTOMER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICE"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICE"', '"PAYMENTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"SALESINVOICE_INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"SALESINVOICE_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"SALESORDERLINE_SALESORDER_ORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"SALESORDERLINE_SALESORDER_REFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"SALESORDERLINE_LINENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESINVOICELINE"', '"PRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"ORDERNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"EMPLOYEE_EMPLOYEEID"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"SALESINVOICE_INVOICENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"SALESINVOICE_REFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"CUSTOMER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"SUPERORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"SUPERORDERREFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"BACKORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"BACKORDERREFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDER"', '"ISCANCELLED"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"DISCOUNTCODE"', 'varchar(1024)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"SALESORDER_ORDERNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"SALESORDER_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"STARTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"ENDDATE"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERDISCOUNT"', '"ISUSED"', 'bit', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"SALESORDER_ORDERNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"SALESORDER_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"SUPPLY_SUPPLYNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"ARTICLEINSTORAGECUBE_STORAGECUBE_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"ARTICLEINSTORAGECUBE_STORAGECUBE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"ARTICLEINLOCATION_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESORDERLINE"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"PAYMENTNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"SALESINVOICE_INVOICENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"SALESINVOICE_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"VALUTA"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESPAYMENT"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"QUOTATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"SALESORDER_ORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"SALESORDER_REFERENCENO"', 'varchar(30)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"EMPLOYEE_EMPLOYEEID"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"CUSTOMER_RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"DATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTE"', '"ISCANCELLED"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"SALESQUOTE_QUOTATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"SALESQUOTE_REFERENCENO"', 'varchar(30)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"LINENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"VATTYPE_CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SALESQUOTELINE"', '"PRICE"', 'decimal(19, 4)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SHELFLIFE"', '"SHELFLIFETYPE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"STORAGEMETHOD_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"LENGTH"', 'varchar(10)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"WIDTH"', 'varchar(10)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"HEIGHT"', 'varchar(10)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"MAXWEIGHT"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGECUBE"', '"TEMPERATURE"', 'decimal', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGEMETHOD"', '"NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"STORAGEMETHOD"', '"DESCRIPTION"', 'varchar(255)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLIER"', '"RELATIONNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLIER"', '"ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLIER"', '"EMAIL"', 'varchar(254)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLIER"', '"PHONENO"', 'varchar(20)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLIER"', '"NAME"', 'varchar(100)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"SUPPLYNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"PURCHASEORDERLINE_PURCHASEORDER_ORDERNO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"PURCHASEORDERLINE_PURCHASEORDER_REFERENCENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"PURCHASEORDERLINE_LINENO"', 'int', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"STORAGECUBE_LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"STORAGECUBE_REFERENCENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"ARTICLE_ARTICLENO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"UNIT_NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"LOCATION_ADDRESS"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"SHELFLIFETIME"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"ARRIVALDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"SEASON"', 'varchar(25)', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"PRODUCTIONLOCATION"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"ISSELLABLESTOCK"', 'bit', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLY"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLYDISCOUNT"', '"DISCOUNTCODE"', 'varchar(1024)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLYDISCOUNT"', '"SUPPLY_SUPPLYNO"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLYDISCOUNT"', '"STARTDATE"', 'datetime', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLYDISCOUNT"', '"ENDDATE"', 'datetime', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"SUPPLYDISCOUNT"', '"ISUSED"', 'bit', 0);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"UNIT"', '"NAME"', 'varchar(100)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"UNIT"', '"AMOUNT"', 'int', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"VATTYPE"', '"CATEGORY"', 'varchar(20)', 1);
INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ('"VATTYPE"', '"VAT"', 'decimal(5, 2)', 1);
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE_2', '"COMPONENT"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE', '"COMPONENT"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_CUSTOMER_DISCOUNT__CUSTOMER', '"CUSTOMERDISCOUNT"', '"CUSTOMER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PRODUCT_ARTICLE_A_ARTICLE', '"PRODUCT"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PRODUCT_PRODUCT_I_LOCATION', '"PRODUCT"', '"LOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PRODUCT_PRODUCT_I_STORAGEC', '"PRODUCT"', '"STORAGECUBE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PRODUCT_PRODUCT_I_SUPPLY', '"PRODUCT"', '"SUPPLY"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEI_SUPPLIER', '"PURCHASEINVOICE"', '"SUPPLIER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_3', '"PURCHASEINVOICELINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEI_PURCHASE', '"PURCHASEINVOICELINE"', '"PURCHASEINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEINVOICELINE"', '"PURCHASEORDERLINE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_3', '"PURCHASEINVOICELINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_3', '"PURCHASEINVOICELINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_SUPPLIER', '"PURCHASEORDER"', '"SUPPLIER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_3', '"PURCHASEORDER"', '"PURCHASEINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_EMPLOYEE', '"PURCHASEORDER"', '"EMPLOYEE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_6', '"PURCHASEORDER"', '"PURCHASEORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_2', '"PURCHASEORDERLINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI_2', '"PURCHASEORDERLINE"', '"ARTICLEINLOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"PURCHASEORDERLINE"', '"ARTICLEINSTORAGECUBE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_2', '"PURCHASEORDERLINE"', '"PURCHASEORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_2', '"PURCHASEORDERLINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_2', '"PURCHASEORDERLINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEP_PURCHASE', '"PURCHASEPAYMENT"', '"PURCHASEINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_4', '"PURCHASEQUOTE"', '"PURCHASEORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEQ_SUPPLIER', '"PURCHASEQUOTE"', '"SUPPLIER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEQ_EMPLOYEE', '"PURCHASEQUOTE"', '"EMPLOYEE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE', '"PURCHASEQUOTELINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_PURCHASEQ_PURCHASE', '"PURCHASEQUOTELINE"', '"PURCHASEQUOTE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT', '"PURCHASEQUOTELINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE', '"PURCHASEQUOTELINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_SALESINVO_CUSTOMER', '"SALESINVOICE"', '"CUSTOMER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_ARTICLE_I_ARTICLE', '"SALESINVOICELINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_SALESINVO_SALESINV', '"SALESINVOICELINE"', '"SALESINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESINVOICELINE"', '"SALESORDERLINE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_UNIT_IN_S_UNIT', '"SALESINVOICELINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESINV_VATTYPE_F_VATTYPE', '"SALESINVOICELINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_SALESORD_2', '"SALESORDER"', '"SALESORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_CUSTOMER', '"SALESORDER"', '"CUSTOMER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_SALESINV_2', '"SALESORDER"', '"SALESINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_EMPLOYEE', '"SALESORDER"', '"EMPLOYEE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_SALESORD', '"SALESORDER"', '"SALESORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_DISCOUNT__SALESORD', '"SALESORDERDISCOUNT"', '"SALESORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_ARTICLE_I_ARTICLE', '"SALESORDERLINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI_2', '"SALESORDERLINE"', '"ARTICLEINLOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"SALESORDERLINE"', '"ARTICLEINSTORAGECUBE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SALESORDE_SALESORD_3', '"SALESORDERLINE"', '"SALESORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_SUPPLY_IN_SUPPLY', '"SALESORDERLINE"', '"SUPPLY"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_UNIT_IN_S_UNIT', '"SALESORDERLINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESORD_VATTYPE_F_VATTYPE', '"SALESORDERLINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESPAY_SALESPAYM_SALESINV', '"SALESPAYMENT"', '"SALESINVOICE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_SALESORDE_SALESORD', '"SALESQUOTE"', '"SALESORDER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_SALESQUOT_CUSTOMER', '"SALESQUOTE"', '"CUSTOMER"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_SALESQUOT_EMPLOYEE', '"SALESQUOTE"', '"EMPLOYEE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_ARTICLE_I_ARTICLE', '"SALESQUOTELINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_RELATIONS_ARTICLE', '"SALESQUOTELINE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_SALESQUOT_SALESQUO', '"SALESQUOTELINE"', '"SALESQUOTE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_UNIT_IN_S_UNIT', '"SALESQUOTELINE"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SALESQUO_VATTYPE_F_VATTYPE', '"SALESQUOTELINE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_STORAGEC_STORAGECU_LOCATION', '"STORAGECUBE"', '"LOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_STORAGEC_STORAGECU_STORAGEM', '"STORAGECUBE"', '"STORAGEMETHOD"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLY_ARTICLE_I_ARTICLE', '"SUPPLY"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLY_SUPPLY_IN_LOCATION', '"SUPPLY"', '"LOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"SUPPLY"', '"PURCHASEORDERLINE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLY_SUPPLY_IN_STORAGEC', '"SUPPLY"', '"STORAGECUBE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLY_UNIT_IN_S_UNIT', '"SUPPLY"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_SUPPLYDI_DISCOUNT__SUPPLY', '"SUPPLYDISCOUNT"', '"SUPPLY"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLE_COMPONENT_COMPONEN', '"ARTICLE"', '"COMPONENT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLE_SHELFLIFE_SHELFLIF', '"ARTICLE"', '"SHELFLIFE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLE_VATTYPE_F_VATTYPE', '"ARTICLE"', '"VATTYPE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLED_DISCOUNT__ARTICLE', '"ARTICLEDISCOUNT"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE', '"ARTICLEINLOCATION"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLEI_LOCATION__LOCATION', '"ARTICLEINLOCATION"', '"LOCATION"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE_2', '"ARTICLEINSTORAGECUBE"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLEI_STORAGECU_STORAGEC', '"ARTICLEINSTORAGECUBE"', '"STORAGECUBE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLE__ARTICLE_I_ARTICLE', '"ARTICLE_IN_UNIT"', '"ARTICLE"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES ('FK_ARTICLE__ARTICLE_I_UNIT', '"ARTICLE_IN_UNIT"', '"UNIT"', 'FOREIGN KEY');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE__ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE__ARTICLE_I_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_COMPONENT_COMPONEN', '"ARTICLE_ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_COMPONENT_COMPONEN', '"ORDER"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_SHELFLIFE_SHELFLIF', '"SHELFLIFETYPE"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_VATTYPE_F_VATTYPE', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLED_DISCOUNT__ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE_2', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_LOCATION__LOCATION', '"ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_STORAGECU_STORAGEC', '"LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_STORAGECU_STORAGEC', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE_2', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_CUSTOMER_DISCOUNT__CUSTOMER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_ARTICLE_A_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_LOCATION', '"ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_STORAGEC', '"LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_STORAGEC', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_SUPPLY', '"SUPPLYNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_2', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_3', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_PURCHASE', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_PURCHASE', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_SUPPLIER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"STORAGECUBE_LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"ARTICLE_ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"STORAGECUBE_REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI_2', '"ARTICLE_ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI_2', '"LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_EMPLOYEE', '"EMPLOYEEID"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_2', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_2', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_3', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_3', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_4', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_4', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_6', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_6', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEORDER_ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEORDER_REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"LINENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_SUPPLIER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEP_PURCHASE', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEP_PURCHASE', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_EMPLOYEE', '"EMPLOYEEID"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_PURCHASE', '"QUOTATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_PURCHASE', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_SUPPLIER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_2', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_3', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_2', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_3', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_CUSTOMER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_SALESINV', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_SALESINV', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESORDER_ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESORDER_REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"LINENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_UNIT_IN_S_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_VATTYPE_F_VATTYPE', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_DISCOUNT__SALESORD', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_DISCOUNT__SALESORD', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"STORAGECUBE_LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"ARTICLE_ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"STORAGECUBE_REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI_2', '"ARTICLE_ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI_2', '"LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_CUSTOMER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_EMPLOYEE', '"EMPLOYEEID"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESINV_2', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESINV_2', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_2', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_2', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_3', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_3', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SUPPLY_IN_SUPPLY', '"SUPPLYNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_UNIT_IN_S_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_VATTYPE_F_VATTYPE', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESPAY_SALESPAYM_SALESINV', '"INVOICENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESPAY_SALESPAYM_SALESINV', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_RELATIONS_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESORDE_SALESORD', '"ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESORDE_SALESORD', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_CUSTOMER', '"RELATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_EMPLOYEE', '"EMPLOYEEID"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_SALESQUO', '"QUOTATIONNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_SALESQUO', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_UNIT_IN_S_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_VATTYPE_F_VATTYPE', '"CATEGORY"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_STORAGEC_STORAGECU_LOCATION', '"ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_STORAGEC_STORAGECU_STORAGEM', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_ARTICLE_I_ARTICLE', '"ARTICLENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_LOCATION', '"ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"PURCHASEORDER_ORDERNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"PURCHASEORDER_REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"LINENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_STORAGEC', '"LOCATION_ADDRESS"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_STORAGEC', '"REFERENCENO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_UNIT_IN_S_UNIT', '"NAME"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLYDI_DISCOUNT__SUPPLY', '"SUPPLYNO"', 1);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE__ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE__ARTICLE_I_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_COMPONENT_COMPONEN', '"COMPONENT_ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_COMPONENT_COMPONEN', '"COMPONENT_ORDER"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_SHELFLIFE_SHELFLIF', '"SHELFLIFE_SHELFLIFETYPE"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLE_VATTYPE_F_VATTYPE', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLED_DISCOUNT__ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_ARTICLE_I_ARTICLE_2', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_LOCATION__LOCATION', '"LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_STORAGECU_STORAGEC', '"STORAGECUBE_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_ARTICLEI_STORAGECU_STORAGEC', '"STORAGECUBE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_COMPONEN_COMPONENT_ARTICLE_2', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_CUSTOMER_DISCOUNT__CUSTOMER', '"CUSTOMER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_ARTICLE_A_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_LOCATION', '"LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_STORAGEC', '"STORAGECUBE_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_STORAGEC', '"STORAGECUBE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PRODUCT_PRODUCT_I_SUPPLY', '"SUPPLY_SUPPLYNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_2', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_ARTICLE_I_ARTICLE_3', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_PURCHASE', '"PURCHASEINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_PURCHASE', '"PURCHASEINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEI_SUPPLIER', '"SUPPLIER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"ARTICLEINSTORAGECUBE_STORAGECUBE_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI', '"ARTICLEINSTORAGECUBE_STORAGECUBE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI_2', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_ARTICLEI_2', '"ARTICLEINLOCATION_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_EMPLOYEE', '"EMPLOYEE_EMPLOYEEID"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_2', '"PURCHASEORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_2', '"PURCHASEORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_3', '"PURCHASEINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_3', '"PURCHASEINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_4', '"PURCHASEORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_4', '"PURCHASEORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_6', '"SUPERORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_6', '"SUPERORDERREFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEORDERLINE_PURCHASEORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEORDERLINE_PURCHASEORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_PURCHASE_7', '"PURCHASEORDERLINE_LINENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEO_SUPPLIER', '"SUPPLIER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEP_PURCHASE', '"PURCHASEINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEP_PURCHASE', '"PURCHASEINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_EMPLOYEE', '"EMPLOYEE_EMPLOYEEID"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_PURCHASE', '"PURCHASEQUOTE_QUOTATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_PURCHASE', '"PURCHASEQUOTE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_PURCHASEQ_SUPPLIER', '"SUPPLIER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_2', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_UNIT_IN_P_UNIT_3', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_2', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_PURCHASE_VATTYPE_F_VATTYPE_3', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_CUSTOMER', '"CUSTOMER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_SALESINV', '"SALESINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESINVO_SALESINV', '"SALESINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESORDERLINE_SALESORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESORDERLINE_SALESORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_SALESORDE_SALESORD', '"SALESORDERLINE_LINENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_UNIT_IN_S_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESINV_VATTYPE_F_VATTYPE', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_DISCOUNT__SALESORD', '"SALESORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_DISCOUNT__SALESORD', '"SALESORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"ARTICLEINSTORAGECUBE_STORAGECUBE_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI', '"ARTICLEINSTORAGECUBE_STORAGECUBE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI_2', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_ARTICLEI_2', '"ARTICLEINLOCATION_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_CUSTOMER', '"CUSTOMER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_EMPLOYEE', '"EMPLOYEE_EMPLOYEEID"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESINV_2', '"SALESINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESINV_2', '"SALESINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD', '"SUPERORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD', '"SUPERORDERREFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_2', '"BACKORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_2', '"BACKORDERREFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_3', '"SALESORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SALESORDE_SALESORD_3', '"SALESORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_SUPPLY_IN_SUPPLY', '"SUPPLY_SUPPLYNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_UNIT_IN_S_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESORD_VATTYPE_F_VATTYPE', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESPAY_SALESPAYM_SALESINV', '"SALESINVOICE_INVOICENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESPAY_SALESPAYM_SALESINV', '"SALESINVOICE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_RELATIONS_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESORDE_SALESORD', '"SALESORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESORDE_SALESORD', '"SALESORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_CUSTOMER', '"CUSTOMER_RELATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_EMPLOYEE', '"EMPLOYEE_EMPLOYEEID"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_SALESQUO', '"SALESQUOTE_QUOTATIONNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_SALESQUOT_SALESQUO', '"SALESQUOTE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_UNIT_IN_S_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SALESQUO_VATTYPE_F_VATTYPE', '"VATTYPE_CATEGORY"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_STORAGEC_STORAGECU_LOCATION', '"LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_STORAGEC_STORAGECU_STORAGEM', '"STORAGEMETHOD_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_ARTICLE_I_ARTICLE', '"ARTICLE_ARTICLENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_LOCATION', '"LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"PURCHASEORDERLINE_PURCHASEORDER_ORDERNO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"PURCHASEORDERLINE_PURCHASEORDER_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_PURCHASE', '"PURCHASEORDERLINE_LINENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_STORAGEC', '"STORAGECUBE_LOCATION_ADDRESS"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_SUPPLY_IN_STORAGEC', '"STORAGECUBE_REFERENCENO"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLY_UNIT_IN_S_UNIT', '"UNIT_NAME"', 0);
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES ('FK_SUPPLYDI_DISCOUNT__SUPPLY', '"SUPPLY_SUPPLYNO"', 0);
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_ARTICLE', '"ARTICLE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_ARTICLE_IN_UNIT', '"ARTICLE_IN_UNIT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_ARTICLEDISCOUNT', '"ARTICLEDISCOUNT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_ARTICLEINLOCATION', '"ARTICLEINLOCATION"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_ARTICLEINSTORAGECUBE', '"ARTICLEINSTORAGECUBE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_COMPONENT', '"COMPONENT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_CUSTOMER', '"CUSTOMER"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_CUSTOMERDISCOUNT', '"CUSTOMERDISCOUNT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_EMPLOYEE', '"EMPLOYEE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_LOCATION', '"LOCATION"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PRODUCT', '"PRODUCT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEINVOICE', '"PURCHASEINVOICE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEINVOICELINE', '"PURCHASEINVOICELINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEORDER', '"PURCHASEORDER"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEORDERLINE', '"PURCHASEORDERLINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEPAYMENT', '"PURCHASEPAYMENT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEQUOTE', '"PURCHASEQUOTE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_PURCHASEQUOTELINE', '"PURCHASEQUOTELINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESINVOICE', '"SALESINVOICE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESINVOICELINE', '"SALESINVOICELINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESORDER', '"SALESORDER"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESORDERDISCOUNT', '"SALESORDERDISCOUNT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESORDERLINE', '"SALESORDERLINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESPAYMENT', '"SALESPAYMENT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESQUOTE', '"SALESQUOTE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SALESQUOTELINE', '"SALESQUOTELINE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SHELFLIFE', '"SHELFLIFE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_STORAGECUBE', '"STORAGECUBE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_STORAGEMETHOD', '"STORAGEMETHOD"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SUPPLIER', '"SUPPLIER"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SUPPLY', '"SUPPLY"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_SUPPLYDISCOUNT', '"SUPPLYDISCOUNT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_UNIT', '"UNIT"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES ('PK_VATTYPE', '"VATTYPE"', 'PRIMARY KEY');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLE', '"ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLE_IN_UNIT', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLE_IN_UNIT', '"UNIT_NAME"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEDISCOUNT', '"DISCOUNTCODE"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEINLOCATION', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEINLOCATION', '"LOCATION_ADDRESS"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEINSTORAGECUBE', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEINSTORAGECUBE', '"STORAGECUBE_LOCATION_ADDRESS"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_ARTICLEINSTORAGECUBE', '"STORAGECUBE_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_COMPONENT', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_COMPONENT', '"ORDER"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_CUSTOMER', '"RELATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_CUSTOMERDISCOUNT', '"DISCOUNTCODE"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_EMPLOYEE', '"EMPLOYEEID"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_LOCATION', '"ADDRESS"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PRODUCT', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PRODUCT', '"SERIALNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEINVOICE', '"INVOICENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEINVOICE', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEINVOICELINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEINVOICELINE', '"PURCHASEINVOICE_INVOICENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEINVOICELINE', '"PURCHASEINVOICE_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEORDER', '"ORDERNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEORDER', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEORDERLINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEORDERLINE', '"PURCHASEORDER_ORDERNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEORDERLINE', '"PURCHASEORDER_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEPAYMENT', '"PAYMENTNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEQUOTE', '"QUOTATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEQUOTE', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEQUOTELINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEQUOTELINE', '"PURCHASEQUOTE_QUOTATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_PURCHASEQUOTELINE', '"PURCHASEQUOTE_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESINVOICE', '"INVOICENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESINVOICE', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESINVOICELINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESINVOICELINE', '"SALESINVOICE_INVOICENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESINVOICELINE', '"SALESINVOICE_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDER', '"ORDERNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDER', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDERDISCOUNT', '"DISCOUNTCODE"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDERLINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDERLINE', '"SALESORDER_ORDERNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESORDERLINE', '"SALESORDER_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESPAYMENT', '"PAYMENTNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTE', '"QUOTATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTE', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTELINE', '"ARTICLE_ARTICLENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTELINE', '"LINENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTELINE', '"SALESQUOTE_QUOTATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SALESQUOTELINE', '"SALESQUOTE_REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SHELFLIFE', '"SHELFLIFETYPE"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_STORAGECUBE', '"LOCATION_ADDRESS"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_STORAGECUBE', '"REFERENCENO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_STORAGEMETHOD', '"NAME"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SUPPLIER', '"RELATIONNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SUPPLY', '"SUPPLYNO"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_SUPPLYDISCOUNT', '"DISCOUNTCODE"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_UNIT', '"NAME"');
INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES ('PK_VATTYPE', '"CATEGORY"');

--
-- CK01
--
INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType, constraintLogic)
    VALUES ('CK01_TEMPERATURE', '"Article"', 'CHECK', 'maxTemperature >= minTemperature');

--
-- TR01
--
INSERT INTO ProceduralConstraint (tableName, constraintName, constraintType, moduleName, constraintLogic, constraintMetaData)
    VALUES ('"Supply"', 'TR01_Supply', 'TRIGGER', 'Stock',
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
    VALUES ('"ArticleInStorageCube"', 'TR02_ArticleInStorageCube', 'TRIGGER', 'StockCubes',
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
    VALUES ('"Product"', 'TR03_Product', 'TRIGGER', 'Stock',
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
    VALUES ('"PurchasePayment"', 'TR04_PURCHASE_PAYMENT_INVOICE_SUM_MATCH', 'TRIGGER', 'Purchase',
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
    VALUES ('"SalesPayment"', 'TR05_SALES_PAYMENT_INVOICE_SUM_MATCH', 'TRIGGER', 'Sales',
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
    VALUES ('"PurchaseOrderLine"', 'TR06_PurchaseOrder_Amount', 'TRIGGER', 'Purchase',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY
            Declare @amount INT
            Declare @superOrderNo INT
            Declare @superRef INT
            Declare @ArticleNo INT
            Select @superOrderNo = Po.superOrderNo, @superRef = Po.superOrderReferenceNo, @amount = Pl.Amount ,@ArticleNo = Pl.Article_articleNo
            From PurchaseOrder Po inner join inserted i on Po.orderNo = i.PurchaseOrder_orderNo AND Po.referenceNo = i.PurchaseOrder_referenceNo inner join PurchaseOrderLine Pl
                 on Po.superOrderNo = Pl.PurchaseOrder_orderNo AND Po.superOrderReferenceNo = Pl.PurchaseOrder_referenceNo

            if((Select SUM(Amount) From PurchaseOrderLine pl inner join PurchaseOrder po on pl.PurchaseOrder_orderNo = po.orderNo AND pl.PurchaseOrder_referenceNo = po.referenceNo
                Where po.superOrderNo = @superOrderNo AND po.superOrderReferenceNo = @superRef AND pl.Article_articleNo = @ArticleNo) > @amount)


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
    VALUES ('"SalesOrderLine"', 'TR07_SalesOrder_Amount', 'TRIGGER', 'Sales',
            'IF @@ROWCOUNT = 0
                RETURN
            SET NOCOUNT ON

            BEGIN TRY
            Declare @amount INT
            Declare @superOrderNo INT
            Declare @superRef INT
            Declare @ArticleNo INT
            Select @superOrderNo = So.superOrderNo, @superRef = So.superOrderReferenceNo, @amount = Sl.Amount, @ArticleNo = Sl.Article_articleNo
            From SalesOrder So inner join inserted i on So.orderNo = i.SalesOrder_orderNo AND So.referenceNo = i.SalesOrder_referenceNo inner join SalesOrderLine Sl
                 on So.superOrderNo = Sl.SalesOrder_orderNo AND So.superOrderReferenceNo = Sl.SalesOrder_referenceNo

            if((Select SUM(Amount) From SalesOrderLine Sl inner join SalesOrder So on Sl.SalesOrder_orderNo = So.orderNo AND Sl.SalesOrder_referenceNo = So.referenceNo
                Where So.superOrderNo = @superOrderNo AND So.superOrderReferenceNo = @superRef AND Sl.Article_articleNo = @ArticleNo) > @amount)


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
    VALUES ('"SalesOrderLine"', 'TR08_SalesOrderLine', 'TRIGGER', 'Sales',
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
    VALUES ('"PurchaseOrderLine"', 'TR09_PurchaseOrderLine', 'TRIGGER', 'Purchase',
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
                        ON s.PurchaseOrderLine_PurchaseOrder_OrderNo = i.PurchaseOrder_OrderNo
                            AND s.PurchaseOrderLine_PurchaseOrder_referenceNo = i.PurchaseOrder_referenceNo
                            AND s.PurchaseOrderLine_lineNo = i."lineNo";
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
    VALUES ('"SalesOrderLine"', 'TR10_SALES_UNIT_NAME_IN_UNIT_IN_ARTICLE', 'TRIGGER', 'Sales',
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
    VALUES ('"PurchaseOrderLine"', 'TR11_PURCHASE_UNIT_NAME_IN_UNIT_IN_ARTICLE', 'TRIGGER', 'Purchase',
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