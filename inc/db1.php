<?php
$db["charset"] = "utf8";
try {
	$pdo = new PDO("mysql:host=".$db["host"].";dbname=".$db["name"], $db["user"], $db["password"]);
	$pdo->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
	$pdo->exec("set names " . $db["charset"]);
} catch(PDOException $e) {
	exit("Ошибка подключения к базе данных.");
}
require(__DIR__ . "/classes/class.database.php");
$injSql = new Database($db);
unset($db);

$STH = $pdo->query("SELECT * FROM config LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
$conf = $STH->fetch();
