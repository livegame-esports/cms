<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ содержит строку запроса для платежного пароля.
	 * Response to GetAccountPaymentPasswordChallengeRequest.
	 * 
 */
class GetAccountPaymentPasswordChallengeResponse
{
	
	/**
	 * Запрос для платежного пароля.
	 * Challenge passcode for users of indexed transaction authentication numbers (TANs).
	 * 
	 *
	 * @var string
	 */
	 public $paymentPasswordChallenge = null;

}
