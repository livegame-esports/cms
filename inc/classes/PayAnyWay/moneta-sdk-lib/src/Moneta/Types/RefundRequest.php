<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Возврат средств по указанной операции.
	 * Request for refunding a transaction.
	 * 
 */
class RefundRequest
{
	
	/**
	 * Номер операции в системе МОНЕТА.РУ, по которой необходимо вернуть деньги.
	 * Unique identifier of the transaction in MONETA.RU that requires a refund.
	 * 
	 *
	 * @var long
	 */
	 public $transactionId = null;

	/**
	 * Сумма, которую необходимо возвратить.
	 * Если сумма не указана, то сумма для возврата берется из указанной операции.
	 * Refund amount that is specified in the payee's currency of the original transaction.
	 * If the amount element is omitted, MONETA.RU refunds the amount that was specified by the payee in the original transaction.
	 * 
	 *
	 * @var decimal
	 */
	 public $amount = null;

	/**
	 * Платежный пароль.
	 * Payment password for the payer's account.
	 * 
	 *
	 * @var normalizedString
	 */
	 public $paymentPassword = null;

	/**
	 * Внешний номер операции.
	 * Merchant transaction ID.
	 * 
	 *
	 * @var string
	 */
	 public $clientTransaction = null;

	/**
	 * Описание операции.
	 * Transaction description or comments.
	 * 
	 *
	 * @var normalizedString
	 */
	 public $description = null;

	/**
	 * Набор полей, которые необходимо сохранить в качестве атрибутов операции. Значения дат в формате dd.MM.yyyy HH:mm:ss
	 * Key-value pairs that will be saved as transaction attributes. For dates, use the following format: dd.MM.yyyy HH:mm:ss
	 * 
	 *
	 * @var OperationInfo
	 */
	 public $operationInfo = null;

	/**
	 * Запрос для платежного пароля.
	 * Challenge passcode that you received in the GetAccountPaymentPasswordChallenge response in the paymentPasswordChallenge element. Specify this element in the following cases:
	 * If a user gets payment passwords by SMS, set paymentPasswordChallenge to SMS. Set paymentPassword to the value that the user receives in the SMS from MONETA.RU.
	 * If a user gets a sequence number (index) for a password from a list of transaction authentication numbers (TANs), set paymentPasswordChallenge to the TAN index. Set paymentPassword to the TAN that has the specified index.
	 * 
	 *
	 * @var string
	 */
	 public $paymentPasswordChallenge = null;

}
