<div class="page">
	{if({needToRemoveInstaller} || {needToGiveAccessToRewriteFiles} || {needToCreateLogsDirectory} || {needToCreateUpdatesDirectory})}
	<div class="col-md-12">
		<div class="bs-callout bs-callout-error">
			<h5>Важно!</h5>

            {if({needToRemoveInstaller})}
				<p>В целях безопасности рекомендуется удалить папку <b>modules/install/</b> или <a href="../dell.php" target="_blank" class="text-danger"><b>Перейдите СЮДА.</b></a></p>
            {/if}

            {if({needToGiveAccessToRewriteFiles})}
				<p>Необходимо установить права записи на файлы движка для PHP, в противном случае возможно некорректная работа движка</p>
            {/if}

            {if({needToCreateLogsDirectory})}
				<p>Необходимо создать папку <b>logs</b> с закрытым доступом из вне в корне движка</p>
            {/if}

            {if({needToCreateUpdatesDirectory})}
	            <p>Необходимо создать папку <b>modules/updates</b> в корне движка</p>
            {/if}
		</div>
		<br>
	</div>
	{/if}

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
				<hr>

				<b>Пароль админ панели</b>
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button" onclick="edit_site_password();">Изменить</button>
					</span>
					<input type="password" class="form-control" id="old_password" autocomplete="off" placeholder="Введите текущий пароль">
					<input type="password" class="form-control" id="password" autocomplete="off" placeholder="Введите новый пароль">
					<input type="password" class="form-control" id="password2" autocomplete="off" placeholder="Повторите">
				</div>
				<div id="edit_password_result"></div>
				<hr>

				<b>Режим разработчика</b>
				<div class="input-group">
					<div class="input-group-btn" data-toggle="buttons">
						<label class="btn btn-default {developer_mode}" onclick="developer_mode_on('1');">
							<input type="radio">
							Включить
						</label>

						<label class="btn btn-default {developer_mode2}" onclick="developer_mode_on('2');">
							<input type="radio">
							Выключить
						</label>
					</div>
					<input type="password" class="form-control" id="dev_key" maxlength="32" value="{dev_key}" placeholder="Введите ключ">
				</div>
				<div class="bs-callout bs-callout-info mt-10">
					<p><a target="_blank" href="https://gamecms.ru/wiki/developer_mode"><span class="glyphicon glyphicon-link"></span> Как получить ключ и что это такое?</a></p>
				</div>
				<input type="hidden" class="form-control" id="host" value="{host}">
			</div>
		</div>

		<script>get_main_info();</script>

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

				<b>Стандартная регистрация</b><br>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {if($conf->standard_registration)} active {/if}" onclick="change_value('config','standard_registration','1','1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {if(!$conf->standard_registration)} active {/if}" onclick="change_value('config','standard_registration','0','1');">
						<input type="radio">
						Выключить
					</label>
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
				<div class="bs-callout bs-callout-info mt-10">
					<h5>Инструкция</h5>
					<p><a target="_blank" href="https://gamecms.ru/wiki/avtorizatsiya-cherez-VK"><span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции</a></p>
				</div>
				<hr>

				<div class="row">
					<div class="col-md-4">
						<b>Регистрация через Steam</b><br>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-default {sact}" onclick="change_value('config__secondary','steam_api','1','1','steam_key');">
								<input type="radio">
								Включить
							</label>

							<label class="btn btn-default {sact2}" onclick="change_value('config__secondary','steam_api','2','1');">
								<input type="radio">
								Выключить
							</label>
						</div>
					</div>
					<div class="col-md-4">
						<b>Автозаполнение STEAM ID</b><br>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-default {if('{auto_steam_id_fill}' == '1')} active {/if}" onclick="change_value('config__secondary','auto_steam_id_fill','1','1');">
								<input type="radio">
								Включить
							</label>

							<label class="btn btn-default {if('{auto_steam_id_fill}' == '2')} active {/if}" onclick="change_value('config__secondary','auto_steam_id_fill','2','1');">
								<input type="radio">
								Выключить
							</label>
						</div>
					</div>
					<div class="col-md-4">
						<b>Формат STEAM ID</b><br>
						<select class="form-control" onchange="change_value('config__secondary','steam_id_format',$(this).val(),'1');">
							<option value="0" {if('{steam_id_format}' == '0')} selected {/if}>
								STEAM_0:X:XXXXXX (cs1.6)
							</option>
							<option value="1" {if('{steam_id_format}' == '1')} selected {/if}>
								STEAM_1:X:XXXXXX (cs:go)
							</option>
						</select>
					</div>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_steam_api();">Изменить</button>
					</span>
					<input value="{steam_key}" type="text" class="form-control" id="steam_key" maxlength="200" autocomplete="off" placeholder="Ключ">
				</div>
				<div id="edit_steam_result"></div>
				<div class="bs-callout bs-callout-info mt-10">
					<h5>Инструкция</h5>
					<p><a target="_blank" href="https://gamecms.ru/wiki/avtorizatsiya-cherez-steam"><span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции</a></p>
				</div>
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
				<div class="bs-callout bs-callout-info mt-10">
					<h5>Инструкция</h5>
					<p><a target="_blank" href="https://gamecms.ru/wiki/avtorizatsiya-cherez-fb"><span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции</a></p>
				</div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Пагинатор</div>
			<div class="panel-body">
				<small class="c-868686">Элементов на странице всех пользователей</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="users_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице всех пользователей" value="{users_lim}">
				</div>
				<small class="c-868686">Элементов на странице банлиста</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="bans_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице банлиста" value="{bans_lim}">
				</div>
				<small class="c-868686">Элементов на странице заявок на разбан</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="bans_lim2" maxlength="3" autocomplete="off" placeholder="Элементов на странице заявок на разбан" value="{bans_lim2}">
				</div>
				<small class="c-868686">Элементов на странице мутлиста</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="muts_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице мутлиста" value="{muts_lim}">
				</div>
				<small class="c-868686">Элементов на странице каталога новостей</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="news_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице каталога новостей" value="{news_lim}">
				</div>
				<small class="c-868686">Элементов на странице статистики</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="stats_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице статистики" value="{stats_lim}">
				</div>
				<small class="c-868686">Элементов на странице жалоб</small>
				<div class="input-group w-100">
					<input type="number" class="form-control" id="complaints_lim" maxlength="3" autocomplete="off" placeholder="Элементов на странице жалоб" value="{complaints_lim}">
				</div>
				<button class="btn btn-default mt-10" type="button" onclick="edit_paginator();">Изменить</button>
				<div id="edit_paginator_result"></div>
			</div>
		</div>
	</div>

	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">Виджеты</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-4">
						<b>«Кот»</b>
						<div class="form-group">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-default {cote_act}" onclick="change_value('config','cote','1','1');">
									<input type="radio">
									Вкл
								</label>

								<label class="btn btn-default {cote_act2}" onclick="change_value('config','cote','2','1');">
									<input type="radio">
									Выкл
								</label>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<b>«Новогодняя мишура»</b>
						<div class="form-group">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-default {new_year_act}" onclick="change_value('config','new_year','1','1');">
									<input type="radio">
									Вкл
								</label>

								<label class="btn btn-default {new_year_act2}" onclick="change_value('config','new_year','2','1');">
									<input type="radio">
									Выкл
								</label>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<b>«Георгиевская лента»</b>
						<div class="form-group">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-default {win_day_act}" onclick="change_value('config','win_day','1','1');">
									<input type="radio">
									Вкл
								</label>

								<label class="btn btn-default {win_day_act2}" onclick="change_value('config','win_day','2','1');">
									<input type="radio">
									Выкл
								</label>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<b>Виджет «Сегодня нас посетили»</b>
				<div class="form-group">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default {last_online_act}" onclick="change_value('config','disp_last_online','1','1');">
							<input type="radio">
							Включить
						</label>
						<label class="btn btn-default {last_online_act2}" onclick="change_value('config','disp_last_online','2','1');">
							<input type="radio">
							Выключить
						</label>
					</div>
				</div>
				<hr>
				<b>Виджет «Последние новости»</b>
				<div class="input-group">
					<div class="input-group-btn" data-toggle="buttons">
						<label class="btn btn-default {nact}" onclick="change_value('config','show_news','3','1'); $('#show_news').val('3');">
							<input type="radio">
							Включить
						</label>
						<label class="btn btn-default {nact2}" onclick="change_value('config','show_news','0','1'); $('#show_news').val('0');">
							<input type="radio">
							Выключить
						</label>
					</div>
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_show_news();">Изменить</button>
					</span>
					<input type="number" class="form-control" id="show_news" maxlength="1" autocomplete="off" value="{show_news}">
				</div>
				<small class="f-r c-868686">Количество выводимых новостей</small>
				<br>
				<hr>
				<b>Виджет «Последние события»</b>
				<div class="input-group">
					<div class="input-group-btn" data-toggle="buttons">
						<label class="btn btn-default {eact}" onclick="change_value('config','show_events','3','1'); $('#show_events').val('3');">
							<input type="radio">
							Включить
						</label>
						<label class="btn btn-default {eact2}" onclick="change_value('config','show_events','0','1'); $('#show_events').val('0');">
							<input type="radio">
							Выключить
						</label>
					</div>
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_show_events();">Изменить</button>
					</span>
					<input type="number" class="form-control" id="show_events" maxlength="1" autocomplete="off" value="{show_events}">
				</div>
				<small class="f-r c-868686">Количество выводимых событий</small>
				<br>
				<hr>
				<b>Виджет «Топ донатеров»</b>
				<div class="input-group">
					<div class="input-group-btn" data-toggle="buttons">
						<label class="btn btn-default {topDonatorsWidgetIsOn}" onclick="change_value('config','top_donators','1','1');">
							<input type="radio">
							Включить
						</label>
						<label class="btn btn-default {topDonatorsWidgetIsOff}" onclick="change_value('config','top_donators','2','1');">
							<input type="radio">
							Выключить
						</label>
					</div>
				</div>

				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button" onclick="editTopDonatorsWidget();">Изменить</button>
					</span>
					<select id="top_donators_show_sum" class="form-control">
						<option value="1" {if('{top_donators_show_sum}' == '1')} selected {/if}>Отображать сумму доната</option>
						<option value="2" {if('{top_donators_show_sum}' == '2')} selected {/if}>Не отображать сумму доната</option>
					</select>
					<input value="{top_donators_count}" type="text" class="form-control" id="top_donators_count" maxlength="2" placeholder="Количество выводимых донатеров">
				</div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Виджеты Вконтакте/Facebook</div>
			<div class="panel-body mb-0">
				<p><b>Тип виджетов</b></p>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {widgets_type_1}" onclick="switch_widgets_type('1');">
						<input type="radio">
						Вконтакте
					</label>

					<label class="btn btn-default {widgets_type_2}" onclick="switch_widgets_type('2');">
						<input type="radio">
						Facebook
					</label>
				</div>
				<hr>
				<p><b>Группа(ы)</b></p>
				<div class="btn-group" data-toggle="buttons" id="vk_group_selector">
					<label class="btn btn-default {vk_group}" onclick="switch_widget('1', '1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {vk_group2}" onclick="switch_widget('2', '1');">
						<input type="radio">
						Выключить
					</label>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_vk_group_id();">Изменить</button>
					</span>
					<input value="{vk_group_id}" type="text" class="form-control" id="vk_group_id" maxlength="80" autocomplete="off" placeholder="ID группы (если несколько, то через запятую без пробелов)">
				</div>
				<small class="f-r c-868686">ID группы (если несколько, то через запятую без пробелов)</small>
				<div id="edit_vk_group_result"><br></div>
				<hr>
				<p><b>Администратор(ы)</b></p>
				<div class="btn-group" data-toggle="buttons" id="vk_admin_selector">
					<label class="btn btn-default {vk_admin}" onclick="switch_widget('1', '2');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {vk_admin2}" onclick="switch_widget('2', '2');">
						<input type="radio">
						Выключить
					</label>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_vk_admin_id();">Изменить</button>
					</span>
					<input value="{vk_admin_id}" type="text" class="form-control" id="vk_admin_id" maxlength="80" autocomplete="off" placeholder="ID пользователя (если несколько, то через запятую без пробелов)">
				</div>
				<small class="f-r c-868686">ID пользователя (если несколько, то через запятую без пробелов)</small>
				<div id="edit_vk_admin_result" class="mb-0"></div>
			</div>
		</div>

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

		<div class="panel panel-default">
			<div class="panel-heading">Главный администратор</div>
			<div class="panel-body mb-0">
				<b>Укажите id профиля главного администратора(ему будут приходить уведомления о покупке прав пользователями)</b><br>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_admins_ids();">Изменить</button>
					</span>
					<input value="{admins_ids}" type="text" class="form-control" id="admins_ids" maxlength="80" autocomplete="off" placeholder="ID пользователя (если несколько, то через запятую без пробелов)">
				</div>
				<small class="f-r c-868686">ID пользователя (если несколько, то через запятую без пробелов)</small>
				<div id="edit_admins_ids_result"><br></div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Выключение сайта</div>
			<div class="panel-body mb-0">
				<b>При выключении сайта, он будет доступен лишь пользователю, авторизованному в админ центре</b><br>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {off_act2}" onclick="change_value('config','off','2','1');">
						<input type="radio">
						Включить сайт
					</label>

					<label class="btn btn-default {off_act}" onclick="change_value('config','off','1','1');">
						<input type="radio">
						Выключить сайт
					</label>
				</div>
				<div class="input-group mt-10">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_off_message();">Изменить</button>
					</span>
					<input value="{off_message}" type="text" class="form-control" id="off_message" maxlength="250" autocomplete="off" placeholder="Сообщение пользователям">
				</div>
				<div id="edit_off_message_result"></div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Протокол, используемый сайтом</div>
			<div class="panel-body">
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_protocol();">Изменить</button>
					</span>
					<select id="protocol" class="form-control">
						<option value="1" {if('{protocol}' == '1')} selected {/if}>Определять автоматически</option>
						<option value="2" {if('{protocol}' == '2')} selected {/if}>HTTP</option>
						<option value="3" {if('{protocol}' == '3')} selected {/if}>HTTPS</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="description" class="modal fade">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"> Описание
			</div>
			<div class="modal-body" id="update_description">
				<center><img src="{site_host}templates/admin/img/loader.gif"></center>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
			</div>
		</div>
	</div>
</div>
