<?php

$configurations = require(dirname(__DIR__) . '/config.php');

$db["host"] = $configurations['mysql']['host'];
$db["name"] = $configurations['mysql']['basename'];
$db["user"] = $configurations['mysql']['username'];
$db["password"] = $configurations['mysql']['password'];
require(__DIR__ . "/db1.php");
