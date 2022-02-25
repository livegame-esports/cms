
<!-- Start main.tpl -->
<?php 
$theme = '1'; 
$monitoringType = '1'; 
$countOfServersDisplayed = '3'; 
$slider[0]['title'] = 'Магазин - продажа услуг в онлайн режиме.'; 
$slider[0]['content'] = 'В магазине Вы можете оплатить любую из представленных услуг и сразу же воспользоваться ею на игровом сервере.'; 
$slider[0]['image'] = '../templates/standart/img/slide-1.jpg'; 
$slider[0]['link'] = '../store'; 
$slider[1]['title'] = 'Забанили, но Вы считаете себя невиновным?'; 
$slider[1]['content'] = 'Раздел разбана поможет Вам обжаловать несправедливый бан. Оформите заявку, приложите скриншоты и ожидайте разбана, если Вы невиновны.'; 
$slider[1]['image'] = '../templates/standart/img/slide-2.jpg'; 
$slider[1]['link'] = '../bans/'; 
$slider[2]['title'] = 'Есть вопрос? Обратитесь к администрации.'; 
$slider[2]['content'] = 'Если у Вас имеются вопросы, Вы можете открыть тикет в разделе поддержки и своевременно получить ответ администрации на него.'; 
$slider[2]['image'] = '../templates/standart/img/slide-3.jpg'; 
$slider[2]['link'] = '../support/'; 
$vertical_menu[0]['name'] = 'Магазин услуг'; 
$vertical_menu[0]['link'] = '../store'; 
$vertical_menu[1]['name'] = 'Новости проекта'; 
$vertical_menu[1]['link'] = '../news/'; 
$vertical_menu[2]['name'] = 'Форум'; 
$vertical_menu[2]['link'] = '../forum/'; 
$vertical_menu[3]['name'] = 'Пользователи'; 
$vertical_menu[3]['link'] = '../users'; 
$vertical_menu[4]['name'] = 'События проекта'; 
$vertical_menu[4]['link'] = '../events'; 
$vertical_menu[5]['name'] = 'Поддержка'; 
$vertical_menu[5]['link'] = '../support/'; 
$vertical_menu[6]['name'] = 'Жалобы'; 
$vertical_menu[6]['link'] = '../complaints/'; 
$vertical_menu_2[0]['name'] = 'Главная страница'; 
$vertical_menu_2[0]['link'] = '../'; 
$vertical_menu_2[1]['name'] = 'Новости проекта'; 
$vertical_menu_2[1]['link'] = '../news/'; 
$vertical_menu_2[2]['name'] = 'Магазин услуг'; 
$vertical_menu_2[2]['link'] = '../store'; 
$vertical_menu_2[3]['name'] = 'Форум'; 
$vertical_menu_2[3]['link'] = '../forum/'; 
$vertical_menu_2[4]['name'] = 'Поддержка'; 
$vertical_menu_2[4]['link'] = '../support/'; 
$vertical_menu_3[0]['name'] = 'Пользователи'; 
$vertical_menu_3[0]['link'] = '../users'; 
$vertical_menu_3[1]['name'] = 'Администраторы'; 
$vertical_menu_3[1]['link'] = '../admins'; 
$vertical_menu_3[2]['name'] = 'Список банов'; 
$vertical_menu_3[2]['link'] = '../banlist'; 
$vertical_menu_3[3]['name'] = 'Заявки на разбан'; 
$vertical_menu_3[3]['link'] = '../bans'; 
$vertical_menu_3[4]['name'] = 'Игровая статистика'; 
$vertical_menu_3[4]['link'] = '../stats'; 
$vertical_menu_4[0]['name'] = 'Об обработке персональных данных'; 
$vertical_menu_4[0]['link'] = '../processing-of-personal-data'; 
$vertical_menu_4[1]['name'] = 'Политика конфиденциальности'; 
$vertical_menu_4[1]['link'] = '../privacy-policy'; 
$vertical_menu_4[2]['name'] = 'Правила проекта'; 
$vertical_menu_4[2]['link'] = '../pages/rules'; 
$vertical_menu_4[3]['name'] = 'База знаний'; 
$vertical_menu_4[3]['link'] = '../pages/baza_znaniy'; 
$footer_banners[0]['link'] = 'https://gamecms.ru/'; 
$footer_banners[0]['img'] = 'https://via.placeholder.com/88x31.jpg'; 
$footer_banners[1]['link'] = 'https://gamecms.ru/'; 
$footer_banners[1]['img'] = 'https://via.placeholder.com/88x31.jpg'; 
$footer_banners[2]['link'] = 'https://gamecms.ru/'; 
$footer_banners[2]['img'] = 'https://via.placeholder.com/88x31.jpg'; 
$footer_description = 'Рады видеть Вас на нашем игровом проекте, посвященном легендарной игре Counter-Strike. На наших серверах Вы можете насладиться приятной игрой в кругу хороших игроков и под руководством отзывчивой администрации.'; 

 ?>
<!DOCTYPE html>
<html lang="ru">
	<?php if($conf->off == 1 && !is_admin()): ?>
		
<!-- Start off_site.tpl -->
<?php $off_data = db_get_info($pdo, "off_message", "config__secondary", 'null', 0); ?>
<head>
	<meta charset="UTF-8">
	<title><?php echo $conf->name; ?></title>
	<style>
		html {
			height: 100%;
			background: rgb(221, 221, 221) none repeat scroll 0% 0%;
		}
		h1 {
			margin-top: 20%;
			text-align: center;
			font-family: arial;
			font-size: 35px;
		}
	</style>
</head>
<body>
	<h1><?php echo $off_data[0]['off_message']; ?></h1>
<!-- End off_site.tpl -->

	<?php else: ?>
		{content}
	<?php endif; ?>
</html>
<!-- End main.tpl -->
