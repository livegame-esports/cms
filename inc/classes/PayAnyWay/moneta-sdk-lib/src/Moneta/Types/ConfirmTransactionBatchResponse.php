<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ на запрос завершения операций в пакетном режиме.
	 * Response to a request for transaction confirmations in batch mode.
	 * 
 */
class ConfirmTransactionBatchResponse
{
	
	/**
	 * Детали проведенных операций, либо описание ошибок, если операция не проведена. Порядок соответствует набору операций, переданных в ConfirmTransactionBatchRequest.
	 * Either information about completed transactions or error descriptions in the same order as in ConfirmTransactionBatchRequest.
	 * 
	 *
	 * @var OperationInfoBatchResponseType
	 */
	 public $transaction = null;

	/**
	 * Детали проведенных операций, либо описание ошибок, если операция не проведена. Порядок соответствует набору операций, переданных в ConfirmTransactionBatchRequest.
	 * Either information about completed transactions or error descriptions in the same order as in ConfirmTransactionBatchRequest.
	 * 
	 *
	 * @param OperationInfoBatchResponseType
	 *
	 * @return void
	 */
	public function addTransaction(OperationInfoBatchResponseType $item)
	{
		$this->transaction[] = $item;
	}

}
