<div class="col-lg-9 order-is-first">
	<div class="row profile-page">
		<div class="col-lg-4">
			<div class="block profile">
				<img src="../{avatar}" alt="{login}">
				<div class="vertical-navigation">
					<ul>
                        <?php if((is_auth() && $_SESSION['id'] == '{profile_id}') || is_worthy("m")): ?>
							<li>
								<a>
									<span class="m-icon icon-bank"></span> Баланс:
									<span id="money">{shilings}</span> <?php echo $messages['RUB']; ?>
								</a>
							</li>
							<li>
								<a>
									<span class="m-icon icon-marker"></span> Скидка:
									<span id="proc">{proc}</span> %
								</a>
							</li>
                        <?php endif; ?>

                        <?php if((is_auth() && $_SESSION['id'] != '{profile_id}' && '{dell}' != '1')): ?>
							<li>
								<a href="../messages?create_id={profile_id}">
									<span class="m-icon icon-pencil"></span> Написать сообщение
								</a>
							</li>
                            <?php if(isOnMyBlacklist($pdo, $id)): ?>
								<li onclick="removeFromBlackList({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
									<a>
										<span class="m-icon icon-remove"></span> Разблокировать пользователя
									</a>
								</li>
                            <?php else: ?>
								<li onclick="addToBlackList({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
									<a>
										<span class="m-icon icon-remove"></span> Заблокировать пользователя
									</a>
								</li>
                            <?php endif; ?>

                            <?php if('{isFriend}' == 'false' && '{issetFriendRequestFromMe}' == 'false' && '{issetFriendRequestFromHim}' == 'false'): ?>
								<li onclick="add_new_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
									<a>
										<span class="m-icon icon-plus"></span> Добавить в друзья
									</a>
								</li>
                            <?php endif; ?>

                            <?php if('{isFriend}' == 'true'): ?>
								<li onclick="dell_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
									<a>
										<span class="m-icon icon-minus"></span> Удалить из друзей
									</a>
								</li>
                            <?php endif; ?>

                            <?php if('{issetFriendRequestFromMe}' == 'true'): ?>
								<li onclick="cancel_friend({profile_id}, function(message) { alert(message) }); $(this).fadeOut();">
									<a>
										<span class="m-icon icon-remove"></span> Отменить заявку
									</a>
								</li>
                            <?php endif; ?>

                            <?php if('{issetFriendRequestFromHim}' == 'true'): ?>
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
                            <?php endif; ?>
                        <?php endif; ?>

                        <?php if(is_worthy("m")): ?>
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
                        <?php endif; ?>

                        <?php if(is_worthy("c")): ?>
							<li onclick="take_proc({profile_id});">
								<a>
									<span class="m-icon icon-ok"></span> Установить скидку
								</a>
							</li>
                        <?php endif; ?>

                        <?php if(is_worthy("f")): ?>
							<li>
								<a href="../edit_user?id={profile_id}">
									<span class="m-icon icon-pencil"></span> Редактировать пользователя
								</a>
							</li>
                        <?php endif; ?>
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
					<small> {last_activity} </small>
				</div>

				<table class="table mb-0">
					<tbody>
                    <?php if('{dell}' != '1'): ?>
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
                        <?php if(('{skype}' != '' && '{skype}' != '---') || '{telegram}' != '' || '{discord}' != '' || '{vk}' != '---' || '{steam_api}' != '0' || '{fb}' != '0'): ?>
							<tr>
								<td colspan="2">
									<h4>Контактные данные</h4>
								</td>
							</tr>
                            <?php if('{skype}' != '' && '{skype}' != '---'): ?>
								<tr>
									<td>Логин Skype</td>
									<td><a title="Добавить в скайп" href="skype:{skype}?add">{skype}</a></td>
								</tr>
                            <?php endif; ?>
                            <?php if('{telegram}' != ''): ?>
								<tr>
									<td>Telegram</td>
									<td>
										<a title="Написать в Telegram" target="_blank" href="https://telegram.me/{telegram}">@{telegram}</a>
									</td>
								</tr>
                            <?php endif; ?>
                            <?php if('{discord}' != ''): ?>
								<tr>
									<td>Discord</td>
									<td><a title="Написать в Discord">{discord}</a></td>
								</tr>
                            <?php endif; ?>
                            <?php if('{vk}' != '---'): ?>
								<tr>
									<td>Вконтакте</td>
									<td>
										<a title="Перейти в профиль Вконтакте" target="_blank" href="https://vk.com/{vk}" id="vk_user">
											<img src="../files/avatars/no_avatar.jpg" alt="">
											<span>Загрузка...</span>
										</a>
										<script>get_vk_profile_info(
                                            '{vk_api}', '#vk_user img', '#vk_user span', '{vk}');</script>
									</td>
								</tr>
                            <?php endif; ?>
                            <?php if('{steam_api}' != '0'): ?>
								<tr>
									<td>Steam</td>
									<td>
										<a title="Перейти в профиль Steam" target="_blank" href="https://steamcommunity.com/profiles/{steam_api}/" id="steam_user">
											<img src="../files/avatars/no_avatar.jpg" alt="">
											<span>Загрузка...</span>
										</a>
										<script>get_user_steam_info('{steam_api}');</script>
									</td>
								</tr>
                            <?php endif; ?>
                            <?php if('{fb}' != '0'): ?>
								<tr>
									<td>Facebook</td>
									<td>
										<a title="Профиль в Facebook" target="_blank" id="fb_user">
											<img src="../files/avatars/no_avatar.jpg" alt="">
											<span>Загрузка...</span>
										</a>
										<script> get_fb_profile_info(
                                            '{fb_api}', '{fb}', '#fb_user', '#fb_user img', '#fb_user span'); </script>
									</td>
								</tr>
                            <?php endif; ?>
                        <?php endif; ?>
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
							<td><?php if('{topic_id}' == '0'): ?>Пользователь не просматривал форум<?php else: ?>
									<a title="Перейти в тему" href="../forum/topic?id={topic_id}">{topic_name}</a><?php endif; ?>
							</td>
						</tr>
						<tr>
							<td>Рейтинг</td>
							<td>{reit}</td>
						</tr>
						
                    <?php else: ?>
						<tr>
							<td colspan="2">
								<h4>Пользователь удален</h4>
							</td>
						</tr>
                    <?php endif; ?>
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
                        <?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "user_admins")) { $tpl->show($CE->user_admins('{profile_id}')); } unset($CE); } ?>
						</tbody>
					</table>
				</div>
			</div>

            <?php if('{dell}' != '1'): ?>
				<div class="block">
					<div class="block_head">
						Стена
					</div>
                    <?php if('{checker}' != '1'): ?>
						<div id="add_new_comments">
							<textarea id="text" maxlength="1000"></textarea>

							<div class="smile_input_forum mt-3">
								<input id="send_btn" class="btn btn-outline-primary" type="button" onclick="send_user_comment({profile_id});" value="Отправить">
								<div id="smile_btn" class="smile_btn" data-container="body" data-toggle="popover" data-placement="top" data-content="empty"></div>
							</div>
						</div>
						<script>
                          $(document).ready(function () {
                            init_tinymce(
                              'text', 'lite', "{file_manager_theme}", "{file_manager}", "<?php echo md5($conf->code); ?>");
                            get_smiles('#smile_btn');
                          });

                          $('#smile_btn').popover({ html: true, animation: true, trigger: 'click' });
                          $('#smile_btn').on('show.bs.popover', function () {
                            $(document).mouseup(function (e) {
                              var container = $('.popover-body');
                              if (container.has(e.target).length === 0) {
                                $('#smile_btn').popover('hide');
                                selected = 'gcms_smiles';
                              }
                            });
                          });

                          function set_smile (elem) {
                            var smile = '<img src="' + $(elem).attr('src') +
                              '" class="g_smile" height="20px" width="20px">';
                            tinymce.activeEditor.insertContent(smile);
                            $('#smile_btn').popover('hide');
                            selected = 'gcms_smiles';
                          }

                          function set_sticker (elem) {
                            var text = 'sticker' + $(elem).attr('src');
                            text = encodeURIComponent(text);
                            send_user_comment({profile_id}, text);
                            $('#smile_btn').popover('hide');
                            selected = 'gcms_smiles';
                          }
						</script>
                    <?php endif; ?>
					<div id="comments" class="mt-3">
						<div class="loader"></div>
					</div>
					<script>load_users_comments({profile_id}, 'first');</script>
				</div>
            <?php endif; ?>
		</div>
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
    <?php endif; ?>

	<div class="block">
		<div class="block_head">
			Сообщения на форуме
		</div>
		<div id="last_activity">
            <?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "user_forum_activity")) { $tpl->show($CE->user_forum_activity('{profile_id}', '3')); } unset($CE); } ?>
		</div>
	</div>

	<div class="block">
		<div class="block_head">
			Заявки на разбан
		</div>
		<div id="mybans">
            <?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "user_bans")) { $tpl->show($CE->user_bans('{profile_id}', '3')); } unset($CE); } ?>
		</div>
	</div>

    <?php if(is_auth()): ?>
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
		Сейчас онлайн <span id="users_online_number"></span>
	</div>
	<div id="online_users">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "online_users")) { $tpl->show($CE->online_users()); } unset($CE); } ?>
	</div>
</div>
    <?php endif; ?>
</div>