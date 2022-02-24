<?php
if(!is_admin()){
	show_error_page('not_adm');
}
if(isset($_GET['server'])) {
	$server = $_GET['server'];
	$server = clean($server,"int");

	$STH = pdo()->prepare("SELECT `id` FROM `servers` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $server ));
	$row = $STH->fetch();
	if(empty($row->id)) {
		header('Location: ../admin/store');
		exit();
	}
} else {
	$STH = pdo()->query("SELECT `id` FROM `servers` ORDER BY trim LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$row = $STH->fetch();
	if(isset($row->id)) {
		$server = $row->id;
	} else {
		$server = 0;
	}
}

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", getLibAssets('tinymce'));
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
	$PI->to_nav('admin_store', 1, 0)
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

if($servers == '') {
	$servers = '<option value="0" title="Укажите дополнительные настройки для серверов">Нет серверов, с указанными дополнительными настройками</option>';
}

$STH = pdo()->query("SELECT stand_rights FROM config__secondary LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
$row = $STH->fetch();
$user_groups_str = '<option value="0" selected>'.$messages['Group_on_site'].' '.$messages['No_give'].'</option>';
foreach ($users_groups as &$value) {
	if($value['id'] != 0) {
		if($row->stand_rights != $value['id']) {
			$user_groups_str .= '<option value="'.$value['id'].'">'.$value['name'].'</option>';
		}
	}
}

$tpl->load_template('store.tpl');
$tpl->set("{server}", $server);
$tpl->set("{servers}", $servers);
$tpl->set("{user_groups}", $user_groups_str);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();