<?php

namespace Manager;

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
        //Delete Session
        \Session::delete('checkUrlOfficerSetup');
        \Session::delete('checkurleditmember');
        \Session::delete('checkurladdmember');
        \Session::delete('backToOfficerSearchList');
        \Session::delete('back_searchlistmemberofcommitte');
        \Session::delete('id');
        \Session::delete('checkurlsearch');
        \Session::delete('Jobholder');
        \Session::delete('previous_url');
        \Session::delete('checkurlsearchlist');
        \Session::delete('back_searchbaseofmember');
        \Session::delete('back_searchlistbaseofmember');
        \Session::delete('dataOfficer');
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

        //Create go back dashboard
        \Session::set('back', \Uri::update_query_string());

        $this->template->header = 'メイン';
        $this->template->title = 'メイン';
        $this->template->pagetitle = \Constants::$page_title['mainmenu'];
        $this->template->content = \View_Smarty::forge('dashboard/index.tpl');
    }
}

/* End of file index.php */
