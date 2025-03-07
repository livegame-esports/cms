<?php

class Payments
{
	private $cashiers;

	public function __construct()
	{
		$this->cashiers = getMerchants();
	}

	function selectPayment($cashierKey)
	{
		return '[' . $this->cashiers[$cashierKey]['name'] . '] : ';
	}

	public function getCashier($cashierKey)
	{
		if(array_key_exists($cashierKey, $this->cashiers)) {
			return $this->cashiers[$cashierKey];
		} else {
			return [];
		}
	}

	public static function getCashierCurrency($slug)
	{
		global $config_additional;

		return (isset($config_additional) && array_key_exists($slug . 'Currency', $config_additional))
			? $config_additional[$slug . 'Currency']
			: 'RUB';
	}

	public function generatePayId()
	{
		return time() . '0' . rand(1, 9);
	}

	public function generatePayDescription($siteName)
	{
		return 'Пополнение баланса на ' . $siteName;
	}

	public function isCashierEnable($cashierKey)
	{
		$cashier = pdo()
			->query("SELECT $cashierKey FROM config__bank LIMIT 1")
			->fetch(PDO::FETCH_OBJ);

		if($cashier->$cashierKey == 1) {
			return true;
		} else {
			return false;
		}
	}

	public static function showForm($url, $parameters)
	{
		?>
		<form id="pay_form" method="post" action="<?php echo $url; ?>">
			<?php
			foreach($parameters as $name => $value) {
				?>
				<input type="hidden" name="<?php echo $name; ?>" value="<?php echo $value; ?>"/>
				<?php
			}
			?>
		</form>
		<script>
          document.getElementById('pay_form').submit();
		</script>
		<?php
	}

	public static function showError($message)
	{
		?>
		<script>alert('<?php echo $message; ?>');</script>
		<?php
	}

	public static function showLink($url, $parameters = [])
	{
		if(empty($parameters)) {
			$link = $url;
		} else {
			$link = $url . '?' . http_build_query($parameters);
		}

		?>
		<script>document.location.href = '<?php echo $link; ?>';</script>
		<?php
	}

	function selectPaymentMess($mess)
	{
		switch($mess) {
			case 'bad sign':
				$mess = 'Неверная подпись';
				break;
			case 'unknown user':
				$mess = 'Неизвестный ID пользователя';
				break;
			case 'invalid purse':
				$mess = 'Неверный кошелек';
				break;
			case 'invalid request':
				$mess = 'Неверный запрос';
				break;
			case 'empty data':
				$mess = 'Пустые данные';
				break;
		}
		return $mess;
	}

	function getUser($pdo, $user_id)
	{
		$STH = $pdo->query("SELECT `id`, `shilings`, `invited`, `login`, `email` FROM `users` WHERE `id`='$user_id' LIMIT 1");
		$STH->setFetchMode(PDO::FETCH_OBJ);
		return $STH->fetch();
	}

	function doPayAction($pdo, $user, $amount, $bank, $pay_method, $pay_number, $currency)
	{
		$amount = check($amount, "float");
		$bank   = $bank + $amount;
		$STH    = $pdo->prepare("UPDATE `users` SET `shilings`=:shilings WHERE `id`='$user->id' LIMIT 1");
		if($STH->execute(['shilings' => $user->shilings + $amount]) == '1') {
			$STH = $pdo->prepare("UPDATE config SET bank=:bank LIMIT 1");
			$STH->execute(['bank' => $bank]);
			$STH = $pdo->prepare(
				"INSERT INTO money__actions (date,shilings,author,type) VALUES (:date, :shilings, :author, :type)"
			);
			$STH->execute(['date' => date("Y-m-d H:i:s"), 'shilings' => $amount, 'author' => $user->id, 'type' => '1']);
			$this->paymentLog($pay_method, $amount, $pdo, $user->id, 1);

			$STH = $pdo->query("SELECT bonuses FROM config__secondary LIMIT 1");
			$STH->setFetchMode(PDO::FETCH_OBJ);
			$bonuses = $STH->fetch();
			if($bonuses->bonuses == 1) {
				$STH = $pdo->prepare("SELECT data FROM config__strings WHERE id=:id LIMIT 1");
				$STH->setFetchMode(PDO::FETCH_OBJ);
				$STH->execute([':id' => '3']);
				$bonuses = $STH->fetch();

				if(!empty($bonuses->data)) {
					$bonuses = unserialize($bonuses->data);

					for($i = 0; $i < count($bonuses); $i++) {
						if(!empty($bonuses[$i]['value'])) {
							if($bonuses[$i]['start'] <= $amount && $amount <= $bonuses[$i]['end']) {
								if($bonuses[$i]['type'] == 1) {
									$bonus = $bonuses[$i]['value'];
								} else {
									$bonus = round($bonuses[$i]['value'] * $amount / 100, 2);
								}

								$STH = $pdo->prepare(
									"UPDATE `users` SET `shilings`=:shilings WHERE `id`='$user->id' LIMIT 1"
								);
								$STH->execute(['shilings' => $user->shilings + $amount + $bonus]);

								$STH = $pdo->prepare(
									"INSERT INTO money__actions (date,shilings,author,type) VALUES (:date, :shilings, :author, :type)"
								);
								$STH->execute(
									[
										'date'     => date("Y-m-d H:i:s"),
										'shilings' => $bonus,
										'author'   => $user->id,
										'type'     => '12'
									]
								);

								break;
							}
						}
					}
				}
			}

			if(!empty($user->invited)) {
				$STH = $pdo->query("SELECT referral_program, referral_percent FROM config__prices LIMIT 1");
				$STH->setFetchMode(PDO::FETCH_OBJ);
				$ref = $STH->fetch();
				if($ref->referral_program == 1) {
					$STH = $pdo->prepare("SELECT id, shilings FROM users WHERE id=:id LIMIT 1");
					$STH->setFetchMode(PDO::FETCH_OBJ);
					$STH->execute([':id' => $user->invited]);
					$inviter = $STH->fetch();
					$amount  = round($amount - calculate_price($amount, $ref->referral_percent), 2);
					$STH     = $pdo->prepare(
						"INSERT INTO money__actions (date,shilings,author,type,gave_out) VALUES (:date, :shilings, :author, :type, :gave_out)"
					);
					$STH->execute(
						[
							'date'     => date("Y-m-d H:i:s"),
							'shilings' => $amount,
							'author'   => $inviter->id,
							'type'     => '11',
							'gave_out' => $user->id
						]
					);

					$STH = $pdo->prepare("UPDATE `users` SET `shilings`=:shilings WHERE `id`='$inviter->id' LIMIT 1");
					$STH->execute(['shilings' => $inviter->shilings + $amount]);

					incNotifications();

					$noty = referal_money($amount . $currency, $user->id, $user->login);
					send_noty($pdo, $noty, $inviter->id, 2);
				}
			}
		}
		$this->insertPay($pay_method, $pay_number, $pdo);
	}

	function issetPay($pdo, $pay_method, $pay_number)
	{
		$STH = $pdo->prepare("SELECT id FROM pays WHERE method=:method AND payid=:payid LIMIT 1");
		$STH->setFetchMode(PDO::FETCH_OBJ);
		$STH->execute([':method' => $pay_method, ':payid' => $pay_number]);
		$row = $STH->fetch();
		if(isset($row->id)) {
			return true;
		} else {
			return false;
		}
	}

	function insertPay($pay_method, $pay_number, $pdo)
	{
		$STH = $pdo->prepare("INSERT INTO pays (method,payid,date) VALUES (:method, :payid, :date)");
		$STH->execute([':method' => $pay_method, ':payid' => $pay_number, ':date' => date("Y-m-d H:i:s")]);
	}

	function paymentLog($payment, $log, $pdo, $user, $type)
	{
		global $messages;

		$payment = $this->selectPayment($payment);

		if($type == 1) {
			$log  = "Пополнение счета на " . $log . $messages['RUB'];
			$file = get_log_file_name("payment_successes");
		} else {
			$log  = $this->selectPaymentMess($log);
			$file = get_log_file_name("payment_errors");
		}

		if(file_exists($_SERVER['DOCUMENT_ROOT'] . "/logs/" . $file)) {
			$i = "a";
		} else {
			$i = "w";
		}

		if(empty($user) or $user == 0) {
			$user = 'Неизвестный';
		} else {
			$STH = $pdo->prepare("SELECT id, login FROM users WHERE id=:val LIMIT 1");
			$STH->setFetchMode(PDO::FETCH_OBJ);
			$STH->execute([':val' => $user]);
			$row = $STH->fetch();
			if(isset($row->id)) {
				$user = $row->login . ' - ' . $row->id;
			} else {
				$user = 'Неизвестный';
			}
		}

		$error_file = fopen($_SERVER['DOCUMENT_ROOT'] . "/logs/" . $file, $i);
		fwrite(
			$error_file,
			$payment . "[" . date("Y-m-d H:i:s")
			. " | " . $_SERVER["REMOTE_ADDR"]
			. " | " . $user . "] : [" . $log . "] \r\n"
		);
		fclose($error_file);
	}
}