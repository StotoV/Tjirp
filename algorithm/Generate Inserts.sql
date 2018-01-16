-- Set database name in which the ERP database is deployed
USE test;

--
-- Module per table
--
-- Set the default module name
DECLARE @defaultModule VARCHAR(MAX) = 'Module'

-- Create virtual table for all the modules
DECLARE @TableModule TABLE (
    tableName VARCHAR(128) NOT NULL,
    moduleName VARCHAR(250) NOT NULL
);
INSERT INTO @TableModule (tableName, moduleName) VALUES
    ('Article', ''),
    ('Article_in_Unit', ''),
    ('ArticleDiscount', ''),
    ('ArticleInLocation', ''),
    ('ArticleInStorageCube', ''),
    ('Component', ''),
    ('Customer', 'Sales'),
    ('CustomerDiscount', ''),
    ('Employee', ''),
    ('Location', ''),
    ('Product', ''),
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
    ('ShelfLife', ''),
    ('StorageCube', ''),
    ('StorageMethod', ''),
    ('Supplier', 'Purchase'),
    ('Supply', ''),
    ('SupplyDiscount', ''),
    ('Unit', ''),
    ('VatType', '');

--
-- Tables
--
SELECT
    'INSERT INTO "table" (name, moduleName) VALUES ' +
    '(''' + TABLE_NAME + ''', ''' + (
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
    'INSERT INTO TableColumn (tableName, columnName, columnType, mandatory) VALUES ' +
    '(''' + TABLE_NAME + ''', ''' + COLUMN_NAME + ''', ''' + DATA_TYPE +

    -- Datatypes which specify a length
    CASE
        -- Integers with decimal precision
        WHEN NUMERIC_PRECISION IS NOT NULL AND NUMERIC_SCALE > 0 AND NUMERIC_SCALE IS NOT NULL
            THEN '(' + CAST(NUMERIC_PRECISION AS VARCHAR) + ', ' + CAST(NUMERIC_SCALE AS VARCHAR) + ')'
        -- Datatypes without length
        WHEN CHARACTER_MAXIMUM_LENGTH IS NULL
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
SELECT fk.object_id,
    'INSERT INTO DeclarativeConstraint (tableName, columnName, constraintName, constraintType, constraintLogic) VALUES (' +
      '''' + OBJECT_NAME (fk.parent_object_id) + ''',' +                                                                -- Table name
      '''' + COL_NAME (fk_columns.parent_object_id, fk_columns.parent_column_id) + ''',' +                              -- Column name
      '''' + OBJECT_NAME (fk.object_id) + ''',' +                                                                       -- Constraint name
      '''FOREIGN KEY'', ' +
      '''ALTER TABLE ' + OBJECT_NAME (fk.parent_object_id) + ' ADD CONSTRAINT ' + OBJECT_NAME (fk.object_id) + ' ' +    -- Table name + constraint name
      'FOREIGN KEY (' + STUFF ((                                                                                        -- Column names on which the foreign key is placed
                            SELECT DISTINCT
                                ', ' + COL_NAME (fk_columns_stuff.parent_object_id, fk_columns_stuff.parent_column_id)
                            FROM
                                sys.foreign_keys fk_stuff INNER JOIN sys.foreign_key_columns fk_columns_stuff
                                ON fk_stuff.OBJECT_ID = fk_columns_stuff.constraint_object_id
                            WHERE
                                fk_stuff.object_id = fk.object_id
                            FOR
                                XML PATH('')), 1, 2, '') + ') ' +
      'REFERENCES ' + OBJECT_NAME (fk_columns.referenced_object_id) +                                                   -- Referenced table name
      ' (' + STUFF ((                                                                                        -- Column names on which the foreign key is placed
                SELECT DISTINCT
                    ', ' + COL_NAME (fk_columns_stuff.referenced_object_id, fk_columns_stuff.referenced_column_id)
                FROM
                    sys.foreign_keys fk_stuff INNER JOIN sys.foreign_key_columns fk_columns_stuff
                    ON fk_stuff.OBJECT_ID = fk_columns_stuff.constraint_object_id
                WHERE
                    fk_stuff.object_id = fk.object_id
                FOR
                    XML PATH('')), 1, 2, '') + ')'');' as SQL               -- column name in referenced table
FROM
    sys.foreign_keys fk INNER JOIN sys.foreign_key_columns fk_columns
    ON fk.OBJECT_ID = fk_columns.constraint_object_id
    INNER JOIN sys.tables tables
    ON fk_columns.referenced_object_id = tables.object_id
-- De WHERE clause moet weg in productie!! Is alleen om te testen of er niet meerdere record
-- getoond worden
-- ALS HET IS GELUKT OM ENKELE RECORDS TE KRIJGEN HETZELFDE TOEPASSEN BIJ DE PK!
WHERE
    OBJECT_NAME (fk.object_id) = 'FK_SUPPLY_SUPPLY_IN_PURCHASE'


--
-- Primary keys
--
SELECT
    'INSERT INTO DeclarativeConstraint (tableName, columnName, constraintName, constraintType, constraintLogic) VALUES (' +
    '''' + tc.TABLE_NAME + ''', ' +
    '''' + COLUMN_NAME + ''', ' +
    '''' + tc.CONSTRAINT_NAME + ''', ' +
    '''PRIMARY KEY'', ' +
    '''ALTER TABLE ' + tc.TABLE_NAME + ' ADD CONSTRAINT ' + tc.CONSTRAINT_NAME +
    ' PRIMARY KEY (' + STUFF((
                        SELECT DISTINCT
                            ', ' + ccu_stuff.COLUMN_NAME
                        FROM
                            INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc_stuff
                            INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu_stuff
                            ON tc_stuff.CONSTRAINT_NAME = ccu_stuff.Constraint_name
                        WHERE
                            tc_stuff.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                        FOR
                            XML PATH('')), 1, 2, '') + ');' as SQL
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
    INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
    ON tc.CONSTRAINT_NAME = ccu.Constraint_name
WHERE
    tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY
    tc.TABLE_NAME