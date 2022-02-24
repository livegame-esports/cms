<?php

global $tpl;
global $messages;
global $PI;

if(page()->privacy == 1 && !is_auth()) {
	show_error_page('not_auth');
}

$ES = new EventsRibbon;

$class  = getPageParam('class');
$number = getPageParam('page');
$limit  = 20;
$start  = getPageStartPosition($number, $limit);

if($class) {
	$STH        = pdo()->query(
		"SELECT 
    								COUNT(*) as count 
								FROM 
								    `events`  
									    LEFT JOIN 
									        `users` 
									            ON 
									                `events`.`author` = `users`.`id` 
										LEFT JOIN 
									        users__groups 
									            ON 
									                users.rights = users__groups.id 
								WHERE 
									users__groups.name IS NOT NULL 
								  		AND `type` = '$class'"
	);
	$page_name  = "../events?class=" . $class . "&";
	$class_name = $ES->get_category_name($class);
} else {
	$STH        = pdo()->query(
		"SELECT 
    								COUNT(*) as count 
								FROM 
								    events  
									    LEFT JOIN 
									        users 
									            ON 
									                events.author = users.id 
										LEFT JOIN 
									        users__groups 
									            ON 
									                users.rights = users__groups.id 
								WHERE 
									users__groups.name IS NOT NULL"
	);
	$page_name  = "../events?";
	$class_name = null;
}
$count = $STH->fetchColumn();

resetIfPaginationIncorrect($number, $limit, $count, '../events');

if(isset($class_name)) {
	page()->title = page()->title . ' - ' . $class_name;
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
$tpl->set("{other}", '');
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$menu = $tpl->get_menu();

$nav = [
	$PI->to_nav('main', 0, 0),
	$PI->to_nav('events', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl');

if(is_auth()) {
	include_once __DIR__ . '/../../inc/authorized.php';
} else {
	include_once __DIR__ . '/../../inc/not_authorized.php';
}

foreach($ES->get_categories() as $key => $category) {
	tpl()->compileCategory(
		$category,
		'../events?class=' . $key,
		$key == $class,
		'admins'
	);
}

$tpl->load_template('/home/events.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{categories}", $tpl->result['categories']);
$tpl->set("{page}", $number);
$tpl->set("{start}", $start);
$tpl->set("{class}", $class);
$tpl->set("{limit}", $limit);
$tpl->set("{pagination}", $tpl->paginator($number, $count, $limit, $page_name));
$tpl->compile('content');
$tpl->clear();