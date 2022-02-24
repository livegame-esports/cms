<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}


$class = getPageParam('class');

$number = getPageParam('page');
$limit = getLimit('news_lim');
$start = getPageStartPosition($number, $limit);


if($class == 0) {
	$count = $pdo
		         ->query("SELECT COUNT(*) as count FROM news")
		         ->fetch(PDO::FETCH_ASSOC)['count'];
	$page_name = '../news/?';
} else {
	$count = $pdo
		         ->query("SELECT COUNT(*) as count FROM news WHERE class = '$class'")
		         ->fetch(PDO::FETCH_ASSOC)['count'];
	$page_name = '../news/?class=' . $class . '&';
}

resetIfPaginationIncorrect($number, $limit, $count, '../index');

tpl()->compileCategory(
	$messages['All'],
	'../news/',
	$class == 0,
	'news'
);

$categories = pdo()->query("SELECT id, name FROM news__classes");
while($category = $categories->fetch(PDO::FETCH_OBJ)) {
	if($category->id == $class) {
		$class_name = $category->name;
	}

	tpl()->compileCategory(
		$category->name,
		'../news/?class=' . $category->id,
		$category->id == $class,
		'news'
	);
}


$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", isset($class_name) ? page()->title . ' - ' . $class_name : page()->title);
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
$tpl->set("{other}", '');
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('news', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

$tpl->load_template('/news/index.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{page}", $number);
$tpl->set("{start}", $start);
$tpl->set("{class}", $class);
$tpl->set("{limit}", $limit);
$tpl->set("{classes}", $tpl->result['categories']);
$tpl->set("{pagination}", $tpl->paginator($number, $count, $limit, $page_name));
$tpl->compile('content');
$tpl->clear();