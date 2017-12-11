<?php

namespace User;

class Controller_Index extends Controller_Base {

    public function before()
    {
        parent::before();

        $this->template->pagetitle = \Constants::$page_title['login'];
    }

    /**
     * The index action.
     *
     * @access  public
     * @return  void
     */
    public function action_index() // すでに管理者ユーザーでログインしているなら、メイン画面へ、そうでないならログイン画面へ
    {
        \Response::redirect('user/dashboard/index');
    }

}

/* End of file index.php */
