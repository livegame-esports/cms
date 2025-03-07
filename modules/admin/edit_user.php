<?php
if(!is_admin()){
	show_error_page('not_adm');
}

$id = getPageParam('id');

if (!$id) {
	show_error_page('not_settings');
}

$STH = pdo()->query("SELECT * FROM users WHERE id='$id'"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$profile = $STH->fetch();
if(empty($profile->id)){
	show_error_page();
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
	$PI->to_nav('admin_users', 0, 0),
	$PI->to_nav('admin_edit_user', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$user_groups_str = '';
foreach ($users_groups as &$value) {
	if($value['id'] != 0) {
		if($profile->rights == $value['id']) {
			$user_groups_str .= '<option value="'.$value['id'].'" selected>'.$value['name'].'</option>';
		} else {
			$user_groups_str .= '<option value="'.$value['id'].'">'.$value['name'].'</option>';
		}
	}
}

if($profile->multi_account != 0) {
	$multi_accounts = explode(';', $profile->multi_account);
	for ($i = 0; $i < count($multi_accounts); $i++) {
		$multi_accounts[$i] = explode(':', $multi_accounts[$i]);

		$STH = pdo()->prepare("SELECT `login` FROM `users` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
		$STH->execute(array( ':id' => $multi_accounts[$i][0] ));
		$row = $STH->fetch();

		if(empty($row->login)) {
			$multi_accounts[$i][0] = 0;
		} else {
			$multi_accounts[$i][2] = $row->login;
		}
	}
	$profile->multi_account = 1;
}

if(empty($profile->signature)) {
	$profile->signature = '';
}
if(empty($profile->fb)) {
	$profile->fb = 0;
}
if(empty($profile->fb_api)) {
	$profile->fb_api = 0;
}

$tpl->load_template('edit_user.tpl');
$tpl->set("{user_groups}", $user_groups_str);
$tpl->set("{token}", token());
$tpl->set("{id}", $profile->id);
$tpl->set("{login}", $profile->login);
$tpl->set("{avatar}", $profile->avatar);
$tpl->set("{regdate}", expand_date($profile->regdate,7));
$tpl->set("{name}", $profile->name);
$tpl->set("{nick}", $profile->nick);
$tpl->set("{route}", $profile->route);
$tpl->set("{skype}", $profile->skype);
$tpl->set("{vk}", $profile->vk);
$tpl->set("{fb}", $profile->fb);
$tpl->set("{signature}", $profile->signature);
$tpl->set("{steam_id}", $profile->steam_id);
$tpl->set("{telegram}", $profile->telegram);
$tpl->set("{discord}", $profile->discord);
$tpl->set("{email}", $profile->email);
if($profile->active == 0) {
	$tpl->set("{active}", "0");
} else {
	$tpl->set("{active}", "1");
}
$tpl->set("{gag}", $profile->gag);
$birth = explode("-", $profile->birth);
$birth_day = "";
for ($x = 31; $x > 0; $x--){
	$birth_day = $birth_day.'<option value="'.$x.'" ';
	if($birth[2]==$x) $birth_day = $birth_day.' selected';
	$birth_day = $birth_day.'>'.$x.'</option>';
}
$birth_month = "";
for ($x = 12; $x > 0; $x--){
	$birth_month = $birth_month.'<option value="'.$x.'" ';
	if($birth[1]==$x) $birth_month = $birth_month.' selected';
	$birth_month = $birth_month.'>'.$x.'</option>';
}
$birth_year = "";
for ($x = (date('Y')); $x > 1959; $x--){
	$birth_year = $birth_year.'<option value="'.$x.'" ';
	if($birth[0]==$x) $birth_year = $birth_year.' selected';
	$birth_year = $birth_year.'>'.$x.'</option>';
}

$tpl->set("{birth_day}", $birth_day);
$tpl->set("{birth_month}", $birth_month);
$tpl->set("{birth_year}", $birth_year);

$shilings = 0;
$STH = pdo()->prepare("SELECT `shilings` FROM `money__actions` WHERE `author`=:author AND type='1'"); $STH->setFetchMode(PDO::FETCH_OBJ);
$STH->execute(array( ':author' => $id ));
while($row = $STH->fetch()) { 
	$shilings += $row->shilings;
}
$tpl->set("{shilings}", $shilings.' '.$messages['RUB']);
$tpl->set("{email_notice}", $profile->email_notice);
$tpl->set("{im}", $profile->im);
$tpl->set("{invited}", $profile->invited);
if($profile->invited != 0) {
	$invited_login = 'Неизвестно';
	$STH = pdo()->prepare("SELECT `login` FROM `users` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
	$STH->execute(array( ':id' => $profile->invited ));
	$row = $STH->fetch();

	if(!empty($row->login)) {
		$invited_login = $row->login;
	}

	$tpl->set("{invited_login}", $invited_login);
}
$tpl->set("{ip}", $profile->ip);
$tpl->set("{multi_account}", $profile->multi_account);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();