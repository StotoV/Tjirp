-- Set database name in which the ERP database is deployed
USE test;

--
-- Tables
--
DECLARE @table_sql VARCHAR(MAX) = 'INSERT INTO "table" (name, moduleName) VALUES'

SELECT
    @table_sql = @table_sql + char(13) + char(10) + '(''' + TABLE_NAME + ''', ''module''),'

FROM
    INFORMATION_SCHEMA.TABLES

PRINT @table_sql

--
-- Columns
--
DECLARE @column_sql VARCHAR(MAX) = 'INSERT INTO TableColumn (tableName, columnName, moduleName, columnType, mandatory) VALUES'

SELECT
    @column_sql = @column_sql + char(13) + char(10) +
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
        END + ',' +

        -- NULL / NOT NULL
        CASE
            WHEN IS_NULLABLE = 'NO'
                THEN ' NOT NULL'
            ELSE
                ' NULL'
        END + '),'
FROM
    INFORMATION_SCHEMA.COLUMNS
ORDER BY
    TABLE_NAME

PRINT @column_sql

--
-- Constraints
--
