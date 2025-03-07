<?php
if(!is_admin()){
	show_error_page('not_adm');
}

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", getLibAssets('farbtastic'));
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
	$PI->to_nav('admin_users_groups', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$STH = pdo()->query("SELECT stand_rights FROM config__secondary LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$row = $STH->fetch();

$count = count($users_groups);
$user_groups_str = '';
foreach ($users_groups as &$value) {
	if($value['id'] != 0) {
		if($row->stand_rights == $value['id']) {
			$user_groups_str .= '<option value="'.$value['id'].'" selected>'.$value['name'].'</option>';
		} else {
			$user_groups_str .= '<option value="'.$value['id'].'">'.$value['name'].'</option>';
		}
	}
}

$tpl->load_template('elements/group_form.tpl');
$tpl->set("{id}", '');
$tpl->set("{color}", '#FFFFFF');
$tpl->set("{name}", '');
$tpl->set("{rights}", '');
$tpl->set("{style}", '');
$tpl->compile('{add_group_form}');
$tpl->clear();

$tpl->load_template('users_groups.tpl');
$tpl->set("{add_group_form}", $tpl->result['{add_group_form}']);
$tpl->set("{users_groups}", $user_groups_str);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();