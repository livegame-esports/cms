<div class="col-lg-9 order-is-first">
	<div class="block">
		<div class="with_code">{content}</div>
	</div>
</div>
<div class="col-lg-3 order-is-last">
	<?php if(is_auth()): ?>
		<div class="block">
	<div class="block_head">
		Навигация
	</div>
	<div class="vertical-navigation">
		<ul>
			<?php for($i=0; $i < count($vertical_menu); $i++): ?>  
			<li>
				<a href="<?php echo $vertical_menu[$i]['link']; ?>"><?php echo $vertical_menu[$i]['name']; ?></a>
			</li>
			<?php endfor; ?>
		</ul>
	</div>
</div>
		<div class="block">
	<div class="block_head">
		Сейчас онлайн <span id="users_online_number"></span>
	</div>
	<div id="online_users">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "online_users")) { $tpl->show($CE->online_users()); } unset($CE); } ?>
	</div>
</div>
	<?php else: ?>
		<div class="block">
	<div class="block_head">
		Авторизация
	</div>

	<button class="btn btn-primary btn-block" data-toggle="modal" data-target="#authorization">Войти на сайт</button>
	<?php if($auth_api->vk_api == 1): ?>
		<a class="btn btn-outline-primary btn-block" href="#" id="vk_link" title="Войти через Вконтакте"><i class="m-icon icon-vk"></i> &nbsp Войти через ВК</a>
	<?php endif; ?>
	<button class="btn btn-outline-primary btn-block" data-toggle="modal" data-target="#registration">Зарегистрироваться</button>
</div>
		<div class="block">
	<div class="block_head">
		Сейчас онлайн <span id="users_online_number"></span>
	</div>
	<div id="online_users">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "online_users")) { $tpl->show($CE->online_users()); } unset($CE); } ?>
	</div>
</div>
	<?php endif; ?>
</div>