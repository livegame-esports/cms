<div class="col-lg-9 order-is-first">
	<div class="block">
		<div class="block_head">
			Покупка привилегий
		</div>
		{if('{servers}' == '0')}
		Услуг не найдено
		{else}
		<div class="row">
			{if('{discount}' != '0')}
				<div class="col-lg-12">
					<div class="noty-block success">
						<h4>Внимание! Действует скидка!</h4>
						На все услуги действует скидка в размере {discount}%
					</div>
				</div>
			{/if}
			<div class="col-lg-6" id="buy_service_area">
				<script>
				function local_change_serv() {
					var server = $('#store_server option:selected').val();
					get_gifts(server);
					get_server_gift(server);
				}
				function local_change_service() {
					var service = $('#store_services option:selected').val();
					get_tarifs_gift(service);
					get_gift_fields(service);
				}
				</script>

				<div class="form-group">
					<label>
						<h4>
							Выберите сервер
						</h4>
					</label>
					<select class="form-control" id="store_server" onchange="local_change_serv();">
						{servers}
					</select>
				</div>

				<div class="form-group">
					<label>
						<h4>
							Выберите услугу
						</h4>
					</label>
					<select class="form-control" id="store_services" onchange="local_change_service();"></select>
				</div>

				<div class="form-group">
					<label>
						<h4>
							Выберите тариф
						</h4>
					</label>
					<select class="form-control" id="store_tarifs"></select>
				</div>

				<div class="form-group">
					<label>
						<h4>
							Игровой профиль
						</h4>
					</label>
					<div id="gift_fields"></div>
				</div>

				{if(is_auth())}
				<div class="form-group">
					<label>
						<h4>
							Условия
						</h4>
					</label>

					<div class="form-check">
						<input class="form-check-input" id="store_checbox" data-status="2" type="checkbox" onclick="on_buying_gift();">
						<label class="form-check-label" for="store_checbox">
							Я ознакомлен с <a target="_blank" href="../pages/rules">правилами</a> проекта и согласен с ними
						</label>
					</div>

					<div id="buy_result" class="mt-3"></div>
					<div id="button" class="mt-3">
						<button id="store_buy_btn" class="btn btn-primary disabled">Купить</button>
						<button id="store_answer_btn" class="btn btn-outline-primary disp-n">Нет</button>
					</div>
				</div>	
				{else}
				<div class="noty-block error">
					<p>Авторизуйтесь, чтобы приобрести услугу</p>
				</div>
				{/if}
			</div>
			<div class="col-lg-6">
				<div class="form-group">
					<label>
						<h4>
							Информация о услуге
						</h4>
					</label>
					<div id="store_service_info" class="with_code noty-block"></div>
					<div id="store_server_info" class="d-none"></div>
					<script>
					function on_buying_gift(){var status=$('#store_checbox').attr("data-status");if(status=='2'){$('#store_checbox').attr("data-status","1");$('#store_buy_btn').removeClass("disabled");$('#store_buy_btn').attr('onclick','buy_gift();');}else{$('#store_checbox').attr("data-status","2");$('#store_buy_btn').addClass("disabled");$('#store_buy_btn').attr('onclick','');}
					$('#store_buy_btn').focus();}
					function buy_gift(check1,check2){
						$('#store_buy_btn').attr('onclick','');
						var data={};
						data['buy_service']='1';
						data['server']=$('#store_server').val();
						data['service']=$('#store_services').val();
						data['tarifs']=$('#store_tarifs').val();
						data['steam_id']=$('#player_steam_id').val();
						data['player_efield']=$('#player_efield').val();
						data['check1']=check1;data['check2']=check2;
						$.ajax({type:"POST",url:"../ajax/actions_ugift.php",data:create_material(data),dataType:"json",success:function(result){NProgress.done();if(result.status==1){setTimeout(show_ok,500);$('#buy_service_area').html('<div class="bs-callout bs-callout-success transition_h_2">'+result.data+'</div>');$('#balance').html(result.shilings);}
					if(result.status==2){setTimeout(show_error,500);show_input_error(result.input,result.reply,null);reset_buying_gift(1);}
					if(result.status==3){setTimeout(show_error,500);$('#buy_result').html("<p class='text-danger'>"+result.data+"</p>");reset_buying_gift(1);}
					if(result.status==4){$('#buy_result').html("<p class='text-danger'>На сервере уже имеется услуга, прикрепленная к данному игровому аккаунту. Желаете совместить услуги?</p>");$('#store_answer_btn').removeClass('disp-n');$('#store_answer_btn').attr('onclick','reset_buying_gift();');$('#store_buy_btn').html("Да");$('#store_buy_btn').attr('onclick','buy_gift(1,0);');}
					if(result.status==5){$('#buy_result').html('<p class="text-danger">Вам предложено изменить группу на "'+result.group+'". Принять предложение?</p>');$('#store_answer_btn').removeClass('disp-n');$('#store_answer_btn').attr('onclick','buy_gift(1,2);');$('#store_buy_btn').html("Да");$('#store_buy_btn').attr('onclick','buy_gift(1,1);');}}});}
					function reset_buying_gift(type){if(type!=1){$('#buy_result').empty();}
					$('#store_answer_btn').addClass('disp-n');$('#store_answer_btn').attr('onclick','');$('#store_buy_btn').attr('onclick','buy_gift();');$('#store_buy_btn').html("Купить");}
					
					function get_gifts(id){var data={};data['get_services']='1';data['id']=id;$.ajax({type:"POST",url:"../ajax/actions_ugift.php",data:create_material(data),dataType:"json",success:function(result){if(result.status==1){$("#store_services").html(result.data);get_tarifs_gift(result.service);}}});}
					
					function get_gift_fields(id){
						var data={};
						data['get_gift_fields']='1';
						data['id']=id;
						$.ajax({
							type:"POST",
							url:"../ajax/actions_ugift.php",
							data:create_material(data),
							dataType:"json",
							success:function(result){
								if(result.status==1){
									$("#gift_fields").html(result.data);
								}
							}
						});
					}
					
					function get_tarifs_gift(id){
						var data={};
						data['get_tarifs']='1';
						data['id']=id;
						$.ajax({
							type:"POST",
							url:"../ajax/actions_ugift.php",
							data:create_material(data),
							dataType:"json",
							success:function(result){
								if(result.status==1){
									$("#store_tarifs").html(result.data);
									$("#store_service_info").html(result.text);
								}
							}
						});
					}
					
					function get_server_gift(id){var data={};data['get_server_store']='1';data['id']=id;data['type']=1;$.ajax({type:"POST",url:"../ajax/actions_ugift.php",data:create_material(data),success:function(html){$("#store_server_info").html(html);local_change_service();}});}
					local_change_serv();
					</script>
				</div>
			</div>
		</div>
		{/if}
	</div>
</div>

<div class="col-lg-3 order-is-last">
	{if(is_auth())}
		{include file="/home/navigation.tpl"}
		{include file="/home/sidebar_secondary.tpl"}
	{else}
		{include file="/index/authorization.tpl"}
		{include file="/home/sidebar_secondary.tpl"}
	{/if}
</div>