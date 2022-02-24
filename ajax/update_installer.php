<?php
include_once __DIR__ . '/../inc/start.php';

$AjaxResponse = new AjaxResponse();

if(!isPostRequest() || !isRightToken() || !is_admin()) {
	$AjaxResponse->status(false)->alert('Ошибка')->send();
}
$token = clean($_POST['token'],null);
if($conf->token == 1 && ($_SESSION['token'] != $token)) {
	log_error("Неверный токен"); 
	exit('Ошибка: [Неверный токен]');
}

if (isset($_POST['install_update'])) {
	ignore_user_abort(1);
	set_time_limit(0);
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	$sth = $pdo->query("SELECT `version`, `update_link` FROM `config__secondary` LIMIT 1");
	$sth->setFetchMode(PDO::FETCH_OBJ);
	$secondary = $sth->fetch();
	$dataUpdate = json_decode($secondary->update_link);
	$rD = download_file(['temp' => 'modules/updates', 'file' => "{$dataUpdate->version}.zip", 'url' => $dataUpdate->file]);
	if($rD['status']) {
		$zipArchive = new ZipArchive;
		$zipOpen = $zipArchive->open($rD['file']);
		if($zipOpen === true) {
			$zipArchive->extractTo("{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}");
			include_once "{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}/installer/first_installer.php";
			$pdo->exec(trim(file_get_contents("{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}/installer/base.sql")));
			copy_files("{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}/files/", "../");
			include_once "{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}/installer/second_installer.php";
			if($zipArchive->close()) {
				$pdo->query("UPDATE `config__secondary` SET `version`='{$dataUpdate->version}', `update_link`='' WHERE 1");
				unlink($rD['file']);
				removeDirectory("{$_SERVER['DOCUMENT_ROOT']}/modules/updates/{$dataUpdate->version}");
				exit(json_encode(['status' => '1']));
			}
			exit(json_encode(['status' => '2']));
		}
		exit(json_encode(['status' => '2']));
	}
	exit(json_encode(['status' => '2']));
}