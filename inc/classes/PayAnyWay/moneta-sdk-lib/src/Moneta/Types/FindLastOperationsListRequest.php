<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на получение списка последних операций.
	 * Если данные не найдены, то size в ответе равен 0.
	 * Request for getting the list of the last transactions.
	 * If MONETA.RU finds no transactions, the size element in the response is set to 0.
	 * 
 */
class FindLastOperationsListRequest
{
	
	/**
	 * ID пользователя в системе МОНЕТА.РУ.
	 * Если это поле не задано, то используется текущий пользователь.
	 * Unique identifier of a user in MONETA.RU.
	 * If you omit this element, MONETA.RU sets the value of this element to the user who sends the request
	 * 
	 *
	 * @var long
	 */
	 public $unitId = null;

	/**
	 * Количество операций.
	 * Maximum number of transactions to include in the response.
	 * 
	 *
	 * @var int
	 */
	 public $transactionsQuantity = null;

}
