<?php
	if(!is_admin()){
		show_error_page('not_adm');
	}

	$tpl->load_template('elements/title.tpl');
	$tpl->set("{title}", $page->title);
	$tpl->set("{name}", $conf->name);
	$tpl->compile( 'title' );
	$tpl->clear();

	$tpl->load_template('head.tpl');
	$tpl->set("{title}", $tpl->result['title']);
	$tpl->set("{image}", $page->image);
	$tpl->set("{other}", '<script src="{site_host}modules/editors/tinymce/tinymce.min.js"></script>');
	$tpl->set("{token}", $token);
	$tpl->set("{cache}", $conf->cache);
	$tpl->set("{template}", $conf->template);
	$tpl->set("{site_host}", $site_host);
	$tpl->compile( 'content' );
	$tpl->clear();

	$tpl->load_template('top.tpl');
	$tpl->set("{site_host}", $site_host);
	$tpl->set("{site_name}", $conf->name);
	$tpl->compile( 'content' );
	$tpl->clear();

	$tpl->load_template('menu.tpl');
	$tpl->set("{site_host}", $site_host);
	$tpl->compile( 'content' );
	$tpl->clear();

	$nav = array(
		$PI->to_nav('admin', 0, 0),
		$PI->to_nav('admin_page_verification', 1, 0)
	);
	$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

	$tpl->load_template('page_top.tpl');
	$tpl->set("{nav}", $nav);
	$tpl->compile( 'content' );
	$tpl->clear();
	
		/* Verifications List */
	$v = $injSql->query("SELECT * FROM `users__application-list` WHERE 1");
	
	if($injSql->rows($v)) {
		while($r = $injSql->arr($v)) {
			if($r['status'] != 2)
				continue;
			
			$q = $injSql->fqr(["SELECT * FROM `users` WHERE `id`='{$r['user_id']}'"]);
			
			$vList .= "<tr><td>{$r['id']}</td><td><a href=\"/profile?id={$q['id']}\" title=\"Посетить профиль\">{$q['login']}</a></td><td>".date("d.m.Y в H:s", $r['timeleft'])."</td><td colspan=\"10\"><button class=\"btn btn-sm btn-success\" OnClick=\"enable_verification({$r['id']}, 1, {$r['user_id']});\">Одобрить</button> | <button class=\"btn btn-sm btn-danger\" OnClick=\"enable_verification({$r['id']}, 0, {$r['user_id']});\">Отказать</button></td></tr>";
		}			
	}
	
		/* Last verification list*/
	$v = $injSql->query("SELECT * FROM `users__application-list` ORDER BY id DESC LIMIT 3");
	
	if($injSql->rows($v)) {
		while($r = $injSql->arr($v)) {
			if($r['status'] == 2)
				continue;
			
			$q = $injSql->fqr(["SELECT * FROM `users` WHERE `id`='{$r['user_id']}'"]);
			
			switch($r['status']) {
				case 1: 
					$s_tatus = '<td class="bg-success">Одобрено</td>';
					break;
				case 0:
					$s_tatus = '<td class="bg-danger">Отказано</td>';
					break;
			}
			
			
			$vLastList .= "<tr><td>{$r['id']}</td><td><a href=\"/profile?id={$q['id']}\" title=\"Посетить профиль\">{$q['login']}</a></td><td>".date('d.m.Y H:i', $r['timeleft'])."</td>{$s_tatus}</tr>";
		}			
	}
	
	$cfg_secondary = $injSql->fqr(['SELECT * FROM `config__secondary` LIMIT 1']);
	
	$tpl->load_template('verifications.tpl');
	$tpl->set("{site_host}", $site_host);
	$tpl->set("{list_verifications}", empty($vList) ? "<tr><td colspan=\"10\">Заявки отсутствуют.</td></tr>" : $vList);
	$tpl->set("{last_list_verifications}", empty($vLastList) ? "<tr><td colspan=\"10\">Заявки отсутствуют.</td></tr>" : $vLastList);
	$tpl->set("{points_category}", $product_category);
	$tpl->set("{product_points}", $product_list);
	$tpl->set("{timeleft}", $cfg_secondary['verification_timeleft']);
	$tpl->set("{img-verification}", $cfg_secondary['verification_image']);
	
	$tpl->compile( 'content' );
	$tpl->clear();

	$tpl->load_template('bottom.tpl');
	$tpl->set("{site_host}", $site_host);
	$tpl->compile( 'content' );
	$tpl->clear();