<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Получение информации о финансовых потоках.
	 * Если данные не найдены, то size в ответе равен 0.
	 * Request for getting the financial flow information.
	 * If the response contains no data, the size element of the response is set to 0.
	 * 
 */
class GetFinancialFlowsListRequest
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
	 * Дата начала финансового потока. Дата берется с начала указанного месяца.
	 * The start date of the financial flow. Financial flow in MONETA.RU always starts on the first day of the month.
	 * 
	 *
	 * @var date
	 */
	 public $dateFrom = null;

	/**
	 * Дата окончания финансового потока. В дате устанавливается конец указанного месяца. Если дата не установлена, то берется конец месяца из даты dateFrom. Период просмотра финансовых потоков не может быть больше 3 месяцев.
	 * The end date of the financial flow. Financial flow in MONETA.RU always ends on the last day of the month. If you omit the dateTo element, MONETA.RU uses the last day of the month in the dateFrom element. Maximum period of the financial flow is limited to three months.
	 * 
	 *
	 * @var date
	 */
	 public $dateTo = null;

	/**
	 * Список счетов, которые учитываются в финансовом потоке.
	 * The list of account numbers to include into the financial flow.
	 * 
	 *
	 * @var long
	 */
	 public $accountIds = null;

	/**
	 * Список счетов, которые учитываются в финансовом потоке.
	 * The list of account numbers to include into the financial flow.
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
	 * Валюта, которая учитывается в финансовом потоке.
	 * Currency that is used in the financial flow.
	 * 
	 *
	 * @var string
	 */
	 public $currencyCode = null;

	/**
	 * Категория операций, которая учитывается в финансовом потоке.
	 * Transaction category to include into the financial flow.
	 * 
	 *
	 * @var string
	 */
	 public $operationTypeCategory = null;

	/**
	 * Расходные или приходные операции. При отсутствии этого поля учитываются все операции.
	 * Indicates whether to include only debit or credit transactions. If you omit this element, MONETA.RU includes both debit and credit transactions.
	 * 
	 *
	 * @var string
	 */
	 public $operationAmountType = null;

	/**
	 * Если categoryDetails=true, то в ответе делается группировка по категориям операций.
	 * Indicates whether the financial flow is grouped by transaction categories. Valid values are:
	 * true. Group by transaction categories.
	 * false. Do not group by transaction categories.
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

	/**
	 * Состояние операций в данном финансовом потоке. Если это поле не установлено - то потоки со всеми состояниями.
	 * The status of transactions to include into the financial flow. If you omit this element, all statuses are included.
	 * 
	 *
	 * @var string
	 */
	 public $operationStatusState = null;

}
