<tr>
	<td>
	<?php if('{shilings}' > '0'): ?>
		<p class="text-success">{shilings} <?php echo $messages['RUB']; ?></p>
	<?php else: ?>
		<p class="text-danger">{shilings} <?php echo $messages['RUB']; ?></p>
	<?php endif; ?>
	</td>
	<td>{type}</td>
	<td>{date}</td>
</tr>