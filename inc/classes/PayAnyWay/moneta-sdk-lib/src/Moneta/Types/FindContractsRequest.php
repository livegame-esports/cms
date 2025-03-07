<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на получение данных договора по ID пользователя. Если данные не найдены, возвращается пустой список.
	 * Request for contract information by a user ID. If MONETA.RU does not find information, the request contains an empty list.
	 * 
 */
class FindContractsRequest extends Entity
{
	
	/**
	 * ID пользователя в системе МОНЕТА.РУ.
	 * Если это поле не задано, то используется текущий пользователь.
	 * MONETA.RU user ID.
	 * If you omit this element, MONETA.RU uses the ID of the user who sends the request.
	 * 
	 *
	 * @var long
	 */
	 public $unitId = null;

}
