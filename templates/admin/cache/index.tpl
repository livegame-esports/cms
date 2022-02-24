<div class="central-block auth-block">
	<div class="central-block-header">
		<h3>Админ центр</h3>
	</div>
	<div class="central-block-body">
		<div class="form-horizontal">
			<form id="admin_login">
				<input id="password" type="password" class="form-control" placeholder="Пароль">
				
				<?php if($conf->captcha != '2'): ?>
					<div data-theme="light" class="g-recaptcha mb-15 clearfix" data-sitekey="<?php echo $conf->captcha_client_key; ?>"></div>
					<script src='https://www.google.com/recaptcha/api.js?hl=ru'></script>
				<?php endif; ?>
				<div id="result"></div>

				<button class="btn2" type="submit">Войти</button>
			</form>
			<script> send_form('#admin_login', 'admin_login();'); </script>
		</div>
	</div>
</div>