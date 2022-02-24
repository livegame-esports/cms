<?php
if(!is_auth()){
	show_error_page('not_auth');
}

if(!is_worthy("j")) {
	show_error_page('not_allowed');
}

$server = getPageParam('server');

if($server) {
	$STH = pdo()->prepare("SELECT id, binds, type FROM servers WHERE id=:id and type != '0' LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $server ));
	$row = $STH->fetch();
	if(empty($row->id)) {
		show_error_page();
	}
} else {
	$server = get_specifically_worthy("j");
	if($server === true) {
		$STH = pdo()->query("SELECT id, binds, type FROM servers WHERE type != '0' ORDER BY trim LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	} else {
		$STH = pdo()->query("SELECT id, binds, type FROM servers WHERE type != '0' AND id = '$server[0]'"); $STH->setFetchMode(PDO::FETCH_OBJ);
	}

	$row = $STH->fetch();
	if(empty($row->id)) {
		show_error_page();
	}

	$server = $row->id;
}

if(!is_worthy_specifically("j", $server)) {
	show_error_page('not_allowed');
}

$server_type = $row->type;
$binds = explode(';', $row->binds);

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
$tpl->set("{other}", getLibAssets('timepicker'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('admins', 0, 0),
	$PI->to_nav('edit_admins', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';


tpl()->result['options'] = '';
$servers = pdo()->query("SELECT id, name, type FROM servers WHERE type != '0' ORDER BY trim");
while($row = $servers->fetch(PDO::FETCH_OBJ)) {
	if(is_worthy_specifically("j", $row->id)) {
		tpl()->compileOption(
			$row->name,
			$row->id . '" title="' . $row->type,
			$row->id == $server,
			'server'
		);
	}
}

$tpl->load_template('home/edit_admins.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{servers}", tpl()->result['options']);
$tpl->set("{server}", $server);
$tpl->set("{server_type}", $server_type);
$tpl->compile( 'content' );
$tpl->clear();