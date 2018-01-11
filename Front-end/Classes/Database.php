<?php
    require_once('Connection.php');

    class Database {
        private $conn; // The connection

        public function __construct(Connection $connection) {
            $this->conn = $connection;
        }

        // Generates the DDL script of the ERP system and returns it as an text file
        public function generateDDL(Array $preferences) {
            foreach ($preferences as $preference) {
                if (isset($preference)) {
                    echo $preference;
                }
            }
        }
    }
?>