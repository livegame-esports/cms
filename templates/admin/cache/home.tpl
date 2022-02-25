
<!-- Start home.tpl -->
<div class="page">
	<?php if({needToRemoveInstaller} || {needToGiveAccessToRewriteFiles} || {needToCreateLogsDirectory} || {needToCreateUpdatesDirectory}): ?>
	<div class="col-md-12">
		<div class="bs-callout bs-callout-error">
			<h5>Важно!</h5>

			<?php if({needToRemoveInstaller}): ?>
			<p>В целях безопасности рекомендуется удалить папку <b>modules/install/</b> или <a href="../dell.php" target="_blank" class="text-danger"><b>Перейдите СЮДА.</b></a></p>
			<?php endif; ?>

			<?php if({needToGiveAccessToRewriteFiles}): ?>
			<p>Необходимо установить права записи на файлы движка для PHP, в противном случае возможно некорректная работа движка</p>
			<?php endif; ?>

			<?php if({needToCreateLogsDirectory}): ?>
			<p>Необходимо создать папку <b>logs</b> с закрытым доступом из вне в корне движка</p>
			<?php endif; ?>

			<?php if({needToCreateUpdatesDirectory}): ?>
			<p>Необходимо создать папку <b>modules/updates</b> в корне движка</p>
			<?php endif; ?>
		</div>
		<br>
	</div>
	<?php endif; ?>

	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">Основные настройки</div>
			<div class="panel-body">

				<b>Название сайта</b>
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_site_name();">Изменить</button>
					</span>
					<input type="text" class="form-control" id="site_name" maxlength="255" autocomplete="off" value="{site_name}">
				</div>
				<div id="edit_site_name_result"></div>
				

				
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Регистрация пользователей</div>
			<div class="panel-body mb-0">
				<b>Требовать подтверждение e-mail'a при регистрации</b>
				<div class="form-group">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default {cact}" onclick="change_value('config','conf_us','1','1');">
							<input type="radio">
							Да
						</label>

						<label class="btn btn-default {cact2}" onclick="change_value('config','conf_us','2','1');">
							<input type="radio">
							Нет
						</label>
					</div>
				</div>
				<hr>

				<b>Сообщение о согласии с политикой конфиденциальности</b>
				<div class="form-group">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default {ppact}" onclick="change_value('config','privacy_policy','1','1');">
							<input type="radio">
							Да
						</label>

						<label class="btn btn-default {ppact2}" onclick="change_value('config','privacy_policy','2','1');">
							<input type="radio">
							Нет
						</label>
					</div>
				</div>
				<hr>

				

				<b>Регистрация через Вконтакте</b><br>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {vact}" onclick="change_value('config__secondary','vk_api','1','1','vk_id,vk_key,vk_service_key');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {vact2}" onclick="change_value('config__secondary','vk_api','2','1');">
						<input type="radio">
						Выключить
					</label>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button" onclick="edit_vk_api();">Изменить</button>
					</span>
					<input value="{vk_id}" type="text" class="form-control" id="vk_id" maxlength="100" autocomplete="off" placeholder="ID приложения">
					<input value="{vk_key}" type="text" class="form-control" id="vk_key" maxlength="100" autocomplete="off" placeholder="Защищенный ключ">
					<input value="{vk_service_key}" type="text" class="form-control" id="vk_service_key" maxlength="100" autocomplete="off" placeholder="Сервисный ключ доступа">
				</div>
				<div id="edit_vk_result"></div>
				
				<hr>

				

				<b>Регистрация через facebook</b><br>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {fbact}" onclick="change_value('config__secondary','fb_api','1','1','fb_id,fb_key');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {fbact2}" onclick="change_value('config__secondary','fb_api','2','1');">
						<input type="radio">
						Выключить
					</label>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button" onclick="edit_fb_api();">Изменить</button>
					</span>
					<input value="{fb_id}" type="text" class="form-control" id="fb_id" maxlength="100" autocomplete="off" placeholder="ID приложения">
					<input value="{fb_key}" type="text" class="form-control" id="fb_key" maxlength="100" autocomplete="off" placeholder="Секрет приложения">
				</div>
				<div id="edit_fb_result"></div>
				
			</div>
		</div>

		
	</div>

	<div class="col-md-6">
		
		

		<div class="panel panel-default">
			<div class="panel-heading">Часовой пояс сайта</div>
			<div class="panel-body mb-0">
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_site_time_zone();">Изменить</button>
					</span>
					<select id="time_zone" class="form-control">
						{time_zones}
					</select>
				</div>
				<div id="edit_time_zone_result"></div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Очистка движка</div>
			<div class="panel-body">
				<b>Удалить все сообщения чата (<span id="chat_number">{chat_number}</span>)</b><br>
				<button class="btn btn-default" type="button" onclick="dell_all_chat_messages();">Выполнить</button>
				<hr>
				<b>Удалить старые заявки на разбан (более 30дней назад)</b><br>
				<button class="btn btn-default" type="button" onclick="fast_admin_action('dellOldBans');">Выполнить</button>
				<hr>
				<b>Удалить старые жалобы (более 30дней назад)</b><br>
				<button class="btn btn-default" type="button" onclick="fast_admin_action('dellOldComplaints');">Выполнить</button>
				<hr>
				<b>Удалить старые тикеты (более 30дней назад)</b><br>
				<button class="btn btn-default" type="button" onclick="fast_admin_action('dellOldTickets');">Выполнить</button>
				<hr>
				<b>Сбросить кэш</b><br>
				<button class="btn btn-default" type="button" onclick="fast_admin_action('dell_cache');">Выполнить</button>
			</div>
		</div>
		
		
		
	</div>
</div>

<!-- End home.tpl -->
