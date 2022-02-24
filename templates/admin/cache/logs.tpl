<div class="page">
    <?php foreach($logs as $slug => $log): ?>
		<div class="col-md-4">
			<div class="block">
				<div class="block_head">
                    <?php echo $log['name']; ?>
				</div>

                <?php if($slug == 'stat'): ?>
					<div class="input-group">
						<div class="input-group-btn" data-toggle="buttons">
							<label class="btn btn-default <?php if($conf->stat == 1): ?> active <?php endif; ?>" onclick="change_value('config','stat','1','1'); send_value('input_privacy','1');">
								<input type="radio">
								Включить
							</label>

							<label class="btn btn-default <?php if($conf->stat == 2): ?> active <?php endif; ?>" onclick="change_value('config','stat','2','1'); send_value('input_privacy','2');">
								<input type="radio">
								Выключить
							</label>
						</div>
						<span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="edit_stat_number();">Изменить</button>
							</span>
						<input type="number" class="form-control" id="stat_number" maxlength="5" autocomplete="off" value="<?php echo $conf->stat_number; ?>">
					</div>
					<small class="f-r c-868686">Сколько последних визитов будет хранить лог</small>
					<div id="edit_stat_number_result"></div>
					<br>
                <?php endif; ?>

				<div id="<?php echo $slug; ?>_actions">
                    <?php if($log['size']): ?>
						<a data-toggle="modal" data-target="#<?php echo $slug; ?>_content" onclick="getLogContent('<?php echo $slug; ?>')" class="btn btn-success w-100">Открыть (<?php echo $log['size']; ?>)</a>
						<a href="#" class="btn btn-danger w-100" onclick="removeLog('<?php echo $slug; ?>')">Удалить</a>
                    <?php else: ?>
						<a href="#" class="btn btn-success w-100 pd-23-12">Файл пуст</a>
                    <?php endif; ?>
				</div>
			</div>

			<div id="<?php echo $slug; ?>_content" class="modal fade">
				<div class="modal-dialog modal-lg2">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">
                                <?php echo $log['name']; ?>

								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span>&times;</span>
								</button>
							</h4>
						</div>
						<div class="modal-body">
							<div class="table-responsive mb-0">
								<table class="table table-bordered">
									<thead>
                                        <?php echo $log['header']; ?>
									</thead>
									<tbody id="<?php echo $slug; ?>_content_body">
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
    <?php endforeach; ?>
</div>