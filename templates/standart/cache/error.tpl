<div class="col-lg-9 order-is-first">
	<div class="noty-block error">
		<h4>Произошла ошибка...</h4>
		<p>{message}</p>
	</div>
</div>
<div class="col-lg-3 order-is-last">
	<div class="block">
	<div class="block_head">
		Навигация
	</div>
	<div class="vertical-navigation">
		<ul>
			<?php for($i=0; $i < count($vertical_menu); $i++): ?>  
			<li>
				<a href="<?php echo $vertical_menu[$i]['link']; ?>"><?php echo $vertical_menu[$i]['name']; ?></a>
			</li>
			<?php endfor; ?>
		</ul>
	</div>
</div>
</div>