<?php

namespace Manager;

class Controller_Committees extends Controller_Base {

	public function action_setting()
	{
		$data['back'] = \Session::get('back');

		$this->template->title    = 'メンバー設定';
		$this->template->content  =	\View_Smarty::forge('committees/setting.tpl', $data);
	}

	public function action_view($id=NULL)
    {
        if(\Session::get('back_addmember')) $data['back'] = \Session::get('back_addmember');
        if(\Session::get('back_editmember')) $data['back'] = \Session::get('back_editmember');

        $data['member'] = \DB::select('persons.id','persons.name','persons.name_kana','persons.department','persons.email','persons.tel','persons.fax','persons.zip','persons.address01','persons.address02','persons.published_site_id','persons.type_of_ml',array('base_of_members.name', 'member_name'),array('base_of_members.name_kana', 'name_member_kana'),'user_key_tables.connect_type')
                        ->from('persons')
                        ->join('user_key_tables','LEFT')
                        ->on('user_key_tables.person_id', '=', 'persons.id')
                        ->join('base_of_members','LEFT')->on('base_of_members.id', '=', 'user_key_tables.member_id')
                        ->and_where_open()
                            ->where('persons.id','=', $id)
                        ->and_where_close()
                        ->limit(1)
                        ->as_object()
                   ->execute();

        $committee_id = $data['member'][0]->id;

        if(\Input::method() == 'POST')
        {   
            \Session::set('dataCommittee', $committee_id);
            \Response::redirect($data['back']);
        }

        $this->template->header       = "メンバー設定";
        $this->template->title       = "メンバー設定";
        $this->template->content     = \View_Smarty::forge('committees/view.tpl', $data);
    }

    public function action_create()
    {
        $data['member_name'] = \Session::get('member_name');
        $member_id = \Session::get('member_id');
        if(\Session::get('back_addmember')) $data['back'] = \Session::get('back_addmember');
        if(\Session::get('back_editmember')) $data['back'] = \Session::get('back_editmember');

        if ($_POST)
        {   
            if ( ! \Security::check_token())
            {    
                \Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/members/create');
            }   
            else   
            {
                if(\Input::post('send')) 
                {
                    //Chay validation truoc khi them mot cong chuc moi
                    $val = \Model_Person::validate('create');
                    if ($val->run())
                    {
                            $CommitteePerson = \Model_Person::forge(array(
                            'department'    => \Input::post('department'),
                            'name'          => \Input::post('name'),
                            'name_kana'     => \Input::post('name_kana'),
                            'email'         => \Input::post('email'),
                            'tel'           => \Input::post('tel'),
                            'fax'           => \Input::post('fax'),
                            'zip'           => \Input::post('zip'),
                            'address01'     => \Input::post('address01'),
                            'address02'     => \Input::post('address02'),
                            'published_site_id' => \Input::post('published_site_id'),
                            'type_of_ml'    => \Input::post('type_of_ml'),
                        ));                 

                        $CommitteePerson->save();

                        $data['dataCommittee'] = $CommitteePerson->id;

                        \Session::set('dataCommittee', $data['dataCommittee']);
                        \Response::redirect($data['back']);
                    }
                    else
                    {
                        \Session::set_flash('error', $val->error());
                    }   
                }
            }
        }

        $this->template->header      = 'メンバー追加';
        $this->template->title      = 'メンバー追加';
        $this->template->content     = \View_Smarty::forge('committees/create.tpl', $data);
    }

    public function action_reset($id=NULL)
    {
        $data['id'] = $id;

        $this->template->header  = '年度管理';
        $this->template->title = '年度管理';
        $this->template->content = \View_Smarty::forge('committees/reset.tpl',$data);
    }

    public function action_resetRequestOfCost($id=NULL)
    {   
        \DB::update('members_of_committees')
        ->set(array(
            'members_of_committees.request_of_cost' => 0,
            'members_of_committees.updated_at'      => date_timestamp_get(date_create())))
        ->where('members_of_committees.committee_id', '=', $id)
        ->where('members_of_committees.request_of_cost', '=', 1)
        ->where('members_of_committees.deleted_at', 'IS', NULL)
        ->execute();

        $error = ' 年会費の請求の設定を行いました。';
        \Session::set_flash('error', $error);

        \Response::redirect('manager/committees/reset/'.$id);
    }

    public function action_resetReceiptOfCost($id=NULL)
    {   
        \DB::update('members_of_committees')
        ->set(array(
            'members_of_committees.receipt_of_cost' => 0,
            'members_of_committees.updated_at'      => date_timestamp_get(date_create())))
        ->where('members_of_committees.committee_id', '=', $id)
        ->where('members_of_committees.receipt_of_cost', '=', 1)
        ->where('members_of_committees.deleted_at', 'IS', NULL)
        ->execute();

        $error = ' 年会費の入金の設定を行いました。';
        \Session::set_flash('error', $error);

        \Response::redirect('manager/committees/reset/'.$id);
    }

}