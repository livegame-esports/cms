<?php
if(!is_admin()){
	show_error_page('not_adm');
}

$server = getPageParam('server');

if($server) {
	$STH = pdo()->prepare("SELECT id,binds,type FROM servers WHERE id=:id and type != '0' LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $server ));
	$row = $STH->fetch();
	if(empty($row->id)) {
		show_error_page();
	}
} else {
	$STH = pdo()->query("SELECT id,binds,type FROM servers WHERE type != '0' ORDER BY trim LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$row = $STH->fetch();
	if(isset($row->id)) {
		$server = $row->id;
	}
}

if(isset($row->id)) {
	$server_type = $row->type;
	$binds = explode(';', $row->binds);
} else {
	$server_type = 0;
	$binds       = [0, 0, 0];
}
$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", getLibAssets('timepicker'));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('top.tpl');
$tpl->set("{site_name}", configs()->name);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('menu.tpl');
$tpl->compile( 'content' );
$tpl->clear();

$nav = [
	$PI->to_nav('admin', 0, 0),
	$PI->to_nav('admin_admins', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$servers = '';
$STH = pdo()->query("SELECT id,name,type FROM servers WHERE type != '0' ORDER BY trim"); $STH->setFetchMode(PDO::FETCH_OBJ);  
while($row = $STH->fetch()) {
	if($row->id == $server) {
		$servers .= '<option value="'.$row->id.'" title="'.$row->type.'" selected>'.$row->name.'</option>';
	} else {
		$servers .= '<option value="'.$row->id.'" title="'.$row->type.'">'.$row->name.'</option>';
	}
}

$tpl->load_template('admins.tpl');
$tpl->set("{servers}", $servers);
$tpl->set("{server}", $server);
$tpl->set("{server_type}", $server_type);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();