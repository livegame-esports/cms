<?php
if(!is_admin()) {
	show_error_page('not_adm');
}

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile('title');
$tpl->clear();

$STH = pdo()->query("SELECT template FROM config LIMIT 1");
$STH->setFetchMode(PDO::FETCH_OBJ);
$row = $STH->fetch();
if(empty($_COOKIE['template'])) {
	configs()->template = $row->template;
}

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", getLibAssets(['codemirror', 'fixedWidth']));
$tpl->set("{token}", token());
$tpl->set("{cache}", configs()->cache);
$tpl->set("{template}", configs()->template);
$tpl->compile('content');
$tpl->clear();

$tpl->load_template('top.tpl');
$tpl->set("{site_name}", configs()->name);
$tpl->compile('content');
$tpl->clear();

$tpl->load_template('menu.tpl');
$tpl->compile('content');
$tpl->clear();

$nav = [
	$PI->to_nav('admin', 0, 0),
	$PI->to_nav('admin_template', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile('content');
$tpl->clear();

$templates        = "";
$templates_mobile = "";
if(!isset($_COOKIE['template'])) {
	$templates_prsonal = "<option value='0' selected>Не задан</option>";
} else {
	$templates_prsonal = "<option value='0'>Не задан</option>";
}

foreach(tpl()->getTemplates() as $templateName => $templatePath) {
	if($templateName != 'admin') {
		if(isset($_SESSION['original_template'])) {
			$original_template = $_SESSION['original_template'];
		} else {
			$original_template = configs()->template;
		}

		if($original_template == $templateName) {
			$templates .= "<option value='" . $templateName . "' selected>" . $templateName . "</option>";
		} else {
			$templates .= "<option value='" . $templateName . "'>" . $templateName . "</option>";
		}

		if(configs()->template_mobile == $templateName) {
			$templates_mobile .= "<option value='" . $templateName . "' selected>" . $templateName . "</option>";
		} else {
			$templates_mobile .= "<option value='" . $templateName . "'>" . $templateName . "</option>";
		}

		if(isset($_COOKIE['template']) && $_COOKIE['template'] == $templateName) {
			$templates_prsonal .= "<option value='" . $templateName . "' selected>" . $templateName . "</option>";
		} else {
			$templates_prsonal .= "<option value='" . $templateName . "'>" . $templateName . "</option>";
		}
	}
}

$tpl->load_template('template.tpl');
$tpl->set("{template}", configs()->template);
$tpl->set("{templates}", $templates);
$tpl->set("{templates_mobile}", $templates_mobile);
$tpl->set("{templates_prsonal}", $templates_prsonal);
$tpl->set("{token}", token());
$tpl->set("{template_tpls}", renderTree("templates/" . configs()->template . "/tpl/", "html"));
$tpl->set("{template_css}", renderTree("templates/" . configs()->template . "/css/", "css"));
$tpl->set("{template_imgs}", renderTree("templates/" . configs()->template . "/img/", "img"));
if(file_exists("templates/" . configs()->template . "/images/")) {
	$tpl->set("{template_images}", renderTree("templates/" . configs()->template . "/images/", "img", 1));
	$tpl->set("{have_images}", "1");
} else {
	$tpl->set("{template_images}", "");
	$tpl->set("{have_images}", "0");
}
$tpl->set("{engine_avatars}", renderTree("files/avatars/", "img", 1));
$tpl->set("{engine_forums_imgs}", renderTree("files/forums_imgs/", "img", 1));
$tpl->set("{engine_maps_imgs}", renderTree("files/maps_imgs/", "img", 1));
$tpl->set("{engine_news_imgs}", renderTree("files/news_imgs/", "img", 1));
$tpl->set("{engine_ranks_imgs}", renderTree("files/ranks_imgs/", "img", 1));
$tpl->set("{engine_merchants}", renderTree("files/merchants/", "img", 1));
$act = get_active(configs()->caching, 2);
$tpl->set("{caching_act}", $act[0]);
$tpl->set("{caching_act2}", $act[1]);
$tpl->compile('content');
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile('content');
$tpl->clear();