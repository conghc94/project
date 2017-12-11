<?php

/**
 */
class Controller_Index extends Controller_Base
{
	public $page;

	/**
	 * 前処理
	 */
	public function before() {
		//入力フォームで取り扱うフィールドを配列として設定
		parent::before();
	}

	/**
	 *
	 * @throws Exception
	 */
	public function action_index() {

		\Response::redirect('manager/dashboard/index');

	}

}
