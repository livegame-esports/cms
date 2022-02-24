<script>
	var pm_interval;
	var check_mess;
</script>

<div class="col-lg-9 order-is-first">
	<div id="messages_sound_player"></div>
	<div class="block dialogs">
		<div class="block_head">
			Диалоги
			<button id="back_btn" class="disp-n btn btn-outline-primary btn-sm" onclick="load_dialogs();">К диалогам</button>
		</div> 
		<div id="place_for_messages">
			<div class="loader"></div>
		</div>
		<script>
			{load_dialogs}
		</script>
	</div>
</div>

<div class="col-lg-3 order-is-last">
	<div class="block">
		<div class="block_head">
			Друзья
		</div> 
		<div id="companions">
			<div class="loader"></div>
			<script>load_companions();</script>
		</div>
	</div>

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
</div>