<div class="block">
	<div class="block_head">
		Сейчас онлайн <span id="users_online_number"></span>
	</div>
	<div id="online_users">
		{func Widgets:online_users()}
	</div>
</div>

{*
<div class="block" id="birthday_boys">
	<div class="block_head">
		Дни рождения
	</div>
	<div id="online_users">
		{func Widgets:birthday_boys()}
	</div>
</div>
*}

{if($conf->top_donators == '1')}
	<div class="block">
		<div class="block_head">
			Топ донатеров
		</div>
		<div id="online_users">
			{func Widgets:top_donators($conf->top_donators_count)}
		</div>
	</div>
{/if}

{if(isModuleActive('cases'))}
	<div id="case_banner"> <script>get_case_banner();</script> </div>
{/if}

<div class="block">
	<div class="block_head">
		Топ пользователей
	</div>
	<div id="top_users">
		{func Widgets:top_users('5')}
	</div>
</div>

<div class="block">
	<div class="block_head">
		Последнее на форуме
	</div>
	<div id="last_activity">
		{func Widgets:last_forum_activity('5')}
	</div>
</div>

<div id="site_stats"> <script>get_site_stats(2);</script> </div>

{if($conf->disp_last_online == '1')}
<div class="block">
	<div class="block_head">
		Сегодня были <span id="count_of_last_onl_us"></span>
	</div> 
	<div id="load_last_online">
		{func Widgets:were_online()}
	</div>
</div>
{/if}
