<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Получение информации об итогах по месяцам.
	 * Если данные не найдены, то size в ответе равен 0.
	 * Request for the monthly turnover information.
	 * If MONETA.RU finds no data, the size element in the response is set to 0.
	 * 
 */
class GetTurnoverListRequest
{
	
	/**
	 * ID пользователя в системе МОНЕТА.РУ.
	 * Если это поле не задано, то используется текущий пользователь.
	 * Unique identifier of a user in MONETA.RU.
	 * If you omit this element, MONETA.RU sets the unitId value to the user who sends the request.
	 * 
	 *
	 * @var long
	 */
	 public $unitId = null;

	/**
	 * Дата начала периода. Дата берется с начала указанного месяца.
	 * The start date of the period. MONETA.RU always starts the period on the first day of the month.
	 * 
	 *
	 * @var date
	 */
	 public $dateFrom = null;

	/**
	 * Дата окончания периода. В дате устанавливается конец указанного месяца. Если дата не установлена, то берется конец месяца из даты dateFrom.
	 * The end date of the period. MONETA.RU always ends the period on the last day of the month. If you omit the dateTo element, MONETA.RU uses the last day of the month in the dateFrom element.
	 * 
	 *
	 * @var date
	 */
	 public $dateTo = null;

	/**
	 * Список счетов, которые учитываются в итогах по месяцам.
	 * The list of account numbers to include into the turnover.
	 * 
	 *
	 * @var long
	 */
	 public $accountIds = null;

	/**
	 * Список счетов, которые учитываются в итогах по месяцам.
	 * The list of account numbers to include into the turnover.
	 * 
	 *
	 * @param long
	 *
	 * @return void
	 */
	public function addAccountIds(long $item)
	{
		$this->accountIds[] = $item;
	}

	/**
	 * Валюта, которая учитывается в итогах по месяцам.
	 * Currency to include into the turnover information.
	 * 
	 *
	 * @var string
	 */
	 public $currencyCode = null;

	/**
	 * Если groupByCurrency=true, то в ответе делается группировка по валюте.
	 * Indicates whether to group turnovers by currency. Valid values are:
	 * true. Group by currency.
	 * false. Do not group by currency.
	 * Default value: true
	 * 
	 *
	 * @var boolean
	 */
	 public $groupByCurrency = null;

	/**
	 * Категория операций, которая учитывается в итогах по месяцам.
	 * Category of transactions to include into the turnover information.
	 * 
	 *
	 * @var string
	 */
	 public $operationTypeCategory = null;

	/**
	 * Если categoryDetails=true, то в ответе делается группировка по категориям операций.
	 * Indicates whether to group turnovers by transaction categories. Valid values are:
	 * true. Group turnovers by category.
	 * false. Do not group turnovers.
	 * Default value: false
	 * 
	 *
	 * @var boolean
	 */
	 public $categoryDetails = null;

	/**
	 * Дополнительные атрибуты запроса.
	 * Additional request parameters.
	 * 
	 *
	 * @var KeyValueAttribute
	 */
	 public $attribute = null;

	/**
	 * Дополнительные атрибуты запроса.
	 * Additional request parameters.
	 * 
	 *
	 * @param KeyValueAttribute
	 *
	 * @return void
	 */
	public function addAttribute(KeyValueAttribute $item)
	{
		$this->attribute[] = $item;
	}

}
