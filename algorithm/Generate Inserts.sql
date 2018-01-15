-- Set database name in which the ERP database is deployed
USE test;

--
-- Tables
--
SELECT
    'INSERT INTO "table" (name, moduleName) VALUES ' + '(''' + TABLE_NAME + ''', ''module'');' as SQL

FROM
    INFORMATION_SCHEMA.TABLES
ORDER BY
    TABLE_NAME

--
-- Columns
--
SELECT
    'INSERT INTO TableColumn (tableName, columnName, moduleName, columnType, mandatory) VALUES ' +
    '(''' + TABLE_NAME + ''', ''' + COLUMN_NAME + ''', ''module'', ''' + DATA_TYPE +

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
SELECT
    'INSERT INTO DeclarativeConstraint (tableName, columnName, constraintName, constraintType, constraintLogic) VALUES (' +
      '''' + OBJECT_NAME (fk.parent_object_id) + ''',' +                                                                -- Table name
      '''' + COL_NAME (fk_columns.parent_object_id, fk_columns.parent_column_id) + ''',' +                              -- Column name
      '''' + OBJECT_NAME (fk.object_id) + ''',' +                                                                       -- Constraint name
      '''FOREIGN KEY'', ' +
      '''ALTER TABLE ' + OBJECT_NAME (fk.parent_object_id) + ' ADD CONSTRAINT ' + OBJECT_NAME (fk.object_id) + ' ' +    -- Table name + constraint name
      'FOREIGN KEY (' + COL_NAME (fk_columns.parent_object_id, fk_columns.parent_column_id) + ') ' +                    -- Column name on which the foreign key is placed
      'REFERENCES ' + OBJECT_NAME (fk_columns.referenced_object_id) +                                                   -- Referenced table name
      ' (' + COL_NAME (fk_columns.referenced_object_id, fk_columns.referenced_column_id) + ')'');' as SQL               -- column name in referenced table
FROM
    sys.foreign_keys fk INNER JOIN sys.foreign_key_columns fk_columns
    ON fk.OBJECT_ID = fk_columns.constraint_object_id
    INNER JOIN sys.tables tables
    ON fk_columns.referenced_object_id = tables.object_id

--
-- Primary keys
--
SELECT
    'INSERT INTO DeclarativeConstraint (tableName, columnName, constraintName, constraintType, constraintLogic) VALUES (' +
    '''' + tc.TABLE_NAME + ''', ' +
    '''' + COLUMN_NAME + ''', ' +
    '''' + tc.CONSTRAINT_NAME + ''', ' +
    '''PRIMARY KEY'', ' +
    '''ALTER TABLE ' + tc.TABLE_NAME + ' ADD CONSTRAINT ' + tc.CONSTRAINT_NAME + ' PRIMARY KEY (' + COLUMN_NAME +''');' as SQL
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
    INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
    ON tc.CONSTRAINT_NAME = ccu.Constraint_name
WHERE
    tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY
    tc.TABLE_NAME

--
-- Alternate keys
--