<div id="points_result"></div>
<div class="page">
	<div class="row">
		<div class="col-md-6">
			<div class="block">
				<div class="block_head">Дополнительные настройки</div>
				<label>Повторная верификация</label>
				<div class="input-group">
					<span class="input-group-btn">
						<button onclick="edit_verification_time();" class="btn btn-default" type="button">Изменить</button>
					</span>
					<input type="text" class="form-control" id="time_verification" value="{timeleft}" placeholder="Введите время в секундах">
				</div>
			</div>
			<div class="block">
				<div class="block_head">Последние верификации</div>
				<div class="table-responsive mb-0">
					<table class="table table-bordered admins">
						<thead>
							<tr>
								<td>#</td>
								<td>Пользователь</td>
								<td>Дата</td>
								<td>Статус</td>
							</tr>
						</thead>
						<tbody>
							{last_list_verifications}
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="block">
				<div class="block_head">Управление верификацией</div>
				
					<div class="col-auto">
						<label for="inputPassword" class="visually-hidden">ID Пользователя</label>
						<input type="number" min="1" max="10000" class="form-control" id="id" placeholder="Укажите ID">
						<label for="inputPassword2" class="visually-hidden">Тип</label>
						<select class="form-control" id="type"><option value="1">Выдать</option><option value="0">Отобрать</option></select>
					</div>
					<div class="col-auto">
						<br><button type="submit" class="btn btn-primary mb-3" onclick="Verifi();">Выполнить</button>
					</div>
					<div id="result_verifi"></div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="block">
				<div class="block_head">Запросы на верификацию</div>
				<div class="table-responsive mb-0">
					<table class="table table-bordered admins">
						<thead>
							<tr>
								<td>#</td>
								<td>Пользователь</td>
								<td>Дата подачи заявки</td>
								<td>Параметры</td>
							</tr>
						</thead>
						<tbody id="list_verifications">
							{list_verifications}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<link href="{site_host}templates/admin/js/toasts/toasty.min.css" rel="stylesheet"/>
<script src="{site_host}templates/admin/js/toasts/toasty.min.js" type="text/javascript"></script>