<?php
include 'inc/dictionary.php';

if(phpversion()) {
	$phpVersion = explode('.', phpversion());
} else {
	$phpVersion = explode('.', PHP_VERSION);
}

if($phpVersion[0] <= 7) {
	$core = 'inc/core.php';
}

if(isset($core)) {
	if(file_exists($core)) {
		foreach(array('GD', 'mbstring') as $module) {
			if(!extension_loaded($module)) {
				exit('To run GameCMS requires PHP module ' . $module);
			}
		}

		require $core;
	} else {
		exit('Core file not found');
	}
} else {
	exit('php up to 7.4(incl.) / php до 7.4(вкл.)');
}
