<?php

namespace Manager;

class Controller_Memberofcommittees extends Controller_Base {

	public function action_index()
	{
		$this->template->header = '所属メンバー検索';
		$this->template->title = '所属メンバー検索';
		$this->template->content 	= 	\View_Smarty::forge('memberofcommittees/index.tpl');
	}

	public function action_addnew()
    {
        $data['member_name'] = \Session::get('member_name');
        $member_id = \Session::get('member_id');

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
                        \Response::redirect('manager/officers/setup');
                    }
                    else
                    {
                        \Session::set_flash('error', $val->error());
                    }   
                }
            }
        }
        $this->template->header  = 'メンバー追加';
        $this->template->title      = 'メンバー追加';
        $this->template->content     = \View_Smarty::forge('memberofcommittees/addnew.tpl', $data);
    }

	public function action_searchmemberofcommitte()
	{
		if(\Input::method() == 'GET');
		{
			$nameMember				=	\Input::get('nameMember');
			$officer_in_commitee	=	\Input::get('officer_in_commitee');
			$request_of_cost		=	\Input::get('request_of_cost');
			$receipt_of_cost		=	\Input::get('receipt_of_cost');
			$noteMemberofCommitte	=	\Input::get('noteMemberofCommitte');
			$sortmemberofCommitte	=	\Input::get('sortmemberofCommitte');
			$attributes_member		=	\Input::get('attributes_member');

			$data['sessionMemberofCommitte'] = array(
				'nameMember'			=>	$nameMember, 
				'officer_in_commitee'	=>	$officer_in_commitee, 
				'request_of_cost'		=>	$request_of_cost, 
				'receipt_of_cost'		=>	$receipt_of_cost,
				'noteMemberofCommitte'	=>	$noteMemberofCommitte,
				'sortmemberofCommitte'	=>	$sortmemberofCommitte, 
				'attributes_member'		=>	$attributes_member,
			);

			\Session::set('sessionMember', $data['sessionMemberofCommitte']);

			switch($sortmemberofCommitte)
			{
				case'0':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'asc';
					break;
				case'1':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'desc';
					break;
				case'2':
						$created_at	=	'base_of_members.id';
						$asc		=	'asc';
					break;
				case'3':
						$created_at	=	'base_of_members.id';
						$asc		=	'desc';
					break;
				default:
						$created_at	=	'';
						$asc		=	'';
					break;
			}

			if($nameMember != NULL)
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
								->where('user_key_tables.connect_type', '=', 31);
			}
			else
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL);
			}

			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $nameMember. "%")->and_where_close();
			}
			if($officer_in_commitee != NULL)
			{
				$query = $query->where('members_of_committees.officer_in_commitee', 'LIKE', "%" .$officer_in_commitee . "%");
			}
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}
			}
			if(count($request_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.request_of_cost', 'IN', $request_of_cost);
			}
			if(count($receipt_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.receipt_of_cost', 'IN', $receipt_of_cost);
			}
			if($noteMemberofCommitte != NULL)
			{
				$query = $query->where('members_of_committees.note', 'LIKE', "%" . $noteMemberofCommitte . "%");
			}
			else
			{
				 $query;
			}

			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
			}

			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links'		 =>	5,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',

			);
			
			$pagination = \Pagination::forge('mypagination', $config);

			\Session::set('backUrl', \Uri::update_query_string());
			\Session::delete('back_searchlistmemberofcommitte');
			\Session::set('back_searchmemberofcommitte', \Uri::update_query_string());

			$data['memberofcommitte_serach'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();
			
		}
			if(\Session::get('checkurlsearch') != NULL)
			{
				$data['dataCheckurl'] = \Session::get('checkurlsearch');
			}

			$this->template->title = '所属メンバー検索';
			$this->template->header = '所属メンバー検索';
			$this->template->content = \View_Smarty::forge('memberofcommittees/searchmemberofcommitte.tpl', $data);
	}
	public function action_searchlistmemberofcommitte() 
	{

		if(\Input::method() == 'GET');
		{
			$nameMember				=	\Input::get('nameMember');
			$officer_in_commitee	=	\Input::get('officer_in_commitee');
			$request_of_cost		=	\Input::get('request_of_cost');
			$receipt_of_cost		=	\Input::get('receipt_of_cost');
			$noteMemberofCommitte	=	\Input::get('noteMemberofCommitte');
			$sortmemberofCommitte	=	\Input::get('sortmemberofCommitte');
			$attributes_member		=	\Input::get('attributes_member');

			$data['sessionMemberofCommitte'] = array(
				'nameMember'			=>	$nameMember, 
				'officer_in_commitee'	=>	$officer_in_commitee, 
				'request_of_cost'		=>	$request_of_cost, 
				'receipt_of_cost'		=>	$receipt_of_cost,
				'noteMemberofCommitte'	=>	$noteMemberofCommitte,
				'sortmemberofCommitte'	=>	$sortmemberofCommitte, 
				'attributes_member'		=>	$attributes_member,
			);

			\Session::set('sessionMember', $data['sessionMemberofCommitte']);

			switch($sortmemberofCommitte)
			{
				case'0':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'asc';
					break;
				case'1':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'desc';
					break;
				case'2':
						$created_at	=	'base_of_members.id';
						$asc		=	'asc';
					break;
				case'3':
						$created_at	=	'base_of_members.id';
						$asc		=	'desc';
					break;
			}

			if($nameMember != NULL)
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
								->where('user_key_tables.connect_type', '=', 31);
			}
			else
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL);
			}

			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $nameMember. "%")->and_where_close();
			}
			if($officer_in_commitee != NULL)
			{
				$query = $query->where('members_of_committees.officer_in_commitee', 'LIKE', "%" .$officer_in_commitee . "%");
			}
			if($attributes_member != NULL)
			{

				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}
			}
			if(count($request_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.request_of_cost', 'IN', $request_of_cost);
			}
			if(count($receipt_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.receipt_of_cost', 'IN', $receipt_of_cost);
			}
			if($noteMemberofCommitte != NULL)
			{
				$query = $query->where('members_of_committees.note', 'LIKE', "%" . $noteMemberofCommitte . "%");
			}
			else
			{
				 $query;
			}

			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/memberofcommittees/index');
			}

			$data['manager_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();

			foreach ($data['manager_distinct'] as $item) 
			{
				$data['manager_searchlist'] = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.description', array('members_of_committees.note','memberofcommittees_note'), array('members_of_committees.edited_history', 'memberofcommittees_edit'), 'user_key_tables.connect_type', array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated'), array('members_of_committees.id', 'id_memberofcommittee') )
						->from('user_key_tables')->join('members_of_committees')->on('user_key_tables.member_id', '=', 'members_of_committees.member_id')
						->join('base_of_members')->on('members_of_committees.member_id', '=', 'base_of_members.id')
						->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
						->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
						->where('user_key_tables.deleted_at','IS', NULL)->where('persons.deleted_at','IS', NULL)
						->where('base_of_members.id', $item['id'])
						->order_by($created_at, $asc)
						->execute()->as_array();


					$data['searchlist'][$item['id_memberofcommittee']] = array();

					$data['searchlist'][$item['id_memberofcommittee']]['id'] 	= $item['id'];
					$data['searchlist'][$item['id_memberofcommittee']]['name'] = $item['name'];
					$data['searchlist'][$item['id_memberofcommittee']]['type'] = $item['type'];
					$data['searchlist'][$item['id_memberofcommittee']]['person_name'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['person_department'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['name_contact11'] 	= NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['department_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['email_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['tel_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['fax_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['zip_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['address01_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['address02_contact11'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['name_contact12'] 	= NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['department_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['email_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['tel_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['fax_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['zip_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['address01_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['address02_contact12'] = NULL;
					$data['searchlist'][$item['id_memberofcommittee']]['id_memberofcommittee'] = NULL;


				foreach ($data['manager_searchlist'] as $item)
				{
					$data['searchlist'][$item['id_memberofcommittee']]['id'] = $item['id'];
					$data['searchlist'][$item['id_memberofcommittee']]['name'] = $item['name'];
					$data['searchlist'][$item['id_memberofcommittee']]['type'] = $item['type'];
					$data['searchlist'][$item['id_memberofcommittee']]['id_memberofcommittee'] = $item['id_memberofcommittee'];
					if($item['connect_type'] == 1)
					{
						$data['searchlist'][$item['id_memberofcommittee']]['person_name'] = $item['person_name'];
						$data['searchlist'][$item['id_memberofcommittee']]['person_department'] = $item['person_department'];
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'] = $item['memberofcommittees_edit'];
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'] = $item['memberofcommittees_note'];
						$data['searchlist'][$item['id_memberofcommittee']]['id_memberofcommittee'] = $item['id_memberofcommittee'];
					}
					else if($item['connect_type'] == 11)
					{
						$data['searchlist'][$item['id_memberofcommittee']]['name_contact11'] = $item['person_name'];
						$data['searchlist'][$item['id_memberofcommittee']]['department_contact11'] = $item['person_department'];
						$data['searchlist'][$item['id_memberofcommittee']]['email_contact11'] = $item['person_email'];
						$data['searchlist'][$item['id_memberofcommittee']]['tel_contact11'] = $item['person_tel'];
						$data['searchlist'][$item['id_memberofcommittee']]['fax_contact11'] = $item['person_fax'];
						$data['searchlist'][$item['id_memberofcommittee']]['zip_contact11'] = $item['person_zip'];
						$data['searchlist'][$item['id_memberofcommittee']]['address01_contact11'] = $item['person_address01'];
						$data['searchlist'][$item['id_memberofcommittee']]['address02_contact11'] = $item['person_address02'];
						$data['searchlist'][$item['id_memberofcommittee']]['id_memberofcommittee'] = $item['id_memberofcommittee'];
					}
					else if($item['connect_type'] == 12)
					{
						$data['searchlist'][$item['id_memberofcommittee']]['name_contact12'] = $item['person_name'];
						$data['searchlist'][$item['id_memberofcommittee']]['department_contact12'] = $item['person_department'];
						$data['searchlist'][$item['id_memberofcommittee']]['email_contact12'] = $item['person_email'];
						$data['searchlist'][$item['id_memberofcommittee']]['tel_contact12'] = $item['person_tel'];
						$data['searchlist'][$item['id_memberofcommittee']]['fax_contact12'] = $item['person_fax'];
						$data['searchlist'][$item['id_memberofcommittee']]['zip_contact12'] = $item['person_zip'];
						$data['searchlist'][$item['id_memberofcommittee']]['address01_contact12'] = $item['person_address01'];
						$data['searchlist'][$item['id_memberofcommittee']]['address02_contact12'] = $item['person_address02'];
						$data['searchlist'][$item['id_memberofcommittee']]['id_memberofcommittee'] = $item['id_memberofcommittee'];
					}
				}	
			}

			\Session::delete('back_searchmemberofcommitte');
			\Session::set('back_searchlistmemberofcommitte', \Uri::update_query_string());
			$count_sear = count($data['manager_distinct']);
			$data['count_sear'] = $count_sear;
		}

		if(\Session::get('checkurlsearchlist') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurlsearchlist');


		}

        $this->template->title = '会員一覧';
        $this->template->header = '会員一覧';
		$this->template->content = \View_Smarty::forge('memberofcommittees/searchlistmemberofcommitte.tpl', $data);
	}
	public function action_exportcsvmemberofcommitte() 
	{

			$nameMember					=	\Session::get("sessionMember")['nameMember']; 
			$officer_in_commitee		=	\Session::get("sessionMember")['officer_in_commitee'];
			$request_of_cost			=	\Session::get("sessionMember")['request_of_cost'];
			$receipt_of_cost			=	\Session::get("sessionMember")['receipt_of_cost'];
			$noteMemberofCommitte		=	\Session::get("sessionMember")['noteMemberofCommitte'];
			$attributes_member			=	\Session::get("sessionMember")['attributes_member'];

			if($nameMember != NULL)
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
								->where('user_key_tables.connect_type', '=', 31);
			}
			else
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL);
			}

			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $nameMember. "%")->and_where_close();
			}
			if($officer_in_commitee != NULL)
			{
				$query = $query->where('members_of_committees.officer_in_commitee', 'LIKE', "%" .$officer_in_commitee . "%");
			}
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}
			}
			if(count($request_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.request_of_cost', 'IN', $request_of_cost);
			}
			if(count($receipt_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.receipt_of_cost', 'IN', $receipt_of_cost);
			}
			if($noteMemberofCommitte != NULL)
			{
				$query = $query->where('members_of_committees.note', 'LIKE', "%" . $noteMemberofCommitte . "%");
			}
			else
			{
				 $query;
			}

			$data['count_sear'] = count($query->distinct()->execute());

			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/memberofcommittees/index');
			}

		if(\Input::method() == 'POST' )
		{

			$attributesMemberCSV	=	\Input::post('attributesMemberCSV');
			$flatMemberCSV			=	\Input::post('flatMemberCSV');
			$nameMemberCSV			=	\Input::post('nameMemberCSV');
			$nameKanaMemberCSV		=	\Input::post('nameKanaMemberCSV');
			$namEngMemberCSV		=	\Input::post('namEngMemberCSV');
			$CustomCSV				=	\Input::post('CustomCSV');
			$repreInfoCSV			=	\Input::post('repreInfoCSV');
			$sortCSV				=	\Input::post('sortCSV');
			$historyCommentCSV		=	\Input::post('historyCommentCSV');
			$remarksCSV				=	\Input::post('remarksCSV');

			switch($sortCSV)
			{
				case'0':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'asc';
					break;
				case'1':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'desc';
					break;
				case'2':
						$created_at	=	'base_of_members.id';
						$asc		=	'asc';
					break;
				case'3':
						$created_at	=	'base_of_members.id';
						$asc		=	'desc';
					break;
				default:
						$created_at	=	'';
						$asc		=	'';
					break;
			}

			if($nameMember != NULL)
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
								->where('user_key_tables.connect_type', '=', 31);
			}
			else
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', array('members_of_committees.id', 'id_memberofcommittee'))
								->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
								->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL);
			}

			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $nameMember. "%")->and_where_close();
			}
			if($officer_in_commitee != NULL)
			{
				$query = $query->where('members_of_committees.officer_in_commitee', 'LIKE', "%" .$officer_in_commitee . "%");
			}
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}
			}
			if(count($request_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.request_of_cost', 'IN', $request_of_cost);
			}
			if(count($receipt_of_cost) > 0)
			{
				$query = $query->where('members_of_committees.receipt_of_cost', 'IN', $receipt_of_cost);
			}
			if($noteMemberofCommitte != NULL)
			{
				$query = $query->where('members_of_committees.note', 'LIKE', "%" . $noteMemberofCommitte . "%");
			}
			else
			{
				 $query;
			}

			$data['manager_exportCSV_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();


			foreach ($data['manager_exportCSV_distinct'] as $item) 
			{
				$data['manager_exportCSV'] = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng',  'base_of_members.description', array('members_of_committees.note','memberofcommittees_note'), array('members_of_committees.edited_history', 'memberofcommittees_edit'), 'user_key_tables.connect_type', array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated'), array('members_of_committees.id', 'id_memberofcommittee'), 'members_of_committees.cumstom_input01', 'members_of_committees.cumstom_input02', 'members_of_committees.cumstom_input03','members_of_committees.cumstom_input04', 'members_of_committees.cumstom_input05', 'members_of_committees.cumstom_input06', 'members_of_committees.cumstom_input07', 'members_of_committees.cumstom_input08', 'members_of_committees.cumstom_input09', 'members_of_committees.cumstom_input10', 'members_of_committees.cumstom_input11', 'members_of_committees.cumstom_input12', 'members_of_committees.cumstom_input13','members_of_committees.cumstom_input14', 'members_of_committees.cumstom_input15', 'members_of_committees.cumstom_input16', 'members_of_committees.cumstom_input17', 'members_of_committees.cumstom_input18', 'members_of_committees.cumstom_input19', 'members_of_committees.cumstom_input20' )
						->from('user_key_tables')->join('members_of_committees')->on('user_key_tables.member_id', '=', 'members_of_committees.member_id')
						->join('base_of_members')->on('members_of_committees.member_id', '=', 'base_of_members.id')
						->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
						->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
						->where('user_key_tables.deleted_at','IS', NULL)->where('persons.deleted_at','IS', NULL)
						->where('base_of_members.id', $item['id'])
						->order_by($created_at, $asc)
						->execute()->as_array();

				$data['searchlist'][$item['id_memberofcommittee']] 								= array();

				if($attributesMemberCSV == 'attributesMemberCSV')
				{
					$data['searchlist'][$item['id_memberofcommittee']]['type'] = $item['type'];
					switch($data['searchlist'][$item['id_memberofcommittee']]['type'])
					{
						case'0':
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('なし', "SJIS");
							break;
						case'1':
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('企業', "SJIS");
							break;
						case'2':
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('団体', "SJIS");
							break;
						case'3':
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('研究機関', "SJIS");
							break;
						case'4':
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('個人', "SJIS");
							break;
						default:
							$data['searchlist'][$item['id_memberofcommittee']]['type'] = mb_convert_encoding('地方自治体', "SJIS");
							break;
					}
				}

				else
				{
					$data['searchlist'][$item['id_memberofcommittee']]['type'] = NULL;
				}

				if($flatMemberCSV == 'flatMemberCSV')
				{
					$data['searchlist'][$item['id_memberofcommittee']]['profile_flag'] = $item['profile_flag'];
					switch($data['searchlist'][$item['id_memberofcommittee']]['profile_flag'])
					{
						case'0':
							$data['searchlist'][$item['id_memberofcommittee']]['profile_flag'] = mb_convert_encoding('RRI会員ではない', "SJIS");
							break;
						default:
							$data['searchlist'][$item['id_memberofcommittee']]['profile_flag'] = mb_convert_encoding('RRI会員', "SJIS");
							break;
					}
				}

				else
				{
					$data['searchlist'][$item['id_memberofcommittee']]['profile_flag'] = NULL;
				}

				if($nameMemberCSV == 'nameMemberCSV')
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name'] = $item['name'];
					$data['searchlist'][$item['id_memberofcommittee']]['name'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['name'], "SJIS");
				}

				else
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name'] = NULL;
				}

				if($nameKanaMemberCSV == 'nameKanaMemberCSV')
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name_kana']	= $item['name_kana'];
					$data['searchlist'][$item['id_memberofcommittee']]['name_kana'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['name_kana'], "SJIS");
				}

				else
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name_kana'] = NULL;
				}

				if($namEngMemberCSV == 'namEngMemberCSV')
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name_eng'] = $item['name_eng'];
					$data['searchlist'][$item['id_memberofcommittee']]['name_eng'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['name_eng'], "SJIS");
				}

				else
				{
					$data['searchlist'][$item['id_memberofcommittee']]['name_eng'] = NULL;
				}

				$data['searchlist'][$item['id_memberofcommittee']]['person_name'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['person_department'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'] 	= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'] 	= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input01'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input02'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input03'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input04'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input05'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input06'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input07'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input08'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input09'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input10'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input11'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input12'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input13'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input14'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input15'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input16'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input17'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input18'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input19'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input20'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['name_memberof'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['department_memberof'] 		= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['email_memberof'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['tel_memberof'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['fax_memberof'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['zip_memberof'] 				= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['address01_memberof'] 			= NULL;
				$data['searchlist'][$item['id_memberofcommittee']]['address02_memberof'] 			= NULL;


				foreach ($data['manager_exportCSV'] as $item)
				{

					if($repreInfoCSV == 'repreInfoCSV')
					{
						$data['searchlist'][$item['id_memberofcommittee']]['name_memberof']			= $item['person_name'];
						$data['searchlist'][$item['id_memberofcommittee']]['department_memberof']	= $item['person_department'];
						$data['searchlist'][$item['id_memberofcommittee']]['email_memberof']		= $item['person_email'];
						$data['searchlist'][$item['id_memberofcommittee']]['tel_memberof']			= $item['person_tel'];
						$data['searchlist'][$item['id_memberofcommittee']]['fax_memberof']			= $item['person_fax'];
						$data['searchlist'][$item['id_memberofcommittee']]['zip_memberof']			= $item['person_zip'];
						$data['searchlist'][$item['id_memberofcommittee']]['address01_memberof']	= $item['person_address01'];
						$data['searchlist'][$item['id_memberofcommittee']]['address02_memberof']	= $item['person_address02'];
						$data['searchlist'][$item['id_memberofcommittee']]['name_memberof'] 		= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['name_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['department_memberof']	= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['department_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['email_memberof']		= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['email_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['tel_memberof']			= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['tel_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['fax_memberof']			= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['fax_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['zip_memberof']			= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['zip_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['address01_memberof']	= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['address01_memberof'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['address02_memberof']	= mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['address02_memberof'], "SJIS");
					}
					if($historyCommentCSV == 'historyCommentCSV')
					{
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'] = $item['memberofcommittees_edit'];
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_edit'], "SJIS");
					}
					if($remarksCSV == 'remarksCSV')
					{
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'] = $item['memberofcommittees_note'];
						$data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['memberofcommittees_note'], "SJIS");
					}

					if($CustomCSV == 'CustomCSV')
					{
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input01'] = $item['cumstom_input01'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input02'] = $item['cumstom_input02'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input03'] = $item['cumstom_input03'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input04'] = $item['cumstom_input04'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input05'] = $item['cumstom_input05'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input06'] = $item['cumstom_input06'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input07'] = $item['cumstom_input07'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input08'] = $item['cumstom_input08'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input09'] = $item['cumstom_input09'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input10'] = $item['cumstom_input10'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input11'] = $item['cumstom_input11'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input12'] = $item['cumstom_input12'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input13'] = $item['cumstom_input13'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input14'] = $item['cumstom_input14'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input15'] = $item['cumstom_input15'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input16'] = $item['cumstom_input16'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input17'] = $item['cumstom_input17'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input18'] = $item['cumstom_input18'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input19'] = $item['cumstom_input19'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input20'] = $item['cumstom_input20'];
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input01'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input01'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input02'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input02'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input03'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input03'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input04'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input04'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input05'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input05'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input06'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input06'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input07'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input07'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input08'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input08'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input09'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input09'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input10'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input10'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input11'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input11'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input12'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input12'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input13'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input13'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input14'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input14'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input15'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input15'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input16'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input16'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input17'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input17'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input18'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input18'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input19'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input19'], "SJIS");
						$data['searchlist'][$item['id_memberofcommittee']]['cumstom_input20'] = mb_convert_encoding($data['searchlist'][$item['id_memberofcommittee']]['cumstom_input20'], "SJIS");
					}		
				}	
			}
			$arrayBigExportCsv = [];
			$arrayExportCsv = [];

			if($attributesMemberCSV == 'attributesMemberCSV')
			{
				array_push($arrayExportCsv,'type');
				$type = 'checktype';
			}
			if($flatMemberCSV == 'flatMemberCSV')
			{
				array_push($arrayExportCsv,'profile_flag');
				$profile_flag = 'checkRRI';
			}
			if($nameMemberCSV == 'nameMemberCSV')
			{
				array_push($arrayExportCsv,'name');
			}
			if($nameKanaMemberCSV == 'nameKanaMemberCSV')
			{
				array_push($arrayExportCsv,'name_kana');
			}
			if($namEngMemberCSV == 'namEngMemberCSV')
			{
				array_push($arrayExportCsv,'name_eng');
			}
			if($remarksCSV == 'remarksCSV')
			{
				array_push($arrayExportCsv,'memberofcommittees_note');
			}
			if($historyCommentCSV == 'historyCommentCSV')
			{
				array_push($arrayExportCsv,'memberofcommittees_edit');
			}
			if($repreInfoCSV == 'repreInfoCSV')
			{
				array_push($arrayExportCsv,'name_memberof','department_memberof', 'email_memberof', 'tel_memberof', 'fax_memberof', 'zip_memberof', 'address01_memberof', 'address02_memberof');
			}
			if($CustomCSV == 'CustomCSV')
			{
				array_push($arrayExportCsv,'cumstom_input01','cumstom_input02', 'cumstom_input03', 'cumstom_input04', 'cumstom_input05', 'cumstom_input06', 'cumstom_input07', 'cumstom_input08', 'cumstom_input09','cumstom_input10', 'cumstom_input11', 'cumstom_input12', 'cumstom_input13', 'cumstom_input14', 'cumstom_input15', 'cumstom_input16', 'cumstom_input17', 'cumstom_input18', 'cumstom_input19', 'cumstom_input20');
			}

			foreach ($data['searchlist'] as $key => $value) {
					$array = [];	
					$result[$key] = $value;
						for ($i=0; $i <count($arrayExportCsv); $i++) {

							array_push($array,$result[$key][$arrayExportCsv[$i]]);		
						}
					array_push($arrayBigExportCsv,$array);
			}

			$response = new \Response();
			$response->set_header('Content-Type', 'application/csv');
			$response->set_header('Content-Disposition', 'attachment; filename="'. '会員データ.csv' .'"');
			$response->set_header('Cache-Control', 'no-cache, no-store, max-age=0, must-revalidate');
			$response->set_header('Expires', 'Mon, 26 Jul 1997 05:00:00 GMT');
			$response->set_header('Pragma', 'no-cache');

			echo \Format::forge($arrayBigExportCsv)->to_csv(NULL, NULL, false, $arrayExportCsv);
			return $response;
		}

        $this->template->title = '所属メンバーのCSV出力';
        $this->template->header = '所属メンバーのCSV出力';
		$this->template->content = \View_Smarty::forge('memberofcommittees/exportcsvmemberofcommitte.tpl');
	}

	public function action_settingcommitte()
	{
		\Session::set('back_settingCommittees', \Uri::update_query_string());
		if(\Session::get('back_addmember')) $data['back'] = \Session::get('back_addmember');
		if(\Session::get('back_editmember')) $data['back'] = \Session::get('back_editmember');
		$this->template->title = 'メンバー設定';
		$this->template->header = 'メンバー設定';
		$this->template->content = \View_Smarty::forge('memberofcommittees/settingcommitte.tpl', $data);
	}

	public function action_searchsettingcommitte()
	{

		if(\Input::method() == 'GET')
		{
			$nameMember				=	\Input::get('nameMember');
			$namePerson				=	\Input::get('namePerson');
			$department				=	\Input::get('department');
			$email					=	\Input::get('email');
			$sortcommitte			=	\Input::get('sortcommitte');

			switch($sortcommitte)
			{
				case'0':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'asc';
					break;
				case'1':
						$created_at	=	'base_of_members.name_kana';
						$asc		=	'desc';
					break;
				case'2':
						$created_at	=	'persons.name_kana';
						$asc		=	'asc';
					break;
				case'3':
						$created_at	=	'persons.name_kana';
						$asc		=	'desc';
					break;
				case'4':
						$created_at	=	'persons.id';
						$asc		=	'asc';
					break;
				case'5':
						$created_at	=	'persons.id';
						$asc		=	'desc';
					break;
			}

			$query = \DB::select('persons.id', 'base_of_members.name', 'base_of_members.type', 'base_of_members.name_kana', array('persons.name', 'person_name'), 'persons.name_kana', 'persons.department', 'persons.email', 'persons.address01', 'persons.tel', 'persons.fax')
									->from('persons')->join('user_key_tables','LEFT')->on('persons.id', '=', 'user_key_tables.person_id')
									->join('members_of_committees', 'LEFT')->on('user_key_tables.committee_id', '=' , 'members_of_committees.committee_id')->on('user_key_tables.member_id', '=' , 'members_of_committees.member_id')
									->join('base_of_members', 'LEFT')->on('members_of_committees.member_id', '=' , 'base_of_members.id')
									->where('base_of_members.deleted_at','IS', NULL)->where('members_of_committees.deleted_at','IS', NULL)
									->where('user_key_tables.deleted_at','IS', NULL)->where('persons.deleted_at','IS', NULL)
									->where('user_key_tables.connect_type', '=', 31);

			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $nameMember. "%")->and_where_close();
			}
			if($namePerson != NULL)
			{
				$query = $query->and_where_open()->where('persons.name', 'LIKE', "%" . $namePerson. "%")->or_where('persons.name_kana', 'LIKE', "%" . $namePerson. "%")->and_where_close();
			}
			if($department != NULL)
			{
				$query = $query->where('persons.department', 'LIKE', "%" . $department. "%");
			}
			if($email != NULL)
			{
				$query = $query->where('persons.email', 'LIKE', "%" . $email. "%");
			}
			else
			{
				 $query;
			}
			for($i=1; $i <=20 ; $i++)
			{
				$i < 10 ? $n = "0{$i}" : $n = $i;
				$cumstom_input = 'cumstom_input'. $n;
				if(\Input::get('cumstom_input'.$i) != NULL)
				{
					$query = $query->where('members_of_committees.'.$cumstom_input, 'LIKE', "%" . \Input::get('cumstom_input'.$i). "%");
				}
				else
				{
					 $query;
				}
			}


			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/memberofcommittees/settingcommitte');
			}

			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links' 	 => 4,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',
			);

			$pagination = \Pagination::forge('mypagination', $config);

			if(\Session::get('back_addmember')) $data['back'] = \Session::get('back_addmember');
			if(\Session::get('back_editmember')) $data['back'] = \Session::get('back_editmember');

			\Session::set('back_searchsettingcommitte', \Uri::update_query_string());

			$data['memberofcommittee_search'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->execute();


		}

		$this->template->title = 'メンバー設定';
		$this->template->header = 'メンバー設定';
		$this->template->content 	= 	\View_Smarty::forge('memberofcommittees/searchsettingcommittee.tpl', $data);
	}

	public function action_addmember($id = NULL)
	{
		$data = NULL;
		\Session::set('back_addmember', \Uri::update_query_string());
		\Session::set('back', \Uri::update_query_string());

		$idCommittee = \DB::select('id')->from('committees')
			->where('id','=',$id)
			->where('deleted_at','IS',NULL)
			->execute();

		if(($idCommittee != NULL))
		{
			\Session::set('idCommittee',$idCommittee[0]['id']);
			$data['data_selectable_officer'] =  \DB::select('selectable_officer')->from('committees')
				->where('id','=',$idCommittee[0]['id'])
				->where('deleted_at','IS',NULL)
				->execute();

			//add value 役職なし to 役職
			$array_1 = array("0" => '役職なし');
			$arr = preg_split( '/\r\n|\r|\n/', $data['data_selectable_officer'][0]['selectable_officer']);
			for($i=0;$i<count($arr);$i++)
			{
				array_push($array_1, $arr[$i]);
			}
			
			$data['data_selectable_officer'] = $array_1;

			if($data['data_selectable_officer'] != NULL)
			\Session::set('data_selectable_officer',$data['data_selectable_officer']);

			$data['dataCommitteeOld'] = \DB::select('*')->from('committees')
				->where('id',$idCommittee[0]['id'])
				->where('deleted_at','IS',NULL)
				->execute();

			for($i=1;$i<=20;$i++)
			{
				if($i < 10)
                    $n = "0{$i}";
                else
                    $n = $i;

					//$array = explode("\n", $data['dataCommitteeOld'][0]['custom_input_selectable'.$n]);
                	$array = preg_split( '/\r\n|\r|\n/', $data['dataCommitteeOld'][0]['custom_input_selectable'.$n]);
					$array1['custom_input_selectable'.$n] = $array;
			}

			$data['dataCustomCommittee'] = $array1;
		}
		else
		{
			\Response::redirect('error/404');
		}

		if(\Input::method() == 'POST')
		{	
			
			$arrayName = array(
				'officer_in_commitee'=> \Input::post('officer_in_commitee'),
				'request_of_cost'	=> \Input::post('request_of_cost'),
				'receipt_of_cost'	=> \Input::post('receipt_of_cost'),
				'note'				=> \Input::post('note'),		
			);

			for ($i=1; $i <= 20 ; $i++)
			{
			    if($i < 10)
			        $n = "0{$i}";
			    else
			        $n = $i;
			    	if(is_array(\Input::post("cumstom_input{$n}")))
			        {
			        	$result = implode(\Input::post("cumstom_input{$n}"), ',');
			        }
			        else
			        {
			        	$result = \Input::post("cumstom_input{$n}");
			        }

			    	$second_array = array(
			            "cumstom_input{$n}"	=> $result,
			        );

			        $arrayName =  array_merge((array)$arrayName,(array)$second_array);
			}

	        $data['dataMemberofcommittees'] = $arrayName;

	        if($data['dataMemberofcommittees'] != NULL) \Session::set('dataMemberofcommittees', $data['dataMemberofcommittees']);

	        if(\Input::post('checkbutton') == 'setting_member')
			{
				\Response::redirect('manager/members/setting');
			}

			if(\Input::post('checkbutton') == 'delete_member') \Session::delete('dataMember');

			if(\Input::post('checkbutton') == 'setting_committee') \Response::redirect('manager/memberofcommittees/settingcommitte');

			if(\Input::post('checkbutton') == 'delete_committee') \Session::delete('dataCommittee');

			if(\Input::post('checkbutton') == 'submit_addmember')
			{

				if(\Session::get('dataMember') !=NULL && \Session::get('dataCommittee') !=NULL)
				{

					try
					{
						\DB::start_transaction();

						$dataMember = \Session::get('dataMember');
						$dataCommittee = \Session::get('dataCommittee');

						$arrayName = array(
							'member_id' => $dataMember,
							'committee_id' => \Session::get('idCommittee'),
							'officer_in_commitee'=> \Input::post('officer_in_commitee'),
							'request_of_cost'	=> \Input::post('request_of_cost'),
							'receipt_of_cost'	=> \Input::post('receipt_of_cost'),
							'note'				=> \Input::post('note'),		
						);

						for ($i=1; $i <= 20 ; $i++)
						{
						    if($i < 10)
						        $n = "0{$i}";
						    else
						        $n = $i;
						    	if(is_array(\Input::post("cumstom_input{$n}")))
						        {
						        	$result = implode(\Input::post("cumstom_input{$n}"), ',');
						        }
						        else
						        {
						        	$result = \Input::post("cumstom_input{$n}");
						        }

						    	$second_array = array(
						            "cumstom_input{$n}"	=> $result,
						        );

						        $arrayName =  array_merge((array)$arrayName,(array)$second_array);
						}

						$memberofcommittee = \Model_Memberofcommittee::forge(
												$arrayName
											);
						$memberofcommittee->save();

						$userkeytable = \Model_Userkeytable::forge(array(
											'member_id'		=> $dataMember,
											'connect_type' 	=> 31,
											'person_id'		=> $dataCommittee,
											'committee_id'	=> \Session::get('idCommittee'),
										));

						$userkeytable->save();

						\DB::commit_transaction();
					}
					catch(Exception $e)
					{
						// rollback pending transactional queries
						\DB::rollback_transaction();
						throw $e;
						\Session::set_flash('error', e('Could not save page.'));
						\Response::redirect('manager/memberofcommittees/addmember');
					}

					\Session::delete('back');
					\Session::delete('dataMemberofcommittees');
					\Session::delete('dataCommittee');
					\Session::delete('sessionOfficer');
					\Session::delete('dataSubCurator');
					\Session::delete('check_sub_curator');
					\Session::delete('check_main_curator');
					\Session::delete('check_new_sub_curator');
					\Session::delete('arrayNewSubCurator');
					\Session::delete('back_addmember');

					//\Session::set_flash('success', 'add member of committee success');
					\Response::redirect('manager/dashboard/index');
				}
				elseif(\Session::get('dataMember') != NULL && \Session::get('dataCommittee') == NULL)
				{
					\Session::set_flash('error', '所属メンバーの設定を行って下さい。');
					\Response::redirect('manager/memberofcommittees/addmember');
				}
				elseif(\Session::get('dataMember') == NULL && \Session::get('dataCommittee') != NULL)
				{
					\Session::set_flash('error', '会員の設定を行って下さい。');
					\Response::redirect('manager/memberofcommittees/addmember');
				}
				else
				{
					\Session::set_flash('error', '役員と所属メンバーの設定を行って下さい。');
					\Response::redirect('manager/memberofcommittees/addmember');
				}
			}

		}

		//If have data Member of committees
		if(\Session::get('dataMemberofcommittees') != NULL)
		{
			$data['dataMemberofcommittees'] = \Session::get('dataMemberofcommittees');

			foreach ($data['dataMemberofcommittees'] as $key => $value)
			{
			if (($key != 'id') &&
				($key != 'committee_id') &&
				($key != 'member_id') &&
				($key != 'officer_in_commitee') &&
				($key != 'request_of_cost') && 
				($key != 'receipt_of_cost'))
			{
				if(strpos($value, ','))
				{
					$cumstom_inputs[$key] = explode(",", trim($value));
				}
				else
				{
					$cumstom_inputs[$key][0] = trim($value);
				}
 			}

		}

			$data['dataCheckbox'] = $cumstom_inputs;
		}

		if(\Session::get('dataMember') != NULL)
			$data['dataMember']	=	\Model_Baseofmember::find('all', array(
					'where' => array(array('id', '=', \Session::get('dataMember')))
				));

		if(\Session::get('dataCommittee') != NULL)	
			$data['dataCommittee'] = \Model_Person::find('all', array(
					'where' => array(array('id', '=', \Session::get('dataCommittee')))
			));

		if(\Session::get('checkurladdmember') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurladdmember');
		}

		$this->template->header = '所属メンバー新規登録';
		$this->template->title = '所属メンバー新規登録';
		$this->template->content = \View_Smarty::forge('memberofcommittees/addmember.tpl', $data);
	}


	public function action_temp($id = NULL)
	{
		$id_memberofcommittee = \DB::select('id','committee_id')->from('members_of_committees')
			->where('id','=',$id)
			->where('deleted_at','IS',NULL)
			->execute();

		if($id_memberofcommittee[0]['id'] != NULL)
		{
			\Session::set('id_memberofcommittee',$id_memberofcommittee[0]['id']);

			$dataMemberofcommittees = \Model_Memberofcommittee::find('all', array(
				'where' => array(array('id', '=', $id_memberofcommittee[0]['id'])),
			));

			foreach ($dataMemberofcommittees as $key ) {
				$temp = $key->to_array();

				\Session::set('dataMemberofcommittees',$temp);

				if($key->committee_id != NULL)
				{
					\Session::set('idCommittee',$key->committee_id);
				}

				if($key->member_id != NULL)
				{
					$id_commmittee = \DB::select('id')->from('base_of_members')
						->where('id','=',$key->member_id)
						->where('deleted_at','IS', NULL)
						->execute();

					if($id_commmittee[0]['id'] != NULL)
					{
						\Session::set('dataMember',$id_commmittee[0]['id']);
						\Session::set('dataMember_old',$id_commmittee[0]['id']);
					}

				}

				if($key->committee_id != NULL && $key->member_id != NULL)
				{
					$dataCommittee = \DB::select('person_id')->from('user_key_tables')
						->where('committee_id','=',$key->committee_id)
						->where('member_id','=',$key->member_id)
						->where('connect_type','=',31)
						->where('deleted_at','IS', NULL)
						->limit(1)
						->execute()->as_array();

					if($dataCommittee != NULL)
					{
						$id_person = \DB::select('id')->from('persons')
						->where('id','=',$dataCommittee[0]['person_id'])
						->where('deleted_at','IS',NULL)
						->execute();

						if($id_person !=NULL)
						{
							\Session::set('dataCommittee',$id_person[0]['id']);
							\Session::set('dataCommittee_old',$id_person[0]['id']);
						}
					}
				}
			}
		}
		else
		{
			\Response::redirect('error/404');
		}
		
		\Response::redirect('manager/memberofcommittees/editmember');
	}

	public function action_editmember()
	{
		\Session::delete('back');
		\Session::set('back_editmember', \Uri::update_query_string());
		\Session::set('back', \Uri::update_query_string());


		if(\Session::get('id_memberofcommittee') == NULL)
		{
			\Response::redirect('error/404');
		}

		if ($_POST)
		{
			if ( ! \Security::check_token())
    		{
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/memberofcommittees/editmember');
			}
			else
			{
				if(\Input::method() == 'POST')
				{
					
					$arrayName = array(
						'officer_in_commitee'=> \Input::post('officer_in_commitee'),
						'request_of_cost'	=> \Input::post('request_of_cost'),
						'receipt_of_cost'	=> \Input::post('receipt_of_cost'),
						'note'				=> \Input::post('note'),		
					);

					for ($i=1; $i <= 20 ; $i++)
					{
					    if($i < 10)
					        $n = "0{$i}";
					    else
					        $n = $i;
					    	if(is_array(\Input::post("cumstom_input{$n}")))
					        {
					        	$result = implode(\Input::post("cumstom_input{$n}"), ',');
					        }
					        else
					        {
					        	$result = \Input::post("cumstom_input{$n}");
					        }

					    	$second_array = array(
					            "cumstom_input{$n}"	=> $result,
					        );

					        $arrayName =  array_merge((array)$arrayName,(array)$second_array);
					}

			        $data['dataMemberofcommittees'] = $arrayName;

			        if($data['dataMemberofcommittees'] != NULL) \Session::set('dataMemberofcommittees', $data['dataMemberofcommittees']);

			        //Click button setting member
					if(\Input::post('checkbutton') == 'setting_member') \Response::redirect('manager/members/setting');

					if(\Input::post('checkbutton') == 'delete_member')
					{
						\Session::delete('dataMember');
					}

					if(\Input::post('checkbutton') == 'delete_committee')
					{
						\Session::delete('dataCommittee');
					}

					if(\Input::post('checkbutton') == 'setting_committee')
					{
						\Response::redirect('manager/memberofcommittees/settingcommitte');
					}

					if(\Input::post('checkbutton') == 'submit_editmember')
					{

						if(\Session::get('dataMember') != NULL && \Session::get('dataCommittee') !=NULL && \Session::get('id_memberofcommittee') != NULL)
						{
							try
							{
								\DB::start_transaction();

								$dataMember = \Session::get('dataMember');
								$dataCommittee = \Session::get('dataCommittee');


								$arrayName = array(
									'member_id' => $dataMember,
									'person_id' => $dataCommittee,
									'officer_in_commitee'=> \Input::post('officer_in_commitee'),
									'request_of_cost'	=> \Input::post('request_of_cost'),
									'receipt_of_cost'	=> \Input::post('receipt_of_cost'),
									'note'				=> \Input::post('note'),		
								);

								for ($i=1; $i <= 20 ; $i++)
								{
								    if($i < 10)
								        $n = "0{$i}";
								    else
								        $n = $i;
								    	if(is_array(\Input::post("cumstom_input{$n}")))
								        {
								        	$result = implode(\Input::post("cumstom_input{$n}"), ',');
								        }
								        else
								        {
								        	$result = \Input::post("cumstom_input{$n}");
								        }

								    	$second_array = array(
								            "cumstom_input{$n}"	=> $result,
								        );

								        $arrayName =  array_merge((array)$arrayName,(array)$second_array);
								}

								$update_membersofcommittees = \Model_Memberofcommittee::find(\Session::get('id_memberofcommittee'));
								$update_membersofcommittees->set(
								    $arrayName
								);
								$update_membersofcommittees->save();

								$update_userkeytable =\DB::update('user_key_tables')
									->where('committee_id','=',\Session::get('idCommittee'))
									->where('connect_type','=',31)
									->where('user_key_tables.deleted_at', 'IS',NULL);
								//echo "<pre>"; print_r($update_userkeytable);exit;
								$update_userkeytable->set(array(
									'member_id' =>  \Session::get('dataMember'),
									'person_id'	=> \Session::get('dataCommittee'),
									'updated_at' => date_timestamp_get(date_create()),
								));
								$update_userkeytable->execute();

								if(\Session::get('dataMember') != \Session::get('dataMember_old'))
								{
									//get value edit history old
									$edited_history_old = \DB::select('edited_history')->from('members_of_committees')
										->where('id','=',\Session::get('id_memberofcommittee'))
										->where('deleted_at', 'IS',NULL)
										->execute();
									//Update history table members_of_committees person_id change
									$update_edithistory =\DB::update('members_of_committees')
										->where('id','=',\Session::get('id_memberofcommittee'))
										->where('deleted_at', 'IS',NULL);
									$update_edithistory->set(array(
										'edited_history' => date('Y-m-d').'会員'.\Session::get('username').'さんから変更になりました。'."\n".$edited_history_old[0]['edited_history'],
									    'updated_at' => date_timestamp_get(date_create()),
									));
									$update_edithistory->execute();
								}

								if(\Session::get('dataCommittee') != \Session::get('dataCommittee_old'))
								{
									//get value edit history old
									$edited_history_old = \DB::select('edited_history')->from('members_of_committees')
										->where('id','=',\Session::get('id_memberofcommittee'))
										->where('deleted_at', 'IS',NULL)
										->execute();
									//Update history table members_of_committees member_id change
									$update_edithistory =\DB::update('members_of_committees')
										->where('id','=',\Session::get('id_memberofcommittee'))
										->where('deleted_at', 'IS',NULL);
									$update_edithistory->set(array(
										'edited_history' => date('Y-m-d').'メンバー'.\Session::get('username').'さんから変更になりました。'."\n".$edited_history_old[0]['edited_history'] ,
									    'updated_at' => date_timestamp_get(date_create()),
									));
									$update_edithistory->execute();
								}

								\DB::commit_transaction();
							}
							catch(Exception $e)
							{
								// rollback pending transactional queries
								\DB::rollback_transaction();
								throw $e;
								\Session::set_flash('error', e('Could not save page.'));
								\Response::redirect('manager/memberofcommittees/editmember');
							}

							
							\Session::delete('id_memberofcommittee');
							\Session::delete('dataMember');
							\Session::delete('dataMember_old');
							\Session::delete('dataCommittee');
							\Session::delete('dataCommittee_old');
							\Session::delete('dataMemberofcommittees');
							\Session::delete('idCommittee');

							//\Session::set_flash('success', 'Edit success memberofcommitte');

							if(\Session::get('back_searchmemberofcommitte'))
							{
								$back_searchmemberofcommitte = \Session::get('back_searchmemberofcommitte');
								\Session::set('checkurlsearch',\Uri::update_query_string());
								\Session::delete('back_searchmemberofcommitte');
								\Response::redirect($back_searchmemberofcommitte);
							}
							else if(\Session::get('back_searchlistmemberofcommitte'))
							{
								$back_searchlistmemberofcommitte = \Session::get('back_searchlistmemberofcommitte');
								\Session::set('checkurlsearchlist',\Uri::update_query_string());
								\Session::delete('back_searchlistmemberofcommitte');
								\Response::redirect($back_searchlistmemberofcommitte);
							}
							else
							{
								\Response::redirect('manager/dashboard/index');
							}
							
						}
						elseif(\Session::get('dataMember') == NULL && \Session::get('dataCommittee') !=NULL)
						{
							\Session::set_flash('error', '会員の設定を行って下さい。');
							\Response::redirect('manager/memberofcommittees/editmember');
						}
						elseif(\Session::get('dataCommittee') ==NULL && \Session::get('dataMember') != NULL)
						{
							\Session::set_flash('error', '所属メンバーの設定を行って下さい。');
							\Response::redirect('manager/memberofcommittees/editmember');
						}
						else
						{
							\Session::set_flash('error', '役員と所属メンバーの設定を行って下さい。');
							\Response::redirect('manager/memberofcommittees/editmember');
						}
					}

					if(\Input::post('checkbutton') == 'submit_deletemember')
					{
						if(\Session::get('id_memberofcommittee') != NULL && \Session::get('dataMember_old') != NULL && \Session::get('idCommittee') != NULL)
						{
							try
							{
								\DB::start_transaction();
								//Delete user_key_tables
								$delete_userkeytable = \DB::update('user_key_tables')
									->where('member_id','=',\Session::get('dataMember_old'))
									->where('committee_id', '=' , \Session::get('idCommittee'))
									->where('person_id','=',\Session::get('dataCommittee_old'))
									->where('connect_type','=',31)
									->where('deleted_at', 'IS',NULL);
								$delete_userkeytable->set(array(
								    'updated_at' => date_timestamp_get(date_create()),
								    'deleted_at' => date_timestamp_get(date_create()),
								));

								//Delete members_of_committees
								$delete_memberofcommittee = \DB::update('members_of_committees')
									->where('id','=',\Session::get('id_memberofcommittee'))
									->where('deleted_at', 'IS',NULL);
								$delete_memberofcommittee->set(array(
								    'updated_at' => date_timestamp_get(date_create()),
								    'deleted_at' => date_timestamp_get(date_create()),
								));
								$delete_memberofcommittee->execute();
								
								\DB::commit_transaction();
							}
							catch(Exception $e)
							{
								// rollback pending transactional queries
								\DB::rollback_transaction();
								throw $e;
								\Session::set_flash('error', e('Could not save page.'));
								\Response::redirect('manager/memberofcommittees/editmember');
							}

							//\Session::set_flash('success', 'Delete success memberofcommitte');
							\Session::delete('id_memberofcommittee');
							\Session::delete('dataMember');
							\Session::delete('dataMember_old');
							\Session::delete('dataCommittee');
							\Session::delete('dataCommittee_old');
							\Session::delete('dataMemberofcommittees');
							\Session::delete('committee_id_old');
							\Session::delete('back_editmember');

							if(\Session::get('back_searchmemberofcommitte'))
							{
								$back_searchmemberofcommitte = \Session::get('back_searchmemberofcommitte');
								\Session::set('checkurlsearch',\Uri::update_query_string());
								\Session::delete('back_searchmemberofcommitte');
								\Response::redirect($back_searchmemberofcommitte);
							}
							else if(\Session::get('back_searchmemberofcommitte'))
							{
								$back_searchmemberofcommitte = \Session::get('back_searchmemberofcommitte');
								\Session::set('checkurlsearchlist',\Uri::update_query_string());
								\Session::delete('back_searchmemberofcommitte');
								\Response::redirect($back_searchmemberofcommitte);
							}
							else
							{
								\Response::redirect('manager/dashboard/index');
							}
							
						}
						else
						{
							\Session::set_flash('error', e('Do not delete'));
							\Response::redirect('manager/memberofcommittees/editmember');
						}
					}
				}
			}
		}

		if(\Session::get('idCommittee') != NULL)
		{
			$data['data_selectable_officer'] =  \DB::select('selectable_officer')->from('committees')
				->where('id','=',\Session::get('idCommittee'))
				->where('deleted_at','IS',NULL)
				->execute();
			$array_1 = array("0" => '役職なし');
			$arr = explode("\n", $data['data_selectable_officer'][0]['selectable_officer']);
			for($i=0;$i<count($arr);$i++)
			{
				array_push($array_1, trim($arr[$i]));
			}

			$data['data_selectable_officer'] = $array_1;

			$arrayName = array('役職なし'=>'役職なし');

			for($j=1; $j < count($data['data_selectable_officer']); $j++)
			{
				$result = array(
					$data['data_selectable_officer'][$j] => $data['data_selectable_officer'][$j],
				);

				$arrayName =  array_merge((array)$arrayName,(array)$result);
			}

			$data['data_selectable_officer'] = $arrayName;
		}

		if(\Session::get('idCommittee') != NULL)
		{
			$data['dataCommitteeOld'] = \DB::Select('*')->from('committees')
				->where('id','=',\Session::get('idCommittee'))
				->where('deleted_at','IS',NULL)
				->execute();

			$array_1 = array("0" => '役職なし');
			//$arr = explode("\n", $data['data_selectable_officer'][0]['selectable_officer']);
			$arr = preg_split( '/\r\n|\r|\n/', $data['dataCommitteeOld'][0]['selectable_officer']);
			for($i=0;$i<count($arr);$i++)
			{
				array_push($array_1, $arr[$i]);
			}
			
			$data['data_selectable_officer'] = $array_1;
		}

		$data['dataCommitteesName']	= \DB::select('id','committee_name')->from('committees')
			->execute()->as_array();
		$data['dataCommitteesName'] = \Arr::assoc_to_keyval($data['dataCommitteesName'], 'id', 'committee_name');
		//Isset data dataMemberofcommittees in view
		if(\Session::get('dataMemberofcommittees') != NULL)
		{
			$data['dataMemberofcommittees']	= \Session::get('dataMemberofcommittees');

			foreach ($data['dataMemberofcommittees'] as $key => $value)
			{
			if (($key != 'id') &&
				($key != 'committee_id') &&
				($key != 'member_id') &&
				($key != 'officer_in_commitee') &&
				($key != 'request_of_cost') && 
				($key != 'receipt_of_cost'))
			{
				if(strpos($value, ','))
				{
					$cumstom_inputs[$key] = explode(",", trim($value));
				}
				else
				{
					$cumstom_inputs[$key][0] = trim($value);
				}
 			}
 			}
 			$data['dataCheckbox'] = $cumstom_inputs;

 			for($i=1;$i<=20;$i++)
			{
				if($i < 10)
                    $n = "0{$i}";
                else
                    $n = $i;

					//$array = explode("\n", $data['dataCommitteeOld'][0]['custom_input_selectable'.$n]);
                	$array = preg_split( '/\r\n|\r|\n/', $data['dataCommitteeOld'][0]['custom_input_selectable'.$n]);
					$array1['custom_input_selectable'.$n] = $array;
			}

			$cumstom_inputs1 = array();

			foreach ($data['dataMemberofcommittees'] as $key => $value) 
			{
				if (($key != 'id') &&
					($key != 'committee_id') &&
					($key != 'member_id') &&
					($key != 'officer_in_commitee') &&
					($key != 'request_of_cost') && 
					($key != 'receipt_of_cost'))
				{
					if(strpos($value, ','))
					{
						$cumstom_inputs1[$key] = explode(",", trim($value));
					}
					else
					{
						$cumstom_inputs1[$key][0] = trim($value);
					}
	 			}
			}
			$data['cumstom_inputs'] = $cumstom_inputs;
			$data['dataCustomCommittee'] = $array1;
		}

		//Isset data Person in view
		if (\Session::get('dataMember') != NULL)
		{
			$dataMember		= \Session::get('dataMember');

			if($dataMember != NULL)
			{
				$data['dataMember'] = \Model_Baseofmember::find('all', array(
					'where' => array(array('id', '=', $dataMember))
				));
			}
			else
			{
				\Session::delete('dataMember');
			}
		}

		//Isset data Person in view
		if (\Session::get('dataCommittee') != NULL)
		{
			$dataCommittee		= \Session::get('dataCommittee');

			if($dataCommittee != NULL)
			{
				$data['dataCommittee'] = \Model_Person::find('all', array(
					'where' => array(array('id', '=', $dataCommittee))
				));
			}
			else
			{
				\Session::delete('dataCommittee');
			}
		}

		if(\Session::get('checkurleditmember') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurleditmember');
		}
		//echo($data('data_selectable_officer'));exit;
		$this->template->header = '所属メンバー編集';
		$this->template->title = '所属メンバー編集';
		$this->template->content = \View_Smarty::forge('memberofcommittees/editmember.tpl', $data);
	}

}

