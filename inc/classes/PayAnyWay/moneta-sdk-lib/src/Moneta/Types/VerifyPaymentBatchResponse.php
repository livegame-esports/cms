<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ на запрос проверки проведения операции в системе МОНЕТА.РУ. Ответ в пакетном режиме.
	 * Response to a transaction validation request. Response in batch mode.
	 * 
 */
class VerifyPaymentBatchResponse
{
	
	/**
	 * Детали операций, либо описание ошибок. Порядок соответствует набору операций, переданных в VerifyPaymentBatchRequest.
	 * Either information about transactions or error descriptions in the same order as in the VerifyPaymentBatch request.
	 * 
	 *
	 * @var VerifyTransferResponseType
	 */
	 public $transaction = null;

	/**
	 * Детали операций, либо описание ошибок. Порядок соответствует набору операций, переданных в VerifyPaymentBatchRequest.
	 * Either information about transactions or error descriptions in the same order as in the VerifyPaymentBatch request.
	 * 
	 *
	 * @param VerifyTransferResponseType
	 *
	 * @return void
	 */
	public function addTransaction(VerifyTransferResponseType $item)
	{
		$this->transaction[] = $item;
	}

}
