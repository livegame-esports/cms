<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$server = getPageParam('server');

if($server && !ServersManager::isExists($server)) {
	show_error_page();
}

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile('title');
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
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('admins', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');


if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}


tpl()->compileCategory(
	$messages['All'],
	'../admins',
	$server == 0,
	'admins'
);

foreach(ServersManager::getForCategories('type!=0') as $serverItem) {
	tpl()->compileCategory(
		$serverItem->name,
		'../admins?server=' . $serverItem->id,
		$serverItem->id == $server,
		'admins'
	);
}

$tpl->load_template('/home/admins.tpl');
$tpl->set("{server}", $server);
$tpl->set("{servers}", $tpl->result['categories']);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();