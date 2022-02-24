<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$accusedProfileId      = 0;
$server    = 0;
$start     = 0;
$limit     = 0;
$paginator = '';
$servers   = '';

if(isset($_GET['accusedProfileId'])) {
	$accusedProfileId = getPageParam('accusedProfileId');
}

$tpl->result['categories'] = '';

if(empty($accusedProfileId)) {
	$server = getPageParam('server');
	$number = getPageParam('page');
	$limit = getLimit('complaints_lim');
	$start = getPageStartPosition($number, $limit);

	if($server) {
		$STH = pdo()->query("SELECT COUNT(*) as count FROM complaints WHERE accused_admin_server_id = '$server'");
		$page_name = "../complaints/?server=" . $server . "&";
	} else {
		$STH = pdo()->query("SELECT COUNT(*) as count FROM complaints");
		$page_name = "../complaints/?";
	}

	$count = $STH->fetchColumn();

	resetIfPaginationIncorrect($number, $limit, $count, '../complaints/index');

	$paginator = $tpl->paginator(
		$number,
		$count,
		$limit,
		$page_name
	);

	tpl()->compileCategory(
		$messages['All'],
		'../complaints/',
		$server == 0,
		'complaints'
	);

	foreach(ServersManager::getForCategories() as $serverItem) {
		tpl()->compileCategory(
			$serverItem->name,
			'../complaints/?server=' . $serverItem->id,
			$serverItem->id == $server,
			'complaints'
		);
	}
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
	$PI->to_nav('complaints', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$tpl->load_template('/complaints/index.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{server}", $server);
$tpl->set("{accusedProfileId}", $accusedProfileId);
$tpl->set("{start}", $start);
$tpl->set("{limit}", $limit);
$tpl->set("{servers}", $tpl->result['categories']);
$tpl->set("{pagination}", $paginator);
$tpl->compile('content');
$tpl->clear();