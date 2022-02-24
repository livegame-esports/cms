<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$server = getPageParam('server');
$number = getPageParam('page');
$limit  = getLimit('muts_lim');
$start  = getPageStartPosition($number, $limit);

$count_active    = 0;
$count_permanent = 0;
$count_temporal  = 0;

if($server) {
	$STH = pdo()->query("SELECT id,ip,port,db_host,db_user,db_pass,db_db,db_prefix,type FROM servers WHERE type!=0 and id='$server' LIMIT 1");
} else {
	$STH = pdo()->query("SELECT id,ip,port,db_host,db_user,db_pass,db_db,db_prefix,type FROM servers WHERE type!=0 ORDER BY trim LIMIT 1");
}
$row = $STH->fetch(PDO::FETCH_OBJ);

if(empty($row->id)) {
	show_error_page('servers_not_configured');
}

$server    = $row->id;
$page_name = "../muts?server=" . $row->id . "&";
$db_host   = $row->db_host;
$db_user   = $row->db_user;
$db_pass   = $row->db_pass;
$db_db     = $row->db_db;
$db_prefix = $row->db_prefix;
$address   = $row->ip . ':' . $row->port;
$ip        = $row->ip;
$port      = $row->port;
$type      = $row->type;
$error     = "";

$now = time();
if($type == '1' || $type == '2' || $type == '3' || $type == '5') {
	if(check_table('comms', $pdo)) {
		$table           = 'comms';
		$count           = get_rows_count($pdo, $table, "server_id = '$server'");
		$count_active    = get_rows_count($pdo, $table, "((expired != '-1' AND expired != '-2' AND (created+length*60 > '$now' AND length!='0')) OR (expired != '-1' AND expired != '-2' AND length='0')) AND server_id = '$server'");
		$count_permanent = get_rows_count($pdo, $table, "length = '0' AND server_id = '$server'");
		$count_temporal  = get_rows_count($pdo, $table, "length != '0' AND server_id = '$server'");
	} else {
		$count = 0;
		$error = $messages['Not_found_tables'];
	}
} else {
	if(!$pdo2 = db_connect($db_host, $db_db, $db_user, $db_pass)) {
		$error = $messages['errorConnectingToDatabase'];
	}

	$table = set_prefix($db_prefix, 'servers');
	$STH   = $pdo2->query(
		"SELECT sid FROM $table WHERE ip='$ip' and port='$port' LIMIT 1"
	);
	$STH->setFetchMode(PDO::FETCH_OBJ);
	$row = $STH->fetch();
	$sid = $row->sid;

	$table = set_prefix($db_prefix, 'comms');
	if(check_table($table, $pdo2)) {
		$count           = get_rows_count($pdo2, $table, "sid = '$sid' || sid = 0");
		$count_active    = get_rows_count($pdo2, $table, "((RemoveType is NULL AND (created+length > '$now' AND length!='0')) OR (RemoveType is NULL AND length='0')) AND (sid = '$sid' || sid = 0)");
		$count_permanent = get_rows_count($pdo2, $table, "length = '0' AND (sid = '$sid' || sid = 0)");
		$count_temporal  = get_rows_count($pdo2, $table, "length != '0' AND (sid = '$sid' || sid = 0)");
	} else {
		$count = 0;
		$error = $messages['Not_found_tables'];
	}
}

resetIfPaginationIncorrect($number, $limit, $count, '../muts');

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
$tpl->set("{other}", getLibAssets('timepicker'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('muts', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$tpl->result['categories'] = '';

foreach(ServersManager::getForCategories(
	'type!=0 AND type!=1'
) as $serverItem) {
	tpl()->compileCategory(
		$serverItem->name,
		'../muts?server=' . $serverItem->id,
		$serverItem->id == $server,
		'muts'
	);
}

$tpl->load_template('/home/mutlist.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{start}", $start);
$tpl->set("{limit}", $limit);
$tpl->set("{server}", $server);
$tpl->set("{error}", $error);
$tpl->set("{servers}", $tpl->result['categories']);
$tpl->set("{count}", $count);
$tpl->set("{count_active}", $count_active);
$tpl->set("{count_permanent}", $count_permanent);
$tpl->set("{count_temporal}", $count_temporal);
$tpl->set("{pagination}", $tpl->paginator($number, $count, $limit, $page_name));
$tpl->compile('content');
$tpl->clear();