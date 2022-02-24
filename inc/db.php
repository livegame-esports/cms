<?php

$configurations = require(dirname(__DIR__) . '/config.php');

$db["host"] = $configurations['mysql']['host'];
$db["name"] = $configurations['mysql']['basename'];
$db["user"] = $configurations['mysql']['username'];
$db["password"] = $configurations['mysql']['password'];
require("{$_SERVER['DOCUMENT_ROOT']}/inc/db1.php");
