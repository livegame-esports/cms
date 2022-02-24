<div class="page">
    {foreach($logs as $slug => $log)}
		<div class="col-md-4">
			<div class="block">
				<div class="block_head">
                    {{$log['name']}}
				</div>

                {if($slug == 'stat')}
					<div class="input-group">
						<div class="input-group-btn" data-toggle="buttons">
							<label class="btn btn-default {if($conf->stat == 1)} active {/if}" onclick="change_value('config','stat','1','1'); send_value('input_privacy','1');">
								<input type="radio">
								Включить
							</label>

							<label class="btn btn-default {if($conf->stat == 2)} active {/if}" onclick="change_value('config','stat','2','1'); send_value('input_privacy','2');">
								<input type="radio">
								Выключить
							</label>
						</div>
						<span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="edit_stat_number();">Изменить</button>
							</span>
						<input type="number" class="form-control" id="stat_number" maxlength="5" autocomplete="off" value="{{$conf->stat_number}}">
					</div>
					<small class="f-r c-868686">Сколько последних визитов будет хранить лог</small>
					<div id="edit_stat_number_result"></div>
					<br>
                {/if}

				<div id="{{$slug}}_actions">
                    {if($log['size'])}
						<a data-toggle="modal" data-target="#{{$slug}}_content" onclick="getLogContent('{{$slug}}')" class="btn btn-success w-100">Открыть ({{$log['size']}})</a>
						<a href="#" class="btn btn-danger w-100" onclick="removeLog('{{$slug}}')">Удалить</a>
                    {else}
						<a href="#" class="btn btn-success w-100 pd-23-12">Файл пуст</a>
                    {/if}
				</div>
			</div>

			<div id="{{$slug}}_content" class="modal fade">
				<div class="modal-dialog modal-lg2">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">
                                {{$log['name']}}

								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span>&times;</span>
								</button>
							</h4>
						</div>
						<div class="modal-body">
							<div class="table-responsive mb-0">
								<table class="table table-bordered">
									<thead>
                                        {{$log['header']}}
									</thead>
									<tbody id="{{$slug}}_content_body">
										<tr><td colspan="10">Загрузка...</td></tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-default" data-dismiss="modal" type="button">
								Закрыть
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
    {/foreach}
</div>