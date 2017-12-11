<?php
namespace User;

//class Controller_Base extends \Controller_Template
use Fuel\Core\Request;

class Controller_Base extends \Controller_Base
{
	// テンプレート名
	public $template = 'user/template';

	/**
	 * 前処理
	 */
	public function before() {
		parent::before();

	}

	/**
	 * Check CSRF token
	 */
	protected function _check_token() {
		if (!\Security::check_token()) {
			\Session::set_flash('error', \Constants::$error_message['expired_csrf_token']);
			\Response::redirect('user/dashboard/index');
		}
	}
}
