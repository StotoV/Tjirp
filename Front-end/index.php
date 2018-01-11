<?php
    require_once('Classes/Connection.php');
    require_once('Classes/Database.php');

    $conn = new Connection();
    $database = new Database($conn);

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        if (isset($_POST['submit'])) {
            echo $database->generateDDL($_POST);
        }
    }
?>
<!DOCTYPE html>
<html lang="nl">
    <head>
        <meta charset="UTF-8">
        <title>Generate your DDL</title>
    </head>
    <body>
        <form action="<?php echo $_SERVER['PHP_SELF'] ?>" method="post">
            <input type="checkbox" name="sales" value="Verkoop module">
            <input type="checkbox" name="purchase" value="Inkoop module">
            <input type="checkbox" name="stock" value="Voorraad module">
            <input type="submit" name="submit">
        </form>
    </body>
</html>
