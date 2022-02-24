<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ на запрос проверки проведения операции в системе МОНЕТА.РУ.
	 * Information about the transaction verification.
	 * 
 */
class VerifyTransactionResponseType extends VerifyTransferResponseType
{
	
	/**
	 * Идентификатор операции в системе МОНЕТА.РУ.
	 * MONETA.RU transaction ID.
	 * 
	 *
	 * @var long
	 */
	 public $transactionId = null;

	/**
	 * Статус операции в системе МОНЕТА.РУ.
	 * Transaction status in MONETA.RU.
	 * 
	 *
	 * @var string
	 */
	 public $operationStatus = null;

}
