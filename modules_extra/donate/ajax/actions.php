<?php
include_once "../../../inc/start.php";
include_once "../../../inc/protect.php";
if(empty($_POST['phpaction'])) {
	log_error("Прямой вызов инклуда | actions.php");
	exit(json_encode(['status' => '2']));
}
if($conf->token == 1 && ($_SESSION['token'] != clean($_POST['token'], null))) {
	log_error("Неверный токен | actions.php");
	exit(json_encode(['status' => '2']));
}

if (isset($_POST['donate_money'])) {
	$id = checkJs($_POST['id'],"int");
	$money = checkJs($_POST['money'],"float");

	if (empty($id)) {
		exit (json_encode(array('status' => '1', 'res' => "ID пользователя не указан!")));
	}

	if (empty($money)) {
		exit (json_encode(array('status' => '2')));
	}

	$STH = $pdo->prepare("SELECT `id`,`login`,`shilings`,`multi_account` FROM `users` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $_SESSION['id'] ));
	$row = $STH->fetch();
	
	// Проверка хватает ли денег донатеру
	if ($row->shilings < $money){
		exit (json_encode(array('status' => '1', 'res' => "У вас не хватает денюшек для столь большого доната.")));
	}
	
	// Проверка скидывает ли пользователь сам себе
	if ($_SESSION['id'] == $id){
		exit (json_encode(array('status' => '1', 'res' => "Зачем ты это делаешь??.")));
	}
	
	// Проверка на минимальную сумму доната
	if ($money < 5){
		exit (json_encode(array('status' => '1', 'res' => "Минимальная сумма доната 5 руб.")));
	}
	
	// Проверяем есть ли у донатера мультиаккаунты и если он скидывает на свой же акк то посылаем его
	if($row->multi_account != 0) {
		$multi_accounts = explode(';', $row->multi_account);
		for ($i = 0; $i < count($multi_accounts); $i++) {
			$multi_accounts[$i] = explode(':', $multi_accounts[$i]);
			
			if($id == $multi_accounts[$i][0]) {
				exit (json_encode(array('status' => '1', 'res' => "Донатить деньги на свои же аккаунты запрещенно.")));
			} 
		}
	}
	
		
	$STH = $pdo->prepare("SELECT `id`,`shilings`,`login` FROM `users` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $id ));
	$rows = $STH->fetch();

	if(empty($rows->id)){
		exit (json_encode(array('status' => '1', 'res' => "Аккаунта не существует!")));
	}

	$login = $rows->login;
	$us_id = $rows->id;
	$res = $rows->shilings+$money;
	$money_stay = $row->shilings-$money;
	
	// Добавляем бабки пацану
	$STH = $pdo->prepare("UPDATE users SET shilings=:shilings WHERE id='$id' LIMIT 1");
	$STH->execute(array( 'shilings' => $rows->shilings+$money ));
	
	// Снятие бабок с донатера
	$STH = $pdo->prepare("UPDATE users SET shilings=:shilings WHERE id=:id LIMIT 1");
	$STH->execute(array( 'shilings' => $row->shilings-$money, 'id' => $_SESSION['id'] ));

	// Записываем что это был донат и минус деньги нам
	$STH = $pdo->prepare("INSERT INTO money__actions (date,shilings,author,type,gave_out) values (:date, :shilings, :author, :type, :gave_out)");
	$STH->execute(array( 'date' => date("Y-m-d H:i:s"),'shilings' => "-$money",'author' => $_SESSION['id'],'type' => '23','gave_out' => $id ));
	// Записываем что это был донат и плюс деньги тому кому донатили
	$STH = $pdo->prepare("INSERT INTO money__actions (date,shilings,author,type,gave_out) values (:date, :shilings, :author, :type, :gave_out)");
	$STH->execute(array( 'date' => date("Y-m-d H:i:s"),'shilings' => $money, 'author' => $id, 'type' => '23','gave_out' => $_SESSION['id'] ));
	
	// Ниже две строчки создания сообщения в чате оповещение о том что один пользователь задонатил другому. 
	// Если же вы желаете такое то потребуется лишний аккаунт берем его ID и вписываем там где проиходит execute в author => ID

	//$STH = $pdo->prepare("INSERT INTO chat (message_date,message_text,user_id) values (:date, :message_text, :author)");
	//$STH->execute(array( 'date' => date("Y-m-d H:i:s"),'message_text' => "Пользователь $row->login задонатил $money руб. пользователю $login",'author' => 120 ));
	
	$STH = $pdo->prepare("INSERT INTO notifications (date,message,user_id) values (:date, :message, :author)");
	$STH->execute(array( 'date' => date("Y-m-d H:i:s"),'message' => "Вы задонатили $money руб. пользователю $login",'author' => "$row->id" ));
	$STH = $pdo->prepare("INSERT INTO notifications (date,message,user_id) values (:date, :message, :author)");
	$STH->execute(array( 'date' => date("Y-m-d H:i:s"),'message' => "Пользователь $row->login задонатил вам $money руб.",'author' => "$us_id" ));
	
	exit (json_encode(array('status' => '1', 'res' => "Вы успешно задонатили $money руб. пользователю $login у вас осталось $money_stay руб.")));
}