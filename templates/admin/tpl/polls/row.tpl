<div class="col-md-6" id="poll_{id}">
	<div class="block">
		<form class="polleditform">
			<div class="block_head">{name} #{id}</div>
			<input name="pollid" type="hidden" value="{id}">
			<b>Название</b><input name="name" class="form-control mt-10" type="text" maxlength="255" autocomplete="off" placeholder="Название опроса" value="{name}">
			<b>Варианты ответов</b>
			<div class="polls" name="polls" id="polls_{id}"></div>
			<button class="btn2 mt-10" type="submit">Сохранить</button>
			<div class="btn2 mt-10" onclick="poll_dell_function({id});">Удалить</div>
			<div class="result" style="color:green;padding:inherit;"></div>
			<b>Код для встраивания в шаблон</b>
			<code>{func Polls:poll_small('{id}')&#125;</code>
		</form>
	</div>
</div>

<script>
$(document).ready(function(){
	let polls = '';
	JSON.parse('{polls}').forEach(function(pool, i, arr) {
		polls += '<div class="input-group">\
			<input class="form-control" name="poll" type="text" maxlength="128" autocomplete="off" placeholder="Вариант" value="'+pool+'">\
			<span class="input-group-btn">\
				<a class="del_poll btn btn-primary" href="">-</a>\
				<a class="add_poll btn btn-primary" href="">+</a>\
			</span>\
		</div>';
	});
	$("#polls_{id}").html(polls);
});
</script>