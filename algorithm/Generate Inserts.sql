-- Set database name in which the ERP database is deployed
USE test;

--
-- Module per table
--
-- Set the default module name
DECLARE @defaultModule VARCHAR(MAX) = 'Stock'

--
-- Module
--
DECLARE @Module TABLE (
    moduleName VARCHAR(250) NOT NULL,
    mandatory BIT DEFAULT 0
)
INSERT INTO @Module (moduleName, mandatory)
    VALUES
      (@defaultModule, 1),
      ('Sales', 0),
      ('Purchase', 0),
      ('StockLocation', 0),
      ('StockCubes', 0);

SELECT
    'INSERT INTO Module ("name", mandatory) VALUES (' +
    '''' + moduleName + ''', ' +
    CAST(mandatory as VARCHAR) + ');'
FROM
    @Module
GROUP BY
    moduleName, mandatory

--
-- Tables
--
DECLARE @TableModule TABLE (
    tableName VARCHAR(128) NOT NULL,
    moduleName VARCHAR(250) NULL,
    mandatory BIT DEFAULT 0
)
INSERT INTO @TableModule (tableName, moduleName) VALUES
    ('Article', 'Stock'),
    ('Article_in_Unit', 'Stock'),
    ('ArticleDiscount', 'Stock'),
    ('ArticleInLocation', 'StockLocation'),
    ('ArticleInStorageCube', 'StockCubes'),
    ('Component', 'Stock'),
    ('Customer', 'Sales'),
    ('CustomerDiscount', 'Sales'),
    ('Employee', 'Stock'),
    ('Module', 'Stock'),
    ('Location', 'StockLocation'),
    ('Product', 'Stock'),
    ('PurchaseInvoice', 'Purchase'),
    ('PurchaseInvoiceLine', 'Purchase'),
    ('PurchaseOrder', 'Purchase'),
    ('PurchaseOrderLine', 'Purchase'),
    ('PurchasePayment', 'Purchase'),
    ('PurchaseQuote', 'Purchase'),
    ('PurchaseQuoteLine', 'Purchase'),
    ('SalesInvoice', 'Sales'),
    ('SalesInvoiceLine', 'Sales'),
    ('SalesOrder', 'Sales'),
    ('SalesOrderDiscount', 'Sales'),
    ('SalesOrderLine', 'Sales'),
    ('SalesPayment', 'Sales'),
    ('SalesQuote', 'Sales'),
    ('SalesQuoteLine', 'Sales'),
    ('ShelfLife', 'Stock'),
    ('StorageCube', 'StockCubes'),
    ('StorageMethod', 'Stock'),
    ('Supplier', 'Purchase'),
    ('Supply', 'Stock'),
    ('SupplyDiscount', 'Stock'),
    ('Unit', 'Stock'),
    ('VATType', 'Stock');

SELECT
    'INSERT INTO "table" ("name", moduleName) VALUES ' +
    '(''"' + TABLE_NAME + '"'', ''' + (
        SELECT
            CASE
                WHEN moduleName IS NOT NULL AND moduleName <> ''
                    THEN moduleName
                ELSE
                    '' + @defaultModule + ''
            END
        FROM @TableModule WHERE tableName = TABLE_NAME
    ) + ''');' as SQL

FROM
    INFORMATION_SCHEMA.TABLES
ORDER BY
    TABLE_NAME

--
-- Columns
--
SELECT
    'INSERT INTO "Column" ("name") VALUES (''"' + COLUMN_NAME + '"'');' as SQL
FROM
    INFORMATION_SCHEMA.COLUMNS
GROUP BY
    COLUMN_NAME

SELECT
    'INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ' +
    '(''"' + TABLE_NAME + '"'', ''"' + COLUMN_NAME + '"'', ''' + DATA_TYPE +

    -- Datatypes which specify a length
    CASE
        -- Integers with decimal precision
        WHEN NUMERIC_PRECISION IS NOT NULL AND NUMERIC_SCALE > 0 AND NUMERIC_SCALE IS NOT NULL
            THEN '(' + CAST(NUMERIC_PRECISION AS VARCHAR) + ', ' + CAST(NUMERIC_SCALE AS VARCHAR) + ')'
        -- Datatypes without length
        WHEN CHARACTER_MAXIMUM_LENGTH IS NULL
            THEN ''
        -- Text datatype
        WHEN DATA_TYPE = 'text'
            THEN ''
        -- Datatypes with length
        ELSE
            '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'
    END + ''', ' +

    -- NULL / NOT NULL
    CASE
        WHEN IS_NULLABLE = 'NO'
            THEN '1'
        ELSE
            '0'
    END + ');' as SQL
FROM
    INFORMATION_SCHEMA.COLUMNS
ORDER BY
    TABLE_NAME

--
-- Foreign keys
--
SELECT
    'INSERT INTO DeclarativeConstraint (constraintName, tableName, referencedTableName, constraintType) VALUES (' +
    '''' + OBJECT_NAME (fk.object_id) + ''', ' +
    '''"' + OBJECT_NAME (fk.parent_object_id) + '"'', ' +
    '''"' + OBJECT_NAME (fk_columns.referenced_object_id) + '"'', ' +
    '''FOREIGN KEY'');'
FROM
    sys.foreign_keys fk INNER JOIN sys.foreign_key_columns fk_columns
    ON fk.OBJECT_ID = fk_columns.constraint_object_id
    INNER JOIN sys.tables tables
    ON fk_columns.referenced_object_id = tables.object_id
GROUP BY
    fk.object_id,
    fk.parent_object_id,
    fk_columns.referenced_object_id

SELECT
    'INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES (' +
    '''' + OBJECT_NAME (fk.object_id) + ''', ' +
    '''"' + COL_NAME (fk_columns.referenced_object_id, fk_columns.referenced_column_id) + '"'', ' +
    CAST(1 as VARCHAR) + '); '
FROM
    sys.foreign_keys fk INNER JOIN sys.foreign_key_columns fk_columns
    ON fk.OBJECT_ID = fk_columns.constraint_object_id
    INNER JOIN sys.tables tables
    ON fk_columns.referenced_object_id = tables.object_id
ORDER BY OBJECT_NAME(fk.object_id)

SELECT
    'INSERT INTO DeclarativeConstraintColumns (constraintName, columnName, isReferenced) VALUES (' +
    '''' + OBJECT_NAME (fk.object_id) + ''', ' +
    '''"' + COL_NAME (fk_columns.parent_object_id, fk_columns.parent_column_id) + '"'', ' +
    CAST(0 as VARCHAR) + '); '
FROM
    sys.foreign_keys fk INNER JOIN sys.foreign_key_columns fk_columns
    ON fk.OBJECT_ID = fk_columns.constraint_object_id
    INNER JOIN sys.tables tables
    ON fk_columns.referenced_object_id = tables.object_id
ORDER BY OBJECT_NAME(fk.object_id)

--
-- Primary keys
--
SELECT
    'INSERT INTO DeclarativeConstraint (constraintName, tableName, constraintType) VALUES (' +
    '''' + tc.CONSTRAINT_NAME + ''', ' +
    '''"' + tc.TABLE_NAME + '"'', ' +
    '''PRIMARY KEY'');'
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
WHERE
    tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY
    tc.TABLE_NAME

SELECT
    'INSERT INTO DeclarativeConstraintColumns (constraintName, columnName) VALUES (' +
    '''' + tc.CONSTRAINT_NAME + ''', ' +
    '''"' + ccu.COLUMN_NAME + '"'');'
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
    INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
    ON tc.CONSTRAINT_NAME = ccu.Constraint_name
WHERE
    tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY
    tc.TABLE_NAME