<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Ответ, содержащий бинарные данные, ассоциированные с указанным в запросе документом.
	 * Response to the request for binary data. The response contains binary data that is associated with the specified document.
	 * 
 */
class FindProfileDocumentFilesResponse
{
	
	/**
	 * 
	 *
	 * @var File
	 */
	 public $file = null;

	/**
	 * 
	 *
	 * @param File
	 *
	 * @return void
	 */
	public function addFile(File $item)
	{
		$this->file[] = $item;
	}

}
