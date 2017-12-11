<?php

namespace Manager;

class Controller_BaseOfMember extends Controller_Base {

	// M004-01	
	public function action_index()
	{
		$this->template->title = '会員検索';
		$this->template->header = '会員検索';
		$this->template->content 	= 	\View_Smarty::forge('baseofmember/index.tpl');
	}

	// M004-02
	public function action_searchmember()
	{
		if(\Input::method() == 'GET');
		{
			// Get data 会員名称: nameMember
			$nameMember			=	\Input::get('nameMember');
			// Get data 総会の出席: checkbox listPresent[]
			$listPresent		=	\Input::get('listPresent');
			// Get data 総会の委任状: checkbox listProxy[]
			$listProxy			=	\Input::get('listProxy');
			// Get data 会員フラグ: checkbox RRI[]
			$RRI				=	\Input::get('RRI');
			// Get data 備考: noteMember
			$noteMember			=	\Input::get('noteMember');
			// Get data ソート順: sortmember
			$sortmember			=	\Input::get('sortmember');
			// Get data 会員属性: attributes_member
			$attributes_member	=	\Input::get('attributes_member');


			// Set Session export CSV M004-04
			$data['sessionMember'] = array(
				'nameMember'			=>	$nameMember,
				'attributes_member'		=>	$attributes_member,
				'RRI'					=>	$RRI,
				'listPresent'			=>	$listPresent, 
				'listProxy'				=>	$listProxy, 
				'sortmember'			=>	$sortmember, 
				'noteMember'			=>	$noteMember
			);

			\Session::set('sessionMember', $data['sessionMember']);

			// ソート順: sortmember
			switch($sortmember)
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

			// Query Builder Base_of_members TBL && Members TBL
			$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'members.note')
								->from('base_of_members')->join('members')->on('base_of_members.id', '=', 'members.member_id')
								->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL);

			// 会員属性: attributes_member
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}		

			}
			// 会員フラグ: checkbox RRI[]
			if(count($RRI) > 0)
			{
				$query = $query->where('base_of_members.profile_flag', 'IN', $RRI);
			}
			// 備考: noteMember
			if($noteMember != NULL)
			{
				$query = $query->where('members.note', 'LIKE', "%" . $noteMember . "%");
			}
			// 会員名称: nameMember (LIKE name && name_kana)
			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
			}
			// 総会の出席: checkbox listPresent[]
			if(count($listPresent) > 0)
			{
				$query = $query->where('members.attendance_of_meeting', 'IN', $listPresent);
			}
			// 総会の委任状: checkbox listProxy[]
			if(count($listProxy) > 0)
			{
				$query = $query->where('members.proxy_of_meeting', 'IN', $listProxy);
			}
			else
			{
				 $query;
			}

			// count total_items result
			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			// Set_flash if count total_items <= 0
			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
			}

			// Config pagiantion
			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links'		 =>	5,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',

			);

			// Set session come back M004-02
			\Session::delete('back_searchlistbaseofmember');
			\Session::set('back_searchbaseofmember', \Uri::update_query_string());

			// pagination
			$pagination = \Pagination::forge('mypagination', $config);

			// create data views M004-02
			$data['manager_search'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();
		}

		if(\Session::get('checkurlsearch') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurlsearch');
		}

			$this->template->title = '会員検索';
			$this->template->header = '会員検索';
			$this->template->content = \View_Smarty::forge('baseofmember/searchmember.tpl', $data);
	}

	// M004-03
	public function action_searchlist() 
	{
		if(\Input::method() == 'GET');
		{
			// Get data 会員名称: nameMember
			$nameMember			=	\Input::get('nameMember');
			// Get data 総会の出席: checkbox listPresent[]
			$listPresent		=	\Input::get('listPresent');
			// Get data 総会の委任状: checkbox listProxy[]
			$listProxy			=	\Input::get('listProxy');
			// Get data 会員フラグ: checkbox RRI[]
			$RRI				=	\Input::get('RRI');
			// Get data 備考: noteMember
			$noteMember			=	\Input::get('noteMember');
			// Get data ソート順: sortmember
			$sortmember			=	\Input::get('sortmember');
			// Get data 会員属性: attributes_member
			$attributes_member	=	\Input::get('attributes_member');

			// Set Session export CSV M004-04
			$data['sessionMember'] = array(
				'nameMember'			=>	$nameMember, 
				'RRI'					=>	$RRI, 
				'attributes_member'		=>	$attributes_member, 
				'listPresent'			=>	$listPresent, 
				'listProxy'				=>	$listProxy, 
				'sortmember'			=>	$sortmember, 
				'noteMember'			=>	$noteMember
			);

			\Session::set('sessionMember', $data['sessionMember']);

			// ソート順: sortmember
			switch($sortmember)
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
						$created_at	=	NULL;
						$asc		=	NULL;
					break;
			}

			// Get data base_of_members.id
			$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'members.note', 'members.edited_history')
								->from('base_of_members')->join('members')->on('base_of_members.id', '=', 'members.member_id')
								->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL);

			// 会員属性: attributes_member
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}

			}
			// 会員フラグ: checkbox RRI[]
			if(count($RRI) > 0)
			{
				$query = $query->where('base_of_members.profile_flag', 'IN', $RRI);
			}
			// 備考: noteMember
			if($noteMember != NULL)
			{
				$query = $query->where('members.note', 'LIKE', "%" . $noteMember . "%");
			}
			// 会員名称: nameMember (LIKE name && name_kana)
			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
			}
			// 総会の出席: checkbox listPresent[]
			if(count($listPresent) > 0)
			{
				$query = $query->where('members.attendance_of_meeting', 'IN', $listPresent);
			}
			// 総会の委任状: checkbox listProxy[]
			if(count($listProxy) > 0)
			{
				$query = $query->where('members.proxy_of_meeting', 'IN', $listProxy);
			}
			else
			{
				 $query;
			}

			// count total_items result
			$data['count_sear'] = count($query->distinct()->execute());

			// Set_flash if count total_items <= 0
			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/baseofmember/index');
			}

			// Result data base_of_members.id
			$data['manager_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();

			// JOIN 4 TBL base_of_members TBL && members TBL && persons TBL && user_key_tables TBL fllow base_of_members.id
			foreach ($data['manager_distinct'] as $item) 
			{
					$data['manager_searchlist'] = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.description', array('members.note','member_note'), array('members.edited_history', 'member_edit'), array('members.proxy_of_meeting','member_proxy'), 'user_key_tables.connect_type', array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated'))
								->from('user_key_tables')->join('members')->on('user_key_tables.member_id', '=', 'members.member_id')
								->join('base_of_members')->on('members.member_id', '=', 'base_of_members.id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('user_key_tables.member_id', $item['id'])
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL)
								->order_by($created_at, $asc)
								->execute()->as_array();

					// Create $data['searchlist'] follow base_of_member.id
					$data['searchlist'][$item['id']] 								= array();
					// Get data base_of_member.id
					$data['searchlist'][$item['id']]['id'] 							= $item['id'];
					// Get data base_of_member.name
					$data['searchlist'][$item['id']]['name'] 						= $item['name'];
					// Get data base_of_member.type
					$data['searchlist'][$item['id']]['type'] 						= $item['type'];
					// Get data members.edited_history 変更履歴コメント
					$data['searchlist'][$item['id']]['member_edit'] 				= NULL;
					// Get data members.note 備考
					$data['searchlist'][$item['id']]['member_note'] 				= NULL;
					// Get data  代表者 connect_type == 1
					$data['searchlist'][$item['id']]['person_name'] 				= NULL;
					$data['searchlist'][$item['id']]['person_department'] 			= NULL;
					// Get data 担当者 connect_type == 11
					$data['searchlist'][$item['id']]['name_contact11'] 				= NULL;
					$data['searchlist'][$item['id']]['department_contact11'] 		= NULL;
					$data['searchlist'][$item['id']]['email_contact11'] 			= NULL;
					$data['searchlist'][$item['id']]['tel_contact11'] 				= NULL;
					$data['searchlist'][$item['id']]['fax_contact11'] 				= NULL;
					$data['searchlist'][$item['id']]['zip_contact11'] 				= NULL;
					$data['searchlist'][$item['id']]['address01_contact11'] 		= NULL;
					$data['searchlist'][$item['id']]['address02_contact11'] 		= NULL;
					// Get data サブ担当 connect_type == 12
					$data['searchlist'][$item['id']]['name_contact12'] 				= NULL;
					$data['searchlist'][$item['id']]['department_contact12'] 		= NULL;
					$data['searchlist'][$item['id']]['email_contact12'] 			= NULL;
					$data['searchlist'][$item['id']]['tel_contact12'] 				= NULL;
					$data['searchlist'][$item['id']]['fax_contact12'] 				= NULL;
					$data['searchlist'][$item['id']]['zip_contact12'] 				= NULL;
					$data['searchlist'][$item['id']]['address01_contact12'] 		= NULL;
					$data['searchlist'][$item['id']]['address02_contact12'] 		= NULL;

				foreach ($data['manager_searchlist'] as $item)
				{
					// Get data edit base_of_member.id M005-01
					$data['searchlist'][$item['id']]['id'] = $item['id'];
					// Get data base_of_member.name
					$data['searchlist'][$item['id']]['name'] = $item['name'];
					// Get data base_of_member.type
					$data['searchlist'][$item['id']]['type'] = $item['type'];
					// Get data members.edited_history 変更履歴コメント
					$data['searchlist'][$item['id']]['member_edit'] = $item['member_edit'];
					// Get data members.note 備考
					$data['searchlist'][$item['id']]['member_note'] = $item['member_note'];

					if($item['connect_type'] == 1)
					{
						// Get data  代表者 connect_type == 1
						$data['searchlist'][$item['id']]['person_name'] = $item['person_name'];
						$data['searchlist'][$item['id']]['person_department'] = $item['person_department'];
					}
					else if($item['connect_type'] == 11)
					{
						// Get data 担当者 connect_type == 11
						$data['searchlist'][$item['id']]['name_contact11'] = $item['person_name'];
						$data['searchlist'][$item['id']]['department_contact11'] = $item['person_department'];
						$data['searchlist'][$item['id']]['email_contact11'] = $item['person_email'];
						$data['searchlist'][$item['id']]['tel_contact11'] = $item['person_tel'];
						$data['searchlist'][$item['id']]['fax_contact11'] = $item['person_fax'];
						$data['searchlist'][$item['id']]['zip_contact11'] = $item['person_zip'];
						$data['searchlist'][$item['id']]['address01_contact11'] = $item['person_address01'];
						$data['searchlist'][$item['id']]['address02_contact11'] = $item['person_address02'];
					}
					else if($item['connect_type'] == 12)
					{
						// Get data サブ担当 connect_type == 12
						$data['searchlist'][$item['id']]['name_contact12'] = $item['person_name'];
						$data['searchlist'][$item['id']]['department_contact12'] = $item['person_department'];
						$data['searchlist'][$item['id']]['email_contact12'] = $item['person_email'];
						$data['searchlist'][$item['id']]['tel_contact12'] = $item['person_tel'];
						$data['searchlist'][$item['id']]['fax_contact12'] = $item['person_fax'];
						$data['searchlist'][$item['id']]['zip_contact12'] = $item['person_zip'];
						$data['searchlist'][$item['id']]['address01_contact12'] = $item['person_address01'];
						$data['searchlist'][$item['id']]['address02_contact12'] = $item['person_address02'];
					}
				}
			}
			
			// Set session come back M004-02

			\Session::delete('back_searchbaseofmember');
			\Session::set('back_searchlistbaseofmember', \Uri::update_query_string());

			$count_sear = count($data['searchlist']);
			$data['count_sear'] = $count_sear;
		}

		if(\Session::get('checkurlsearchlist') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurlsearchlist');	
		}

		$this->template->title = '会員一覧';
		$this->template->header = '会員一覧';
		$this->template->content = \View_Smarty::forge('baseofmember/searchlist.tpl', $data);
	}

	// M004-04
	public function action_exportcsv() 
	{	
		// Set_flash error if result count < 0 from M004-01, M004-2
		// return M004-01
		$nameMember			=	\Session::get("sessionMember")['nameMember']; 
		$listPresent		=	\Session::get("sessionMember")['listPresent'];
		$listProxy			=	\Session::get("sessionMember")['listProxy'];
		$RRI				=	\Session::get("sessionMember")['RRI'];
		$noteMember			=	\Session::get("sessionMember")['noteMember'];
		$attributes_member	=	\Session::get("sessionMember")['attributes_member'];


		// Get data base_of_members.id
		$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'members.note')
							->from('base_of_members')->join('members')->on('base_of_members.id', '=', 'members.member_id')
							->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL);

		// 会員属性: attributes_member
		if($attributes_member != NULL)
		{
			if($attributes_member > 0)
			{
				$query = $query->where('base_of_members.type', $attributes_member);
			}

		}
		// 会員フラグ: checkbox RRI[]
		if(count($RRI) > 0)
		{
			$query = $query->where('base_of_members.profile_flag', 'IN', $RRI);
		}
		// 備考: noteMember
		if($noteMember != NULL)
		{
			$query = $query->where('members.note', 'LIKE', "%" . $noteMember . "%");
		}
		// 会員名称: nameMember (LIKE name && name_kana)
		if($nameMember != NULL)
		{
			$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
		}
		// 総会の出席: checkbox listPresent[]
		if(count($listPresent) > 0)
		{
			$query = $query->where('members.attendance_of_meeting', 'IN', $listPresent);
		}
		// 総会の委任状: checkbox listProxy[]
		if(count($listProxy) > 0)
		{
			$query = $query->where('members.proxy_of_meeting', 'IN', $listProxy);
		}
		else
		{
			 $query;
		}

		$data['count_sear'] = count($query->distinct()->execute());

		if($data['count_sear'] <= 0)
		{
			\Session::set_flash('error', '一致するレコードが見つかりません');
			\Response::redirect('manager/baseofmember/index');
		}

		// Export CSV
		if(\Input::method() == 'POST' )
		{
			// checkbox 会員属性 type.base_of_members
			$attributesMemberCSV	=	\Input::post('attributesMemberCSV');
			// checkbox 会員フラグ profile_flag.base_of_members
			$flatMemberCSV			=	\Input::post('flatMemberCSV');
			// checkbox 会員名称 name.base_of_members
			$nameMemberCSV			=	\Input::post('nameMemberCSV');
			// checkbox 会員名称(ふりがな) name_kana.base_of_members
			$nameKanaMemberCSV		=	\Input::post('nameKanaMemberCSV');
			// checkbox 会員名称(英語) name_eng.base_of_members
			$namEngMemberCSV		=	\Input::post('namEngMemberCSV');
			// checkbox 代表者情報 Get data name.personss,department.persons 代表者 connect_type == 1
			$repreInfoCSV			=	\Input::post('repreInfoCSV');
			// checkbox ソート順 sort.base_of_members
			$sortCSV				=	\Input::post('sortCSV');
			// checkbox contactMemberCSV
			$contactMemberCSV		=	\Input::post('contactMemberCSV');
			// checkbox 変更履歴コメント Get data members.edited_history
			$historyCommentCSV		=	\Input::post('historyCommentCSV');
			// checkbox 備考 Get data members.note
			$remarksCSV				=	\Input::post('remarksCSV');

			// checkbox ソート順 sort.base_of_members
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

			// Get data base_of_members.id
			$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'base_of_members.description',array('members.edited_history', 'member_edit'), array('members.note','member_note'))
							->from('base_of_members')->join('members')->on('base_of_members.id', '=', 'members.member_id')
							->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL);

			// 会員属性: attributes_member
			if($attributes_member != NULL)
			{
				if($attributes_member > 0)
				{
					$query = $query->where('base_of_members.type', $attributes_member);
				}
			}
			// 会員フラグ: checkbox RRI[]
			if(count($RRI) > 0)
			{
				$query = $query->where('base_of_members.profile_flag', 'IN', $RRI);
			}
			// 備考: noteMember
			if($noteMember != NULL)
			{
				$query = $query->where('members.note', 'LIKE', "%" . $noteMember . "%");
			}
			// 会員名称: nameMember (LIKE name && name_kana)
			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
			}
			// 総会の出席: checkbox listPresent[]
			if(count($listPresent) > 0)
			{
				$query = $query->where('members.attendance_of_meeting', 'IN', $listPresent);
			}
			// 総会の委任状: checkbox listProxy[]
			if(count($listProxy) > 0)
			{
				$query = $query->where('members.proxy_of_meeting', 'IN', $listProxy);
			}
			else
			{
				 $query;
			}

			$data['manager_exportCSV_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();

			// JOIN 4 TBL base_of_members TBL && members TBL && persons TBL && user_key_tables TBL fllow base_of_members.id
			foreach ($data['manager_exportCSV_distinct'] as $item) 
			{

				$data['manager_exportCSV'] = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'base_of_members.description', array('members.note','member_note'), array('members.edited_history', 'member_edit'), array('members.proxy_of_meeting','member_proxy'), 'user_key_tables.connect_type', array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated') )
						->from('user_key_tables')->join('members')->on('user_key_tables.member_id', '=', 'members.member_id')
						->join('base_of_members')->on('members.member_id', '=', 'base_of_members.id')
						->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
						->where('user_key_tables.member_id', $item['id'])
						->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
						->where('base_of_members.deleted_at', 'IS', NULL)->where('members.deleted_at', 'IS', NULL)
						->order_by($created_at, $asc)
						->execute()->as_array();

					$data['searchlist'][$item['id']] = array();
					if($attributesMemberCSV == 'attributesMemberCSV')
					{
						$data['searchlist'][$item['id']]['type'] = $item['type'];
						switch($data['searchlist'][$item['id']]['type'])
						{
							case'0':
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('なし', "SJIS");
								break;
							case'1':
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('企業', "SJIS");
								break;
							case'2':
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('団体', "SJIS");
								break;
							case'3':
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('研究機関', "SJIS");
								break;
							case'4':
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('個人', "SJIS");
								break;
							default:
								$data['searchlist'][$item['id']]['type'] = mb_convert_encoding('地方自治体', "SJIS");
								break;
						}
					}
					else
					{
						$data['searchlist'][$item['id']]['type'] = NULL;
					}
					if($flatMemberCSV == 'flatMemberCSV')
					{
						$data['searchlist'][$item['id']]['profile_flag'] = $item['profile_flag'];
						switch($data['searchlist'][$item['id']]['profile_flag'])
						{
							case'0':
								$data['searchlist'][$item['id']]['profile_flag'] = mb_convert_encoding('RRI会員ではない', "SJIS");
								break;
							default:
								$data['searchlist'][$item['id']]['profile_flag'] = mb_convert_encoding('RRI会員', "SJIS");
								break;
						}
					}
					else
					{
						$data['searchlist'][$item['id']]['profile_flag'] = NULL;
					}
					if($nameMemberCSV == 'nameMemberCSV')
					{
						$data['searchlist'][$item['id']]['name'] = $item['name'];
						$data['searchlist'][$item['id']]['name'] = mb_convert_encoding($data['searchlist'][$item['id']]['name'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['id']]['name'] = NULL;
					}
					if($nameKanaMemberCSV == 'nameKanaMemberCSV')
					{
						$data['searchlist'][$item['id']]['name_kana']	= $item['name_kana'];
						$data['searchlist'][$item['id']]['name_kana'] = mb_convert_encoding($data['searchlist'][$item['id']]['name_kana'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['id']]['name_kana'] = NULL;
					}
					if($namEngMemberCSV == 'namEngMemberCSV')
					{
						$data['searchlist'][$item['id']]['name_eng'] = $item['name_eng'];
						$data['searchlist'][$item['id']]['name_eng'] = mb_convert_encoding($data['searchlist'][$item['id']]['name_eng'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['id']]['name_eng'] = NULL;
					}

					$data['searchlist'][$item['id']]['person_name'] = NULL;
					$data['searchlist'][$item['id']]['person_department'] = NULL;
					$data['searchlist'][$item['id']]['member_edit'] = NULL;
					$data['searchlist'][$item['id']]['member_note'] = NULL;
					$data['searchlist'][$item['id']]['name_contact11'] = NULL;
					$data['searchlist'][$item['id']]['department_contact11'] = NULL;
					$data['searchlist'][$item['id']]['email_contact11'] = NULL;
					$data['searchlist'][$item['id']]['tel_contact11'] = NULL;
					$data['searchlist'][$item['id']]['fax_contact11'] = NULL;
					$data['searchlist'][$item['id']]['zip_contact11'] = NULL;
					$data['searchlist'][$item['id']]['address01_contact11'] = NULL;
					$data['searchlist'][$item['id']]['address02_contact11'] = NULL;
					$data['searchlist'][$item['id']]['name_contact12'] 	= NULL;
					$data['searchlist'][$item['id']]['department_contact12'] = NULL;
					$data['searchlist'][$item['id']]['email_contact12'] = NULL;
					$data['searchlist'][$item['id']]['tel_contact12'] = NULL;
					$data['searchlist'][$item['id']]['fax_contact12'] = NULL;
					$data['searchlist'][$item['id']]['zip_contact12'] = NULL;
					$data['searchlist'][$item['id']]['address01_contact12'] = NULL;
					$data['searchlist'][$item['id']]['address02_contact12'] = NULL;

				foreach ($data['manager_exportCSV'] as $item)
				{
					if($item['connect_type'] == 1)
					{
						if($repreInfoCSV == 'repreInfoCSV')
						{
							$data['searchlist'][$item['id']]['person_name'] = $item['person_name'];
							$data['searchlist'][$item['id']]['person_department'] = $item['person_department'];
							$data['searchlist'][$item['id']]['person_name'] = mb_convert_encoding($data['searchlist'][$item['id']]['person_name'], "SJIS");
							$data['searchlist'][$item['id']]['person_department'] = mb_convert_encoding($data['searchlist'][$item['id']]['person_department'], "SJIS");
						}
						if($historyCommentCSV == 'historyCommentCSV')
						{
							$data['searchlist'][$item['id']]['member_edit'] = $item['member_edit'];
							$data['searchlist'][$item['id']]['member_edit'] = mb_convert_encoding($data['searchlist'][$item['id']]['member_edit'], "SJIS");
						}
						if($remarksCSV == 'remarksCSV')
						{
							$data['searchlist'][$item['id']]['member_note'] = $item['member_note'];
							$data['searchlist'][$item['id']]['member_note'] = mb_convert_encoding($data['searchlist'][$item['id']]['member_note'], "SJIS");
						}

					}
					else if($item['connect_type'] == 11)
					{
						if($contactMemberCSV == 0 || $contactMemberCSV == 2)
						{
							$data['searchlist'][$item['id']]['name_contact11'] = $item['person_name'];
							$data['searchlist'][$item['id']]['name_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['name_contact11'], "SJIS");
							$data['searchlist'][$item['id']]['department_contact11'] = $item['person_department'];
							$data['searchlist'][$item['id']]['department_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['department_contact11'], "SJIS");
							$data['searchlist'][$item['id']]['email_contact11'] = $item['person_email'];
							$data['searchlist'][$item['id']]['email_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['email_contact11'], "SJIS");
							$data['searchlist'][$item['id']]['tel_contact11'] = $item['person_tel'];
							$data['searchlist'][$item['id']]['tel_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['tel_contact11'] , "SJIS");
							$data['searchlist'][$item['id']]['fax_contact11'] = $item['person_fax'];
							$data['searchlist'][$item['id']]['fax_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['fax_contact11'] , "SJIS");
							$data['searchlist'][$item['id']]['zip_contact11'] = $item['person_zip'];
							$data['searchlist'][$item['id']]['zip_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['zip_contact11'] , "SJIS");
							$data['searchlist'][$item['id']]['address01_contact11'] = $item['person_address01'];
							$data['searchlist'][$item['id']]['address01_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['address01_contact11'] , "SJIS");
							$data['searchlist'][$item['id']]['address02_contact11'] = $item['person_address02'];
							$data['searchlist'][$item['id']]['address02_contact11'] = mb_convert_encoding($data['searchlist'][$item['id']]['address02_contact11'] , "SJIS");
						}
					}
					else if($item['connect_type'] == 12)
					{
						if($contactMemberCSV == 0)
						{
							$data['searchlist'][$item['id']]['name_contact12'] = $item['person_name'];
							$data['searchlist'][$item['id']]['department_contact12'] = $item['person_department'];
							$data['searchlist'][$item['id']]['email_contact12'] = $item['person_email'];
							$data['searchlist'][$item['id']]['tel_contact12'] = $item['person_tel'];
							$data['searchlist'][$item['id']]['fax_contact12'] = $item['person_fax'];
							$data['searchlist'][$item['id']]['zip_contact12'] = $item['person_zip'];
							$data['searchlist'][$item['id']]['address01_contact12'] = $item['person_address01'];
							$data['searchlist'][$item['id']]['address02_contact12'] = $item['person_address02'];
							$data['searchlist'][$item['id']]['name_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['name_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['department_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['department_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['email_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['email_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['tel_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['tel_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['fax_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['fax_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['zip_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['zip_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['address01_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['address01_contact12'] , "SJIS");
							$data['searchlist'][$item['id']]['address02_contact12'] = mb_convert_encoding($data['searchlist'][$item['id']]['address02_contact12'] , "SJIS");
						}
					}
				}	
			}
			$arrayBigExportCsv = [];
			$arrayExportCsv = [];

			if($attributesMemberCSV == 'attributesMemberCSV')
			{
				array_push($arrayExportCsv,'type');
			}
			if($flatMemberCSV == 'flatMemberCSV')
			{
				array_push($arrayExportCsv,'profile_flag');
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
			if($repreInfoCSV == 'repreInfoCSV')
			{
				array_push($arrayExportCsv,'person_name','person_department');
			}
			if($historyCommentCSV == 'historyCommentCSV')
			{
				array_push($arrayExportCsv,'member_edit');
			}
			if($remarksCSV == 'remarksCSV')
			{
				array_push($arrayExportCsv,'member_note');
			}
			if($contactMemberCSV == 0)
			{
				array_push($arrayExportCsv,'name_contact11','department_contact11', 'email_contact11', 'tel_contact11', 'fax_contact11', 'zip_contact11', 'address01_contact11', 'address02_contact11', 'name_contact12','department_contact12', 'email_contact12', 'tel_contact12', 'fax_contact12', 'zip_contact12', 'address01_contact12', 'address02_contact12');
			}
			else if($contactMemberCSV == 2)
			{
				array_push($arrayExportCsv,'name_contact11','department_contact11', 'email_contact11', 'tel_contact11', 'fax_contact11', 'zip_contact11', 'address01_contact11', 'address02_contact11');
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

		$this->template->title = '会員のCSV出力';
		$this->template->header = '会員のCSV出力';
		$this->template->content = \View_Smarty::forge('baseofmember/exportcsv.tpl');
	}
}