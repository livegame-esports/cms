<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на получение документов пользователя.
	 * Request for documents that are associated with the specified MONETA.RU user account.
	 * 
 */
class FindProfileDocumentsRequest
{
	
	/**
	 * ID пользователя, документы которого запрашиваются.
	 * The unique identifier of the user whose documents you want to get.
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

}
