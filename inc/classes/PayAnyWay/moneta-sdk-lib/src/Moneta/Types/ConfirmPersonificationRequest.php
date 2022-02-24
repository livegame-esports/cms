<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на проведение идентификации пользователя.
	 * Request for user identification.
	 * 
 */
class ConfirmPersonificationRequest extends Entity
{
	
	/**
	 * Код, с помощью которого можно произвести идентификацию пользователя.
	 * User identification code.
	 * 
	 *
	 * @var string
	 */
	 public $personificationCode = null;

	/**
	 * В profile должны быть заполнены следующие поля:
	 * first_name
	 * middle_initial_name (optional)
	 * last_name
	 * date_of_birth формат: yyyy-mm-dd
	 * legal_address
	 * inn (optional)
	 * В document должны быть заполнены следующие поля:
	 * type (всегда равен PASSPORT)
	 * series
	 * number
	 * issuer
	 * issued
	 * department
	 * User information must contain the following attributes:
	 * first_name
	 * middle_initial_name (optional)
	 * last_name
	 * date_of_birth Use the following format: yyyy-mm-dd
	 * legal_address
	 * inn (optional)
	 * The document must contain the following attributes:
	 * type (PASSPORT)
	 * series
	 * number
	 * issuer
	 * issued
	 * department
	 * 
	 *
	 * @var PersonalInformation
	 */
	 public $personalInformation = null;

}
