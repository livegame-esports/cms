<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Тип, описывающий атрибуты операции в ответах.
	 * Transaction attributes in responses.
	 * 
 */
class TransactionResponseType
{
	
	/**
	 * Текущий статус операции.
	 * The current transaction status.
	 * 
	 *
	 * @var string
	 */
	 public $status = null;

	/**
	 * Время последней модификации операции.
	 * The date and time of the latest change in a transaction.
	 * 
	 *
	 * @var dateTime
	 */
	 public $dateTime = null;

	/**
	 * Номер операции.
	 * Unique identifier of a transaction in MONETA.RU.
	 * 
	 *
	 * @var long
	 */
	 public $transaction = null;

	/**
	 * Внешний номер операции.
	 * Merchant transaction ID.
	 * 
	 *
	 * @var string
	 */
	 public $clientTransaction = null;

	/**
	 * Дополнительные свойства операции.
	 * Для получения этого поля в запросе необходимо выставлять атрибут version равный или больше VERSION_2 (только в InvoiceRequest).
	 * Additional transaction details.
	 * For retrieving operationInfo the request attribute "version" has to be set to "VERSION_2" or greater (only in InvoiceRequest).
	 * 
	 *
	 * @var OperationInfo
	 */
	 public $operationInfo = null;

}
