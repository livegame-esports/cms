<div class="page">
	<div class="col-md-6">
		<div class="block">
			<div class="block_head">
				Основные настройки
			</div>

			<b>Привязка сессий админ центра к IP адресу</b>
			<div class="form-group">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {if($conf->ip_protect == 1)} active {/if}" onclick="edit_ip_protect('1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {if($conf->ip_protect == 2)} active {/if}" onclick="edit_ip_protect('2');">
						<input type="radio">
						Выключить
					</label>
				</div>
			</div>
			<small class="c-868686">Рекомендуется включить для большей безопасности админ центра</small>
			<hr>
			<b>Проверка токена</b>
			<div class="form-group">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {if($conf->token == 1)} active {/if}" onclick="change_value('config','token','1','1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {if($conf->token == 2)} active {/if}" onclick="change_value('config','token','2','1');">
						<input type="radio">
						Выключить
					</label>
				</div>
			</div>
			<small class="c-868686">Рекомендуется включить для защиты от CSRF</small>
			<hr>
			<b>Глобальный бан</b>
			<div class="form-group">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default {if($conf->global_ban == 1)} active {/if}" onclick="change_value('config','global_ban','1','1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {if($conf->global_ban == 2)} active {/if}" onclick="change_value('config','global_ban','2','1');">
						<input type="radio">
						Выключить
					</label>
				</div>
			</div>
			<div class="bs-callout bs-callout-info mt-10">
				<p>
					<a target="_blank" href="https://gamecms.ru/wiki/global_ban"><span class="glyphicon glyphicon-link"></span> Подробнее о глобальном бане</a>
				</p>
			</div>
			<div class="clearfix"></div>
		</div>

		<div class="block">
			<div class="block_head">
				Капча
			</div>

			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-default {if($conf->captcha == 1)} active {/if}" onclick="onCaptcha();">
					<input type="radio">
					Включить
				</label>

				<label class="btn btn-default {if($conf->captcha == 2)} active {/if}" onclick="offCaptcha();">
					<input type="radio">
					Выключить
				</label>
			</div>
			<div class="input-group mt-10">
				<span class="input-group-btn">
					<button class="btn btn-default pd-23-12" type="button" onclick="editCaptcha();">Изменить</button>
				</span>
				<input value="{{$conf->captcha_client_key}}" type="text" class="form-control" id="captcha_client_key" maxlength="256" autocomplete="off" placeholder="Клиентский ключ">
				<input value="{{$conf->captcha_secret}}" type="text" class="form-control" id="captcha_secret" maxlength="256" autocomplete="off" placeholder="Секретный ключ">
			</div>

			<div class="bs-callout bs-callout-info mt-10">
				<p>
					<a target="_blank" href="https://gamecms.ru/wiki/captcha"><span class="glyphicon glyphicon-link"></span> Инструкция по настройке</a>
				</p>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<div class="col-md-6">
		<div class="block">
			<div class="block_head">Ограничение на смену логина</div>

			<b>Раз в сколько дней разрешить смену логина</b>
			<div class="form-group mb-0">
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="edit_col_login();">Изменить</button>
					</span>
					<input type="text" class="form-control" id="col_login" maxlength="3" autocomplete="off" value="{{$configSecondary->col_login}}">
				</div>
				<div id="edit_col_login_result"></div>
			</div>
		</div>

		<div class="block">
			<div class="block_head">Защита от флуда</div>
			<div class="form-group">
				<div class="btn-group mb-10" data-toggle="buttons">
					<label class="btn btn-default {if($conf->protect == 1)} active {/if}" onclick="edit_protect('1');">
						<input type="radio">
						Включить
					</label>

					<label class="btn btn-default {if($conf->protect == 2)} active {/if}" onclick="edit_protect('2');">
						<input type="radio">
						Выключить
					</label>
				</div>
			</div>

			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" onclick="edit_violations_delta();">Изменить</button>
				</span>
				<input type="number" class="form-control" id="violations_delta" maxlength="5" autocomplete="off" value="{{$conf->violations_delta}}">
			</div>
			<small class="f-r c-868686">Время(в сек.), в пределах которого разрешается выполнить 1 действие.</small>
			<div id="edit_violations_delta_result"></div>
			<br>

			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" onclick="edit_violations_number();">Изменить</button>
				</span>
				<input type="number" class="form-control" id="violations_number" maxlength="5" autocomplete="off" value="{{$conf->violations_number}}">
			</div>
			<small class="f-r c-868686">Количество допустимых нарушений.</small>
			<div id="edit_violations_number_result"></div>
			<br>
		</div>

		<div class="block">
			<div class="block_head">Запрещенные слова</div>
			<button class="btn btn-default" data-target="#forbidden-words" data-toggle="modal" onclick="loadForbiddenWords();">Настройка</button>

			<div id="forbidden-words" class="modal fade">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Запрещенные слова</h4>
						</div>
						<div class="modal-body">
							<div class="bs-callout bs-callout-info mb-10 fs-14">
								Данная функция запрещает отправку определенных слов в чате, комментариях, на форуме, в личных сообщениях и т.д.<br>
							</div>

							<form id="forbidden-words-list"></form>
							<button class="btn btn-default mt-5 f-l" onclick="saveForbiddenWords();">Сохранить</button>
							<button class="btn btn-default mt-5 ml-5 f-l" onclick="addForbiddenWordInput();">Добавить</button>
							<div class="clearfix"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="block">
			<div class="block_head">Скрывать STEAM ID / IP игроков</div>

			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" onclick="editHidingPlayersId();">Изменить</button>
				</span>
				<select id="hidePlayersIdType" class="form-control">
					<option value="0" {if($conf->hide_players_id == '0')} selected {/if}>Не скрывать</option>
					<option value="1" {if($conf->hide_players_id == '1')} selected {/if}>Скрывать у всех</option>
					<option value="2" {if($conf->hide_players_id == '2')} selected {/if}>Только у админов</option>
					<option value="3" {if($conf->hide_players_id == '3')} selected {/if}>Только у игроков</option>
				</select>
			</div>

			<div class="bs-callout bs-callout-info mt-10">
				<p class="mb-0">Пользователи с любым из флагов i, k, s, j имеют иммунитет к данной опции
				<p>
			</div>
		</div>

		<div class="block">
			<div class="block_head">
				Запрещенные идентификаторы
			</div>
			<div class="col-md-2">
				<button class="btn btn-default" data-target="#bad_nicks" data-toggle="modal" onclick="load_bad_nicks();">Настройка</button>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default {if($configSecondary->bad_nicks_act == 1)} active {/if}" onclick="change_value('config__secondary','bad_nicks_act','1','1');">
							<input type="radio">
							Включить
						</label>

						<label class="btn btn-default {if($configSecondary->bad_nicks_act == 2)} active {/if}" onclick="change_value('config__secondary','bad_nicks_act','2','1');">
							<input type="radio">
							Выключить
						</label>
					</div>
				</div>
			</div>

			<div id="bad_nicks" class="modal fade">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">Запрещенные идентификаторы</h4>
						</div>
						<div class="modal-body">
							<div class="bs-callout bs-callout-info mb-10 fs-14">
								Данная функция запрещает покупку привилегий на указанные Вами идентификаторы.<br>
								<br>
								Вы можете указать шаблон для запрета идентификаторов при помощи символа: <b>{%}</b>. Пример:<br>
								<b>{%}bad nick</b> - запретит все идентификаторы, которые заканчиваются на <b>bad nick</b> <br>
								<b>bad nick{%}</b> - запретит все идентификаторы, которые начинаются на <b>bad nick</b> <br>
								<b>{%}bad nick{%}</b> - запретит все идентификаторы, в которых встречается строка <b>bad nick</b> <br>
							</div>

							<form id="bad_nicks_list"></form>
							<button class="btn btn-default mt-5 f-l" onclick="save_bad_nicks();">Сохранить</button>
							<button class="btn btn-default mt-5 ml-5 f-l" onclick="add_nick_input();">Добавить</button>
							<div class="clearfix"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-12">
		<div class="block">
			<div class="block_head">
				Заблокированные ip
			</div>
			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" onclick="add_banned_ip();">Добавить</button>
				</span>
				<input type="text" class="form-control" id="ip" maxlength="20" autocomplete="off" placeholder="Добавить вечный бан по ip + cookies (укажите ip)">
			</div>
			<div class="table-responsive mb-0">
				<table class="bans_table table table-bordered">
					<thead>
					<tr>
						<td>IP</td>
						<td>Истекает</td>
						<td>Действие</td>
					</tr>
					</thead>
					<tbody id="banned_ip">
					<script>load_banned_ip();</script>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>