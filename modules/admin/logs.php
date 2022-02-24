<?php

global $PI;


$logs = (new Logs())->getLogs();

foreach($logs as $key => $value) {
	if(file_exists($value['file'])) {
		$size    = calculate_size(filesize($value['file']));
	} else {
		$size    = 0;
	}

	$logs[$key]['size']    = $size;
	$logs[$key]['header'] = $value['header'];
}

(new Page())
	->setBreadCrumbs(
		[
			$PI->to_nav('admin'),
			$PI->to_nav('admin_logs', 1)
		]
	)
	->collectPage('logs.tpl');
