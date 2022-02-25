<div class="block" style="margin-top: 5vh;">
	<div class="block_head">
		Посетители профиля:
	</div>
	<div id="users_visit" style="margin-top: 15px;">
		<a class="user_visit" target="_blank" href="../profile?id={id}" tooltip="yes" title="" data-original-title="{login}"><img src="../{avatar}" alt="{login}" />
			<script>
				get_user_visit({
					profile_id
				});
			</script>
	</div>
</div>

<script>
	user_visit({
		profile_id
	});
</script>