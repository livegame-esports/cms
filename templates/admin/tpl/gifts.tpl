<div class="page">
	<div class="col-md-12">
		<div class="block">
			<div class="block_head">
				Выберите сервер
			</div>
			<select class="form-control" onchange="server_change_gift();" id="server">
				{servers}
			</select>
		</div>
	</div>
	<div class="col-md-12">
		<div class="block">
			<div class="block_head">
				Автоматическое добавление
			</div>
			<script>
			var ebonus = '<p><span style="color:#e67e23;">Бонусы <span style="color:#169179;">/anew</span></span></p>\n<p><span style="color:#e67e23;">Перед покупкой и в момент покупки вы не должны находиться на сервере, да бы зачисление прошло успешно</span></p>';
			var eprefix = '<p><span style="color:#e67e23;">Индивидуальный префикс в чате. Не плохая возможность выделиться среди всех игроков.</span></p><p><span style="color:#e67e23;"><span style="color:#7e8c8d;">!g</span> - <span style="color:#2dc26b;">зеленый</span></span></p><p><span style="color:#e67e23;"><span style="color:#7e8c8d;">!t</span> - цвет команды, <span style="color:#ba372a;">T</span> - <span style="color:#3598db;">CT</span></span></p><p><span style="color:#e67e23;"><span style="color:#7e8c8d;">!n</span> - нейтральный, <span style="color:#f1c40f;">желтый</span></span></p><p><span style="color:#e67e23;">Пример: <span style="color:#2dc26b;">!g[</span><span style="color:#f1c40f;">!nko1dun</span><span style="color:#2dc26b;">!g]</span></span></p>';
			</script>
			<button class="btn2 mt-10" onclick="add_auto_gift('Бонусы','buy_bonus','шт.',ebonus);">Buy Bonus</button>
			<button class="btn2 mt-10" onclick="add_auto_gift('Префиксы','buy_prefix','дня(ей)',eprefix);">Buy Prefix</button>
		</div>
	</div>
	<div class="col-md-12">
		<div class="block">
		<p><center><font color="green"><b>Скачать плагины можно тут:</font><a style="color:red" href="https://awscode.ru/pages/gamecms/plugins"> ЗАГРУЗИТЬ</a>.<br><a style="color:blue" href="https://vk.com/id503477854">По поводу функционала к НЕМУ.</a></b></p></center>
		</div>
	</div>
	<div class="col-md-6">
		<div class="block">
			<div class="block_head">
				Добавить предмет
			</div>

			<select class="form-control mt-10" id="sale">
				<option value="1">Продажа: Включена</option>
				<option value="2">Продажа: Выключена</option>
			</select>
			<select class="form-control mt-10" id="show">
				<option value="1">Отображение на странице администраторов: Включено</option>
				<option value="2">Отображение на странице администраторов: Выключено</option>
			</select>
			<input class="form-control mt-10" type="text" maxlength="255" id="name" placeholder="Наименование предмета" autocomplete="off">
			<input class="form-control mt-10" type="text" maxlength="25" id="flags" placeholder="Обработчик" autocomplete="off">
			<input class="form-control mt-10" type="text" maxlength="25" id="stime" placeholder="Измерение" autocomplete="off">
			<input class="form-control mt-10" type="number" maxlength="2" id="discount" placeholder="Скидка (в % от 0 до 99)" autocomplete="off">
			<div class="form-group">
				<small>db хост</small><input type="text" class="form-control" id="db_ihost" maxlength="64" placeholder="localhost" autocomplete="off">
				<small>db логин</small><input type="text" class="form-control" id="db_ilogin" maxlength="64" placeholder="dbuser" autocomplete="off">
				<small>db пароль</small><input type="password" class="form-control" id="db_ipass" maxlength="64" placeholder="password" autocomplete="off">
				<small>db база</small><input type="text" class="form-control" id="db_iname" maxlength="64" placeholder="dbname" autocomplete="off">
			</div>
			<br>
			<textarea id="text" class="form-control maxMinW100" rows="5">Описание</textarea>
			<button class="btn2 mt-10" onclick="add_service_gift();">Добавить</button>
		</div>
	</div>
	<div class="col-md-6">
		<div class="block">
			<div class="block_head">
				Добавить тариф
			</div>
			Выберите услугу:
			<select class="form-control" id="services"></select>
			<input class="form-control mt-10" type="text" maxlength="7" id="time" placeholder="Количество / дней" autocomplete="off">
			<input class="form-control mt-10" type="number" maxlength="6" id="pirce" placeholder="Цена (в рублях)" autocomplete="off">
			<input class="form-control mt-10" type="number" maxlength="2" id="tarif_discount" placeholder="Скидка (в % от 0 до 99)" autocomplete="off">
			<button class="btn2 mt-10" onclick="add_tarif_gift();">Добавить</button>
		</div>
	</div>
	<div class="col-md-12 mt-10" id="services2">
		<center><img src="{site_host}templates/admin/img/loader.gif"></center>
	</div>
</div>
<script>
function add_auto_gift(name,flags,stime,text){
	NProgress.start();
	var token=$('#token').val();
	var server=$('#server').val();
	text=$.trim(text);
	server=encodeURIComponent(server);
	name=encodeURIComponent(name);
	flags=encodeURIComponent(flags);
	stime=encodeURIComponent(stime);
	text=encodeURIComponent(text);
	$.ajax({
		type:"POST",
		url:"../ajax/actions_gift.php",
		data:"phpaction=1&add_service=1&token="+token+"&server="+server+"&name="+name+"&show=1&discount=0&stime="+stime+"&flags="+flags+"&text="+text+"&sale=1",dataType:"json",
		success:function(result){
			if(result.status==1){
				NProgress.done();
				setTimeout(show_ok,500);
				get_gifts();
				get_gifts2();
			} else {
				NProgress.done();
				setTimeout(show_error,500);
				show_input_error(result.input,result.reply,null);
			}
		}
	});
}
function edit_service_gift(id){
	NProgress.start();
	var token=$('#token').val();
	var name=$('#name'+id).val();
	var flags=$('#flags'+id).val();
	var stime=$('#stime'+id).val();
	var text=tinymce.get("text"+id).getContent();
	var sale=$('#sale'+id).val();
	var show=$("#show"+id).val();
	var discount=$("#discount"+id).val();
	
	var db_ihost=$("#db_ihost"+id).val();
	var db_ilogin=$("#db_ilogin"+id).val();
	var db_ipass=$("#db_ipass"+id).val();
	var db_iname=$("#db_iname"+id).val();
	db_ihost=encodeURIComponent(db_ihost);
	db_ilogin=encodeURIComponent(db_ilogin);
	db_ipass=encodeURIComponent(db_ipass);
	db_iname=encodeURIComponent(db_iname);
	
	text=$.trim(text);
	name=encodeURIComponent(name);
	flags=encodeURIComponent(flags);
	stime=encodeURIComponent(stime);
	text=encodeURIComponent(text);
	sale=encodeURIComponent(sale);
	show=encodeURIComponent(show);
	discount=encodeURIComponent(discount);
	$.ajax({
		type:"POST",
		url:"../ajax/actions_gift.php",
		data:"phpaction=1&edit_service=1&token="+token+"&name="+name+"&show="+show+"&discount="+discount+"&stime="+stime+"&flags="+flags+"&text="+text+"&id="+id+"&sale="+sale+"&db_ihost="+db_ihost+"&db_ilogin="+db_ilogin+"&db_ipass="+db_ipass+"&db_iname="+db_iname,dataType:"json",
		success:function(result){
			if(result.status==1){
				NProgress.done();
				setTimeout(show_ok,500);
				get_gifts();
			}else{
				NProgress.done();
				setTimeout(show_error,500);
				show_input_error(result.input+id,result.reply,null);
			}
		}
	});
}
function dell_service_gift(id){NProgress.start();var token=$('#token').val();$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:"phpaction=1&dell_service=1&token="+token+"&id="+id,success:function(){$("#service"+id).fadeOut();get_gifts();NProgress.done();setTimeout(show_ok,500);}});}
function up_service_gift(id){NProgress.start();var token=$('#token').val();$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:"phpaction=1&up_service=1&token="+token+"&id="+id,dataType:"json",success:function(result){NProgress.done();if(result.status==1){get_gifts2();setTimeout(show_ok,500);}else{setTimeout(show_error,500);}}});}
function down_service_gift(id){NProgress.start();var token=$('#token').val();$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:"phpaction=1&down_service=1&token="+token+"&id="+id,dataType:"json",success:function(result){NProgress.done();if(result.status==1){get_gifts2();setTimeout(show_ok,500);}else{setTimeout(show_error,500);}}});}
function edit_tarif_gift(id){NProgress.start();var data={};data['edit_tarif']='1';data['id']=id;data['pirce']=$('#pirce'+id).val();data['time']=$('#time'+id).val();data['discount']=$('#tarif_discount'+id).val();$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:create_material(data),dataType:"json",success:function(result){if(result.status==1){NProgress.done();setTimeout(show_ok,500);}else{NProgress.done();setTimeout(show_error,500);show_input_error(result.input+id,result.reply,null);}}});}
function dell_tarif_gift(id){NProgress.start();var data={};data['dell_tarif']='1';data['id']=id;$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:create_material(data),success:function(){$("#tarif"+id).fadeOut();NProgress.done();setTimeout(show_ok,500);}});}
function add_service_gift(){
	NProgress.start();
	var token=$('#token').val();
	var server=$('#server').val();
	var name=$('#name').val();
	var flags=$('#flags').val();
	var stime=$('#stime').val();
	var text=tinymce.get("text").getContent();
	var sale=$("#sale").val();
	var show=$("#show").val();
	var discount=$("#discount").val();
	var db_ihost=$("#db_ihost").val();
	var db_ilogin=$("#db_ilogin").val();
	var db_ipass=$("#db_ipass").val();
	var db_iname=$("#db_iname").val();
	db_ihost=encodeURIComponent(db_ihost);
	db_ilogin=encodeURIComponent(db_ilogin);
	db_ipass=encodeURIComponent(db_ipass);
	db_iname=encodeURIComponent(db_iname);
	text=$.trim(text);
	server=encodeURIComponent(server);
	name=encodeURIComponent(name);
	flags=encodeURIComponent(flags);
	stime=encodeURIComponent(stime);
	text=encodeURIComponent(text);
	sale=encodeURIComponent(sale);
	show=encodeURIComponent(show);
	discount=encodeURIComponent(discount);
	
	$.ajax({
		type:"POST",
		url:"../ajax/actions_gift.php",
		data:"phpaction=1&add_service=1&token="+token+"&server="+server+"&name="+name+"&show="+show+"&discount="+discount+"&stime="+stime+"&flags="+flags+"&text="+text+"&sale="+sale+"&db_ihost="+db_ihost+"&db_ilogin="+db_ilogin+"&db_ipass="+db_ipass+"&db_iname="+db_iname,dataType:"json",
		success:function(result){
			if(result.status==1){
				NProgress.done();
				setTimeout(show_ok,500);
				get_gifts();
				get_gifts2();
			} else {
				NProgress.done();
				setTimeout(show_error,500);
				show_input_error(result.input,result.reply,null);
			}
		}
	});
}
function add_tarif_gift(){NProgress.start();var data={};data['add_tarif']='1';data['service']=$('#services').val();data['pirce']=$('#pirce').val();data['time']=$('#time').val();data['discount']=$('#tarif_discount').val();$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:create_material(data),dataType:"json",success:function(result){if(result.status==1){NProgress.done();setTimeout(show_ok,500);get_gifts2();}else{NProgress.done();setTimeout(show_error,500);show_input_error(result.input,result.reply,null);}}});}
function get_gifts(){var token=$('#token').val();var id=$('#server').val();id=encodeURIComponent(id);$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:"phpaction=1&get_services=1&token="+token+"&id="+id,success:function(html){$("#services").html(html);}});}
function get_gifts2(tiny_code){if(typeof tinymce!="undefined"){tinymce.remove();}
if(typeof tinymce!="undefined"){init_tinymce('text',tiny_code,'lite',1);}
var token=$('#token').val();var id=$('#server').val();id=encodeURIComponent(id);$.ajax({type:"POST",url:"../ajax/actions_gift.php",data:"phpaction=1&get_services2=1&token="+token+"&id="+id,success:function(html){$("#services2").html(html);}});}

function server_change_gift() {
	var server = $('#server').val();
	location.href = '../admin/gift?server='+server;
}
if($.trim($("#server").html()) == '') {
	selectedValue == 1;
} else {
	var selectBox = document.getElementById("server");
	var selectedValue = selectBox.options[selectBox.selectedIndex].title;
}

get_gifts();
get_gifts2('{{md5($conf->code)}}');
</script>