<?php
    class Connection {
        private $host = 'localhost';
        private $database = 'Tjirp';
        private $username = 'sa';
        private $password = 'dbrules';
        private $pdo;

        public function __construct() {
            try {
                $this->pdo = new PDO("sqlsrv:Server=$this->host;Database=$this->database;ConnectionPooling=0", "$this->username", "$this->password");
                $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
                return $this->pdo;
            } catch (PDOException $e) {
                echo "Connection failed: " . $e->getMessage();
            }
        }

        // Returns the connection
        public function getConnection() {
            return $this->pdo;
        }
    }
?>
