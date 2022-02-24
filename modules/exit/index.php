<?php
if(
	(isset($_GET['ban']) and $_GET['ban'] == md5(configs()->code))
	|| (isset($ban) && $ban == true)
) {
	global $SC;
	global $ip;

	$SC->set_cookie("point", "1");

	pdo()
		->prepare("INSERT INTO users__blocked (ip) values (:ip)")
		->execute(['ip' => $ip]);
}
if(is_auth()) {
	pdo()
		->exec("DELETE FROM `users__online` WHERE `user_id`='$_SESSION[id]' LIMIT 1");

	pdo()
		->prepare("UPDATE `users` SET `last_activity`=:last_activity WHERE `id`='$_SESSION[id]' LIMIT 1")
		->execute(['last_activity' => date("Y-m-d H:i:s")]);
}

$SC->unset_user_session();
header('Location: ../');
exit();