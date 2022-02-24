<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ, который содержит список счетов.
	 * Response to FindAccountsListRequest. The response includes the list of accounts.
	 * 
 */
class FindAccountsListResponse
{
	
	/**
	 * 
	 *
	 * @var AccountInfo
	 */
	 public $account = null;

	/**
	 * 
	 *
	 * @param AccountInfo
	 *
	 * @return void
	 */
	public function addAccount(AccountInfo $item)
	{
		$this->account[] = $item;
	}

}
