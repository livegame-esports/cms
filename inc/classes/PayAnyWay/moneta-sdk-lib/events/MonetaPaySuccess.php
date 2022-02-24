<?php

global $messages;

$Pm        = new Payments;
$payMethod = 'payanyway';

try {
	$currentCurrency = Payments::getCashierCurrency($payMethod);

	if(
		empty($_POST['MNT_AMOUNT'])
		|| empty($_POST['MNT_TRANSACTION_ID'])
		|| empty($_POST['user_id'])
	) {
		throw new Exception('empty data');
	}

	$amount    = clean($_POST['MNT_AMOUNT'], 'float');
	$payNumber = clean($_POST['MNT_TRANSACTION_ID'], 'int');
	$userId    = clean($_POST['user_id'], 'int');

	$userInfo = $Pm->getUser(pdo(), $userId);
	if(empty($userInfo->id)) {
		throw new Exception('unknown user');
	} else {
		if(!$Pm->issetPay(pdo(), $payMethod, $payNumber)) {
			if(
				isEmailIntroduced($userInfo->email)
				&& isset($config_additional)
				&& array_key_exists('payAnyWayPrintCheck', $config_additional)
				&& $config_additional['payAnyWayPrintCheck'] == true
			) {
				$monetaSDK = new Moneta\MonetaSdk();
				$kassa = $monetaSDK->getKassaService();

				$document = [
					'id'               => $payNumber,
					'checkoutDateTime' => date(DATE_ATOM),
					'docNum'           => $payNumber,
					'docType'          => 'SALE',
					'email'            => $userInfo->email,
					'inventPositions'  => [
						[
							'name'     => (new Payments)->generatePayDescription(clean_name(configs()->name)),
							'price'    => $amount,
							'quantity' => 1,
							'vatTag'   =>
								$kassa::VATNOVAT
						],
					],
					'moneyPositions'   => [
						['paymentType' => 'CARD', 'sum' => $amount],
					]
				];

				$document = json_encode($document, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
				$result = $kassa->sendDocument($document);
			}

			$Pm->doPayAction(
				pdo(),
				$userInfo,
				$amount,
				configs()->bank,
				$payMethod,
				$payNumber,
				$messages['RUB']
			);
		}
	}
} catch(Exception $e) {
	if(empty($userId)) {
		$userId = 0;
	}

	$Pm->paymentLog($payMethod, $e->getMessage(), pdo(), $userId, 2);
	http_response_code(500);
	exit($e->getMessage());
}