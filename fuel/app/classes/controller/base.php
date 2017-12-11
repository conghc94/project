<?php

class Controller_Base extends Controller_Hybrid
{
	// テンプレート名
	public $template = 'template';
	public $referrer;

	public function before()
	{
		parent::before();

		$this->current_user = null;
		$this->userprofile = null;

		// simpleauth ドライバが認証済みか確認
		$driver = Auth::verified('simpleauth');
		$logined = 0;
		if (($id = Auth::get_user_id()) !== false)
		{
			$this->current_user = Model\Auth_User::find($id[1]);
//			$this->userprofile = \Model_Userprofile::get_related_onecase_by_userid($id[1]);
		}
		if (\Auth::check()) {
			$logined = 1;
		}

		// Set a global variable so views can use it
		View::set_global('current_user', $this->current_user);
		View::set_global('current_userprofile', $this->userprofile);

		if (!$this->is_restful()) {
			$this->template->logined_flag = $logined;

			// viewにもセットしておく
			$this->template->title = \Constants::$site_title;
			$this->template->pagetitle = \Constants::$page_title['normal'];

		}
	}

}
