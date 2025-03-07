<?php
global $tpl;
global $host;
global $PI;

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

if(!is_admin()){
	$tpl->load_template('index.tpl');
	$tpl->set("{site_name}", configs()->name);
	$tpl->set("{host}", $host);
	$tpl->compile( 'content' );
	$tpl->clear();
} else {
	$tpl->load_template('top.tpl');
	$tpl->set("{token}", token());
	$tpl->set("{site_name}", configs()->name);
	$tpl->compile( 'content' );
	$tpl->clear();

	$tpl->load_template('menu.tpl');
	$tpl->compile( 'content' );
	$tpl->clear();

	$nav = [
		$PI->to_nav('admin', 1, 0)
	];
	$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);
	$tpl->load_template('page_top.tpl');
	$tpl->set("{nav}", $nav);
	$tpl->compile( 'content' );
	$tpl->clear();

	$time_zones = "";
	for ($i=0; $i <= 12; $i++) {
		$zone = 'Etc/GMT-'.$i;
		$zone_name = substr(str_replace("-", "+", $zone), 4);
		if(configs()->time_zone == $zone) {
			$time_zones .= "<option value='".$zone."' selected>".$zone_name."</option>";
		} else {
			$time_zones .= "<option value='".$zone."'>".$zone_name."</option>";
		}
	}
	for ($i=1; $i <= 12; $i++) {
		$zone = 'Etc/GMT+'.$i;
		$zone_name = substr(str_replace("+", "-", $zone), 4);
		if(configs()->time_zone == $zone) {
			$time_zones .= "<option value='".$zone."' selected>".$zone_name."</option>";
		} else {
			$time_zones .= "<option value='".$zone."'>".$zone_name."</option>";
		}
	}

	$STH = pdo()->query("SELECT COUNT(*) as count FROM chat"); $STH->setFetchMode(PDO::FETCH_ASSOC);
	$chat = $STH->fetch();


	$needToRemoveInstaller = 0;
	if(file_exists('modules/install/installer.php')) {
		$needToRemoveInstaller = 1;
	}

	$needToGiveAccessToRewriteFiles = 0;
	$folders = array('ajax', 'inc', 'files', 'logs', 'modules', 'modules_extra', 'templates', 'index.php' );
	for ($i=0; $i < count($folders); $i++) { 
		if(!is_writable($folders[$i])) {
			$needToGiveAccessToRewriteFiles = 1;
		}
	}

	$needToCreateLogsDirectory = 0;
	if(!file_exists('logs')) {
		$needToCreateLogsDirectory = 1;
	}

	$needToCreateUpdatesDirectory = 0;
	if(!file_exists('modules/updates')) {
		$needToCreateUpdatesDirectory = 1;
	}

	$STH = pdo()->query("SELECT * FROM config__secondary LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);  
	$conf2 = $STH->fetch();

	$tpl->load_template('home.tpl');
	$tpl->set("{needToRemoveInstaller}", $needToRemoveInstaller);
	$tpl->set("{needToGiveAccessToRewriteFiles}", $needToGiveAccessToRewriteFiles);
	$tpl->set("{needToCreateLogsDirectory}", $needToCreateLogsDirectory);
	$tpl->set("{needToCreateUpdatesDirectory}", $needToCreateUpdatesDirectory);
	$tpl->set("{template}", configs()->template);
	$tpl->set("{host}", $host);
	$tpl->set("{site_name}", configs()->name);
	$tpl->set("{time_zone}", configs()->time_zone);
	$tpl->set("{time_zones}", $time_zones);
	$tpl->set("{users_lim}", $conf2->users_lim);
	$tpl->set("{muts_lim}", $conf2->muts_lim);
	$tpl->set("{bans_lim}", $conf2->bans_lim);
	$tpl->set("{bans_lim2}", $conf2->bans_lim2);
	$tpl->set("{news_lim}", $conf2->news_lim);
	$tpl->set("{stats_lim}", $conf2->stats_lim);
	$tpl->set("{complaints_lim}", $conf2->complaints_lim);
	$tpl->set("{admins_ids}", $conf2->admins_ids);
	$tpl->set("{off_message}", $conf2->off_message);

	$act = get_active(configs()->vk_group, 2);
	$tpl->set("{vk_group}", $act[0]);
	$tpl->set("{vk_group2}", $act[1]);

	$act = get_active(configs()->vk_admin, 2);
	$tpl->set("{vk_admin}", $act[0]);
	$tpl->set("{vk_admin2}", $act[1]);

	$act = get_active($conf2->vk_api, 2);
	$tpl->set("{vact}", $act[0]);
	$tpl->set("{vact2}", $act[1]);

	$act = get_active($conf2->fb_api, 2);
	$tpl->set("{fbact}", $act[0]);
	$tpl->set("{fbact2}", $act[1]);

	$act = get_active($conf2->steam_api, 2);
	$tpl->set("{sact}", $act[0]);
	$tpl->set("{sact2}", $act[1]);

	$tpl->set("{auto_steam_id_fill}", $conf2->auto_steam_id_fill);
	$tpl->set("{steam_id_format}", $conf2->steam_id_format);

	$act = get_active(configs()->cote, 2);
	$tpl->set("{cote_act}", $act[0]);
	$tpl->set("{cote_act2}", $act[1]);

	$act = get_active(configs()->new_year, 2);
	$tpl->set("{new_year_act}", $act[0]);
	$tpl->set("{new_year_act2}", $act[1]);

	$act = get_active(configs()->win_day, 2);
	$tpl->set("{win_day_act}", $act[0]);
	$tpl->set("{win_day_act2}", $act[1]);

	$act = get_active(configs()->disp_last_online, 2);
	$tpl->set("{last_online_act}", $act[0]);
	$tpl->set("{last_online_act2}", $act[1]);

	$act = get_active(configs()->conf_us, 2);
	$tpl->set("{cact}", $act[0]);
	$tpl->set("{cact2}", $act[1]);

	$act = get_active(configs()->off, 2);
	$tpl->set("{off_act}", $act[0]);
	$tpl->set("{off_act2}", $act[1]);

	$act = get_active(configs()->privacy_policy , 2);
	$tpl->set("{ppact}", $act[0]);
	$tpl->set("{ppact2}", $act[1]);

	$act = get_active($dev_mode, 2);
	$tpl->set("{developer_mode}", $act[0]);
	$tpl->set("{developer_mode2}", $act[1]);
	if($act[0] == 'active') {
		$dev_key = '********************************';
	} else {
		$dev_key = '';
	}
	$tpl->set("{dev_key}", $dev_key);

	$act = get_active(configs()->widgets_type, 2);
	$tpl->set("{widgets_type_1}", $act[0]);
	$tpl->set("{widgets_type_2}", $act[1]);

	$act = get_active(configs()->show_news, 3);
	$tpl->set("{nact}", $act[0]);
	$tpl->set("{nact2}", $act[1]);
	$tpl->set("{show_news}", $act[2]);

	$act = get_active(configs()->show_events, 3);
	$tpl->set("{eact}", $act[0]);
	$tpl->set("{eact2}", $act[1]);
	$tpl->set("{show_events}", $act[2]);

	$act = get_active(configs()->top_donators, 2);
	$tpl->set("{topDonatorsWidgetIsOn}", $act[0]);
	$tpl->set("{topDonatorsWidgetIsOff}", $act[1]);
	$tpl->set("{top_donators_count}", configs()->top_donators_count);
	$tpl->set("{top_donators_show_sum}", configs()->top_donators_show_sum);

	$tpl->set("{vk_id}", $conf2->vk_id);
	$tpl->set("{vk_key}", $conf2->vk_key);
	$tpl->set("{vk_service_key}", $conf2->vk_service_key);
	$tpl->set("{steam_key}", $conf2->steam_key);
	$tpl->set("{fb_id}", $conf2->fb_id);
	$tpl->set("{fb_key}", $conf2->fb_key);
	$tpl->set("{vk_admin_id}", configs()->vk_admin_id);
	$tpl->set("{vk_group_id}", configs()->vk_group_id);
	$tpl->set("{copyright_key}", configs()->copyright_key);
	$tpl->set("{chat_number}", $chat['count']);
	$tpl->set("{protocol}", configs()->protocol);
	$tpl->compile( 'content' );
	$tpl->clear();

	$tpl->load_template('bottom.tpl');
	$tpl->compile( 'content' );
	$tpl->clear();
}