<?php

namespace User;

use Auth\Auth;

class Controller_Dashboard extends Controller_Base {

    public function before()
    {
        parent::before();

    }


    /**
     * The index action.
     *
     * @access  public
     * @return  void
     */
    public function action_index()
    {
        $this->template->pagetitle = \Constants::$page_title['mainmenu'];
        $this->template->content = \View_Smarty::forge('dashboard/index.tpl');
    }



}

/* End of file index.php */
