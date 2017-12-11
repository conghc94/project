<?php
namespace Manager;

//class Controller_Base extends \Controller_Template
use Fuel\Core\Request;

class Controller_Base extends \Controller_Base
{
	// テンプレート名
	public $template = 'manager/template';

	/**
	 * 前処理
	 */
	public function before() {
		parent::before();

		// ログイン処理部分以外はここでチェック
		if ($this->controller !== 'index' or ! in_array($this->action, array('login', 'logout')))
		{
			if (\Auth::check())
			{
				// すでに管理者ユーザーでログインしていないならトップへ
				$admin_group_id = \Constants::$user_group['Administrators'];
				if (! \Auth::member($admin_group_id))
				{
					\Auth::logout();
					\Response::redirect('/');
				}
			}
			else
			{
				\Response::redirect('manager/index/login');
			}
		}
	}

	/**
	 * Check CSRF token
	 */
	protected function _check_token() {
		if (!\Security::check_token()) {
			\Session::set_flash('error', \Constants::$error_message['expired_csrf_token']);
			\Response::redirect('manager/index/login');
		}
	}
}
