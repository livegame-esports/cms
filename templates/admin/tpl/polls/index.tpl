<div class="page">
	<div class="col">
		<div class="block">
			<div class="block_head">Добавление опроса</div>
			<form class="polladdform">
				<b>Название</b><input name="name" class="form-control mt-10" type="text" maxlength="255" autocomplete="off" placeholder="Название опроса">
				<b>Варианты ответов</b>
				<div class="polls" name="polls">
					<div class="input-group">
						<input class="form-control" name="poll" type="text" maxlength="128" autocomplete="off" placeholder="Вариант">
						<span class="input-group-btn">
							<a class="del_poll btn btn-primary" href="">-</a>
							<a class="add_poll btn btn-primary" href="">+</a>
						</span>
					</div>
				</div>
				<button class="btn2 mt-10" type="submit">Добавить</button>
				<div class="result" style="color:green;padding:inherit;"></div>
			</form>
		</div>
	</div>
	{rows}
</div>
<script>

$('.polls').on('click', '.del_poll', function(e) {
	e.preventDefault();
	let $poll = $(this).parent().parent();
	
	if ($poll.siblings().length) {
		$poll.remove();
	}
});

$('.polls').on('click', '.add_poll', function(e) {
	e.preventDefault();
	let $parent = $(this).parent().parent();
	let $poll = $parent.clone();
	$parent.after($poll);
	$poll.find('input').prop('placeholder','Вариант').val('').focus();
});

function poll_post(e, data, method) {
	NProgress.start();
	
	data['token']=$('#token').val();
	data['method']=method;
	data['name']=$(e).children('input[name=name]').val();
	data['polls']=JSON.stringify(
		Object.values($(e).serializeArray()).filter(({ name }) => name === 'poll').map(({ value }) => value)
	);
	console.log(data)
	$.ajax({
		type:"POST",
		url:"../ajax/actions_poll.php",
		data:create_material(data),
		dataType:"json",
		success:function(result){
			NProgress.done();
			if(result.status==1){
				setTimeout(show_ok,500);
				$('#name').val('');
			} else {
				setTimeout(show_error,500);
			}
			$(e).children('.result').html(result.data);
		}
	});
}

$(".polladdform").on("submit",function(event) {
	event.preventDefault();
	poll_post(this,{},'poll_add_function');
	
});

$(".polleditform").on("submit",function(event) {
	event.preventDefault();
	poll_post(this,{pollid:$(this).children('input[name=pollid]').val()},'poll_edit_function');
});

function poll_dell_function(id){
	NProgress.start();
	var data={};
	data['method']='poll_dell_function';
	data['pollid']=id;
	$.ajax({type:"POST",url:"../ajax/actions_poll.php",data:create_material(data),dataType:"json",success:function(result){
		NProgress.done();
		if(result.status==1){
			setTimeout(show_ok,500);
			$("#poll_"+id).remove();
		} else {
			$("#result"+id).html(result.data);
			setTimeout(show_error,500);
		}
	}});
}
</script>