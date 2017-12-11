<?php

namespace Manager;

class Controller_Officers extends Controller_Base {
	
	public function action_index()
	{
		$this->template->header = '役員検索';
		$this->template->title = '役員検索';
		$this->template->content =	\View_Smarty::forge('officers/index.tpl');
	}

	public function action_searchofficers()
	{	
		if(\Input::method()	==	'GET')
		{
			// Get data 役職: officer_in_group
			$officer_in_group		=	\Input::get('officer_in_group');
			// Get data 会員名称: nameMember
			$nameMember				=	\Input::get('nameMember');
			// Get data 役員氏名: nameOfficers
			$nameOfficers			=	\Input::get('nameOfficers');
			// Get data 担当者氏名: nameCurator
			$nameCurator			=	\Input::get('nameCurator');
			// Get data 備考: noteOfficers
			$noteOfficers			=	\Input::get('noteOfficers');
			// Get data ソート順: sortOfficers
			$sortOfficers			=	\Input::get('sortOfficers');

			// Set Session export CSV M008-04
			$data['sessionOfficer']	=	array(
				'officer_in_group'		=>	$officer_in_group,  
				'nameMember'			=>	$nameMember, 
				'nameOfficers'			=>	$nameOfficers,
				'nameCurator'			=>	$nameCurator, 
				'noteOfficers'			=>	$noteOfficers,
				'sortOfficers'			=>	$sortOfficers,  
			);


			\Session::set('sessionOfficer', $data['sessionOfficer']);

			// ソート順: sortOfficers
			switch($sortOfficers)
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

			// case 役員氏名: nameOfficers != NULL && 担当者氏名: nameCurator != NULL
			if(($nameOfficers != NULL) && ($nameCurator != NULL))
			{
				// get data 役員氏名: nameOfficers user_key_tables.connect_type = 2
				$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', array('officers.id', 'officers_id'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('user_key_tables.connect_type', 2)
									->and_where('persons.name', 'LIKE', "%" . $nameOfficers. "%")
									->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers. "%")
								->where_close();

				// 役職: checkbox officer_in_group
				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				// 会員名称: nameMember 
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				// 備考: noteOfficers
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}

				$data['count_sear'] = $query->order_by($created_at, $asc)->distinct()->execute();

				foreach($data['count_sear'] as $item)
				{
					// get data 担当者氏名: nameCurator user_key_tables.connect_type = 21 fllow user_key_tables.connect_type = 2
					$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', array('officers.id', 'officers_id'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('base_of_members.id', $item['id'])
									->and_where('user_key_tables.connect_type', 21)
									->and_where_open()
										->where('persons.name', 'LIKE', "%" . $nameCurator. "%")
										->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator. "%")
									->and_where_close()
								->where_close();
				}
			}
			// else
			else
			{
				$query = \DB::select('base_of_members.name', 'base_of_members.id',  'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', array('officers.id', 'officers_id'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL);
				// 役職: checkbox officer_in_group
				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				// 会員名称: nameMember 
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				// 役員氏名: nameOfficers user_key_tables.connect_type = 2 
				if($nameOfficers != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 2)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameOfficers . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers . "%")->and_where_close();
				}
				// 担当者氏名: nameCurator user_key_tables.connect_type = 21
				if($nameCurator != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 21)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameCurator . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator . "%")->and_where_close();
				}
				// 備考: noteOfficers
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}
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
			
			$pagination = \Pagination::forge('mypagination', $config);

			// Set session come back M008-02
			\Session::delete('backToOfficerSearchList');
			\Session::set('backToOfficerSearch', \Uri::update_query_string());

			// create data views M008-02
			$data['officers_searchlist'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();

		}

		if(\Session::get('checkurlsearch') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurlsearch');
		}

		$this->template->title = '役員検索';
		$this->template->header = '役員検索';
		$this->template->content = \View_Smarty::forge('officers/searchofficers.tpl', $data);
	}
	public function action_searchlistofficers() 
	{
		if(\Input::method() == 'GET' )
		{

			// Get data 役職: officer_in_group
			$officer_in_group		=	\Input::get('officer_in_group');
			// Get data 会員名称: nameMember
			$nameMember				=	\Input::get('nameMember');
			// Get data 役員氏名: nameOfficers
			$nameOfficers			=	\Input::get('nameOfficers');
			// Get data 担当者氏名: nameCurator
			$nameCurator			=	\Input::get('nameCurator');
			// Get data 備考: noteOfficers
			$noteOfficers			=	\Input::get('noteOfficers');
			// Get data ソート順: sortOfficers
			$sortOfficers			=	\Input::get('sortOfficers');

			// Set Session export CSV M008-04
			$data['sessionOfficer']	=	array(
				'officer_in_group'		=>	$officer_in_group,  
				'nameMember'			=>	$nameMember, 
				'nameOfficers'			=>	$nameOfficers, 
				'nameCurator'			=>	$nameCurator, 
				'noteOfficers'			=>	$noteOfficers, 
				'sortOfficers'			=>	$sortOfficers,  
			);


			\Session::set('sessionOfficer', $data['sessionOfficer']);

			// ソート順: sortOfficers
			switch($sortOfficers)
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

			// case 役員氏名: nameOfficers != NULL && 担当者氏名: nameCurator != NULL
			if(($nameOfficers != NULL) && ($nameCurator != NULL))
			{
				// get data 役員氏名: nameOfficers user_key_tables.connect_type = 2
				$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('user_key_tables.connect_type', 2)
									->and_where('persons.name', 'LIKE', "%" . $nameOfficers. "%")
									->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers. "%")
								->where_close();

				// 役職: checkbox officer_in_group
				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				// 会員名称: nameMember 
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				// 備考: noteOfficers
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}

				$data['count_sear'] = $query->order_by($created_at, $asc)->distinct()->execute();

				foreach($data['count_sear'] as $item)
				{
					// get data 担当者氏名: nameCurator user_key_tables.connect_type = 21 fllow user_key_tables.connect_type = 2
					$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('base_of_members.id', $item['id'])
									->and_where('user_key_tables.connect_type', 21)
									->and_where_open()
										->where('persons.name', 'LIKE', "%" . $nameCurator. "%")
										->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator. "%")
									->and_where_close()
								->where_close();
				}
			}
			// else
			else
			{

				$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL);

				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				// 役員氏名: nameOfficers user_key_tables.connect_type = 2 
				if($nameOfficers != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 2)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameOfficers . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers . "%")->and_where_close();
				}
				// 担当者氏名: nameCurator user_key_tables.connect_type = 21
				if($nameCurator != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 21)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameCurator . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator . "%")->and_where_close();
				}
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}
			}

			// count total_items result
			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			// Set_flash if count total_items <= 0 $$ redirect officers/index
			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/officers/index');
			}

			$data['officers_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();


			foreach ($data['officers_distinct'] as $item) 
			{
				// JOIN 4 TBL user_key_tables TBL && officers TBL && base_of_members TBL  && persons TBL fllow user_key_tables.officer_id
				$data['officers_searchlist'] = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id', array('officers.note','note_officers') ,  array('officers.edited_history','edit_officers'), 'user_key_tables.connect_type', array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated'))
						->from('user_key_tables')->join('officers')->on('user_key_tables.member_id', '=', 'officers.member_id')->on('user_key_tables.officer_id', '=', 'officers.id')
						->join('base_of_members')->on('officers.member_id', '=', 'base_of_members.id')
						->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
						->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
						->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
						->where('user_key_tables.officer_id', $item['officer_id'])
						->execute()->as_array();

					// Create $data['searchlist'] follow user_key_tables.officer_id
					$data['searchlist'][$item['officer_id']] = array();
					// Get data base_of_member.id
					$data['searchlist'][$item['officer_id']]['id'] 	= NULL;
					// Get data base_of_member.name
					$data['searchlist'][$item['officer_id']]['name'] = NULL;
					// Get data base_of_member.type
					$data['searchlist'][$item['officer_id']]['type'] = NULL;
					// Get data officers.edited_history 変更履歴コメント
					$data['searchlist'][$item['officer_id']]['edit_officers'] = NULL;
					// Get data officers.note 備考
					$data['searchlist'][$item['officer_id']]['note_officers'] = NULL;
					// Get data  役員氏名 connect_type == 2
					$data['searchlist'][$item['officer_id']]['person_name'] = NULL;
					$data['searchlist'][$item['officer_id']]['person_department'] = NULL;
					// Get data  担当者 connect_type == 21
					$data['searchlist'][$item['officer_id']]['name_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['department_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['email_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['tel_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['fax_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['zip_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['address01_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['address02_contact21'] = NULL;
					// Get data  サブ担当 connect_type == 22
					$data['searchlist'][$item['officer_id']]['name_contact22'] 	= NULL;
					$data['searchlist'][$item['officer_id']]['department_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['email_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['tel_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['fax_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['zip_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['address01_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['address02_contact22'] = NULL;

				foreach ($data['officers_searchlist'] as $item)
				{
					// Get data edit officers.id M009-01
					$data['searchlist'][$item['officer_id']]['officer_id'] = $item['officer_id'];
					// Get data baseofmembers.id
					$data['searchlist'][$item['officer_id']]['id'] = $item['id'];
					// Get data baseofmembers.name
					$data['searchlist'][$item['officer_id']]['name'] = $item['name'];
					// Get data baseofmembers.type
					$data['searchlist'][$item['officer_id']]['type'] = $item['type'];
					// Get data officers.edited_history 変更履歴コメント
					$data['searchlist'][$item['officer_id']]['edit_officers'] = $item['edit_officers'];
					// Get data officers.note 備考
					$data['searchlist'][$item['officer_id']]['note_officers'] = $item['note_officers'];

					if($item['connect_type'] == 2)
					{
						// Get data  役員氏名 connect_type == 2
						$data['searchlist'][$item['officer_id']]['person_name'] = $item['person_name'];
						$data['searchlist'][$item['officer_id']]['person_department'] = $item['person_department'];
					}
					else if($item['connect_type'] == 21)
					{
						// Get data  担当者 connect_type == 21
						$data['searchlist'][$item['officer_id']]['name_contact21'] = $item['person_name'];
						$data['searchlist'][$item['officer_id']]['department_contact21'] = $item['person_department'];
						$data['searchlist'][$item['officer_id']]['email_contact21'] = $item['person_email'];
						$data['searchlist'][$item['officer_id']]['tel_contact21'] = $item['person_tel'];
						$data['searchlist'][$item['officer_id']]['fax_contact21'] = $item['person_fax'];
						$data['searchlist'][$item['officer_id']]['zip_contact21'] = $item['person_zip'];
						$data['searchlist'][$item['officer_id']]['address01_contact21'] = $item['person_address01'];
						$data['searchlist'][$item['officer_id']]['address02_contact21'] = $item['person_address02'];
					}
					else if($item['connect_type'] == 22)
					{
						// Get data  サブ担当 connect_type == 22
						$data['searchlist'][$item['officer_id']]['name_contact22'] = $item['person_name'];
						$data['searchlist'][$item['officer_id']]['department_contact22'] = $item['person_department'];
						$data['searchlist'][$item['officer_id']]['email_contact22'] = $item['person_email'];
						$data['searchlist'][$item['officer_id']]['tel_contact22'] = $item['person_tel'];
						$data['searchlist'][$item['officer_id']]['fax_contact22'] = $item['person_fax'];
						$data['searchlist'][$item['officer_id']]['zip_contact22'] = $item['person_zip'];
						$data['searchlist'][$item['officer_id']]['address01_contact22'] = $item['person_address01'];
						$data['searchlist'][$item['officer_id']]['address02_contact22'] = $item['person_address02'];
					}
				}	

			}

			\Session::delete('backToOfficerSearch');
			\Session::set('backToOfficerSearchList', \Uri::update_query_string());

			$count_sear = count($data['officers_distinct']);
			$data['count_sear'] = $count_sear;
		}

		if(\Session::get('checkurlsearchlist') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkurlsearchlist');
		}

		$this->template->title = '役員一覧';
		$this->template->header = '役員一覧';
		$this->template->content = \View_Smarty::forge('officers/searchlistofficers.tpl', $data);
	}
	public function action_exportcsvofficers() 
	{
		// Set_flash error if result count < 0 from M008-01, M008-02
		// return M008-01
		$officer_in_group		=	\Session::get("sessionOfficer")['officer_in_group'];
		$nameMember				=	\Session::get("sessionOfficer")['nameMember'];
		$nameOfficers			=	\Session::get("sessionOfficer")['nameOfficers'];
		$nameCurator			=	\Session::get("sessionOfficer")['nameCurator'];
		$noteOfficers			=	\Session::get("sessionOfficer")['noteOfficers'];

		// case 役員氏名: nameOfficers != NULL && 担当者氏名: nameCurator != NULL
		if(($nameOfficers != NULL) && ($nameCurator != NULL))
		{
			// get data 役員氏名: nameOfficers user_key_tables.connect_type = 2
			$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
							->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
							->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
							->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
							->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
							->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
							->where_open()
								->where('user_key_tables.connect_type', 2)
								->and_where('persons.name', 'LIKE', "%" . $nameOfficers. "%")
								->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers. "%")
							->where_close();

			// 役職: checkbox officer_in_group
			if(count($officer_in_group) > 0)
			{
				$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
			}
			// 会員名称: nameMember 
			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
			}
			// 備考: noteOfficers
			if($noteOfficers != NULL)
			{
				$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
			}
			else
			{
				 $query;
			}

			$data['count_sear'] = $query->order_by($created_at, $asc)->distinct()->execute();

			foreach($data['count_sear'] as $item)
			{
				// get data 担当者氏名: nameCurator user_key_tables.connect_type = 21 fllow user_key_tables.connect_type = 2
				$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
							->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
							->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
							->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
							->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
							->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
							->where_open()
								->where('base_of_members.id', $item['id'])
								->and_where('user_key_tables.connect_type', 21)
								->and_where_open()
									->where('persons.name', 'LIKE', "%" . $nameCurator. "%")
									->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator. "%")
								->and_where_close()
							->where_close();
			}
		}
		// else
		else
		{
			$query = \DB::select('base_of_members.name', 'base_of_members.id', 'base_of_members.name_kana', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'officers.officer_in_group', 'user_key_tables.officer_id')
							->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
							->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
							->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
							->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
							->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL);

			if(count($officer_in_group) > 0)
			{
				$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
			}
			if($nameMember != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
			}
			// 役員氏名: nameOfficers user_key_tables.connect_type = 2
			if($nameOfficers != NULL)
			{
				$query = $query->where('user_key_tables.connect_type', 2)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameOfficers . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers . "%")->and_where_close();
			}
			// 担当者氏名: nameCurator user_key_tables.connect_type = 21
			if($nameCurator != NULL)
			{
				$query = $query->where('user_key_tables.connect_type', 21)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameCurator . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator . "%")->and_where_close();
			}
			if($noteOfficers != NULL)
			{
				$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
			}
			else
			{
				 $query;
			}
		}

		// count total_items result
		$data['count_sear'] = count($query->distinct()->execute());

		// Set_flash if count total_items <= 0
		if($data['count_sear'] <= 0)
		{
			\Session::set_flash('error', '一致するレコードが見つかりません');
			\Response::redirect('manager/officers/index');
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
			// checkbox 代表者情報 Get data name.personss,department.persons 役員氏名 connect_type == 2
			$repreInfoCSV			=	\Input::post('repreInfoCSV');
			// checkbox ソート順 sort.base_of_members
			$sortCSV				=	\Input::post('sortCSV');
			// checkbox contacOfficersCSV
			$contactMemberCSV		=	\Input::post('contactMemberCSV');
			// checkbox 変更履歴コメント officers.edited_history
			$historyCommentCSV		=	\Input::post('historyCommentCSV');
			// checkbox 備考 Get data officers.note
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

			// case 役員氏名: nameOfficers != NULL && 担当者氏名: nameCurator != NULL
			if(($nameOfficers != NULL) && ($nameCurator != NULL))
			{
				// get data 役員氏名: nameOfficers user_key_tables.connect_type = 2
				$query =  \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'officers.officer_in_group', 'user_key_tables.officer_id', array('officers.note','note_officers') ,  array('officers.edited_history','edit_officers'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('user_key_tables.connect_type', 2)
									->and_where('persons.name', 'LIKE', "%" . $nameOfficers. "%")
									->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers. "%")
								->where_close();

				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}

				foreach($data['count_sear'] as $item)
				{
					// get data 担当者氏名: nameCurator user_key_tables.connect_type = 21 fllow user_key_tables.connect_type = 2
					$query =  \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'officers.officer_in_group', 'user_key_tables.officer_id', array('officers.note','note_officers') ,  array('officers.edited_history','edit_officers'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
								->where_open()
									->where('base_of_members.id', $item['id'])
									->and_where('user_key_tables.connect_type', 21)
									->and_where_open()
										->where('persons.name', 'LIKE', "%" . $nameCurator. "%")
										->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator. "%")
									->and_where_close()
								->where_close();
				}
			}
			// else
			else
			{
				$query = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'officers.officer_in_group', 'user_key_tables.officer_id', array('officers.note','note_officers') ,  array('officers.edited_history','edit_officers'))
								->from('base_of_members')->join('officers')->on('base_of_members.id', '=', 'officers.member_id')
								->join('user_key_tables')->on('officers.member_id', '=', 'user_key_tables.member_id')->on('officers.id', '=', 'user_key_tables.officer_id')
								->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
								->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
								->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL);

				if(count($officer_in_group) > 0)
				{
					$query = $query->where('officers.officer_in_group', 'IN' , $officer_in_group);
				}
				if($nameMember != NULL)
				{
					$query = $query->and_where_open()->where('base_of_members.name', 'like', "%" . $nameMember. "%")->or_where('base_of_members.name_kana', 'like', "%" . $nameMember. "%")->and_where_close();
				}
				// 役員氏名: nameOfficers user_key_tables.connect_type = 2
				if($nameOfficers != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 2)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameOfficers . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameOfficers . "%")->and_where_close();
				}
				// 担当者氏名: nameCurator user_key_tables.connect_type = 21
				if($nameCurator != NULL)
				{
					$query = $query->where('user_key_tables.connect_type', 21)->and_where_open()->where('persons.name', 'LIKE', "%" . $nameCurator . "%")->or_where('persons.name_kana', 'LIKE', "%" . $nameCurator . "%")->and_where_close();
				}
				if($noteOfficers != NULL)
				{
					$query = $query->where('officers.note', 'LIKE', "%" . $noteOfficers . "%");
				}
				else
				{
					 $query;
				}
			}

			$data['officers_distinct'] = $query->order_by($created_at, $asc)->distinct()->execute();

			foreach ($data['officers_distinct'] as $item) 
			{
				// JOIN 4 TBL user_key_tables TBL && officers TBL && base_of_members TBL  && persons TBL fllow user_key_tables.officer_id
				$data['officers_searchlist'] = \DB::select('base_of_members.name','base_of_members.type', 'base_of_members.created_at', 'base_of_members.profile_flag', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'officers.officer_in_group', array('officers.note','note_officers') ,  array('officers.edited_history','edit_officers'), 'user_key_tables.connect_type', 'user_key_tables.officer_id',  array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated'))
						->from('user_key_tables')->join('officers')->on('user_key_tables.member_id', '=', 'officers.member_id')->on('user_key_tables.officer_id', '=', 'officers.id')
						->join('base_of_members')->on('officers.member_id', '=', 'base_of_members.id')
						->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
						->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
						->where('base_of_members.deleted_at', 'IS', NULL)->where('officers.deleted_at', 'IS', NULL)
						->where('user_key_tables.officer_id', $item['officer_id'])
						->execute()->as_array();

					// mb_convert_encoding($data, SJIS) convert SJIS
					// Create $data['searchlist'] follow user_key_tables.officer_id
					$data['searchlist'][$item['officer_id']] = array();
					// Get data base_of_member.id
					if($attributesMemberCSV == 'attributesMemberCSV')
					{
						$data['searchlist'][$item['officer_id']]['type'] = $item['type'];
						switch($data['searchlist'][$item['officer_id']]['type'])
						{
							case'0':
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('なし', "SJIS");
								break;
							case'1':
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('企業', "SJIS");
								break;
							case'2':
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('団体', "SJIS");
								break;
							case'3':
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('研究機関', "SJIS");
								break;
							case'4':
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('個人', "SJIS");
								break;
							default:
								$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding('地方自治体', "SJIS");
								break;
						}
					}
					else
					{
						$data['searchlist'][$item['officer_id']]['type'] = NULL;
					}
					if($flatMemberCSV == 'flatMemberCSV')
					{
						$data['searchlist'][$item['officer_id']]['profile_flag'] = $item['profile_flag'];
						switch($data['searchlist'][$item['officer_id']]['profile_flag'])
						{
							case'0':
								$data['searchlist'][$item['officer_id']]['profile_flag'] = mb_convert_encoding('RRI会員ではない', "SJIS");
								break;
							default:
								$data['searchlist'][$item['officer_id']]['profile_flag'] = mb_convert_encoding('RRI会員', "SJIS");
								break;
						}
					}
					else
					{
						$data['searchlist'][$item['officer_id']]['profile_flag'] = NULL;
					}
					if($nameMemberCSV == 'nameMemberCSV')
					{
						$data['searchlist'][$item['officer_id']]['name'] = $item['name'];
						$data['searchlist'][$item['officer_id']]['name'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['officer_id']]['name'] = NULL;
					}
					if($nameKanaMemberCSV == 'nameKanaMemberCSV')
					{
						$data['searchlist'][$item['officer_id']]['name_kana']	= $item['name_kana'];
						$data['searchlist'][$item['officer_id']]['name_kana'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name_kana'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['officer_id']]['name_kana'] = NULL;
					}
					if($namEngMemberCSV == 'namEngMemberCSV')
					{
						$data['searchlist'][$item['officer_id']]['name_eng'] = $item['name_eng'];
						$data['searchlist'][$item['officer_id']]['name_eng'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name_eng'], "SJIS");
					}
					else
					{
						$data['searchlist'][$item['officer_id']]['name_eng'] = NULL;
					}

					// Get data officers.edited_history 変更履歴コメント
					$data['searchlist'][$item['officer_id']]['edit_officers'] = NULL;
					// Get data officers.note 備考
					$data['searchlist'][$item['officer_id']]['note_officers'] = NULL;
					// Get data  役員氏名 connect_type == 2
					$data['searchlist'][$item['officer_id']]['person_name'] = NULL;
					$data['searchlist'][$item['officer_id']]['person_department'] = NULL;
					// Get data  担当者 connect_type == 21
					$data['searchlist'][$item['officer_id']]['name_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['department_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['email_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['tel_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['fax_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['zip_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['address01_contact21'] = NULL;
					$data['searchlist'][$item['officer_id']]['address02_contact21'] = NULL;
					// Get data  サブ担当 connect_type == 22
					$data['searchlist'][$item['officer_id']]['name_contact22'] 	= NULL;
					$data['searchlist'][$item['officer_id']]['department_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['email_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['tel_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['fax_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['zip_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['address01_contact22'] = NULL;
					$data['searchlist'][$item['officer_id']]['address02_contact22'] = NULL;

				foreach ($data['officers_searchlist'] as $item)
				{

					// 役員情報 Get data name.personss,department.persons 役員氏名 connect_type == 2
					if($item['connect_type'] == 2)
					{
						if($repreInfoCSV == 'repreInfoCSV')
						{
							$data['searchlist'][$item['officer_id']]['person_name'] = $item['person_name'];
							$data['searchlist'][$item['officer_id']]['person_department'] = $item['person_department'];
							$data['searchlist'][$item['officer_id']]['person_name'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['person_name'] = $item['name'], "SJIS");
							$data['searchlist'][$item['officer_id']]['person_department'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['person_department'], "SJIS");
						}
						// checkbox 変更履歴コメント Get data members.edited_history
						if($historyCommentCSV == 'historyCommentCSV')
						{
							$data['searchlist'][$item['officer_id']]['edit_officers'] = $item['edit_officers'];
							$data['searchlist'][$item['officer_id']]['edit_officers'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['edit_officers'] , "SJIS");
						}
						// checkbox 備考 Get data members.note
						if($remarksCSV == 'remarksCSV')
						{
							$data['searchlist'][$item['officer_id']]['note_officers'] = $item['note_officers'];
							$data['searchlist'][$item['officer_id']]['note_officers'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['note_officers'] , "SJIS");
						}
					}
					// 主担当者・サブ担当者をすべて出力 Get data 役員氏名 connect_type == 21 && 担当者氏名 connect_type == 22
					else if($item['connect_type'] == 21)
					{
						if($contactMemberCSV == 0 || $contactMemberCSV == 2)
						{
							$data['searchlist'][$item['officer_id']]['name_contact21'] = $item['person_name'];
							$data['searchlist'][$item['officer_id']]['department_contact21'] = $item['person_department'];
							$data['searchlist'][$item['officer_id']]['email_contact21'] = $item['person_email'];
							$data['searchlist'][$item['officer_id']]['tel_contact21'] = $item['person_tel'];
							$data['searchlist'][$item['officer_id']]['fax_contact21'] = $item['person_fax'];
							$data['searchlist'][$item['officer_id']]['zip_contact21'] = $item['person_zip'];
							$data['searchlist'][$item['officer_id']]['address01_contact21'] = $item['person_address01'];
							$data['searchlist'][$item['officer_id']]['address02_contact21'] = $item['person_address02'];
							$data['searchlist'][$item['officer_id']]['name_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name_contact21'], "SJIS");
							$data['searchlist'][$item['officer_id']]['department_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['department_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['email_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['email_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['tel_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['tel_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['fax_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['fax_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['zip_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['zip_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['address01_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['address01_contact21'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['address02_contact21'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['address02_contact21'] , "SJIS");

						}
					}
					else if($item['connect_type'] == 22)
					{
						if($contactMemberCSV == 0)
						{
							$data['searchlist'][$item['officer_id']]['name_contact22'] = $item['person_name'];
							$data['searchlist'][$item['officer_id']]['department_contact22'] = $item['person_department'];
							$data['searchlist'][$item['officer_id']]['email_contact22'] = $item['person_email'];
							$data['searchlist'][$item['officer_id']]['tel_contact22'] = $item['person_tel'];
							$data['searchlist'][$item['officer_id']]['fax_contact22'] = $item['person_fax'];
							$data['searchlist'][$item['officer_id']]['zip_contact22'] = $item['person_zip'];
							$data['searchlist'][$item['officer_id']]['address01_contact22'] = $item['person_address01'];
							$data['searchlist'][$item['officer_id']]['address02_contact22'] = $item['person_address02'];
							$data['searchlist'][$item['officer_id']]['name_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name_contact22'], "SJIS");
							$data['searchlist'][$item['officer_id']]['department_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['department_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['email_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['email_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['tel_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['tel_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['fax_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['fax_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['zip_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['zip_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['address01_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['address01_contact22'] , "SJIS");
							$data['searchlist'][$item['officer_id']]['address02_contact22'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['address02_contact22'] , "SJIS");
						}
					}
					else
					{
						if($attributesMemberCSV == 'attributesMemberCSV')
						{
							$data['searchlist'][$item['officer_id']]['type'] = $item['type'];
							$data['searchlist'][$item['officer_id']]['type'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['type'], "SJIS");
						}
						if($nameMemberCSV == 'nameMemberCSV')
						{
							$data['searchlist'][$item['officer_id']]['name'] = $item['name'];
							$data['searchlist'][$item['officer_id']]['name'] = mb_convert_encoding($data['searchlist'][$item['officer_id']]['name'], "SJIS");
						}
					}
				}

			}
			// data export file CSV
			$arrayBigExportCsv = [];
			//  title file CSV
			$arrayExportCsv = [];
			// checkbox 会員属性 type.base_of_members
			if($attributesMemberCSV == 'attributesMemberCSV')
			{
				array_push($arrayExportCsv,'type');
			}
			// checkbox 会員フラグ profile_flag.base_of_members
			if($flatMemberCSV == 'flatMemberCSV')
			{
				array_push($arrayExportCsv,'profile_flag');
				$profile_flag = 'checkRRI';
			}
			// checkbox 会員名称 name.base_of_members
			if($nameMemberCSV == 'nameMemberCSV')
			{
				array_push($arrayExportCsv,'name');
			}
			// checkbox 会員名称(ふりがな) name_kana.base_of_members
			if($nameKanaMemberCSV == 'nameKanaMemberCSV')
			{
				array_push($arrayExportCsv,'name_kana');
			}
			// checkbox 会員名称(英語) name_eng.base_of_members
			if($namEngMemberCSV == 'namEngMemberCSV')
			{
				array_push($arrayExportCsv,'name_eng');
			}
			// 代表者情報 Get data name.personss,department.persons 役員氏名 connect_type == 2
			if($repreInfoCSV == 'repreInfoCSV')
			{
				array_push($arrayExportCsv,'person_name','person_department');
			}
			// checkbox 変更履歴コメント Get data officers.edited_history
			if($historyCommentCSV == 'historyCommentCSV')
			{
				array_push($arrayExportCsv,'edit_officers');
			}
			// checkbox 備考 Get data officers.note
			if($remarksCSV == 'remarksCSV')
			{
				array_push($arrayExportCsv,'note_officers');
			}
			// 主担当者・サブ担当者をすべて出力 get data 役員氏名 connect_type == 21 && 担当者氏名 connect_type == 22
			if($contactMemberCSV == 0)
			{
				array_push($arrayExportCsv,'name_contact21','department_contact21', 'email_contact21', 'tel_contact21', 'fax_contact21', 'zip_contact21', 'address01_contact21', 'address02_contact21', 'name_contact22','department_contact22', 'email_contact22', 'tel_contact22', 'fax_contact22', 'zip_contact22', 'address01_contact22', 'address02_contact22');
			}
			// 主担当者のみ出力 Get data 役員氏名 connect_type == 21
			else if($contactMemberCSV == 2)
			{
				array_push($arrayExportCsv,'name_contact21','department_contact21', 'email_contact21', 'tel_contact21', 'fax_contact21', 'zip_contact21', 'address01_contact21', 'address02_contact21');
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

		$this->template->title = '役員のCSV出力';
		$this->template->header = '役員のCSV出力';
		$this->template->content = \View_Smarty::forge('officers/exportcsvofficers.tpl', $data);
	}
	public function action_setting() 
    {    
        $data['back'] = \Session::get('back');
        
        if(\Input::method() == 'POST') 
        {
            $member_flag = \Input::POST('member_flag');
            \Session::set('member_flag', $member_flag);
        }

        $this->template->header   = '役員設定';
		$this->template->title   = '役員設定';
		$this->template->content = \View_Smarty::forge('officers/setting.tpl', $data);
	}

	public function action_view($id=null) 
    {   
        $data['back'] = \Session::get('back');

        $data['member'] = \DB::select('persons.id','persons.name','persons.name_kana','persons.department','persons.email','persons.tel','persons.fax','persons.zip','persons.address01','persons.address02','persons.published_site_id','persons.type_of_ml',array('base_of_members.name', 'member_name'),array('base_of_members.name_kana', 'name_member_kana'),'user_key_tables.connect_type')
                        ->from('persons')
                        ->join('user_key_tables','LEFT')
                        ->on('user_key_tables.person_id', '=', 'persons.id')
                        ->join('base_of_members','LEFT')->on('base_of_members.id', '=', 'user_key_tables.member_id')
                        ->and_where_open()
                            ->where('persons.id','=', $id)
                            ->where('persons.deleted_at', 'IS', NULL)
                        ->and_where_close()
                        ->limit(1)
                        ->as_object()
                        ->execute();

        if(\Input::method() == 'POST')
        {   
            \Session::set('dataOfficer', $id);
            \Response::redirect($data['back']);
        }

        $this->template->header       = "役員設定";
		$this->template->title       = "役員設定";
		$this->template->content     = \View_Smarty::forge('officers/view.tpl', $data);
	}

    public function action_search()
    {
        $data = NULL;

        if(\Session::get('back'))
        {
            $data['back'] = \Session::get('back');
        }

        //Click  Search in Setting Curators
        if (\Input::method() == 'GET')
        {
            $name_member = \Input::GET('member_name');
            $name = \Input::GET('name');
            $department = \Input::GET('department');
            $email = \Input::GET('email');
            $sort_order = \Input::GET('sort');

            switch ($sort_order)
            {
                case 'base_of_members.name_kana_ASC':
                    $sort       =  'base_of_members.name_kana';
                    $order      = 'ASC';
                    break;
                case 'base_of_members.name_kana_DESC':
                    $sort       = 'base_of_members.name_kana';
                    $order      = 'DESC';
                    break;
                case 'persons.name_kana_ASC':
                    $sort       = 'persons.name_kana';
                    $order      = 'ASC';
                    break;
                case 'persons.name_kana_DESC':
                    $sort       = 'persons.name_kana';
                    $order      = 'DESC';
                    break;
                case 'persons.id_ASC':
                    $sort       = 'persons.id';
                    $order      = 'ASC';
                    break;
                case 'persons.id_DESC':
                    $sort       = 'persons.id';
                    $order      = 'DESC';
                    break;
            }

            $query =\DB::select('persons.id','persons.name','persons.department','persons.email','persons.tel', 'persons.fax','persons.address01',array('base_of_members.name', 'name_member'), array('base_of_members.name_kana', 'name_member_kana'),'user_key_tables.connect_type',array('user_key_tables.id', 'id_userkey'))
				->from('persons')->join('user_key_tables', 'LEFT')->on('persons.id', '=', 'user_key_tables.person_id')
				->join('base_of_members', 'LEFT')->on('user_key_tables.member_id', '=' , 'base_of_members.id')
				->where('base_of_members.deleted_at','IS',NULL)
				->where('persons.deleted_at','IS',NULL)
				->where('user_key_tables.deleted_at','IS',NULL);

            if($name_member != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $name_member. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $name_member. "%")->and_where_close();
			}
			if($name != NULL)
			{
				$query = $query->and_where_open()->where('persons.name', 'LIKE', "%" . $name. "%")->or_where('persons.name_kana', 'LIKE', "%" . $name. "%")->and_where_close();
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

			$data['count_sear'] = count($query->order_by($sort, $order)->distinct()->execute());

			if($data['count_sear'] < 1)
		   	{
				\Session::set_flash('error', '一致するレコードが見つかりません');
		   	}

			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links' 	 => 5,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',
			);

			$pagination = \Pagination::forge('conversionpagination', $config);

			\Session::set('backUrl', \Uri::update_query_string());

			$data['member'] = $query->order_by($sort, $order)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();

			$data['pagination'] = $pagination;
		}

		$this->template->header   = '役員設定';
        $this->template->title = '役員設定';
        $this->template->content = \View_Smarty::forge('officers/search.tpl', $data);
    }

   public function action_setup() 
    {
        $link = 'manager/officers/setup';
        \Session::set('back', $link);
        \Session::set('backToOfficerSetup', $link);
        if(\Session::get('previous_url'))
        {
        	\Session::delete('dataMember');
			\Session::delete('dataOfficer');
			\Session::delete('dataMainCurator');
			\Session::delete('arrayNewSubCurator');
			\Session::delete('member_flag');
			\Session::delete('previous_url');
        }

        if(\Input::referrer() == null)
		{
			\Session::delete('member_flag');
			\Session::delete('member_name');
			\Session::delete('dataMember');
			\Session::delete('dataOfficer');
			\Session::delete('id_officer');
			\Session::delete('dataMainCurator');
			\Session::delete('arrayNewSubCurator');
			\Session::delete('member_name');
			\Session::delete('check_sub_curator');
			\Session::delete('check_new_sub_curator');
			\Session::delete('idSubCuratorSetting');
		}

		if(\Input::post('MainCuratorSetting') || \Input::post('new_sub_curator') || \Input::post('sub_curator'))
		{
			$check_main_curator = \Input::post('check_main_curator');
			$check_sub_curator = \Input::post('check_sub_curator');
			$check_new_sub_curator = \Input::post('check_new_sub_curator');

			// echo $check_main_curator;exit;
			if($check_main_curator!=NULL)
			{
				\Session::set('check_main_curator',$check_main_curator);
				$data['check_main_curator'] = $check_main_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_new_sub_curator!=NULL)
			{
				\Session::set('check_new_sub_curator',$check_new_sub_curator);
				$data['check_new_sub_curator'] = $check_new_sub_curator;

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');

				}

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}
			}

			\Response::redirect('manager/curators/setting');
        }

        //Click button Edit Main Curator
		if(\Input::post('edit_main_curator'))
		{
			$check_main_curator = \Input::post('check_main_curator');
			$check_sub_curator = \Input::post('check_sub_curator');
			$check_new_sub_curator = \Input::post('check_new_sub_curator');

			if($check_main_curator != NULL)
			{
				\Session::set('check_main_curator',$check_main_curator);

				$data['check_main_curator'] = $check_main_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_sub_curator != NULL)
			{
				\Session::set('check_sub_curator',$check_sub_curator);

				$data['check_sub_curator'] = $check_sub_curator;

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');

				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_new_sub_curator!=NULL)
			{
				\Session::set('check_new_sub_curator',$check_new_sub_curator);

				$data['check_new_sub_curator'] = $check_new_sub_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');
				}
				
			}

			\Response::redirect('manager/curators/edit');
		}

        $data['member_flag']    = \Session::get('member_flag');
        if(\Session::get('dataMember')){
        	$member_id          = \Session::get('dataMember');	
        }
        else
        {
        	$member_id 			= NULL;
        	\Session::delete('dataMember');
        }

        if(\Session::get('dataOfficer'))
        {
        	$officer_id         = \Session::get('dataOfficer');
        }
        else
        {
        	$officer_id 		= NULL;
        	\Session::delete('dataOfficer');
        }
        
        if(\Session::get('dataMainCurator'))
        {
        	$main_curator_id 	= \Session::get('dataMainCurator');	
        }
        else
        {
        	$main_curator_id 	= NULL;
        	\Session::delete('dataMainCurator');
        }
        
        $dataNewSubCurator		= \Session::get('dataNewSubCurator');
        $data['member_id']      = \Session::get('member_id');

        if($member_id != NULL)
        {
            $memberInfo       = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.profile_flag')
            ->from('base_of_members')
            ->and_where_open()
                ->where('base_of_members.id', '=', $member_id)
                ->where('base_of_members.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->as_object()
            ->execute();

            if($memberInfo->as_array() != NULL)
            {
            	$data['member'] = $memberInfo;
            }
            else
            {
            	$data['member'] = NULL;	
            }

            $old_officer_in_group = \DB::select('officers.officer_in_group')
	        ->from('officers')
	        ->where('officers.member_id', '=', $member_id)
	        ->where('officers.deleted_at', 'IS', NULL)
	        ->execute();
        }
        else
        {
            $data['member']        = NULL;
        }

        if($officer_id != NULL)
        {
            $data['dataOfficer']   = \DB::select('persons.id','persons.name','persons.name_kana','persons.department','persons.email','persons.tel','persons.fax','persons.zip','persons.address01','persons.address02','persons.published_site_id','persons.type_of_ml')
            ->from('persons')
            ->and_where_open()
                ->where('persons.id','=', $officer_id)
                ->where('persons.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->limit(1)
            ->as_object()
            ->execute();
        }
        else
        {
            $data['dataOfficer']    = NULL;
        }

        if($main_curator_id != NULL)
		{
			$data['dataMainCurator'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $main_curator_id))
			));
		}
		else
		{
			$data['dataMainCurator']    = NULL;
			\Session::delete('dataMainCurator');
		}

		//Isset data Sub Curator in View
		$dataNewSubCurator	= \Session::get('dataNewSubCurator');
		$arrayNewSubCurator = array();

		if($dataNewSubCurator != NULL)
		{
			if(\Session::get('arrayNewSubCurator') != NULL)
			{
				$arrayNewSubCurator = \Session::get('arrayNewSubCurator');

				array_push($arrayNewSubCurator, $dataNewSubCurator);

				\Session::set('arrayNewSubCurator',$arrayNewSubCurator);
				\Session::delete('dataNewSubCurator');
			}
			else
			{
				$arrayNewSubCurator = array();

				if(isset($dataNewSubCurator))
				{
					array_push($arrayNewSubCurator, $dataNewSubCurator);
				}

				\Session::set('arrayNewSubCurator',$arrayNewSubCurator);
				\Session::delete('dataNewSubCurator');
			}
		}
		else
		{
			$arrayNewSubCurator = \Session::get('arrayNewSubCurator');
		}
		
		$dataArray = array();

		for($i = 0; $i < count($arrayNewSubCurator); $i++)
		{

			$data['dataNewSubCurator'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $arrayNewSubCurator[$i]))
			));

			array_push($dataArray,$data['dataNewSubCurator']);
				
		}

		if($dataArray != NULL)
		{
			$data['arrayNewSubCurator'] = $dataArray;
		}

		if ($_POST)
		{   
			if ( ! \Security::check_token())
			{
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
				\Response::redirect('manager/officers/setup');
			}
			else   
			{
				if(\Input::post('submitOfficer'))
		        {
		            $note               = \Input::post('note');
		            
		            if(\Input::post('member_flag'))
		            {
		            	$officer_in_group   = \Input::post('member_flag');
		            }
		            else
		            {
		            	$officer_in_group   = 0;
		            }

		            $check = 0;
			        if(isset($old_officer_in_group))
			        {
			        	for($i = 0; $i <count($old_officer_in_group); $i++)
			        	{
			        		if($old_officer_in_group[$i]['officer_in_group'] == $officer_in_group) 
			        		{
			        			$check = 1;
			        			break;
			        		}
			        	}
			        }

		            if($data['member'] != NULL && $data['dataOfficer'] != NULL) 
		            {
		                try 
		                {
		                    \DB::start_transaction();

		                	if($check == 1)
		                	{
		                		$error = 'この役員は既に登録されました。';
		                		\Session::set_flash('error', $error);
		                	}
		                	else
		                	{
		                		$OfficerPerson = \Model_Officer::forge(array(
			                        'member_id'         => $member_id,
			                        'note'              => $note,
			                        'officer_in_group'  => $officer_in_group
			                    ));

			                    $OfficerPerson->save();

			                    $new_officer_id =  $OfficerPerson->id;

			                    $UserKeyTables_officer = \Model_Userkeytable::forge(array(
			                        'connect_type'      => 2,
			                        'person_id'         => $officer_id,
			                        'member_id'         => $member_id,
			                        'officer_id'		=> $new_officer_id
			                    ));

			                    $UserKeyTables_officer->save();

			                    //Get id of main curator in the session
			                    if(isset($data['dataMainCurator']))
			                    {
			                    	foreach ($data['dataMainCurator'] as $key) {
				                        $id_mainCurator = $key->id;
				                    }

				                    $UserKeyTables_mainCurator = \Model_Userkeytable::forge(array(
				                        'connect_type'      => 21,
				                        'person_id'        => $id_mainCurator,
				                        'member_id'         => $member_id,
				                        'officer_id'		=> $new_officer_id
				                    ));

				                    $UserKeyTables_mainCurator->save();
			                    }

			                    $arrayNewSubCurator = \Session::get('arrayNewSubCurator');
								
								for($i = 0 ; $i < count($arrayNewSubCurator) ; $i++)
								{
									$UserKeytables_subCurator = \Model_Userkeytable::forge(array(
			                            'connect_type'      => 22,
			                            'person_id'        => $arrayNewSubCurator[$i],
			                            'member_id'         => $member_id,
			                            'officer_id'		=> $new_officer_id
			                        ));

			                        $UserKeytables_subCurator->save();
								}

			                    \DB::commit_transaction();

			                    \Session::delete('member_flag');
			                    \Session::delete('member_id');
			                    \Session::delete('dataMember');
			                    \Session::delete('dataOfficer');
			                    \Session::delete('dataMainCurator');
			                    \Session::delete('arrayNewSubCurator');
			                    \Session::delete('member_name');
			                    \Session::delete('back');

			                    \Response::redirect('manager/dashboard/index');
		                	}
		                }

		                catch (Exception $e)
		                {
		                    // rollback pending transactional queries
		                    \DB::rollback_transaction();

		                    throw $e;
		                    \Session::set_flash('error', e('Could not save page.'));
		                    \Response::redirect('manager/officers/setup');
		                }
		            }
		            elseif($data['member'] != NULL && $data['dataOfficer'] == NULL)
		            {
		                $error = '役員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		            elseif($data['member'] == NULL && $data['dataOfficer'] != NULL)
		            {
		                $error = '会員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		            else
		            {
		                $error = '役員と会員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		        }
			}
		}

		if(\Session::get('checkUrlOfficerSetup') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkUrlOfficerSetup');
		}

        $this->template->header   = '役員新規登録';
        $this->template->title      = '役員新規登録';
        $this->template->content    = \View_Smarty::forge('officers/setup.tpl', $data);
    }

    public function action_create() 
    {
        $data['member_name'] = \Session::get('member_name');
        $member_id = \Session::get('member_id');
        $data['back'] = \Session::get('back');

        if ($_POST)
        {   
        	if ( ! \Security::check_token())
        	{    
        		\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
        		\Response::redirect('manager/officers/create');   }   
        	else   
        	{
        		if(\Input::post('send')) 
			    {
			        //Chay validation truoc khi them mot cong chuc moi
			        $val = \Model_Person::validate('create');
			        if ($val->run())
			        {
			                $OfficerPerson = \Model_Person::forge(array(
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

			            $OfficerPerson->save();

			            //\Session::set('id_officer', $OfficerPerson->id);
			            $data['dataOfficer'] = $OfficerPerson->id;

			            \Session::set('dataOfficer', $data['dataOfficer']);                
			            \Response::redirect($data['back']);
			        }
			        else
			        {
			            \Session::set_flash('error', $val->error());
			        }   
			    }
			}
        }

        $this->template->header      = '役員追加';
        $this->template->title      = '役員追加';
        $this->template->content    = \View_Smarty::forge('officers/create.tpl', $data);
    }

    public function action_delete()
    {
        $data['back'] = \Session::get('back');

        if(\Input::method() == 'POST') 
        {
            \Session::delete('dataOfficer');    
        }

        \Response::redirect($data['back']);
    }

    public function action_getEdit($id=NULL)
    {
    	$dataJobholder = \DB::select('officers.member_id', 'officers.officer_in_group')
            ->from('officers')
            ->join('base_of_members','LEFT')->on('base_of_members.id', '=', 'officers.member_id')
            ->and_where_open()
                ->where('officers.id', '=', $id)
                ->where('officers.deleted_at', 'IS', NULL)
                ->where('base_of_members.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->execute();

        if(isset($id)) \Session::set('Jobholder', $id);
        $member_id = $dataJobholder[0]['member_id'];
        $officer_in_group = $dataJobholder[0]['officer_in_group'];

        $dataMember  = \DB::select('base_of_members.id', 'base_of_members.name')
        ->from('base_of_members')
        ->and_where_open()
            ->where('base_of_members.id', '=', $member_id)
            ->where('base_of_members.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->execute();

        if($dataMember != NULL)
        {
        	$member_name = $dataMember[0]['name'];
        }

        $dataOfficer = \DB::select('user_key_tables.person_id')
        ->from('user_key_tables')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 2)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->limit(1)
        ->execute();

        if($dataOfficer != NULL)
        {
        	$officer_id = $dataOfficer[0]['person_id'];
        }

        $dataMainCurator = \DB::select('user_key_tables.person_id')
        ->from('user_key_tables')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 21)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->limit(1)
        ->execute();

        if($dataMainCurator != NULL)
        {
            $main_curator_id = $dataMainCurator[0]['person_id'];
        }

        $arrayNewSubCurator = \DB::select('user_key_tables.person_id')
        ->from('user_key_tables')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 22)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->execute();

		$arraySubCuratorId = array();

        if($arrayNewSubCurator != NULL)
        {
        	for($i = 0; $i < count($arrayNewSubCurator); $i++)
			{
				array_push($arraySubCuratorId, $arrayNewSubCurator[$i]['person_id']);
			}
        }

		if(isset($officer_in_group)) 	\Session::set('member_flag', $officer_in_group);
		if(isset($member_name))			\Session::set('member_name', $member_name);
		if(isset($member_id)) 			\Session::set('dataMember', $member_id);
		if(isset($officer_id)) 			\Session::set('dataOfficer', $officer_id);
		if(isset($main_curator_id)) 	\Session::set('dataMainCurator', $main_curator_id);
		if(isset($arraySubCuratorId))	\Session::set('arrayNewSubCurator', $arraySubCuratorId);

    	\Response::redirect('manager/officers/edit');
    }

    public function action_edit()
    {
    	$data = NULL;
        $link = 'manager/officers/edit';
        \Session::set('previous_url', $link);
        \Session::set('back', $link);
        \Session::set('backToOfficerEdit', $link);
        $id = \Session::get('Jobholder');
        $user = \Session::get('username');

        if(\Input::post('MainCuratorSetting') || \Input::post('new_sub_curator') || \Input::post('sub_curator'))
		{
			$check_main_curator = \Input::post('check_main_curator');
			$check_sub_curator = \Input::post('check_sub_curator');
			$check_new_sub_curator = \Input::post('check_new_sub_curator');

			// echo $check_main_curator;exit;
			if($check_main_curator!=NULL)
			{
				\Session::set('check_main_curator',$check_main_curator);
				$data['check_main_curator'] = $check_main_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_new_sub_curator!=NULL)
			{
				\Session::set('check_new_sub_curator',$check_new_sub_curator);
				$data['check_new_sub_curator'] = $check_new_sub_curator;

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');

				}

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}
			}

			\Response::redirect('manager/curators/setting');
        }

        if(\Input::post('edit_main_curator'))
		{
			$check_main_curator = \Input::post('check_main_curator');
			$check_sub_curator = \Input::post('check_sub_curator');
			$check_new_sub_curator = \Input::post('check_new_sub_curator');

			if($check_main_curator != NULL)
			{
				\Session::set('check_main_curator',$check_main_curator);

				$data['check_main_curator'] = $check_main_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_sub_curator != NULL)
			{
				\Session::set('check_sub_curator',$check_sub_curator);

				$data['check_sub_curator'] = $check_sub_curator;

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');

				}

				if(\Session::get('check_new_sub_curator')!=NULL)
				{
					\Session::delete('check_new_sub_curator');
				}
			}

			if($check_new_sub_curator!=NULL)
			{
				\Session::set('check_new_sub_curator',$check_new_sub_curator);

				$data['check_new_sub_curator'] = $check_new_sub_curator;

				if(\Session::get('check_sub_curator')!=NULL)
				{
					\Session::delete('check_sub_curator');
				}

				if(\Session::get('check_main_curator')!=NULL)
				{
					\Session::delete('check_main_curator');
				}
				
			}

			\Response::redirect('manager/curators/edit');
		}

        //Get the current date to update to edited_history
        $current_timestamp = \Date::time()->get_timestamp();
        $current_date = \Date::forge($current_timestamp)->format("%Y/%m/%d");

        $dataJobholder = \DB::select('officers.member_id', 'officers.officer_in_group', 'officers.note')
            ->from('officers')
            ->and_where_open()
                ->where('officers.id', '=', $id)
                ->where('officers.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->execute();

        if($dataJobholder != NULL)
        {
        	$member_id = $dataJobholder[0]['member_id'];
        	$officer_in_group = $dataJobholder[0]['officer_in_group'];
        	$data['note'] = $dataJobholder[0]['note'];
        }

        $dataOfficer = \DB::select('persons.id')
        ->from('persons')
        ->join('user_key_tables','LEFT')
        ->on('user_key_tables.person_id', '=', 'persons.id')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 2)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('persons.deleted_at', 'IS', NULL)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->limit(1)
        ->execute();

        if($dataOfficer != NULL)
        {
        	$officer_id = $dataOfficer[0]['id'];
        }

        $dataMainCurator = \DB::select('persons.id')
        ->from('persons')
        ->join('user_key_tables','LEFT')
        ->on('user_key_tables.person_id', '=', 'persons.id')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 21)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
            ->where('persons.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->limit(1)
        ->execute();

        if($dataMainCurator->as_array() != NULL)
        {
            $main_curator_id = $dataMainCurator[0]['id'];
        }

        $ArraySubCurator = \DB::select('persons.id')
        ->from('persons')
        ->join('user_key_tables','LEFT')
        ->on('user_key_tables.person_id', '=', 'persons.id')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 22)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
            ->where('persons.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->as_object()
        ->execute();

        $dataNewSubCurator = NULL;

        for($i=0; $i<count($ArraySubCurator);$i++)
        {
        	$dataNewSubCurator[$i] = $ArraySubCurator[$i]->id;
        }

        //Get the current officer_in_group
        if(\Session::get('member_flag') && \Session::get('member_flag')>0)
        {
            $data['member_flag'] = \Session::get('member_flag');
        }
        else
        {
        	$data['member_flag'] = NULL;
        }

        //Get the current member to display
        if(\Session::get('dataMember'))
        {
        	$temp_member_id 	= \Session::get('dataMember');
	        $memberInfo     = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.name_kana')
            ->from('base_of_members')
            ->and_where_open()
                ->where('base_of_members.id', '=', $temp_member_id)
                ->where('base_of_members.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->as_object()
            ->execute();

            if($memberInfo->as_array() != NULL)
            {
            	$data['member'] = $memberInfo;
            }
            else
            {
            	$data['member'] = NULL;
            }

            $old_officer_in_group = \DB::select('officers.officer_in_group')
	        ->from('officers')
	        ->where('officers.member_id', '=', $temp_member_id)
	        ->where('officers.deleted_at', 'IS', NULL)
	        ->where('officers.id' ,'<>', $id)
	        ->execute();
        }
        else
        {
        	$data['member'] = NULL;
        }

        //Get the current officer to display
        if(\Session::get('dataOfficer'))
        {
        	$temp_officer_id	 = \Session::get('dataOfficer');
            $Officer   = \DB::select('persons.id','persons.name','persons.name_kana','persons.department','persons.email','persons.tel','persons.fax','persons.zip','persons.address01','persons.address02','persons.published_site_id','persons.type_of_ml')
            ->from('persons')
            ->and_where_open()
                ->where('persons.id','=', $temp_officer_id)
                ->where('persons.deleted_at', 'IS', NULL)
            ->and_where_close()
            ->limit(1)
            ->as_object()
            ->execute();

            if($Officer->as_array() != NULL)
            {
            	$data['dataOfficer'] = $Officer;
            }else
            {
            	$data['dataOfficer'] = NULL;
            }

        }
        else
        {
        	$data['dataOfficer'] = NULL;
        }
       
        //Get the current main curator to display
        if(\Session::get('dataMainCurator'))
        {
        	$temp_main_curator_id	 = \Session::get('dataMainCurator');

			$data['dataMainCurator'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $temp_main_curator_id))
			));

            foreach ($data['dataMainCurator'] as $key) {
                $current_main_curator_id = $key->id;
            }
        }

        //Get the current sub curator to display
        $dataNewSubCurator	= \Session::get('dataNewSubCurator');
        $arrayNewSubCurator = array();

		if($dataNewSubCurator != NULL)
		{
			if(\Session::get('arrayNewSubCurator') != NULL)
			{
				$arrayNewSubCurator = \Session::get('arrayNewSubCurator');

				array_push($arrayNewSubCurator, $dataNewSubCurator);

				\Session::set('arrayNewSubCurator',$arrayNewSubCurator);
				\Session::delete('dataNewSubCurator');
			}
			else
			{
				$arrayNewSubCurator = array();

				if(isset($dataNewSubCurator))
				{
					array_push($arrayNewSubCurator, $dataNewSubCurator);
				}

				\Session::set('arrayNewSubCurator',$arrayNewSubCurator);
				\Session::delete('dataNewSubCurator');
			}
		}
		else
		{
			$arrayNewSubCurator = \Session::get('arrayNewSubCurator');
		}
	
		$dataArray = array();

		for($i = 0; $i < count($arrayNewSubCurator); $i++)
		{

			$data['dataNewSubCurator'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $arrayNewSubCurator[$i]))
			));

			array_push($dataArray,$data['dataNewSubCurator']);
				
		}

		if($dataArray != NULL)
		{
			$data['arrayNewSubCurator'] = $dataArray;
		}

        if(\Session::get('dataMember'))
        {
            $current_member_id      = \Session::get('dataMember');
        }
        else
        {
            $current_member_id      = $member_id;
        }    

        if(\Session::get('dataOfficer'))
        {
            $current_officer_id         = \Session::get('dataOfficer');
        }
        else
        {
            $current_officer_id     = $officer_id;
        }

        $user_key_tables_officer = \DB::select(array('user_key_tables.id', 'user_key_tables_officer'))
        ->from('user_key_tables')
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 2)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
	        ->as_object()
	        ->execute();

        if($user_key_tables_officer->as_array() != NULL)
        {
            $user_key_tables_officer_id = $user_key_tables_officer[0]->user_key_tables_officer;
        }

        $user_key_tables_main_curator = \DB::select(array('user_key_tables.id', 'user_key_tables_main_curator'))
        ->from('user_key_tables')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 21)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->as_object()
        ->execute();

        if($user_key_tables_main_curator->as_array() != NULL)
        {
            $user_key_tables_main_curator_id = $user_key_tables_main_curator[0]->user_key_tables_main_curator;
        }

        $user_key_tables_sub_curator = \DB::select(array('user_key_tables.id', 'user_key_tables_sub_curator'))
        ->from('user_key_tables')
        ->and_where_open()
            ->where('user_key_tables.member_id','=', $member_id)
            ->where('user_key_tables.connect_type', '=', 22)
            ->where('user_key_tables.officer_id', '=', $id)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
        ->and_where_close()
        ->as_object()
        ->execute();

        $user_key_tables_sub_curator_id = NULL;
        if($user_key_tables_sub_curator != NULL)
        {
            for($i=0; $i<count($user_key_tables_sub_curator);$i++)
            {
            	$user_key_tables_sub_curator_id[$i] = $user_key_tables_sub_curator[$i]->user_key_tables_sub_curator;
            }
        }

        if ($_POST)
		{   
			if ( ! \Security::check_token())
			{    
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
				\Response::redirect('manager/officers/edit');
			}   
			else   
			{
				if(\Input::post('submitOfficer'))
		        {
		            $note               = \Input::post('note');

		            if(\Input::post('member_flag') != NULL)
		            {
		            	$current_officer_in_group   = \Input::post('member_flag');
		       	     }
		            else
		            {
		            	$current_officer_in_group   = \Input::post('member_flag');	
		            }

		            $check = 0;
			        if(isset($old_officer_in_group))
			        {
			        	for($i = 0; $i <count($old_officer_in_group); $i++)
			        	{
			        		if($old_officer_in_group[$i]['officer_in_group'] == $current_officer_in_group) 
			        		{
			        			$check = 1;
			        			break;
			        		}
			        	}
			        }

		            if($data['member'] != NULL && $data['dataOfficer'] != NULL) 
		            {
		                try 
		                {
		                    \DB::start_transaction();

		                    if($check == 1)
		                	{
		                		$error = 'この役員は既に登録されました。';
		                		\Session::set_flash('error', $error);
		                	}
		                	else
		                	{
		                		if($current_member_id != $member_id)
			                    {	
			                    	$log = \DB::select('officers.edited_history')
			                    	->from('officers')
			                    	->where('id', '=', $id)
			                    	->execute();

			                    	$edited_history = $log[0]['edited_history'];

			                        \Model_Officer::find($id)
			                        ->set(array(
			                        	'member_id'         => $current_member_id,
			                            'note'              => $note,
			                            'officer_in_group'  => $current_officer_in_group,
			                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
			                        ))->save();

			                        if($current_officer_id != $officer_id)
				                    {
				                        \Model_Userkeytable::find($user_key_tables_officer_id)
				                        ->set(array(
				                        	'member_id'		 => $current_member_id,
				                            'person_id'      => $current_officer_id,
				                        ))->save();

				                        $log = \DB::select('officers.edited_history')
				                    	->from('officers')
				                    	->where('id', '=', $id)
				                    	->execute();

			                    		$edited_history = $log[0]['edited_history'];

				                        \Model_Officer::find($id)
				                        ->set(array(
				                            'note'              => $note,
				                            'officer_in_group'  => $current_officer_in_group,
				                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
				                        ))->save();
				                    }
				                    else
				                    {
				                    	\Model_Userkeytable::find($user_key_tables_officer_id)
				                        ->set(array(
				                        	'member_id'		 => $current_member_id
				                        ))->save();

				                        \Model_Officer::find($id)
				                        ->set(array(
				                        	'member_id'         => $current_member_id,
				                            'note'              => $note,
				                            'officer_in_group'  => $current_officer_in_group
				                        ))->save();
				                    }

				                    if(isset($current_main_curator_id))
				                    {
										if(isset($main_curator_id))	
										{
											if($current_main_curator_id != $main_curator_id)
					                        {
					                            \Model_Userkeytable::find($user_key_tables_main_curator_id)
						                        ->set(array(
						                        	'member_id'	 => $current_member_id,
					                                'person_id'  => $current_main_curator_id,
						                        ))->save();

					                            $log = \DB::select('officers.edited_history')
						                    	->from('officers')
						                    	->where('id', '=', $id)
						                    	->execute();

						                    	$edited_history = $log[0]['edited_history'];

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group,
						                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
						                        ))->save();
					                        }
					                        else
					                        {
					                        	\Model_Userkeytable::find($user_key_tables_main_curator_id)
						                        ->set(array(
						                        	'member_id'		 => $current_member_id
						                        ))->save();

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group
						                        ))->save();
					                        }
										}
										else
										{
											$add_main_curator = \Model_Userkeytable::forge(array(
				                                'connect_type'      => 21,
				                                'person_id'         => $current_main_curator_id,
				                                'member_id'         => $current_member_id,
				                                'officer_id'		=> $id
				                            ));

				                            $add_main_curator->save();

				                            $log = \DB::select('officers.edited_history')
					                    	->from('officers')
					                    	->where('id', '=', $id)
					                    	->execute();

					                    	$edited_history = $log[0]['edited_history'];

				                            \Model_Officer::find($id)
					                        ->set(array(
					                            'note'              => $note,
					                            'officer_in_group'  => $current_officer_in_group,
					                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
					                        ))->save();
										}
				                    }
				                    else
				                    {
				                    	if(isset($main_curator_id))
				                    	{
				                    		\Model_Userkeytable::find($user_key_tables_main_curator_id)
				                    		->delete();
				                    	}
				                    }

				                    if(isset($arrayNewSubCurator))
				                    {
				                    	if(isset($ArraySubCurator))
				                    	{
				                    		if($arrayNewSubCurator != $ArraySubCurator)
					                        {
												for($i = 0; $i< count($user_key_tables_sub_curator_id); $i++)
												{
													\Model_Userkeytable::find($user_key_tables_sub_curator_id[$i])->delete();
												}

												//Create Sub Curator current					
												for($i = 0; $i< count($arrayNewSubCurator); $i++)
												{
													$data_userkey_12_new = \Model_Userkeytable::forge(array(
														'member_id'		=> $current_member_id,
														'connect_type' 	=> 22,
														'person_id'		=> $arrayNewSubCurator[$i],
														'officer_id'		=> $id
													));

													$data_userkey_12_new->save();
												}

												$log = \DB::select('officers.edited_history')
						                    	->from('officers')
						                    	->where('id', '=', $id)
						                    	->execute();

						                    	$edited_history = $log[0]['edited_history'];

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group,
						                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
						                        ))->save();
					                        }
					                        else
					                        {
					                        	$user_key_tables_sub_curator_id;

												for($i = 0; $i< count($user_key_tables_sub_curator_id); $i++)
												{
													\Model_Userkeytable::find($user_key_tables_sub_curator_id[$i])->delete();
												}

												//Create Sub Curator current					
												for($i = 0; $i< count($arrayNewSubCurator); $i++)
												{
													$data_userkey_12_new = \Model_Userkeytable::forge(array(
														'member_id'		=> $current_member_id,
														'connect_type' 	=> 22,
														'person_id'		=> $arrayNewSubCurator[$i],
														'officer_id'	=> $id
													));

													$data_userkey_12_new->save();
												}

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group,
						                        ))->save();
					                        }
				                    	}
				                    	else
										{
											for($i = 0; $i< count($arrayNewSubCurator); $i++)
											{
												$data_userkey_12_new = \Model_Userkeytable::forge(array(
													'member_id'		=> $current_member_id,
													'connect_type' 	=> 22,
													'person_id'		=> $arrayNewSubCurator[$i],
													'officer_id'	=> $id
												));

												$data_userkey_12_new->save();
											}

											$log = \DB::select('officers.edited_history')
					                    	->from('officers')
					                    	->where('id', '=', $id)
					                    	->execute();

					                    	$edited_history = $log[0]['edited_history'];

				                            \Model_Officer::find($id)
					                        ->set(array(
					                            'note'              => $note,
					                            'officer_in_group'  => $current_officer_in_group,
					                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
					                        ))->save();
										}
				                    }
				                    else
				                    {
				                    	for($i = 0; $i< count($ArraySubCurator); $i++)
										{
											\Model_Userkeytable::find($ArraySubCurator[$i])->delete();
										}
				                    }
			                    }
			                    else
			                    {
			                        \Model_Officer::find($id)
			                        ->set(array(
			                            'note'              => $note,
			                            'officer_in_group'  => $current_officer_in_group
			                        ))->save();

			                        if($current_officer_id != $officer_id)
				                    {
				                        \Model_Userkeytable::find($user_key_tables_officer_id)
				                        ->set(array(
				                        	'person_id'	 => $current_officer_id,
				                        ))->save();

				                        $log = \DB::select('officers.edited_history')
				                    	->from('officers')
				                    	->where('id', '=', $id)
				                    	->execute();

				                    	$edited_history = $log[0]['edited_history'];

				                        \Model_Officer::find($id)
				                        ->set(array(
				                            'note'              => $note,
				                            'officer_in_group'  => $current_officer_in_group,
				                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
				                        ))->save();
				                    }
				                    else
				                    {
				                        \Model_Officer::find($id)
				                        ->set(array(
				                            'note'              => $note,
				                            'officer_in_group'  => $current_officer_in_group,
				                        ))->save();
				                    }

				                    if(isset($current_main_curator_id))
				                    {
										if(isset($main_curator_id))	
										{
											if($current_main_curator_id != $main_curator_id)
					                        {		                           
					                            \Model_Userkeytable::find($user_key_tables_main_curator_id)
						                        ->set(array(
						                        	'person_id'	 => $current_main_curator_id
						                        ))->save();

					                            $log = \DB::select('officers.edited_history')
						                    	->from('officers')
						                    	->where('id', '=', $id)
						                    	->execute();

						                    	$edited_history = $log[0]['edited_history'];

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group,
						                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
						                        ))->save();
					                        }
					                        else
					                        {
					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group
						                        ))->save();
					                        }
										}
										else
										{
											$add_main_curator = \Model_Userkeytable::forge(array(
				                                'connect_type'      => 21,
				                                'person_id'         => $current_main_curator_id,
				                                'member_id'			=> $current_member_id,
				                                'officer_id'		=> $id
				                            ));

				                            $add_main_curator->save();

				                            $log = \DB::select('officers.edited_history')
					                    	->from('officers')
					                    	->where('id', '=', $id)
					                    	->execute();

					                    	$edited_history = $log[0]['edited_history'];

				                            \Model_Officer::find($id)
					                        ->set(array(
					                            'note'              => $note,
					                            'officer_in_group'  => $current_officer_in_group,
					                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
					                        ))->save();
										}
				                    }
				                    else
				                    {
				                    	if(isset($main_curator_id))
				                    	{
				                    		\Model_Userkeytable::find($user_key_tables_main_curator_id)->delete();
				                    	}
				                    }

				                    if(isset($arrayNewSubCurator))
				                    {
				                    	if(isset($ArraySubCurator))
				                    	{
				                    		if($arrayNewSubCurator != $ArraySubCurator)
					                        {
					                        	for($i=0;$i<count($user_key_tables_sub_curator_id);$i++)
					                        	{
												    $sub_curator_id = $user_key_tables_sub_curator_id[$i];
												    \Model_Userkeytable::find($sub_curator_id)
												    ->delete();
					                        	}

												//Create Sub Curator current					
												for($i = 0; $i< count($arrayNewSubCurator); $i++)
												{
													$data_userkey_12_new = \Model_Userkeytable::forge(array(
														'member_id'		=> $current_member_id,
														'connect_type' 	=> 22,
														'person_id'		=> $arrayNewSubCurator[$i],
														'officer_id'		=> $id
													));

													$data_userkey_12_new->save();
												}

												$log = \DB::select('officers.edited_history')
						                    	->from('officers')
						                    	->where('id', '=', $id)
						                    	->execute();

						                    	$edited_history = $log[0]['edited_history'];

					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group,
						                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
						                        ))->save();

					                        }
					                        else
					                        {
					                            \Model_Officer::find($id)
						                        ->set(array(
						                            'note'              => $note,
						                            'officer_in_group'  => $current_officer_in_group
						                        ))->save();
					                        }
				                    	}
				                    	else
										{
											for($i = 0; $i< count($arrayNewSubCurator); $i++)
											{
												$data_userkey_12_new = \Model_Userkeytable::forge(array(
													'member_id'		=> $current_member_id,
													'connect_type' 	=> 22,
													'person_id'		=> $arrayNewSubCurator[$i],
													'officer_id'		=> $id
												));

												$data_userkey_12_new->save();
											}

											$log = \DB::select('officers.edited_history')
					                    	->from('officers')
					                    	->where('id', '=', $id)
					                    	->execute();

					                    	$edited_history = $log[0]['edited_history'];

				                            \Model_Officer::find($id)
					                        ->set(array(
					                            'note'              => $note,
					                            'officer_in_group'  => $current_officer_in_group,
					                            'edited_history'    => $current_date.' 役員が〇〇〇〇さんから変更になりました。'.$edited_history
					                        ))->save();
										}
				                    }
				                    else
				                    {
				                    	for($i=0;$i<count($user_key_tables_sub_curator_id);$i++)
			                        	{
										    $sub_curator_id = $user_key_tables_sub_curator_id[$i];
										    \Model_Userkeytable::find($sub_curator_id)
										    ->delete();
			                        	}
				                    }
			                    }
		                	}                    
		                    
		                    \DB::commit_transaction();

		                    \Session::delete('member_flag');
							\Session::delete('member_name');
							\Session::delete('dataMember');
							\Session::delete('arrMember');
							\Session::delete('dataOfficer');
							\Session::delete('id_officer');
							\Session::delete('dataMainCurator');
							\Session::delete('arrayNewSubCurator');
							\Session::delete('Jobholder');
							\Session::delete('member_name');

							
		                }

		                catch (Exception $e)
		                {
		                    // rollback pending transactional queries
		                    \DB::rollback_transaction();

		                    throw $e;
		                    \Session::set_flash('error', e('Could not save page.'));
		                    \Response::redirect($link);
		                }

		                //Edit office cuccess

		                if(\Session::get('backToOfficerSearch') != NULL)
				        {
				        	$backToOfficerSearch = \Session::get('backToOfficerSearch');
				        	\Session::set('checkurlsearch', \Uri::update_query_string());
				        	\Session::delete('backToOfficerSearch');
				        	\Response::redirect($backToOfficerSearch);
				        }
				        else if(\Session::get('backToOfficerSearchList') != NULL)
				        {
				        	\Session::set('checkurlsearchlist', \Uri::update_query_string());
				        	$backToOfficerSearchList = \Session::get('backToOfficerSearchList');
				        	\Session::delete('backToOfficerSearchList');
				        	\Response::redirect($backToOfficerSearchList);
			            }
			            else
			            {
			            	\Response::redirect('manager/dashboard/index');
			            }
			        }
		            elseif($data['member'] != NULL && $data['dataOfficer'] == NULL)
		            {
		                $error = '役員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		            elseif($data['member'] == NULL && $data['dataOfficer'] != NULL)
		            {
		                $error = '会員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		            else
		            {
		                $error = '役員と会員の設定を行って下さい。';
		                \Session::set_flash('error', $error);
		            }
		        }

		       	if(\Input::post('deleteOfficer'))
		       	{
		       		\Session::set_flash('jobholder_id', \Session::get('Jobholder'));

		       		if(isset($user_key_tables_officer_id))
		       		{
		       			\Session::set_flash('user_key_tables_officer_id', $user_key_tables_officer_id);
		       		}

		       		if(isset($user_key_tables_main_curator_id))
		       		{
		       			\Session::set_flash('user_key_tables_main_curator_id', $user_key_tables_main_curator_id);
		       		}

		       		if(isset($user_key_tables_sub_curator_id))
		       		{
		       			\Session::set_flash('user_key_tables_sub_curator_id', $user_key_tables_sub_curator_id);
		       		}
		       		
		       		\Response::redirect('manager/officers/deletejobholder');
		       	}
			}
		}

		if(\Session::get('checkUrlOfficerEdit') != NULL)
		{
			$data['dataCheckurl'] = \Session::get('checkUrlOfficerEdit');
		}

		$this->template->header      = '役員編集';
        $this->template->title      = '役員編集';
        $this->template->content    = \View_Smarty::forge('officers/edit.tpl', $data);
    }

	public function action_deletejobholder()
	{
		$jobholder_id = \Session::get('Jobholder');
		
		if(\Session::get_flash('user_key_tables_officer_id'))
		{
			$user_key_tables_officer_id = \Session::get_flash('user_key_tables_officer_id');
		}

		if(\Session::get_flash('user_key_tables_main_curator_id'))
		{
			$user_key_tables_main_curator_id = \Session::get_flash('user_key_tables_main_curator_id');	
		}

		if(\Session::get_flash('user_key_tables_sub_curator_id'))
		{
			$user_key_tables_sub_curator_id = \Session::get_flash('user_key_tables_sub_curator_id');	
		}

		try
		{
			\DB::start_transaction();

			\Model_Officer::find($jobholder_id)->delete();

			if(isset($user_key_tables_officer_id))
			{
				\Model_Userkeytable::find($user_key_tables_officer_id)->delete();
			}

			if(isset($user_key_tables_main_curator_id))
			{
				\Model_Userkeytable::find($user_key_tables_main_curator_id)->delete();
			}	

			if(isset($user_key_tables_sub_curator_id))
			{
				for($i = 0; $i< count($user_key_tables_sub_curator_id); $i++)
				{
					\Model_Userkeytable::find($user_key_tables_sub_curator_id[$i])->delete();
				}
			}

			\DB::commit_transaction();
		}
		catch (Exception $e)
        {
            // rollback pending transactional queries
            \DB::rollback_transaction();

            throw $e;
            \Session::set_flash('error', e('Could not save page.'));
            \Response::redirect('error/404');
        }
		
        if(\Session::get('backToOfficerSearch') != NULL)
        {
        	$backToOfficerSearch = \Session::get('backToOfficerSearch');
        	\Session::set('checkurlsearch', \Uri::update_query_string());
        	\Session::delete('backToOfficerSearch');
        	\Response::redirect($backToOfficerSearch);
        }
        else if(\Session::get('backToOfficerSearchList') != NULL)
        {
        	\Session::set('checkurlsearchlist', \Uri::update_query_string());
        	$backToOfficerSearchList = \Session::get('backToOfficerSearchList');
        	\Session::delete('backToOfficerSearchList');
        	\Response::redirect($backToOfficerSearchList);
        }
        else
        {
        	\Response::redirect('manager/dashboard/index');
        }
	}

}