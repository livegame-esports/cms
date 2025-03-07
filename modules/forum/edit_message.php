<?php
if(!is_auth()) {
	show_error_page('not_auth');
}

$id = getPageParam('id');

if (!$id) {
	show_error_page('not_settings');
}

$id2 = getPageParam('id2');

if(!$id2) {
	show_error_page('not_settings');
}

$STH = pdo()->prepare("SELECT * FROM `forums__topics` WHERE `id`=:id LIMIT 1");
$STH->setFetchMode(PDO::FETCH_OBJ);
$STH->execute(array( ':id' => $id ));
$topic = $STH->fetch();
if(empty($topic->id)) {
	show_error_page();
}

$STH = pdo()->query("SELECT `forums`.`name`, `forums`.`id`, `forums__section`.`access` FROM `forums` LEFT JOIN `forums__section` ON `forums__section`.`id` = `forums`.`section_id` WHERE `forums`.`id`='$topic->forum_id'");
$STH->setFetchMode(PDO::FETCH_OBJ);
$forum = $STH->fetch();
if(empty($forum->name)) {
	show_error_page();
}

if(!Forum::have_rights($forum->access)) {
	show_error_page('not_allowed');
}

$id  = $topic->id;
$STH = pdo()->query("SELECT `id`, `text`, `author`, `date` FROM `forums__messages` WHERE `id`='$id2'");
$STH->setFetchMode(PDO::FETCH_OBJ);
$mess = $STH->fetch();
if(empty($mess->id)) {
	show_error_page();
}

if(!is_worthy("r") and (($_SESSION['id'] != $mess->author) or ((time() - strtotime($mess->date)) > (60 * 15)))) {
	show_error_page('not_allowed');
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
$tpl->set("{other}", getLibAssets('tinymce'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('forum', 0, 0),
	$PI->to_nav('forum_topic', 0, $topic->id, $topic->name),
	$PI->to_nav('forum_edit_message', 1, 0),
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

$editor_settings = get_editor_settings();
$tpl->load_template('/forum/edit_message.tpl');
$tpl->set("{file_manager}", $editor_settings['file_manager']);
$tpl->set("{file_manager_theme}", $editor_settings['file_manager_theme']);
$tpl->set("{id}", $mess->id);
$tpl->set("{text}", $mess->text);
$tpl->set("{template}", configs()->template);
$tpl->set("{views}", $topic->views);
$tpl->set("{answers}", $topic->answers);
$tpl->set("{status}", $topic->status);
$tpl->set("{name}", $topic->name);
$tpl->set("{topic_id}", $topic->id);
$tpl->compile('content');
$tpl->clear();