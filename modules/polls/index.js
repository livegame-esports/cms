function poll_answer(pollid, answer, pool_type, el){
	NProgress.start();
	var data={};
	data['token']=$('#token').val();
	data['method']='poll_answer';
	data['pollid']=pollid;
	data['answer']=answer;
	data['pool_type']=pool_type;
	
	$.ajax({
		type:"POST",
		url:"../ajax/actions_poll.php",
		data:create_material(data),
		dataType:"json",
		success:function(result){
			NProgress.done();
			if(result.status==1){
				setTimeout(show_ok,500);
			} else {
				setTimeout(show_error,500);
			}
			
			$(el).parent().html(result.data);
		}
	});
}