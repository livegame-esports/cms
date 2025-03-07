<?php
if(!is_worthy("w")){
	show_error_page('not_allowed');
}

if(isset($_GET['id'])){
	$id = getPageParam('id');

	$STH = pdo()->query("SELECT `forums`.`name`, `forums`.`description`, `forums__section`.`access` FROM `forums` LEFT JOIN `forums__section` ON `forums__section`.`id` = `forums`.`section_id` WHERE `forums`.`id`='$id'"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$row = $STH->fetch();
	if(empty($row->name)){
		show_error_page();
	}

	if(!Forum::have_rights($row->access)) {
		show_error_page('not_allowed');
	}
} else {
	show_error_page('not_settings');
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
	$PI->to_nav('forum', 0, 0),
	$PI->to_nav('forum_forum', 0, $id, $row->name),
	$PI->to_nav('forum_add_topic', 1, 0),
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

$editor_settings = get_editor_settings();
$tpl->load_template('/forum/add_topic.tpl');
$tpl->set("{file_manager}", $editor_settings['file_manager']);
$tpl->set("{file_manager_theme}", $editor_settings['file_manager_theme']);
$tpl->set("{template}", configs()->template);
$tpl->set("{token}", token());
$tpl->set("{id}", $id);
$tpl->compile( 'content' );
$tpl->clear();