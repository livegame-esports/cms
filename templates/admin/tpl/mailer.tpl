<div class="page">
	<div class="alert alert-info" role="alert">
	  <h4 class="alert-heading">Внимание!</h4>
	  <p>Для корректной работы системы, Вам потребуется подключить SMTP в <a href="/admin/email_settings" target="_blank">Настройках почты</a>.</p>
	</div>
	
	<div class="col-md-12">
		<div class="block">
			<div class="block_head">
				Заполнение формы
			</div>
			<div class="form-group">
				<label for="sendTitle">Тема сообщения</label>
				<input type="text" class="form-control" id="sendTitle">
				<small class="form-text text-muted">Это будет заголовком Вашего сообщения.</small>
			</div>
			<div class="form-group">
				<label for="sendMessage">Сообщение</label>
				<textarea class="form-control" id="sendMessage"></textarea>
			</div>
			<br>
			<button type="button" class="btn btn-primary btn-block" onclick="onMailer();">Отправить</button>
			<div id="resultMailer"></div>
		</div>
	</div>
</div>