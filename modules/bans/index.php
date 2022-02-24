<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}


$server = getPageParam('server');
$number = getPageParam('page');
$limit = getLimit('bans_lim2');
$start = getPageStartPosition($number, $limit);


if($server){
	$STH = pdo()->query("SELECT COUNT(*) as count FROM bans WHERE server = '$server'");
	$page_name = "../bans/?server=".$server."&";
} else {
	$STH = pdo()->query("SELECT COUNT(*) as count FROM bans");
	$page_name = "../bans/?";
}

$count = $STH->fetchColumn();

resetIfPaginationIncorrect($number, $limit, $count, '../bans/index');

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
	$PI->to_nav('bans', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

tpl()->compileCategory(
	$messages['All'],
	'../bans/',
	$server == 0,
	'bans'
);

foreach(ServersManager::getForCategories() as $serverItem) {
	tpl()->compileCategory(
		$serverItem->name,
		'../bans/?server=' . $serverItem->id,
		$serverItem->id == $server,
		'bans'
	);
}

$tpl->load_template('/bans/index.tpl');
$tpl->set("{template}", configs()->template); 
$tpl->set("{page}", $number);
$tpl->set("{start}", $start); 
$tpl->set("{server}", $server);
$tpl->set("{limit}", $limit);
$tpl->set("{servers}", $tpl->result['categories']);
$tpl->set("{pagination}", $tpl->paginator($number,$count,$limit,$page_name));
$tpl->compile( 'content' );
$tpl->clear();