<?php

global $PI;

$configSecondary = pdo()->query("SELECT * FROM config__secondary LIMIT 1")->fetch(PDO::FETCH_OBJ);

(new Page())
	->setBreadCrumbs(
		[
			$PI->to_nav('admin'),
			$PI->to_nav('admin_guard', 1)
		]
	)
	->collectPage('guard.tpl');
