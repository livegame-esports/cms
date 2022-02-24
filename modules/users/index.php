<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}


if(isset($_GET['group']) && $_GET['group'] != '0') {
	if($_GET['group'] === 'multi_accounts') {
		if(is_worthy("f") || is_worthy("g")) {
			$group = 'multi_accounts';
		} else {
			$group = 0;
		}
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
		$STH = pdo()->query("SELECT COUNT(*) as count FROM users WHERE multi_account != '0' AND active='1'");
	} else {
		$STH = pdo()->query("SELECT COUNT(*) as count FROM users WHERE rights = '$group' AND active='1'");
	}
}
$count = $STH->fetchColumn();
$page_name = "../users?group=".$group."&";

$number = getPageParam('page');
$limit = getLimit('users_lim');
$start = getPageStartPosition($number, $limit);

resetIfPaginationIncorrect($number, $limit, $count, '../users');

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{site_name}", configs()->name);
$tpl->set("{image}", page()->image);
$tpl->set("{robots}", page()->robots);
$tpl->set("{type}", page()->kind);
$tpl->set("{description}", page()->description);
$tpl->set("{keywords}", page()->keywords);
$tpl->set("{url}", page()->full_url);
$tpl->set("{other}", '');
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('users', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$groups = "<option value='0'>".$messages['All']."</option>";
$STH = pdo()->query("SELECT `id`, `name` FROM `users__groups`"); $STH->setFetchMode(PDO::FETCH_OBJ);
while($row = $STH->fetch()) { 
	if($group == $row->id) {
		$groups .= "<option value='".$row->id."' selected>".$row->name."</option>";
	} else {
		$groups .= "<option value='".$row->id."'>".$row->name."</option>";
	}
}
if(is_worthy("f") || is_worthy("g")) {
	if($group === 'multi_accounts') {
		$groups .= "<option value='multi_accounts' selected>Мульти-аккаунты</option>";
	} else {
		$groups .= "<option value='multi_accounts'>Мульти-аккаунты</option>";
	}	
}

$tpl->load_template('/home/users.tpl');
$tpl->set("{pagination}", $tpl->paginator($number,$count,$limit,$page_name));
$tpl->set("{token}", token());
$tpl->set("{template}", configs()->template);
$tpl->set("{page}", !$number ? 1 : $number);
$tpl->set("{start}", $start);
$tpl->set("{limit}", $limit);
$tpl->set("{group}", $group);
$tpl->set("{groups}", $groups);
$tpl->compile( 'content' );
$tpl->clear();