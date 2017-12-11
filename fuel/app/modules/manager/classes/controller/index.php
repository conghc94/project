<?php

namespace Manager;

class Controller_Index extends Controller_Base {

    public function before()
    {
        parent::before();

        $this->template->header = "";
        $this->template->title = "メンバー管理システム";
        //$this->template->pagetitle = \Constants::$page_title['login'];
    }

    public function action_login()
    {
        // すでにログインしているかチェック
        \Auth::check() and \Response::redirect('manager/dashboard/index');

        // ログイン用validateルール取得
        $val = \Model_User::validate('MasterLogin');

        if (\Input::method() == 'POST')
        {
            if ($val->run())
            {
                //validate問題なし
                if ( ! \Auth::check()) // すでにログインしているかチェック
                {
                    if (\Auth::login(\Input::post('username'), \Input::post('password'))) //ログインチェック
                    {
                        // 管理者ユーザーか確認
                        $admin_group_id = \Constants::$user_group['Administrators'];
                        if (\Auth::member($admin_group_id)) {
                            //管理者ユーザーならメイン画面へ
                            \Response::redirect('manager/dashboard/index');
                            // \Response::redirect_back('manager/dashboard/index', 'location');
                        } else {
                            //管理者ユーザーではないならログアウトしてログイン画面へ
                            \Auth::logout();
                            \Response::redirect('manager/index/login');
                        }
                    }
                    else
                    {
                        // ログインエラーメッセージは設定されたエラーメッセージをセット
                        $this->template->set_global('error', \Constants::$error_message['login_error']);
                    }
                }
                else
                {
                    // ログインエラーメッセージは設定されたエラーメッセージをセット
                    $this->template->set_global('error', \Constants::$error_message['already_logged_in']);
                }
            }
        }

        // ログイン画面を表示
        $this->template->content = \View_Smarty::forge('index/login.tpl', array('val' => $val), false);
    }

    /**
     * The logout action.
     *
     * @access  public
     * @return  void
     */
    public function action_logout() //ログアウトする
    {
        \Session::delete('dataDelegate_old');
        \Session::delete('dataMainCurator_old');
        \Session::delete('arrayNewSubCurator_old');
        \Session::delete('dataMember');
        \Session::delete('dataBaseofmember');
        \Session::delete('idBaseofmember');
        \Session::delete('arrayNewSubCurator_old');
        \Session::delete('dataCreateMember');
        \Session::delete('dataDelegate');
        \Session::delete('dataMainCurator');
        \Session::delete('dataSubCurator');        
        \Session::delete('check_sub_curator');
        \Session::delete('check_main_curator');
        \Session::delete('check_new_sub_curator');
        \Session::delete('arrayNewSubCurator');
        \Session::delete('check_delegate');
        \Session::delete('back_addmember');
        \Session::delete('back_serchbaseofmember');
        \Session::delete('sessionOfficer');
        \Session::delete('sessionMember');
        \Session::delete('back_editmember');
        \Session::delete('idCommittee');
        \Session::delete('id_memberofcommittee');
        \Session::delete('dataMemberofcommittees');
        \Session::delete('dataMember_old');
        \Session::delete('dataCommittee');
        \Session::delete('dataCommittee_old');
        \Session::delete('data_selectable_officer');
        \Session::delete('member_name');
        \Session::delete('backToOfficerSetup');
        \Session::delete('backUrl');
        \Session::delete('member_flag');
        \Session::delete('back_searchsettingcommitte');
        \Session::delete('backToOfficerSearch');
        \Session::delete('back_settingCommittees');
        \Session::delete('back_searchmemberofcommitte');
        \Session::delete('back');
        \Auth::logout();
        \Response::redirect('manager/index/login');
    }

    /**
     * The index action.
     *
     * @access  public
     * @return  void
     */
    public function action_index() // すでに管理者ユーザーでログインしているなら、メイン画面へ、そうでないならログイン画面へ
    {
        $admin_group_id = \Constants::$user_group['Administrators'];
        if (\Auth::check() && \Auth::member($admin_group_id)){
            \Response::redirect('manager/dashboard/index');
        } else {
            \Response::redirect('manager/index/login');
        }
    }

}

/* End of file index.php */
