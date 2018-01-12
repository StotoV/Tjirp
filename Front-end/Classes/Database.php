<?php
    require_once('Connection.php');

    class Database {
        private $conn; // The connection

        public function __construct(Connection $connection) {
            $this->conn = $connection;
        }

        // Generates the DDL script of the ERP system and returns it as an text file
        public function generateDDL(Array $post) {
            $arrayOfOptionsAndValues = Array ('sales' => 0, 'purchase' => 0, 'stock' => 0);

            // Check for each checkbox if it is checked and assign the appropriate value to the array
            foreach ($arrayOfOptionsAndValues as $option => $value) {
                if (isset($post[$option])) {
                    $arrayOfOptionsAndValues[$option] = 1;
                }
            }

            // Execute if the setup is completed
            if ($this->createTheDatabase() === true) {
                if ($this->createTheTables() === true) {
                    if ($this->createTheGenerateDDLProc() === true) {
                        if ($this->createTheInsertSQLAndPreferencesProc() === true) {
                            // The connection
                            $pdo = $this->conn->getConnection();

                            // Execute the InsertSQLAndPreferences proc
                            $stmt = $pdo->prepare("
                               USE Tjirp
                               EXEC InsertSQLAndPreferences 1, 1, 1
                            ");
                            if ($stmt->execute()) {
                                return 'DDL generated successfully';
                            } else {
                                $returnVar = 'Something went wrong while executing the proc!<br>';
                                foreach ($stmt->errorInfo() as $info) {
                                    $returnVar .= $info . '<br>';
                                }
                                $returnVar .= $stmt->errorCode();
                                return $returnVar;
                            }
                        }
                    }
                }
            }
            return 'DDL generation failed';
        }

        private function createTheDatabase() {
            // The connection
            $pdo = $this->conn->getConnection();

            // The database creation
            $stmt = $pdo->prepare("
                SET NOCOUNT ON
                USE master 
                DROP DATABASE IF EXISTS Tjirp
                CREATE DATABASE Tjirp
            ");
            if ($stmt->execute()) {
                echo 'Database created <br>';
                return true;
            } else {
                $returnVar = 'Something went wrong!<br>';
                foreach ($stmt->errorInfo() as $info) {
                    $returnVar .= $info . '<br>';
                }
                $returnVar .= $stmt->errorCode() . '<br>';
                return $returnVar;
            }
        }

        private function createTheTables() {
            // The connection
            $pdo = $this->conn->getConnection();

            // The database creation
            $stmt = $pdo->prepare("
                USE Tjirp

                CREATE TABLE module (
                    id						INT				NOT NULL	PRIMARY KEY		IDENTITY(1,1),
                    moduleName				VARCHAR(255)	NOT NULL	UNIQUE,
                    superModule				INT				NULL,
                    toBeGenerated			BIT				NOT NULL,
                    SQLCode					VARCHAR(MAX)	NOT NULL
                );
                
                CREATE TABLE relation (
                    relationName			VARCHAR(255)	NOT NULL	PRIMARY KEY,
                    tableOne				VARCHAR(128)	NOT NULL,
                    tableTwo				VARCHAR(128)	NOT NULL,
                    SQLCode					VARCHAR(MAX)	NOT NULL
                );
                
                CREATE TABLE constraintImplementation (
                    id						INT				NOT NULL	PRIMARY KEY		IDENTITY(1,1),
                    SQLCode					VARCHAR(MAX)	NOT NULL
                );
                
                CREATE TABLE constraintImplementationInTable (
                    constraintId			INT				NOT NULL,
                    tableOfConstraint		VARCHAR(128)	NOT NULL,
                    CONSTRAINT PK_constraintsInTables PRIMARY KEY (constraintId, tableOfConstraint),
                    CONSTRAINT FK_constraints FOREIGN KEY (constraintId) REFERENCES constraintImplementation(id)
                );
            ");
            if ($stmt->execute()) {
                echo 'Database tables created <br>';
                return true;
            } else {
                $returnVar = 'Something went wrong with the generation of the tables!<br>';
                foreach ($stmt->errorInfo() as $info) {
                    $returnVar .= $info . '<br>';
                }
                $returnVar .= $stmt->errorCode() . '<br>';
                return $returnVar;
            }
        }

        private function createTheGenerateDDLProc() {
            // The connection
            $pdo = $this->conn->getConnection();

            // The database creation
            $stmt = $pdo->prepare("                
                CREATE PROC GenerateDDL
                AS BEGIN
                    SET NOCOUNT ON
                
                    BEGIN TRY
                        -- Loop through the modules table to generate the modules
                        DECLARE @COUNT INT = 1
                        WHILE @COUNT <= (SELECT COUNT(*) FROM module)
                            BEGIN
                                -- Print SQL code if the record needs to be generated and the record is has no superrecords
                                IF (SELECT toBeGenerated FROM module WHERE id = @COUNT) = 1 AND (SELECT superModule FROM module WHERE id = @COUNT) IS NULL
                                    BEGIN
                                        DECLARE @SQL VARCHAR(MAX) = (SELECT SQLCode FROM module WHERE id = @COUNT)
                                        PRINT @SQL
                                        EXEC (@SQL)
                
                                        -- Loop through the records that has the current record as superrecord by creating a temp table with all the subrecords
                                        DECLARE @COUNTSUB INT = 1;
                                        SELECT subId = ROW_NUMBER() OVER(ORDER BY(SELECT NULL)), * INTO TempWithSubs FROM module WHERE superModule = @COUNT
                                        WHILE @COUNTSUB <= (SELECT COUNT(*) FROM TempWithSubs)
                                            BEGIN
                                                DECLARE @SUBSQL VARCHAR(MAX) = (SELECT SQLCode FROM TempWithSubs WHERE subId = @COUNTSUB)
                
                                                PRINT @SUBSQL
                                                EXEC (@SUBSQL)
                
                                                -- Increase count
                                                SET @COUNTSUB = @COUNTSUB + 1
                                            END
                
                                        DROP TABLE TempWithSubs
                                    END
                
                                -- Increase count
                                SET @COUNT = @COUNT + 1
                            END
                
                        -- Select all the relations of which the tables exist and add them to te variable
                        DECLARE @RELATIONSQL VARCHAR(MAX) = ''
                        SELECT @RELATIONSQL = (@RELATIONSQL + SQLCode + CHAR(13)+CHAR(10)) FROM relation
                            WHERE EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = tableOne)
                            AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = tableTwo)
                
                        PRINT @RELATIONSQL
                        EXEC(@RELATIONSQL)
                
                        -- Select all the constraints of which the needed tables exists
                        DECLARE @CONSTRAINTSQL VARCHAR(MAX) = ''
                        SELECT @CONSTRAINTSQL = (@CONSTRAINTSQL + SQLCode + CHAR(13)+CHAR(10)) FROM constraintImplementation C
                            WHERE NOT EXISTS (SELECT *
                                                FROM constraintImplementationInTable CT
                                                WHERE CT.constraintId = C.id
                                                AND CT.tableOfConstraint NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES))
                
                        PRINT @CONSTRAINTSQL
                        EXEC (@CONSTRAINTSQL)
                    END TRY
                    BEGIN CATCH
                        ;THROW
                    END CATCH
                END
            ");
            if ($stmt->execute()) {
                echo 'GenerateDDL proc created <br>';
                return true;
            } else {
                $returnVar = 'Something went wrong!<br>';
                foreach ($stmt->errorInfo() as $info) {
                    $returnVar .= $info . '<br>';
                }
                $returnVar .= $stmt->errorCode() . '<br>';
                return $returnVar;
            }
        }

        private function createTheInsertSQLAndPreferencesProc() {
            // The connection
            $pdo = $this->conn->getConnection();

            // The database creation
            $stmt = $pdo->prepare("
                CREATE PROC InsertSQLAndPreferences
                    @TEST0 INT,
                    @TEST1 INT,
                    @TEST2 INT
                AS BEGIN
                    SET NOCOUNT ON
                
                    BEGIN TRY
                        -- Insert SQL code and the preferences
                        INSERT INTO module (moduleName, toBeGenerated, SQLCode, superModule) VALUES					('test', @TEST0, 'CREATE TABLE ONE (id INT NOT NULL PRIMARY KEY);', NULL),
                                                                                                                    ('test2', @TEST1, 'CREATE TABLE TWO (id INT NOT NULL PRIMARY KEY);', NULL),
                                                                                                                    ('test3', @TEST2, 'CREATE TABLE THREE (id INT NOT NULL PRIMARY KEY);', NULL),
                                                                                                                    ('test4', 1, 'ALTER TABLE ONE ADD test1 INT NOT NULL', 1),
                                                                                                                    ('test5', 1, 'ALTER TABLE ONE ADD test2 INT NOT NULL', 1),
                                                                                                                    ('test6', 1, 'ALTER TABLE THREE ADD test1 INT NOT NULL', 3)
                
                        INSERT INTO relation (relationName, tableOne, tableTwo, SQLCode) VALUES						('oneTwo', 'ONE', 'TWO', 'ALTER TABLE ONE ADD FOREIGN KEY (id) REFERENCES TWO(id)'),
                                                                                                                    ('oneThree', 'ONE', 'THREE', 'ALTER TABLE ONE ADD FOREIGN KEY (id) REFERENCES THREE(id)')
                
                        INSERT INTO constraintImplementation (SQLCode) VALUES										('ALTER TABLE ONE ADD CONSTRAINT CK_TEST1 CHECK(id != 0)'),
                                                                                                                    ('ALTER TABLE TWO ADD CONSTRAINT CK_TEST2 CHECK(id != 0)')
                
                        INSERT INTO constraintImplementationInTable (constraintId, tableOfConstraint) VALUES		(1, 'ONE'),
                                                                                                                    (1, 'TWO'),
                                                                                                                    (1, 'THREE'),
                                                                                                                    (2, 'TWO')
                
                        -- Execute the GenerateDDL proc
                        EXEC GenerateDDL
                    END TRY
                    BEGIN CATCH
                        ;THROW
                    END CATCH
                END
            ");
            if ($stmt->execute()) {
                echo 'InsertSQLAndPreferences proc created <br>';
                return true;
            } else {
                $returnVar = 'Something went wrong!<br>';
                foreach ($stmt->errorInfo() as $info) {
                    $returnVar .= $info . '<br>';
                }
                $returnVar .= $stmt->errorCode() . '<br>';
                return $returnVar;
            }
        }
    }
?>