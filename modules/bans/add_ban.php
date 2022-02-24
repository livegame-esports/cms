<?php
if(!is_auth()){
	show_error_page('not_auth');
}

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
$tpl->set("{other}", getLibAssets('tinymce'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('bans', 0, 0),
	$PI->to_nav('bans_add_ban', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';


tpl()->result['options'] = '';
$servers = pdo()->query("SELECT id, name, type from servers order by trim");
while($server = $servers->fetch(PDO::FETCH_OBJ)) {
	tpl()->compileOption(
		$server->name,
		$server->id . '" data-server-type="' . $server->type,
		0,
		'complaint'
	);
}

$editor_settings = get_editor_settings();
$tpl->load_template('/bans/add_ban.tpl');
$tpl->set("{file_manager}", $editor_settings['file_manager']);
$tpl->set("{file_manager_theme}", $editor_settings['file_manager_theme']);
$tpl->set("{template}", configs()->template);
$tpl->set("{token}", token());
$tpl->set("{servers}", tpl()->result['options']);
$tpl->compile( 'content' );
$tpl->clear();