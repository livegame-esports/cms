<?php
if(!is_auth()){
	show_error_page('not_auth');
}

if(!is_worthy("q")) {
	show_error_page('not_allowed');
}

$id = getPageParam('id');

if (!$id) {
	show_error_page('not_settings');
}

$STH = pdo()->query("SELECT * FROM news WHERE id='$id' LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$new = $STH->fetch();
if(empty($new->id)){
	show_error_page();
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
$tpl->set("{other}", getLibAssets(['tinymce', 'timepicker']));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('news', 0, 0),
	$PI->to_nav('news_new', 0, $new->id, $new->new_name),
	$PI->to_nav('news_change_new', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

tpl()->result['options'] = '';
$classes = pdo()->query("SELECT id, name from news__classes");
while($class = $classes->fetch(PDO::FETCH_OBJ)) {
	tpl()->compileOption(
		$class->name,
		$class->id,
		$class->id == $new->class,
		'new_class'
	);
}

$editor_settings = get_editor_settings();
$tpl->load_template('/news/change_new.tpl');
$tpl->set("{file_manager}", $editor_settings['file_manager']);
$tpl->set("{file_manager_theme}", $editor_settings['file_manager_theme']);
$tpl->set("{template}", configs()->template);
$tpl->set("{token}", token());
$tpl->set("{classes}", tpl()->result['options']);
$tpl->set("{id}", $new->id);
$tpl->set("{name}", $new->new_name);
$tpl->set("{img}", $new->img);
$tpl->set("{text}", $new->text);
$tpl->set("{short_text}", $new->short_text);
$tpl->set("{date}", date( 'd.m.Y H:i', strtotime($new->date)));
$tpl->compile( 'content' );
$tpl->clear();