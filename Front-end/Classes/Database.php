<?php
    require_once('Connection.php');

    class Database {
        private $conn; // The connection

        public function __construct(Connection $connection) {
            $this->conn = $connection;
        }

        // Generates the DDL script of the ERP system and returns it as an text file
        public function generateDDL(Array $post) {
            $arrayOfValues = Array();
            $replaceStr = ',';

            // Check for each checkbox if it is checked and assign the appropriate value to the array
            foreach ($post as $value) {
                if ($value !== 'Verzenden') {
                    array_push($arrayOfValues, $value);
                    $replaceStr .= ', (?)';
                }
            }

            // The connection
            $pdo = $this->conn->getConnection();

            // Get the right amount of parameters
            $sql = "DECLARE @PREFERENCES AS PreferenceTable, @OUTPUT VARCHAR(MAX); INSERT INTO @PREFERENCES (moduleName) VALUES (~); EXEC GenerateDDL @PREFERENCES, @OUTPUT OUTPUT; PRINT @OUTPUT";
            $replaceStr = str_replace(',,', '', $replaceStr);
            $sql = str_replace('(~)', $replaceStr, $sql);

            // Execute the GenerateDDL proc if more than one value is passed
            if (count($arrayOfValues) > 0) {
                $stmt = $pdo->prepare($sql);

                // Bind params
                $count = 1;
                foreach ($arrayOfValues as $value) {
                    $stmt->bindParam($count, $value);
                    $count += 1;
                }
//                $stmt->bindParam($count, $return_value, PDO::PARAM_STR, 4000);

                if ($stmt->execute()) {
                    return 'DDL generated';
                } else {
                    $returnVar = 'Something went wrong while executing the proc!<br>';
                    foreach ($stmt->errorInfo() as $info) {
                        $returnVar .= $info . '<br>';
                    }
                    $returnVar .= $stmt->errorCode();
                    return $returnVar;
                }
            } else {
                return 'Nothing to generate';
            }
        }
    }
?>