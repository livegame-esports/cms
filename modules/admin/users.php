<?php
if(!is_admin()){
	show_error_page('not_adm');
}

if(isset($_GET['exportUsersXlsx'])) {
	$users = pdo()->query(
		"SELECT 
					    id, 
					    login, 
					    email, 
					    regdate, 
    	   				CASE
					        WHEN name = '---' THEN ''
					        ELSE name
					    END AS name,
					    CASE
					        WHEN steam_api = '0' THEN ''
					        ELSE concat('https://steamcommunity.com/profiles/', steam_api) 
					    END AS steam_api,
    					CASE
					        WHEN vk_api = 0 THEN ''
					        ELSE concat('https://vk.com/id', vk_api)
					    END AS vk_api,
    					CASE
					        WHEN telegram = '' THEN ''
					        ELSE concat('tg://resolve?domain=', telegram)
					    END AS telegram
					FROM 
					    users"
	)->fetchAll(PDO::FETCH_ASSOC);

	array_unshift($users, ['ID', 'Логин', 'E-mail', 'Дата регистрации', 'Имя', 'Профиль STEAM', 'Профиль VK', 'Профиль Telegram']);

	$xlsx = SimpleXLSXGen::fromArray($users);
	$xlsx->downloadAs('users.xlsx');
	die;
}


$number = getPageParam('page');
$limit = 30;
$start = getPageStartPosition($number, $limit);


if(isset($_GET['group']) && $_GET['group'] != '0') {
	if($_GET['group'] === 'multi_accounts') {
		$group = 'multi_accounts';
	} else {
		$group = getPageParam('group');
	}
} else {
	$group = 0;
}


if($group === 0) {
	$STH = pdo()->query("SELECT COUNT(*) as count FROM users");
} else {
	if($group === 'multi_accounts') {
		$STH = pdo()->query("SELECT COUNT(*) as count FROM users WHERE multi_account != '0'");
	} else {
		$STH = pdo()->query("SELECT COUNT(*) as count FROM users WHERE rights = '$group'");
	}
}
$count = $STH->fetchColumn();
$page_name = "users?group=".$group."&";

resetIfPaginationIncorrect($number, $limit, $count, '../admin/users');

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", '');
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('top.tpl');
$tpl->set("{site_name}", configs()->name);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('menu.tpl');
$tpl->compile( 'content' );
$tpl->clear();

$nav = [
	$PI->to_nav('admin', 0, 0),
	$PI->to_nav('admin_users', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$groups = "<option value='0'>Все</option>";
$STH = pdo()->query("SELECT `id`, `name` FROM `users__groups`"); $STH->setFetchMode(PDO::FETCH_OBJ);
while($row = $STH->fetch()) { 
	if($group == $row->id) {
		$groups .= "<option value='".$row->id."' selected>".$row->name."</option>";
	} else {
		$groups .= "<option value='".$row->id."'>".$row->name."</option>";
	}
}
if($group === 'multi_accounts') {
	$groups .= "<option value='multi_accounts' selected>Мульти-аккаунты</option>";
} else {
	$groups .= "<option value='multi_accounts'>Мульти-аккаунты</option>";
}

$tpl->load_template('users.tpl');
$tpl->set("{pagination}", $tpl->paginator($number,$count,$limit,$page_name));
$tpl->set("{token}", token());
if($number == 0) {
	$number = 1;
}
$tpl->set("{page}", $number);
$tpl->set("{start}", $start); 
$tpl->set("{group}", $group);
$tpl->set("{groups}", $groups);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();