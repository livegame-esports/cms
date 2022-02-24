<?php

class Logs
{
	private $logs = [
		'log'               => [
			'name'   => 'Общие логи',
			'reader' => 'mainLogsReader',
			'header' => '<tr><td>Дата</td><td>IP</td><td>Пользователь</td><td>Действие</td></tr>'
		],
		'error_log'         => [
			'name'   => 'Общие логи с ошибками',
			'reader' => 'mainLogsReader',
			'header' => '<tr><td>Дата</td><td>IP</td><td>Пользователь</td><td>Действие</td></tr>'
		],
		'pdo_errors'        => [
			'name'   => 'Логи с ошибками базы данных',
			'reader' => 'pdoLogsReader',
			'header' => '<tr><td>Дата</td><td>Хост</td><td>База</td><td>Действие</td></tr>'
		],
		'payment_successes' => [
			'name'   => 'Лог успешных пополнений счета',
			'reader' => 'paymentLogsReader',
			'header' => '<tr><td>Агрегатор</td><td>Дата</td><td>IP</td><td>Пользователь</td><td>Действие</td></tr>'
		],
		'payment_errors'    => [
			'name'   => 'Лог ошибок при пополнений счета',
			'reader' => 'paymentLogsReader',
			'header' => '<tr><td>Агрегатор</td><td>Дата</td><td>IP</td><td>Пользователь</td><td>Действие</td></tr>'
		],
		'services_log'      => [
			'name'   => 'Лог операция с привилегиями',
			'reader' => 'servicesLogsReader',
			'header' => '<tr><td>Дата</td><td>Пользователь</td><td>Сервер</td><td>Идентификатор</td><td>Услуга</td><td>Действие</td></tr>'
		],
		'stat'              => [
			'name'   => 'Лог посещений',
			'reader' => 'statLogsReader',
			'header' => '<tr><td>Дата</td><td>Данные о посетителе</td><td>IP</td><td>Посещенный URL</td></tr>'
		],
	];

	public function getLogs() {
		foreach($this->logs as $key => $value) {
			$this->logs[$key]['file'] = $this->getLogFile($key);
		}

		return $this->logs;
	}

	public function getLogContent($slug) {
		if(isset($this->logs[$slug])) {
			return $this->{$this->logs[$slug]['reader']}($this->getLogFile($slug));
		} else {
			return '';
		}
	}

	public function removeLog($slug) {
		if(isset($this->logs[$slug])) {
			unlink($this->getLogFile($slug));
		}
	}

	private function getLogFile($logName) {
		return __DIR__ . '/../../logs/' . get_log_file_name($logName);
	}

	private function getLogPartsForMain($logRow) {
		$log = explode('] : [', $logRow);

		if(count($log) > 1) {
			$meta = explode(' | ', mb_substr(trim($log[0]), 1));
			$content = mb_substr(trim($log[1]), 0, -1);

			return [$meta, $content];
		} else {
			return false;
		}
	}

	private function getLogPartsForPayments($logRow) {
		$log = explode('] : [', $logRow);

		if(count($log) > 1) {
			if(count($log) > 2) {
				$subMeta = mb_substr(trim($log[0]), 1);
				$meta = explode(' | ', trim($log[1]));
				$content = mb_substr(trim($log[2]), 0, -1);

				return [$subMeta, $meta, $content];
			} else {
				$meta = explode(' | ', mb_substr(trim($log[0]), 1));
				$content = mb_substr(trim($log[1]), 0, -1);

				return [$meta, $content];
			}

		} else {
			return false;
		}
	}

	private function collectUserTd($data) {
		$data = str_replace('Пользователь: ', '', $data);

		$user = explode(' - ', $data);

		if(count($user) == 1) {
			return $user[0];
		} else {
			return "<a href='../profile?id=$user[1]'>$data</a>";
		}
	}

	private function mainLogsReader($file) {
		$logs = explode('<br>', get_log_file($file));

		$data = '';

		foreach($logs as $log) {
			$log = $this->getLogPartsForMain($log);

			$data .= '<tr>';

			if($log) {
				$meta = $log[0];
				$content = $log[1];

				$data .= '<tr>';

				if(count($meta) == 1) {
					$data .= "<td colspan='3'>$meta[0]</td>";
				} else {
					$data .= "<td>$meta[0]</td><td>$meta[1]</td><td>" . $this->collectUserTd($meta[2]) . "</td>";
				}

				$data .= "<td>$content</td>";
			}

			$data .= "</tr>";
		}

		return $data;
	}

	private function pdoLogsReader($file) {
		$logs = explode('<br>', get_log_file($file));

		$data = '';

		foreach($logs as $log) {
			$log = $this->getLogPartsForMain($log);

			$data .= '<tr>';

			if($log) {
				$meta = $log[0];
				$content = $log[1];

				$data .= '<tr>';

				if(count($meta) == 1) {
					$data .= "<td colspan='3'>$meta[0]</td>";
				} else {
					$data .= "<td>$meta[0]</td><td>$meta[1]</td><td>$meta[2]</td>";
				}

				$data .= "<td>$content</td>";
			}

			$data .= "</tr>";
		}

		return $data;
	}

	private function paymentLogsReader($file) {
		$logs = explode('<br>', get_log_file($file));

		$data = '';

		foreach($logs as $log) {
			$log = $this->getLogPartsForPayments($log);

			$data .= '<tr>';

			if($log) {
				if(empty($log[2])) {
					$data .= "<td colspan='4'>{$log[0][0]}</td><td>$log[1]</td>";
				} else {
					$subMeta = $log[0];
					$meta = $log[1];
					$content = $log[2];
					$data .= "<td>$subMeta</td><td>$meta[0]</td><td>$meta[1]</td><td>" . $this->collectUserTd($meta[2]) . "</td><td>$content</td>";
				}
			}

			$data .= "</tr>";
		}

		return $data;
	}

	private function servicesLogsReader($file) {
		$logs = explode('<br>', get_log_file($file));

		$data = '';

		foreach($logs as $log) {
			$log = explode('] : [', $log);

			if(count($log) > 1) {
				$content = mb_substr(trim($log[1]), 0, -1);
				$meta = mb_substr(trim($log[0]), 1);

				$data .= '<tr>';
				$metaParts = explode(' | Пользователь: ', $meta);
				if(isset($metaParts[1])) {
					$date = $metaParts[0];

					$metaParts = explode(' | Сервер: ', $metaParts[1]);
					$user = $this->collectUserTd($metaParts[0]);

					$metaParts = explode(' | Идентификатор: ', $metaParts[1]);
					$server = $metaParts[0];

					$metaParts = explode(' | Услуга: ', $metaParts[1]);
					$steam = $metaParts[0];
					if(isset($metaParts[1])) {
						$service = $metaParts[1];
					} else {
						$service = '';
					}

					$data .= "<td>$date</td><td>$user</td><td>$server</td><td>$steam</td><td>$service</td>";
				} else {
					$data .= "<td colspan='5'>$meta</td>";
				}
				$data .= "<td>$content</td>";
				$data .= "</tr>";
			}
		}

		return $data;
	}

	private function statLogsReader($file) {
		if(file_exists($file)) {
			$file = file($file);
			$col  = sizeof($file);

			if($col > sizeof($file)) {
				$col = sizeof($file);
			}

			$data = '';

			for($i = sizeof($file) - 1; $i + 1 > sizeof($file) - $col; $i--) {
				$string = explode("|", $file[$i]);

				for($j = 0; $j < count($string); $j++) {
					if(empty($string[$j])) {
						$string[$j] = '';
					}
				}

				$data .= "<tr><td>$string[0]</td><td>$string[1]</td><td>$string[2]</td><td>$string[3]</td></tr>";
			}
		} else {
			$data = '';
		}

		return $data;
	}
}