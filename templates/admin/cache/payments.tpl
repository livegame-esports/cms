<div class="page">
    <div class="row">
        <div class="col-md-6">
            <div class="block">
                <div class="block_head">
                    FreeKassa (для мерчантов зарегистрированных после 01.08.2021)
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->fk_new == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','fk_new','1','1','fk_new_login,fk_new_pass1,fk_new_pass2');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->fk_new == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','fk_new','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="edit_freekassa('new');">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="fknew_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_new_login; ?>"
                           placeholder="ID магазина">
                    <input type="text"
                           class="form-control"
                           id="fknew_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_new_pass1; ?>"
                           placeholder="Секретное слово">
                    <input type="text"
                           class="form-control"
                           id="fknew_pass2"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_new_pass2; ?>"
                           placeholder="Секретное слово 2">
                </div>
                <div id="edit_freekassanew_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/FreeKassaNew">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещ:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_fk=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL успеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL неуспеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    Free-Kassa (для мерчантов зарегистрированных до 01.08.2021)
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->fk == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','fk','1','1','fk_login,fk_pass1,fk_pass2');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->fk == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','fk','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="edit_freekassa();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="fk_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_login; ?>"
                           placeholder="ID магазина">
                    <input type="text"
                           class="form-control"
                           id="fk_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_pass1; ?>"
                           placeholder="Секретное слово">
                    <input type="text"
                           class="form-control"
                           id="fk_pass2"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->fk_pass2; ?>"
                           placeholder="Секретное слово 2">
                </div>
                <div id="edit_freekassa_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/FreeKassa">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещ:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL успеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL неуспеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    ROBOKASSA
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->rb == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','rb','1','1','rb_login,rb_pass1,rb_pass2');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->rb == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','rb','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="edit_robokassa();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="rb_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->rb_login; ?>"
                           placeholder="Логин">
                    <input type="text"
                           class="form-control"
                           id="rb_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->rb_pass1; ?>"
                           placeholder="Пароль 1">
                    <input type="text"
                           class="form-control"
                           id="rb_pass2"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->rb_pass2; ?>"
                           placeholder="Пароль 2">
                </div>
                <div id="edit_robokassa_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/RoboKassa">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">Result Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_rb=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Success Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Fail Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    InterKassa
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->ik == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ik','1','1','ik_login,ik_pass1');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->ik == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ik','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="edit_interkassa();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="ik_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ik_login; ?>"
                           placeholder="ID кассы">
                    <input type="text"
                           class="form-control"
                           id="ik_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ik_pass1; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_interkassa_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/InterKassa">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещ:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_ik=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL успеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL ожидан:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL неуспеха:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    Paysera
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->ps == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ps','1','1','ps_num,ps_pass');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->ps == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ps','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="edit_paysera();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="ps_num"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ps_num; ?>"
                           placeholder="Номер проекта">
                    <input type="text"
                           class="form-control"
                           id="ps_pass"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ps_pass; ?>"
                           placeholder="Пароль проекта">
                </div>
                <div id="edit_paysera_result"></div>

                <div class="row mt-10">
                    <div class="col-md-6">
                        <b> Тестовый режим </b>
                        <div class="form-group">
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-default <?php if($merchants->ps_test == 1): ?> active <?php endif; ?>"
                                       onclick="change_value('config__bank','ps_test','1','1');">
                                    <input type="radio">
                                    Включить
                                </label>

                                <label class="btn btn-default <?php if($merchants->ps_test != 1): ?> active <?php endif; ?>"
                                       onclick="change_value('config__bank','ps_test','0','1');">
                                    <input type="radio">
                                    Выключить
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <b> Валюта </b>
                        <div class="form-group">
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-default <?php if($merchants->ps_currency == 'RUB'): ?> active <?php endif; ?>"
                                       onclick="change_value('config__bank','ps_currency','RUB','1');">
                                    <input type="radio">
                                    RUB
                                </label>

                                <label class="btn btn-default <?php if($merchants->ps_currency == 'USD'): ?> active <?php endif; ?>"
                                       onclick="change_value('config__bank','ps_currency','USD','1');">
                                    <input type="radio">
                                    USD
                                </label>

                                <label class="btn btn-default <?php if($merchants->ps_currency == 'EUR'): ?> active <?php endif; ?>"
                                       onclick="change_value('config__bank','ps_currency','EUR','1');">
                                    <input type="radio">
                                    EUR
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    LiqPay
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons" id="liqpayTrigger">
                        <label class="btn btn-default <?php if($merchants->lp == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','lp','1','1');">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->lp == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','lp','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="editLiqPayPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="lp_public_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->lp_public_key; ?>"
                           placeholder="Публичный ключ">
                    <input type="text"
                           class="form-control"
                           id="lp_private_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->lp_private_key; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_liqpay_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/LiqPay">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL скрипта:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_lp=get</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    PayAnyWay
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->payanyway == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','payanyway','1','1');">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->payanyway == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','payanyway','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="editPayAnyWayPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="payanyway_id"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->payanyway_id; ?>"
                           placeholder="ID Бизнес-счёта">
                    <input type="text"
                           class="form-control"
                           id="payanyway_code"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->payanyway_code; ?>"
                           placeholder="Код проверки целостности данных">
                </div>
                <div id="edit_payanyway_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/PayAnyWay">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещения:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?payanyway=pay</b></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    YooKassa
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->yookassa == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','yookassa','1','1');">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->yookassa == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','yookassa','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="editYooKassaPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="yookassa_id"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->yookassa_id; ?>"
                           placeholder="ID магазина">
                    <input type="text"
                           class="form-control"
                           id="yookassa_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->yookassa_key; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_yookassa_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/YooKassa">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещения:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?yookassa=pay</b></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="block">
                <div class="block_head">
                    UnitPay
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->up == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','up','1','1','up_type,up_pass1,up_pass2');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->up == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','up','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="edit_unitpay();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="up_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->up_pass1; ?>"
                           placeholder="PUBLIC KEY">
                    <input type="text"
                           class="form-control"
                           id="up_pass2"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->up_pass2; ?>"
                           placeholder="SECRET KEY">
                    <select class="form-control" id="up_type">
                        <option value="1" <?php if($merchants->up_type == '1'): ?> selected <?php endif; ?>>
                            Способ работы: физ. лицо
                        </option>
                        <option value="2" <?php if($merchants->up_type == '2'): ?> selected <?php endif; ?>>
                            Способ работы: самозанятый / ИП / юр. лицо
                        </option>
                    </select>
                </div>
                <div id="edit_unitpay_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/UnitPay">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">Result Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse</b></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Success Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Fail Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    WalletOne
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->wo == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','wo','1','1','wo_login,wo_pass');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->wo == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','wo','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="edit_walletone();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="wo_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->wo_login; ?>"
                           placeholder="ID кассы">
                    <input type="text"
                           class="form-control"
                           id="wo_pass"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->wo_pass; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_walletone_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/WalletOne">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL скрипта:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_wo=get</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    WebMoney
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->w == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','wb','1','1','wb_login,wb_pass1,wb_num');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->w == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','wb','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="edit_webmoney();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="wb_login"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->wb_login; ?>"
                           placeholder="Наименование">
                    <input type="text"
                           class="form-control"
                           id="wb_pass1"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->wb_pass1; ?>"
                           placeholder="Пароль">
                    <input type="text"
                           class="form-control"
                           id="wb_num"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->wb_num; ?>"
                           placeholder="Ваш кошелек">
                </div>
                <div id="edit_webmoney_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/WebMoney">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">Result Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_wb=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Success Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Fail Url:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    ЮMoney
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->ya == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ya','1','1','ya_num,ya_key');">
                            <input type="radio">
                            Включить
                        </label>

                        <label class="btn btn-default <?php if($merchants->ya == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ya','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="edit_yandexmoney();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="ya_num"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ya_num; ?>"
                           placeholder="Ваш кошелек">
                    <input type="text"
                           class="form-control"
                           id="ya_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ya_key; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_yandexmoney_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/yoomoney">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <p>Адрес для уведомлений:
                        <b>{full_site_host}purse?result_ya=get</b></p>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    Qiwi
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons" id="qiwiTrigger">
                        <label class="btn btn-default <?php if($merchants->qw == 1): ?> active <?php endif; ?>"
                               onclick="onQiwiPaymentSystem();">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->qw == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','qw','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button"
                                onclick="editQiwiPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="qw_pass"
                           maxlength="300"
                           autocomplete="off"
                           value="<?php echo $merchants->qw_pass; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_qiwi_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/QIWI">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <p>Адрес для серверных уведомлений:
                        <b>{full_site_host}purse?result_qw=get</b></p>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    AnyPay
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->ap == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ap','1','1');">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->ap == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','ap','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-23-12" type="button"
                                onclick="editAnyPayPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="ap_project_id"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ap_project_id; ?>"
                           placeholder="ID проекта">
                    <input type="text"
                           class="form-control"
                           id="ap_private_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->ap_private_key; ?>"
                           placeholder="Секретный ключ">
                </div>
                <div id="edit_anypay_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/AnyPay">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещения:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result_ap=get</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL успешной оплаты:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL неуспешной оплаты:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="block">
                <div class="block_head">
                    Enot
                </div>
                <div class="form-group mb-10">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default <?php if($merchants->enot == 1): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','enot','1','1');">
                            <input type="radio">
                            Включить
                        </label>
                        <label class="btn btn-default <?php if($merchants->enot == 2): ?> active <?php endif; ?>"
                               onclick="change_value('config__bank','enot','2','1');">
                            <input type="radio">
                            Выключить
                        </label>
                    </div>
                </div>
                <div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default pd-40-12" type="button"
                                onclick="editEnotPaymentSystem();">
							Изменить
						</button>
					</span>
                    <input type="text"
                           class="form-control"
                           id="enot_id"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->enot_id; ?>"
                           placeholder="ID проекта">
                    <input type="text"
                           class="form-control"
                           id="enot_key"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->enot_key; ?>"
                           placeholder="Секретный ключ">
                    <input type="text"
                           class="form-control"
                           id="enot_key2"
                           maxlength="255"
                           autocomplete="off"
                           value="<?php echo $merchants->enot_key2; ?>"
                           placeholder="Секретный ключ 2">
                </div>
                <div id="edit_enot_result"></div>
                <div class="bs-callout bs-callout-info mt-10">
                    <h5>
                        <a target="_blank" href="https://gamecms.ru/wiki/Enot">
                            <span class="glyphicon glyphicon-link"></span> Нажмите для перехода к инструкции
                        </a>
                    </h5>
                    <table>
                        <tr>
                            <td style="text-align: right">URL оповещения:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?enot=pay</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL успешной оплаты:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=success</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">URL неуспешной оплаты:</td>
                            <td>&nbsp&nbsp<b>{full_site_host}purse?result=fail</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>