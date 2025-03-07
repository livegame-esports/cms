<div class="chat_message" id="message_id_{id}">
	<a href="../profile?id={user_id}" title="{gp_name}">
		<img src="{avatar}">
	</a>
	<div class="message">
		<div class="info">
			<div class="author" onclick="treatment('{login}');" title="{gp_name}" style="color: {gp_color}">{login}</div>
			<div class="date" tooltip="yes" data-placement="left" title="{date_full}">{date_short}</div>
			{if(strripos("{gp_rights}", "d") !== false)}
				<span onclick="dell_chat_message('{id}');" tooltip="yes" data-placement="left" title="Удалить" class="m-icon icon-trash dell_message"></span>
				<span id="edit_message_{id}" onclick="edit_chat_message('{id}', this);" tooltip="yes" data-placement="left" title="Редактировать" class="m-icon icon-pencil edit_message"></span>
			{/if}
		</div>
		<div id="message_text_{id}" class="with_code">
			{text}
		</div>
		{if(strripos("{gp_rights}", "d") !== false)}
			<textarea id="message_text_e_{id}" class="form-control disp-n">{text}</textarea>
		{/if}
	</div>
</div>