<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$number = getPageParam('page');
$limit  = getLimit('stats_lim');
$start  = getPageStartPosition($number, $limit);
$server = getPageParam('server');

if($server) {
	$STH = pdo()->query("SELECT id,st_db_host,st_db_user,st_db_pass,st_db_db,st_type,st_db_table,ip,port FROM servers WHERE st_type!=0 and id='$server' LIMIT 1");
} else {
	$STH = pdo()->query("SELECT id,st_db_host,st_db_user,st_db_pass,st_db_db,st_type,st_db_table,ip,port FROM servers WHERE st_type!=0 ORDER BY trim LIMIT 1");
}
$row = $STH->fetch(PDO::FETCH_OBJ);

if(empty($row->id)) {
	show_error_page($server ? '404' : 'servers_not_configured');
}

$server    = $row->id;
$page_name = "../stats?server=" . $row->id . "&";
$db_host   = $row->st_db_host;
$db_user   = $row->st_db_user;
$db_pass   = $row->st_db_pass;
$db_db     = $row->st_db_db;
$type      = $row->st_type;
$table     = $row->st_db_table;
$ip        = $row->ip;
$port      = $row->port;
$count     = 0;
$error     = "";

if(!$pdo2 = db_connect($db_host, $db_db, $db_user, $db_pass)) {
	$error = $messages['errorConnectingToDatabase'];
} else {
	if($type == '1' or $type == '2') {
		$STH = $pdo2->query("SELECT COUNT(*) as count FROM csstats_players WHERE frags!=0");
	} elseif($type == '3') {
		$STH = $pdo2->query("SELECT COUNT(*) as count FROM $table WHERE kills!=0");
	} elseif($type == '4') {
		$STH = $pdo2->prepare("SELECT game FROM hlstats_Servers WHERE address=:address AND port=:port LIMIT 1");
		$STH->execute([':address' => $ip, ':port' => $port]);
		$game = $STH->fetch(PDO::FETCH_OBJ);

		if(empty($game->game)) {
			$game = 'csgo';
		} else {
			$game = $game->game;
		}

		$STH = $pdo2->query("SELECT COUNT(*) as count FROM hlstats_Players WHERE kills!=0 AND game='$game'");
	} elseif($type == '5') {
		$STH = $pdo2->query("SELECT COUNT(*) as count FROM $table WHERE kills!=0");
	} elseif($type == '6') {
		$STH = $pdo2->query("SELECT COUNT(*) as count FROM $table");
	}

	$count = $STH->fetchColumn();
}

resetIfPaginationIncorrect($number, $limit, $count, '../stats');

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
$tpl->set("{url}", page()->url);
$tpl->set("{other}", '');
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('stats', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$tpl->result['categories'] = '';

foreach(ServersManager::getForCategories('st_type!=0') as $serverItem) {
	tpl()->compileCategory(
		$serverItem->name,
		'../stats?server=' . $serverItem->id,
		$serverItem->id == $server,
		'stats'
	);
}

$tpl->load_template('/home/stats.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{start}", $start);
$tpl->set("{limit}", $limit);
$tpl->set("{server}", $server);
$tpl->set("{error}", $error);
$tpl->set("{servers}", $tpl->result['categories']);
$tpl->set("{type}", $type);
$tpl->set("{pagination}", $tpl->paginator($number, $count, $limit, $page_name));
$tpl->compile('content');
$tpl->clear();