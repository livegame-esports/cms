<?php

global $tpl;
global $messages;
global $PI;


if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$id = getPageParam('id');

if(!$id){
	show_error_page('not_settings');
}


$number = getPageParam('page');
$limit = 20;
$start = getPageStartPosition($number, $limit);


$STH = pdo()->query("SELECT COUNT(*) as count FROM `forums__topics` WHERE `forum_id` = '$id'");
$number_name = "forum?id=".$id."&";
$count = $STH->fetchColumn();

resetIfPaginationIncorrect($number, $limit, $count, '../index');

$STH = pdo()->query("SELECT `forums`.*, `forums__section`.`access` FROM `forums` LEFT JOIN `forums__section` ON `forums__section`.`id` = `forums`.`section_id` WHERE `forums`.`id`='$id'"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$row = $STH->fetch();
if(empty($row->id)){
	show_error_page();
}

if(!Forum::have_rights($row->access)) {
	show_error_page('not_allowed');
}

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", $row->name);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{site_name}", configs()->name);
$tpl->set("{image}", page()->image);
$tpl->set("{robots}", page()->robots);
$tpl->set("{type}", page()->kind);
$tpl->set("{description}", $row->description);
$tpl->set("{keywords}", $PI->compile_keywords($row->description));
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
	$PI->to_nav('forum', 0, 0),
	$PI->to_nav('forum_forum', 1, 0, $row->name),
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$tpl->load_template('/forum/forum.tpl');
$tpl->set("{id}", $id);
$tpl->set("{template}", configs()->template); 
$tpl->set("{token}", token());
$tpl->set("{page}", $number);
$tpl->set("{start}", $start);
$tpl->set("{limit}", $limit);
$tpl->set("{name}", $row->name);
$tpl->set("{pagination}", $tpl->paginator($number,$count,$limit,$number_name));
$tpl->compile( 'content' );
$tpl->clear();