<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Экземпляр отчета за конкретный месяц в системе МОНЕТА.РУ.
	 * Report instance.
	 * 
 */
class ReportInstance
{
	
	/**
	 * ID экземпляра отчета.
	 * Report instance ID.
	 * 
	 *
	 * @var long
	 */
	 public $id = null;

	/**
	 * ID отчета.
	 * Report ID.
	 * 
	 *
	 * @var long
	 */
	 public $reportId = null;

	/**
	 * Год.
	 * Report instance year.
	 * 
	 *
	 * @var int
	 */
	 public $year = null;

	/**
	 * Месяц (1-12).
	 * Report instance month (1-12).
	 * 
	 *
	 * @var int
	 */
	 public $month = null;

	/**
	 * Ссылка, по которой можно скачать данный экземпляр отчета в формате PDF.
	 * Ссылка для скачивания будет сгенерирована только в том случае,
	 * если у пользователя, который вызывает данный метод, в разделе "Мой счет" - "Безопасность" создан "Публичный идентификатор".
	 * Ссылка для скачивания действует в течении 30 минут. В элементе urlExpirationDate указано время действия ссылки.
	 * Если время действия ссылки закончилось, то в ответ будет отдаваться HTTP status code: 400 (Bad Request).
	 * Если в ссылке для скачивания будут изменены параметры, то в ответ будет отдаваться HTTP status code: 400 (Bad Request).
	 * Download URL.
	 * 
	 *
	 * @var string
	 */
	 public $url = null;

	/**
	 * Время действия ссылки для скачивания отчета.
	 * URL expiration date.
	 * 
	 *
	 * @var dateTime
	 */
	 public $urlExpirationDate = null;

	/**
	 * 
	 *
	 * @var KeyValueAttribute
	 */
	 public $attribute = null;

	/**
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
