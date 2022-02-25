
<!-- Start elements/nav_li.tpl -->
<?php if('{href}' != 'active'): ?>
	<li><a href="{href}" title="Перейти к: {name}">{name}</a></li> /
<?php else: ?>
	<li class="active">{name}</li>
<?php endif; ?>
<!-- End elements/nav_li.tpl -->
