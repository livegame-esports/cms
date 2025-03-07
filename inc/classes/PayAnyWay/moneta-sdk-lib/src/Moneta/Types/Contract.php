<?php

// Warning! This code was generated by WSDL2PHP tool. 
// author: Filippov Andrey <afi.work@gmail.com> 
// see https://solo-framework-lib.googlecode.com 

namespace Moneta\Types;

/**
 * Договор в системе МОНЕТА.РУ. Данные представляются в виде "ключ-значение".
	 * Возможные ключи договора:
	 * num. Номер договора.
	 * unitid. ID юнита, у которого создан договор.
	 * own. true-создан для указанного в запросе юнита, false-создан для родительского юнита.
	 * unitname. если own=false, то данное поле содержит имя юнита.
	 * datestart. Дата начала договора.
	 * datestop. Дата окончания договора.
	 * status. Статус договора:
	 * CREATED. Сформирован.
	 * SIGNED. Подписан.
	 * ACTIVE. Активный.
	 * PAUSED. Приостановлен.
	 * INACTIVE. Расторгнут.
	 * type. Тип договора:
	 * PARTNER. Договор.
	 * VIRTUAL. Виртуальный договор.
	 * Contract information in the list of key-value pairs.
	 * Valid contract keys are:
	 * num. Contract number.
	 * unitid. Unique identifier of the contract.
	 * own. Indicates whether the contract is created for the specified user account. Valid values are:
	 * true. The contract is created for the account which ID is specified in the unitid element.
	 * false. The contract is created for the parent account.
	 * unitname. The name of the parent account, if the own element is set to false.
	 * datestart. The start date of the contract.
	 * datestop. The end date of the contract.
	 * status. Contract status. Valid values are:
	 * CREATED
	 * SIGNED
	 * ACTIVE
	 * PAUSED
	 * INACTIVE
	 * type. Contract type. Valid values are:
	 * PARTNER. Partner contract.
	 * VIRTUAL. Virtual contract.
	 * 
 */
class Contract
{
	
	/**
	 * ID договора.
	 * Contract ID.
	 * 
	 *
	 * @var long
	 */
	 public $id = null;

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
