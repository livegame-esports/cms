<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на сохранение делегированного доступа к счету.
	 * Request for granting delegated access to the MONETA.RU account.
	 * 
 */
class SaveAccountRelationRequest extends AccountRelation
{
	
	/**
	 * Платежный пароль.
	 * Payment password for the account.
	 * 
	 *
	 * @var normalizedString
	 */
	 public $paymentPassword = null;

	/**
	 * Запрос для платежного пароля.
	 * Challenge passcode that you received in the GetAccountPaymentPasswordChallenge
	 * response in the paymentPasswordChallenge element. Specify this element in the
	 * following cases:
	 * If a user gets payment passwords by SMS, set paymentPasswordChallenge to
	 * SMS. Set paymentPassword to the value that the user receives in the SMS from
	 * MONETA.RU.
	 * If a user gets a sequence number (index) for a password from a list of
	 * transaction authentication numbers (TANs), set paymentPasswordChallenge to
	 * the TAN index. Set paymentPassword to the TAN that has the specified index.
	 * 
	 *
	 * @var string
	 */
	 public $paymentPasswordChallenge = null;

}
