<div class="col-lg-9 order-is-first">
	<div class="row profile-page">
		<div class="col-lg-4">
			<div class="block profile">
				<img src="../{avatar}" alt="{login}">
				<div class="vertical-navigation">
					<ul>
						{if((is_auth() && $_SESSION['id'] == '{profile_id}') || is_worthy("m"))}
						<li>
							<a>
								<span class="m-icon icon-bank"></span> Баланс:
								<span id="money">{shilings}</span> {{$messages['RUB']}}
							</a>
						</li>
						<li>
							<a>
								<span class="m-icon icon-marker"></span> Скидка:
								<span id="proc">{proc}</span> %
							</a>
						</li>
						{/if}

						{if((is_auth() && $_SESSION['id'] != '{profile_id}' && '{dell}' != '1'))}
						<li>
							<a href="../messages?create_id={profile_id}">
								<span class="m-icon icon-pencil"></span> Написать сообщение
							</a>
						</li>
						<li><a onclick="donate_money({profile_id});"><span class="fa fa-money"></span> Задонатить</a></li>
						{if(isOnMyBlacklist($pdo, $id))}
						<li onclick="removeFromBlackList({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
							<a>
								<span class="m-icon icon-remove"></span> Разблокировать пользователя
							</a>
						</li>
						{else}
						<li onclick="addToBlackList({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
							<a>
								<span class="m-icon icon-remove"></span> Заблокировать пользователя
							</a>
						</li>
						{/if}

						{if('{isFriend}' == 'false' && '{issetFriendRequestFromMe}' == 'false' && '{issetFriendRequestFromHim}' == 'false')}
						<li onclick="add_new_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
							<a>
								<span class="m-icon icon-plus"></span> Добавить в друзья
							</a>
						</li>
						{/if}

						{if('{isFriend}' == 'true')}
						<li onclick="dell_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
							<a>
								<span class="m-icon icon-minus"></span> Удалить из друзей
							</a>
						</li>
						{/if}

						{if('{issetFriendRequestFromMe}' == 'true')}
						<li onclick="cancel_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
							<a>
								<span class="m-icon icon-remove"></span> Отменить заявку
							</a>
						</li>
						{/if}

						{if('{issetFriendRequestFromHim}' == 'true')}
						<li onclick="take_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut(); $(this).next().fadeOut();">
							<a>
								<span class="m-icon icon-ok"></span> Принять заявку
							</a>
						</li>
						<li onclick="reject_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut(); $(this).prev().fadeOut();">
							<a>
								<span class="m-icon icon-remove"></span> Отклонить заявку
							</a>
						</li>
						{/if}
						{/if}

						{if(is_worthy("m"))}
						<li onclick="give_money({profile_id});">
							<a>
								<span class="m-icon icon-plus"></span> Дать деньги
							</a>
						</li>
						<li onclick="pick_up_money({profile_id});">
							<a>
								<span class="m-icon icon-minus"></span> Забрать деньги
							</a>
						</li>
						{/if}

						{if(is_worthy("c"))}
						<li onclick="take_proc({profile_id});">
							<a>
								<span class="m-icon icon-ok"></span> Установить скидку
							</a>
						</li>
						{/if}

						{if(is_worthy("f"))}
						<li>
							<a href="../edit_user?id={profile_id}">
								<span class="m-icon icon-pencil"></span> Редактировать пользователя
							</a>
						</li>
						{/if}
					</ul>
				</div>

				<div id="result_profile"></div>
			</div>

			<div class="block">
				<div class="block_head">
					<a href="../friends?id={profile_id}">
						Друзья <small>[все]</small>
					</a>
				</div>
				<div id="friends">
					{friends}
				</div>
			</div>
		</div>

		<div class="col-lg-8">
			<div class="block profile">
				<div class="block_head">
					{login}
					{verification}
					<small>
						{last_activity}
					</small>
				</div>

				<table class="table mb-0">
					<tbody>
						{if('{dell}' != '1')}
						<tr>
							<td colspan="2">
								<h4>Общая информация</h4>
							</td>
						</tr>
						<tr>
							<td>ID</td>
							<td>{profile_id}</td>
						</tr>
						<tr>
							<td>Группа</td>
							<td><span style="color: {group_color}">{group}</span></td>
						</tr>
						<tr>
							<td>Дата регистрации</td>
							<td>{regdate}</td>
						</tr>
						<tr>
							<td>Ник на сервере</td>
							<td>{nick}</td>
						</tr>
						<tr>
							<td colspan="2">
								<h4>Личные данные</h4>
							</td>
						</tr>
						<tr>
							<td>Имя</td>
							<td>{name}</td>
						</tr>
						<tr>
							<td>Дата рождения</td>
							<td>{birth}</td>
						</tr>
						{if(('{skype}' != '' && '{skype}' != '---') || '{telegram}' != '' || '{discord}' != '' || '{vk}' != '---' || '{steam_api}' != '0' || '{fb}' != '0')}
						<tr>
							<td colspan="2">
								<h4>Контактные данные</h4>
							</td>
						</tr>
						{if('{skype}' != '' && '{skype}' != '---')}
						<tr>
							<td>Логин Skype</td>
							<td><a title="Добавить в скайп" href="skype:{skype}?add">{skype}</a></td>
						</tr>
						{/if}
						{if('{telegram}' != '')}
						<tr>
							<td>Telegram</td>
							<td>
								<a title="Написать в Telegram" target="_blank" href="https://telegram.me/{telegram}">@{telegram}</a>
							</td>
						</tr>
						{/if}
						{if('{discord}' != '')}
						<tr>
							<td>Discord</td>
							<td><a title="Написать в Discord">{discord}</a></td>
						</tr>
						{/if}
						{if('{vk}' != '---')}
						<tr>
							<td>Вконтакте</td>
							<td>
								<a title="Перейти в профиль Вконтакте" target="_blank" href="https://vk.com/{vk}" id="vk_user">
									<img src="../files/avatars/no_avatar.jpg" alt="">
									<span>Загрузка...</span>
								</a>
								<script>
									get_vk_profile_info(
										'{vk_api}', '#vk_user img', '#vk_user span', '{vk}');
								</script>
							</td>
						</tr>
						{/if}
						{if('{steam_api}' != '0')}
						<tr>
							<td>Steam</td>
							<td>
								<a title="Перейти в профиль Steam" target="_blank" href="https://steamcommunity.com/profiles/{steam_api}/" id="steam_user">
									<img src="../files/avatars/no_avatar.jpg" alt="">
									<span>Загрузка...</span>
								</a>
								<script>
									get_user_steam_info('{steam_api}');
								</script>
							</td>
						</tr>
						{/if}
						{if('{fb}' != '0')}
						<tr>
							<td>Facebook</td>
							<td>
								<a title="Профиль в Facebook" target="_blank" id="fb_user">
									<img src="../files/avatars/no_avatar.jpg" alt="">
									<span>Загрузка...</span>
								</a>
								<script>
									get_fb_profile_info(
										'{fb_api}', '{fb}', '#fb_user', '#fb_user img', '#fb_user span');
								</script>
							</td>
						</tr>
						{/if}
						{/if}
						<tr>
							<td colspan="2">
								<h4>Активность на форуме</h4>
							</td>
						</tr>
						<tr>
							<td>Сообщений</td>
							<td>{answers}</td>
						</tr>
						<tr>
							<td>Спасибок</td>
							<td>{thanks}</td>
						</tr>
						<tr>
							<td>Последняя тема</td>
							<td>{if('{topic_id}' == '0')}Пользователь не просматривал форум{else}
								<a title="Перейти в тему" href="../forum/topic?id={topic_id}">{topic_name}</a>{/if}
							</td>
						</tr>
						<tr>
							<td>Рейтинг</td>
							<td>{reit}</td>
						</tr>
						{include file="/home/profile_stats.tpl"}
						{else}
						<tr>
							<td colspan="2">
								<h4>Пользователь удален</h4>
							</td>
						</tr>
						{/if}
					</tbody>
				</table>
			</div>
		</div>

		<div class="col-lg-12">
			<div class="block block-table">
				<div class="block_head">
					Привилегии
				</div>
				<div class="table-responsive mb-0">
					<table class="table table-condensed table-bordered admins">
						<thead>
							<tr>
								<td>#</td>
								<td>Сервер</td>
								<td>Идентификатор</td>
								<td>Услуги</td>
							</tr>
						</thead>
						<tbody id="admins">
							{func Widgets:user_admins('{profile_id}')}
						</tbody>
					</table>
				</div>
			</div>

			{*
			{if('{dell}' != '1')}
			<div class="block">
				<div class="block_head">
					Стена
				</div>
				{if('{checker}' != '1')}
				<div id="add_new_comments">
					<textarea id="text" maxlength="1000"></textarea>

					<div class="smile_input_forum mt-3">
						<input id="send_btn" class="btn btn-outline-primary" type="button" onclick="send_user_comment({profile_id});" value="Отправить">
						<div id="smile_btn" class="smile_btn" data-container="body" data-toggle="popover" data-placement="top" data-content="empty"></div>
					</div>
				</div>
				<script>
					$(document).ready(function() {
						init_tinymce(
							'text', 'lite', "{file_manager_theme}", "{file_manager}", "{{md5($conf->code)}}");
						get_smiles('#smile_btn');
					});

					$('#smile_btn').popover({
						html: true,
						animation: true,
						trigger: 'click'
					});
					$('#smile_btn').on('show.bs.popover', function() {
						$(document).mouseup(function(e) {
							var container = $('.popover-body');
							if (container.has(e.target).length === 0) {
								$('#smile_btn').popover('hide');
								selected = 'gcms_smiles';
							}
						});
					});

					function set_smile(elem) {
						var smile = '<img src="' + $(elem).attr('src') +
							'" class="g_smile" height="20px" width="20px">';
						tinymce.activeEditor.insertContent(smile);
						$('#smile_btn').popover('hide');
						selected = 'gcms_smiles';
					}

					function set_sticker(elem) {
						var text = 'sticker' + $(elem).attr('src');
						text = encodeURIComponent(text);
						send_user_comment({
							profile_id
						}, text);
						$('#smile_btn').popover('hide');
						selected = 'gcms_smiles';
					}
				</script>
				{/if}
				<div id="comments" class="mt-3">
					<div class="loader"></div>
				</div>
				<script>
					load_users_comments({
						profile_id
					}, 'first');
				</script>
			</div>
			{/if}
			*}
		</div>
	</div>
</div>
<div class="col-lg-3 order-is-last">
	{if(is_auth())}
	{include file="/home/navigation.tpl"}
	{else}
	{include file="/index/authorization.tpl"}
	{/if}

	{* include file="/modules/users_visit.tpl" *}

	<div class="block">
		<div class="block_head">
			Сообщения на форуме
		</div>
		<div id="last_activity">
			{func Widgets:user_forum_activity('{profile_id}', '3')}
		</div>
	</div>

	<div class="block">
		<div class="block_head">
			Заявки на разбан
		</div>
		<div id="mybans">
			{func Widgets:user_bans('{profile_id}', '3')}
		</div>
	</div>

	{include file="/home/sidebar_secondary.tpl"}

</div>