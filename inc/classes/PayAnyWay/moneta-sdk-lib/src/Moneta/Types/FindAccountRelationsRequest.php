<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на получение списка пользователей, которые имеют делегированный доступ к указанному счету.
	 * Request for a list of users who have delegated to the specified account ID.
	 * 
 */
class FindAccountRelationsRequest
{
	
	/**
	 * Номер счета в системе МОНЕТА.РУ.
	 * MONETA.RU account number.
	 * 
	 *
	 * @var long
	 */
	 public $accountId = null;

}
