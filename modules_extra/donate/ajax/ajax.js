function donate_money(id){
	var money=prompt("Сколько?: ","100");
	var token=$('#token').val();
	$.ajax({
		type:"POST",
		url: "../modules_extra/donate/ajax/actions.php",
		data:"phpaction=1&donate_money=1&token="+token+"&id="+id+"&money="+money,
		dataType:"json",
		success:function(result){
			1==result.status?(alert(result.res),location.reload()):alert("Жадина(")
		}
	});
}