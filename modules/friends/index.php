<?php
if(!is_auth()){
	show_error_page('not_auth');
}

$id = getPageParam('id');

if (!$id) {
	$id = $_SESSION['id'];
}

$STH = pdo()->query("SELECT * FROM users WHERE id='$id'"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$profile = $STH->fetch();
if(empty($profile->id)){
	show_error_page();
}

$tpl->load_template('elements/title.tpl');
if($_SESSION['id'] == $id){
	$tpl->set("{title}", page()->title);
} else {
	$tpl->set("{title}", page()->title." ".$profile->login);
}
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
$tpl->set("{other}", getLibAssets(['modernizr', 'tabs']));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$menu = $tpl->get_menu();

if($_SESSION['id'] == $id){
	$nav = [
		$PI->to_nav('main', 0, 0),
		$PI->to_nav('users', 0, 0),
		$PI->to_nav('profile', 0, $profile->id, $profile->login),
		$PI->to_nav('friends', 1, 0)
	];
} else {
	$nav = [
		$PI->to_nav('main', 0, 0),
		$PI->to_nav('users', 0, 0),
		$PI->to_nav('profile', 0, $profile->id, $profile->login),
		$PI->to_nav('friends', 1, 0, page()->title . " " . $profile->login)
	];
}
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

include_once __DIR__ . '/../../inc/authorized.php';

if($_SESSION['id'] == $id){
	$tpl->load_template('/home/myfriends.tpl');
} else {
	$tpl->load_template('/home/friends.tpl');
}
$tpl->set("{token}", token());
$tpl->set("{template}", configs()->template); 
$tpl->set("{id}", $profile->id); 
$tpl->set("{login}", $profile->login);  
$tpl->compile( 'content' );
$tpl->clear();