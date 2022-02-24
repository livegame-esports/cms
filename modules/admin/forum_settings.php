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
$tpl->set("{other}", '');
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
	$PI->to_nav('admin_forum_settings', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$STH = pdo()->prepare("SELECT `data` FROM `config__strings` WHERE `id`=:id LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
$STH->execute(array( ':id' => 2 ));
$row = $STH->fetch();
$settings = unserialize($row->data);

$tpl->load_template('forum_settings.tpl');

$act = get_active($settings['file_manager'], 2, 2);
$tpl->set("{fm_act1}", $act[0]);
$tpl->set("{fm_act2}", $act[1]);

$act = get_active($settings['file_manager_theme'], 2, 2);
$tpl->set("{fmt_act1}", $act[0]);
$tpl->set("{fmt_act2}", $act[1]);

$tpl->set("{file_max_size}", $settings['file_max_size']);
$tpl->set("{ext_img}", $settings['ext_img']);
$tpl->set("{file_max_size}", $settings['file_max_size']);
$tpl->set("{ext_img}", $settings['ext_img']);
$tpl->set("{ext_music}", $settings['ext_music']);
$tpl->set("{ext_video}", $settings['ext_video']);
$tpl->set("{ext_file}", $settings['ext_file']);
$tpl->set("{ext_misc}", $settings['ext_misc']);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();