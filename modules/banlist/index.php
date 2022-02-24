<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$server = getPageParam('server');
$number = getPageParam('page');
$limit  = getLimit('bans_lim');
$start  = getPageStartPosition($number, $limit);

$count_active    = 0;
$count_permanent = 0;
$count_temporal  = 0;

if($server) {
	$STH = pdo()->query("SELECT id,ip,port,db_host,db_user,db_pass,db_db,db_prefix,type FROM servers WHERE type!=0 and type!=1 and id='$server' LIMIT 1");
} else {
	$STH = pdo()->query("SELECT id,ip,port,db_host,db_user,db_pass,db_db,db_prefix,type FROM servers WHERE type!=0 and type!=1 ORDER BY trim LIMIT 1");
}
$row = $STH->fetch(PDO::FETCH_OBJ);

if(empty($row->id)) {
	show_error_page('servers_not_configured');
}

$server    = $row->id;
$page_name = "../banlist?server=" . $row->id . "&";
$db_host   = $row->db_host;
$db_user   = $row->db_user;
$db_pass   = $row->db_pass;
$db_db     = $row->db_db;
$db_prefix = $row->db_prefix;
$address   = $row->ip . ':' . $row->port;
$ip        = $row->ip;
$port      = $row->port;
$type      = $row->type;
$count     = 0;

$error = "";
if(!$pdo2 = db_connect($db_host, $db_db, $db_user, $db_pass)) {
	$error = $messages['errorConnectingToDatabase'];
} else {
	$now = time();
	if($type == '2' || $type == '3' || $type == '5') {
		$table           = set_prefix($db_prefix, 'bans');
		$count           = get_rows_count($pdo2, $table, "server_ip = '$address'");
		$count_active    = get_rows_count($pdo2, $table, "(unban_type IS NULL AND expired = 0 AND (((ban_created + ban_length*60) > '$now' AND ban_length != 0)) OR ban_length = 0) AND server_ip = '$address'");
		$count_permanent = get_rows_count($pdo2, $table, "ban_length = 0 AND server_ip = '$address'");
		$count_temporal  = get_rows_count($pdo2, $table, "ban_length != 0 AND server_ip = '$address'");
	} else {
		$table = set_prefix($db_prefix, 'servers');
		$STH = $pdo2->query("SELECT sid FROM $table WHERE ip='$ip' and port='$port' LIMIT 1");
		$STH->setFetchMode(PDO::FETCH_OBJ);
		$row = $STH->fetch();
		$sid = $row->sid;

		$table           = set_prefix($db_prefix, 'bans');
		$count           = get_rows_count($pdo2, $table, "sid = '$sid' OR sid = 0");
		$count_active    = get_rows_count($pdo2, $table, "unban_type IS NULL AND RemoveType IS NULL AND ((created + length > '$now' AND length != 0) OR length = 0) AND (sid = '$sid' OR sid = 0)");
		$count_permanent = get_rows_count($pdo2, $table, "length = '0' AND (sid = '$sid' OR sid = 0)");
		$count_temporal  = get_rows_count($pdo2, $table, "length != '0' AND (sid = '$sid' OR sid = 0)");
	}
}

resetIfPaginationIncorrect($number, $limit, $count, '../banlist');

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
$nav  = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('banlist', 1, 0)
];
$nav  = $tpl->get_nav($nav, 'elements/nav_li.tpl');

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
		'../banlist?server=' . $serverItem->id,
		$serverItem->id == $server,
		'banlist'
	);
}

$tpl->load_template('/home/banlist.tpl');
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