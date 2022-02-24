<div class="col-lg-3 order-is-last">
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
	<?php if($conf->vk_admin == 1 or $conf->vk_group == 1): ?>
	<div class="vk-widgets">
		<?php if($conf->vk_admin == 1): ?>
		<div class="block">
			<div class="block_head">
				<?php if(count($vk_admins) > 1): ?>Гл. администраторы<?php else: ?>Гл. администратор<?php endif; ?>
			</div>
			<?php for($i=0; $i < count($vk_admins); $i++): ?>
				<?php if($conf->widgets_type == 1): ?>
				<a title="Перейти в профиль Вконтакте" target="_blank" href="https://vk.com/id<?php echo $vk_admins[$i]; ?>" id="admin_widget<?php echo $i; ?>">
					<img src="../files/avatars/no_avatar.jpg" alt="">
					<span>Загрузка...</span>
				</a>
				<script>get_vk_profile_info('<?php echo $vk_admins[$i]; ?>', '#admin_widget<?php echo $i; ?> img', '#admin_widget<?php echo $i; ?> span', '<?php echo $vk_admins[$i]; ?>');</script>
				<?php else: ?>
				<a title="Профиль в Facebook" target="_blank" id="admin_widget<?php echo $i; ?>">
					<img src="../files/avatars/no_avatar.jpg" alt="">
					<span>Загрузка...</span>
				</a>
				<script> get_fb_profile_info('<?php echo $vk_admins[$i]; ?>', '<?php echo $vk_admins[$i]; ?>', '#admin_widget<?php echo $i; ?>', '#admin_widget<?php echo $i; ?> img', '#admin_widget<?php echo $i; ?> span'); </script>
				<?php endif; ?>
			<?php endfor; ?>
		</div>
		<?php endif; ?>

		<?php if($conf->vk_group == 1): ?>
			<?php if($conf->widgets_type == 1): ?>
				<script type="text/javascript" src="//vk.com/js/api/openapi.js?120"></script>
				<?php for($i=0; $i < count($vk_groups); $i++): ?>
					<div id="vk_groups<?php echo $i; ?>" class="d-none d-lg-block"></div>
					<script> VK.Widgets.Group("vk_groups<?php echo $i; ?>", {mode: 3, width: "auto", height: "400", color3: "#45698B"}, <?php echo $vk_groups[$i]; ?>); </script>
				<?php endfor; ?>
			<?php else: ?>
				<div id="fb-root"></div>
				<script>(function(d, s, id) {
					var js, fjs = d.getElementsByTagName(s)[0];
					if (d.getElementById(id)) return;
					js = d.createElement(s); js.id = id;
					js.src = 'https://connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v3.0&appId=2144044429185543&autoLogAppEvents=1';
					fjs.parentNode.insertBefore(js, fjs);
					}(document, 'script', 'facebook-jssdk'));
				</script>
				<?php for($i=0; $i < count($vk_groups); $i++): ?>
					<div class="block d-none d-lg-block p-0">
						<div class="fb-page" data-href="https://www.facebook.com/<?php echo $vk_groups[$i]; ?>/" data-tabs="timeline" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="false">
							<blockquote cite="https://www.facebook.com/<?php echo $vk_groups[$i]; ?>/" class="fb-xfbml-parse-ignore">
								<a href="https://www.facebook.com/<?php echo $vk_groups[$i]; ?>/"><div class="loader"></div></a>
							</blockquote>
						</div>
					</div>
				<?php endfor; ?>
			<?php endif; ?>
		<?php endif; ?>
	</div>
<?php endif; ?>
	<div class="block">
	<div class="block_head">
		Сейчас онлайн <span id="users_online_number"></span>
	</div>
	<div id="online_users">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "online_users")) { $tpl->show($CE->online_users()); } unset($CE); } ?>
	</div>
</div>

<?php if($conf->top_donators == '1'): ?>
	<div class="block">
		<div class="block_head">
			Топ донатеров
		</div>
		<div id="online_users">
			<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "top_donators")) { $tpl->show($CE->top_donators($conf->top_donators_count)); } unset($CE); } ?>
		</div>
	</div>
<?php endif; ?>

<div class="block">
	<div class="block_head">
		Топ пользователей
	</div>
	<div id="top_users">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "top_users")) { $tpl->show($CE->top_users('5')); } unset($CE); } ?>
	</div>
</div>

<div class="block">
	<div class="block_head">
		Последнее на форуме
	</div>
	<div id="last_activity">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "last_forum_activity")) { $tpl->show($CE->last_forum_activity('5')); } unset($CE); } ?>
	</div>
</div>

<?php if($conf->disp_last_online == '1'): ?>
<div class="block">
	<div class="block_head">
		Сегодня были <span id="count_of_last_onl_us"></span>
	</div> 
	<div id="load_last_online">
		<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "were_online")) { $tpl->show($CE->were_online()); } unset($CE); } ?>
	</div>
</div>
<?php endif; ?>
</div>

<div class="col-lg-9 order-is-first">
	<div id="main-slider" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<?php for($i=0; $i < count($slider); $i++): ?>  
				<div class="carousel-item <?php if($i==0): ?>active<?php endif; ?>">
					<img class="d-block w-100" src="<?php echo $slider[$i]['image']; ?>">
					<div class="carousel-caption">
						<h1>
							<?php if(!empty($slider[$i]['link'])): ?><a href="<?php echo $slider[$i]['link']; ?>" target="_blank"><?php endif; ?>
							<?php echo $slider[$i]['title']; ?>
							<?php if(!empty($slider[$i]['link'])): ?></a><?php endif; ?>
						</h1>
						<p class="d-none d-lg-block"><?php echo $slider[$i]['content']; ?></p>
						<?php if(!empty($slider[$i]['link'])): ?>
							<a href="<?php echo $slider[$i]['link']; ?>" class="px-4 btn btn-primary d-none d-lg-inline-block" target="_blank">Подробнее</a>
						<?php endif; ?>
					</div>
				</div>
			<?php endfor; ?>
		</div>
		<a class="carousel-control-prev" href="#main-slider" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="carousel-control-next" href="#main-slider" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>

	<div class="block">
	<div class="block_head">
		Чат
	</div>
	<div id="chat">
		<form>
			<div id="drop_zone" class="">
				<div id="drop_mask"></div>

				<div id="chat_messages">
					<div class="loader"></div>
				</div>

				<div id="chat_sound_playes"></div>
				<input id="load_val" type="hidden" value="1" />
				<input id="last_mess" type="hidden" value="" />
				<input id="stop_sending" type="hidden" value="0">
			</div>
			<?php if(is_auth()): ?>
			<div class="input-group mt-3">
				<div class="smile_input">
					<input id="message_input" type="text" class="form-control" placeholder="Введите сообщение...">
					<div id="smile_btn" class="smile_btn" data-container="body" data-toggle="popover" data-placement="top" data-content="empty"></div>
				</div>
				<span class="input-group-btn">
					<input id="send_button" type="button" class="btn btn-default" value="Отправить" onclick="chat_send_message();"/>
				</span>
			</div>
			<?php else: ?>
			<p class="mb-0 mt-4 text-center"><a class="small" data-toggle="modal" data-target="#authorization">Авторизуйтесь</a>, чтобы отправлять сообщения</p>
			<?php endif; ?>
		</form>
	</div>
	<div id="passive" class="disp-n">
		<center>
			<img src="{site_host}templates/{template}/img/zzz.png">
			<p class="mt-10">Включен пассивный режим.</p>
			<p>Вы отсутствовали более чем <b></b> минут.</p>
		</center>
	</div>
</div>
<script>
	//drag&drop
	$(document).ready(function(){
		var dropZone = $('#drop_zone');
		var dropMask = $('#drop_mask');
		var maxFileSize = 2*1024*1024; //2мб макс размер
		var drop_file = true; //false - выкл , true - вкл | загрузка изображений в чат

		if (typeof(window.FileReader) != 'undefined' && drop_file) {
			dropZone[0].ondragover = function(event) {
				dropZone.addClass('hover');
				dropMask.show();
				return false;
			};

			dropMask[0].ondragleave = function() {
				dropZone.removeClass('hover');
				dropMask.hide();
				return false;
			};

			dropMask[0].ondrop = function(event) {
				event.preventDefault();
				dropMask.hide();
				dropZone.removeClass('hover');
				dropZone.addClass('loader');

				if(event.dataTransfer.files[0] == undefined) {
					dropZone.removeClass('loader');
					show_noty('Down', 'error', '<a>Неверный тип файла</a>', '3000');
					dropZone.addClass('error');
					setTimeout(function(){
						dropZone.removeClass('error');
					}, 2000);
					return false;
				} else {
					var file = event.dataTransfer.files[0];
				}

				if (file.size > maxFileSize) {
					dropZone.removeClass('loader');
					show_noty('Down', 'error', '<a>Файл слишком большой</a>', '3000');
					dropZone.addClass('error');
					setTimeout(function(){
						dropZone.removeClass('error');
					}, 2000);
					return false;
				}

				var data = new FormData;
				data.append("file", file);
				data.append("token", $('#token').val());
				data.append("drop_img", '1');
				data.append("phpaction", '1');
				data.append("id", '{id}');

				clearInterval(chat_interval);
				NProgress.start();
				$.ajax({
					type: "POST",
					url: "../ajax/chat_actions.php",
					data: data,
					processData: false,
					contentType: false,
					dataType: "json",

					success: function(result) {
						dropZone.removeClass('loader');
						NProgress.done();
						chat_get_messages(1);
						if(result.status == 1){
							setTimeout(show_ok, 500);
						} else {
							setTimeout(show_error, 500);
							show_noty('Down', 'error', '<a>'+result.data+'</a>', '3000');
							dropZone.addClass('error');
							setTimeout(function(){
								dropZone.removeClass('error');
							}, 2000);
						}
					},
					error: function(result){
						dropZone.removeClass('loader');
						NProgress.done();
						chat_get_messages(1);
					}
				});
			};
		}
	});

	//smiles&stickers
	$('#smile_btn').popover({ html: true, animation: true, trigger: 'click' });
	$('#smile_btn').on('show.bs.popover', function () {
		$(document).mouseup(function (e) {
			var container = $(".popover-body");
			if (container.has(e.target).length === 0){
				$('#smile_btn').popover('hide');
				selected = 'gcms_smiles';
			}
		});
	});
	function set_sticker(elem){
		if($('#stop_sending').val() == 0){
			var text = "sticker"+$(elem).attr("src");
			text = encodeURIComponent(text);
			chat_send_message(text);

			$('#smile_btn').popover('hide');
			selected = 'gcms_smiles';
		}
	}
	function set_smile(elem){
		$("#message_input").focus();
		var text = $("#message_input").val();
		var smile = $(elem).attr("title");
		$("#message_input").val(text+" "+smile+" ");
		
		$('#smile_btn').popover('hide');
		selected = 'gcms_smiles';
	}

	//init chat
	get_smiles('#smile_btn');
	chat_first_messages();
	set_enter('#message_input', 'chat_send_message()');

	var block = document.getElementById("chat_messages");
	var load_val = $('#load_val').val();
	block.onscroll = function() {
		if((block.scrollTop < 300) && (load_val == $('#load_val').val())) {
			$('#load_val').val(+load_val + 1);
			chat_load_messages();
		}
	}

	idleTimer = null;
	idleState = false;
	idleWait = 600000;

	$(document).ready(function(){
		$(document).bind('mousemove keydown scroll', function(){
			clearTimeout(idleTimer);
			if(idleState == true){ 
				reset_page();
			}

			idleState = false;
			idleTimer = setTimeout(function(){ 
				clearInterval(chat_interval);
				$("#chat").fadeOut();
				$("#passive").fadeIn();
				$("#passive b").append(idleWait/1000/60);
				idleState = true; 
			}, idleWait);
		});
		$("body").trigger("mousemove");
	});
</script>

	<?php if($conf->show_news != '0'): ?>
	<div class="block">
		<div class="block_head">
			Новости проекта
		</div> 
		<div class="vertical-center-line">
			<div id="new_news" class="clearfix">
				<?php if (class_exists("Widgets")) { $CE = new Widgets($pdo, $tpl); if(method_exists($CE, "last_news")) { $tpl->show($CE->last_news($conf->show_news)); } unset($CE); } ?>
			</div>
		</div>
	</div>
	<?php endif; ?>

	<div class="block">
		<div class="block_head">
			Форум
		</div> 
		<div id="forum">
			<?php if (class_exists("Forum")) { $CE = new Forum($pdo, $tpl); if(method_exists($CE, "get_forums")) { $tpl->show($CE->get_forums()); } unset($CE); } ?>
		</div>
	</div>

	
</div>

<div class="disp-n" id="auth-result">{conf_mess}</div>
<script>
	var conf_mess = $("#auth-result > p").text();
	
	if(conf_mess != '') {
		var conf_mess_style = $("#auth-result > p").attr("class");

		if(conf_mess_style.indexOf("danger") > 0) {
			conf_mess_style = 'error';
		} else {
			conf_mess_style = 'success';
		}

		show_noty('Down', conf_mess_style, '<a>' + conf_mess + '</a>', 10000);
	}
</script>