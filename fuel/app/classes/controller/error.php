<?php

/**
 * エラー画面
 */
class Controller_Error extends Controller_Base
{
	/**
	 * 前処理
	 */
	public function before() {
		parent::before();
	}

	/**
	 * 
	 * @throws Exception
	 */
	public function action_index() {
		$this->template->content = \View_Smarty::forge("{$this->controller}/{$this->action}.tpl");
	}

	/**
	 * 404画面
	 * @throws Exception
	 */
	public function action_404() {
		$this->template->content = \View_Smarty::forge("{$this->controller}/{$this->action}.tpl");
	}

}
