<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Тип, описывающий данные в виде бинарного файла.
	 * Binary data.
	 * 
 */
class File
{
	
	/**
	 * ID документа, которому принадлежит данный файл.
	 * Unique identifier of the document to which the file belongs.
	 * 
	 *
	 * @var long
	 */
	 public $documentId = null;

	/**
	 * Данные файла. При передаче/получении данных используйте MTOM (Message Transmission Optimization Mechanism).
	 * File contents. Use MTOM (Message Transmission Optimization Mechanism) to send and fetch the data.
	 * 
	 *
	 * @var base64Binary
	 */
	 public $blob = null;

	/**
	 * Проверен или нет данный файл.
	 * Indicates whether the file is verified or not.
	 * 
	 *
	 * @var boolean
	 */
	 public $approved = null;

	/**
	 * ID файла.
	 * File ID.
	 * 
	 *
	 * @var long
	 */
	 public $fileId = null;

	/**
	 * Mime type файла (например: image/jpeg).
	 * MIME type of the file.
	 * For example, image/jpeg for an image in jpeg format.
	 * 
	 *
	 * @var string
	 */
	 public $mimeType = null;

	/**
	 * Имя файла или описание.
	 * File name or description.
	 * 
	 *
	 * @var string
	 */
	 public $title = null;

}
