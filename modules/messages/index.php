<?php
if(!is_auth()){
	show_error_page('not_auth');
}

$id = getPageParam('id');
$createId = getPageParam('create_id');

if ($id) {
	$load = 'open_dialog("'.$id.'");';
} elseif ($createId) {
	$id = $createId;
	$load = 'create_dialog("'.$id.'");';
} else {
	$load = 'load_dialogs();';
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
$tpl->set("{other}", getLibAssets('jplayer'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('users', 0, 0),
	$PI->to_nav('profile', 0, $user->id, $user->login),
	$PI->to_nav('messages', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

$tpl->load_template('/home/messages.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{site_name}", configs()->name);
$tpl->set("{load_dialogs}", $load);
$tpl->compile( 'content' );
$tpl->clear();