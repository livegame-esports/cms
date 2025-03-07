<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на подтверждение сотового телефона пользователя (поле cell_phone объекта tns:Profile).
	 * The second request for the confirmation of a user's phone number that is specified in the cell_phone element of tns:Profile.
	 * After you send the ApprovePhoneSendConfirmation request, the user receives an SMS message with the verification code to the unconfirmed mobile phone number. Use the ApprovePhoneApplyCode request to send the verification code to MONETA.RU.
	 * 
 */
class ApprovePhoneApplyCodeRequest
{
	
	/**
	 * ID пользователя в системе МОНЕТА.РУ. Если это поле не задано, то используется текущий пользователь.
	 * The unique identifier of the MONETA.RU user whose phone number must be confirmed. If you omit this element, MONETA.RU uses the ID of the user who sends the request.
	 * 
	 *
	 * @var long
	 */
	 public $unitId = null;

	/**
	 * 
	 * 
	 *
	 * @var long
	 */
	 public $profileId = null;

	/**
	 * Код подтверждения, который пришел пользователю в тексте sms сообщения.
	 * The confirmation code that the user received in the SMS message.
	 * 
	 *
	 * @var string
	 */
	 public $confirmationCode = null;

}
