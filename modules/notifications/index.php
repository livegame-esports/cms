<?php

global $tpl;
global $messages;
global $PI;

if(!is_auth()){
	show_error_page('not_auth');
}

pdo()
	->prepare("UPDATE notifications SET status=:status WHERE status='0' and user_id='$_SESSION[id]'")
	->execute(array( 'status' => '1' ));

$number = getPageParam('page');
$limit = 10;
$start = getPageStartPosition($number, $limit);


$STH = pdo()->query("SELECT COUNT(*) as count FROM notifications WHERE user_id='$_SESSION[id]'");
$count = $STH->fetchColumn();
$page_name = "../notifications?";

resetIfPaginationIncorrect($number, $limit, $count, '../index');

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
	$PI->to_nav('notifications', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

$tpl->load_template('/home/notifications.tpl');
$tpl->set("{template}", configs()->template); 
$tpl->set("{page}", $number);
$tpl->set("{start}", $start); 
$tpl->set("{limit}", $limit); 
$tpl->set("{pagination}", $tpl->paginator($number,$count,$limit,$page_name));
$tpl->compile( 'content' );
$tpl->clear();