<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Запрос на получение списка операций по заданному фильтру.
	 * Обязательными в фильтре являются только поля с датами периода.
	 * Все остальные поля в фильтре необязательные.
	 * Если данные не найдены, то size в ответе равен 0.
	 * Request for getting a list of transactions by the specified filter.
	 * 
 */
class FindOperationsListRequest
{
	
	/**
	 * Настройки страницы данных.
	 * Specifies the sequence number of the page that you want to retrieve if the list of transactions includes multiple pages.
	 * 
	 *
	 * @var Pager
	 */
	 public $pager = null;

	/**
	 * Фильтр, по которому ищем операции.
	 * Filtering criteria.
	 * 
	 *
	 * @var FindOperationsListRequestFilter
	 */
	 public $filter = null;

}
