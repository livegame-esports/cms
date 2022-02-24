<?php
if(!is_admin()){
	show_error_page('not_adm');
}

global $tpl;
global $PI;

$tpl->load_template('elements/title.tpl');
$tpl->set("{title}", page()->title);
$tpl->set("{name}", configs()->name);
$tpl->compile( 'title' );
$tpl->clear();

$tpl->load_template('head.tpl');
$tpl->set("{title}", $tpl->result['title']);
$tpl->set("{image}", page()->image);
$tpl->set("{other}", getLibAssets(['dropzone', 'gstatic']));
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
	$PI->to_nav('admin_bank', 1, 0)
];
$nav = $tpl->get_nav($nav, 'elements/nav_li.tpl', 1);

$tpl->load_template('page_top.tpl');
$tpl->set("{nav}", $nav);
$tpl->compile( 'content' );
$tpl->clear();

$bank1 = configs()->bank;
$bank2 = 0;
$bank3 = 0;
$STH = pdo()->prepare("SELECT `shilings` FROM `money__actions` WHERE `type`=:type and MONTH(`date`) = MONTH(NOW()) AND YEAR(`date`) = YEAR(NOW())"); $STH->setFetchMode(PDO::FETCH_OBJ);
$STH->execute(array( ':type' => 1 ));
while($row = $STH->fetch()) { 
	$bank2 = $bank2 + $row->shilings;
}
$STH = pdo()->prepare("SELECT `shilings` FROM `money__actions` WHERE `type`=:type and MONTH(`date`) = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)) and YEAR(`date`) = YEAR(DATE_ADD(NOW(), INTERVAL -1 MONTH))"); $STH->setFetchMode(PDO::FETCH_OBJ);
$STH->execute(array( ':type' => 1 ));
while($row = $STH->fetch()) { 
	$bank3 = $bank3 + $row->shilings;
}

$STH = pdo()->query("SELECT * FROM `config__prices` LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);  
$bank_conf = $STH->fetch();
$discount = $bank_conf->discount;

$STH = pdo()->query("SELECT `return_services`, `bonuses`, `stand_balance`, `bad_nicks_act`, `min_amount` FROM `config__secondary` LIMIT 1"); $STH->setFetchMode(PDO::FETCH_OBJ);
$row = $STH->fetch();

$tpl->load_template('bank.tpl');

$act = get_active(configs()->cont, 2);
$tpl->set("{act}", $act[0]);
$tpl->set("{act2}", $act[1]);

$act = get_active($row->return_services, 2);
$tpl->set("{rs_act}", $act[0]);
$tpl->set("{rs_act2}", $act[1]);

$act = get_active($bank_conf->referral_program, 2);
$tpl->set("{ref_act}", $act[0]);
$tpl->set("{ref_act2}", $act[1]);

$act = get_active($row->bonuses, 2);
$tpl->set("{bns_act}", $act[0]);
$tpl->set("{bns_act2}", $act[1]);

$tpl->set("{referral_percent}", $bank_conf->referral_percent );
$tpl->set("{col_pass}", configs()->col_pass);
$tpl->set("{discount}", $discount);
$tpl->set("{col_nick}", configs()->col_nick);
$tpl->set("{col_type}", configs()->col_type);
$tpl->set("{bank1}", $bank1);
$tpl->set("{bank2}", $bank2);
$tpl->set("{bank3}", $bank3);
$tpl->set("{price1}", $bank_conf->price1);
$tpl->set("{price2}", $bank_conf->price2);
$tpl->set("{price3}", $bank_conf->price3);
$tpl->set("{price2_1}", $bank_conf->price2_1);
$tpl->set("{price2_2}", $bank_conf->price2_2);
$tpl->set("{price2_3}", $bank_conf->price2_3);
$tpl->set("{price4}", $bank_conf->price4);
$tpl->set("{stand_balance}", $row->stand_balance);
$tpl->set("{min_amount}", $row->min_amount);
$tpl->compile( 'content' );
$tpl->clear();

$tpl->load_template('bottom.tpl');
$tpl->compile( 'content' );
$tpl->clear();