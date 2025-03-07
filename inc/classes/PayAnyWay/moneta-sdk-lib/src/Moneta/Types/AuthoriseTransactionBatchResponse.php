<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ на запрос регистрации операций в пакетном режиме.
	 * Response to the authorization hold request in batch mode.
	 * 
 */
class AuthoriseTransactionBatchResponse
{
	
	/**
	 * Детали проведенных операций, либо описание ошибок, если операция не проведена. Порядок соответствует набору операций, переданных в AuthoriseTransactionBatchRequest.
	 * Either information about completed transactions or error descriptions in the same order as in AuthoriseTransactionBatchRequest.
	 * 
	 *
	 * @var OperationInfoBatchResponseType
	 */
	 public $transaction = null;

	/**
	 * Детали проведенных операций, либо описание ошибок, если операция не проведена. Порядок соответствует набору операций, переданных в AuthoriseTransactionBatchRequest.
	 * Either information about completed transactions or error descriptions in the same order as in AuthoriseTransactionBatchRequest.
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
