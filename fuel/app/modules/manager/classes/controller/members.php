<?php
namespace Manager;

class Controller_Members extends Controller_Base {
	
	public function action_index()
	{
		$this->template->header = 'メンバー検索';
		$this->template->title = 'メンバー検索';
		$this->template->content 	= 	\View_Smarty::forge('members/index.tpl');
	}

	public function action_searchmember()
	{	
		if(\Input::method() == 'GET' )
		{

			$name_member			=	\Input::get('nameMember');
			$namePerson				=	\Input::get('namePerson');
			$department				=	\Input::get('department');
			$email					=	\Input::get('email');
			$sortmember				=	\Input::get('sortmember');

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

			$query = \DB::select('base_of_members.type', 'persons.id', 'base_of_members.name', 'base_of_members.name_kana', array('persons.name', 'person_name'), 'persons.name_kana', 'persons.department', 'persons.email', 'persons.address01', 'persons.tel', 'persons.fax')
									->from('persons')->join('user_key_tables', 'LEFT')->on('persons.id', '=', 'user_key_tables.person_id')
									->join('base_of_members', 'LEFT')->on('user_key_tables.member_id', '=' , 'base_of_members.id')
									->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
									->where('base_of_members.deleted_at', 'IS', NULL);

			if($name_member != NULL)
			{
				$query = $query->and_where_open()->where('base_of_members.name', 'LIKE', "%" . $name_member. "%")->or_where('base_of_members.name_kana', 'LIKE', "%" . $name_member. "%")->and_where_close();
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

			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			if($data['count_sear'] <= 0)
			{
				\Session::set_flash('error', '一致するレコードが見つかりません');
				\Response::redirect('manager/members/index');
			}

			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links' 	 => 4,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',
			);

			$pagination = \Pagination::forge('mypagination', $config);

			\Session::set('backToOfficerSearch', \Uri::update_query_string());

			$data['member_search'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->execute();


		}
		$this->template->header = 'メンバー検索';
		$this->template->title = 'メンバー検索';
		$this->template->content = \View_Smarty::forge('members/searchmember.tpl', $data);
	}

	public function action_editmembers($id = 0)
	{

		$data['member'] = \DB::select('base_of_members.type', 'persons.id', 'base_of_members.name', 'base_of_members.name_kana', array('persons.name', 'person_name'), 'persons.name_kana', 'persons.department', 'persons.email', 'persons.address01', 'persons.address02', 'persons.tel', 'persons.fax', 'persons.zip', 'persons.published_site_id', 'persons.type_of_ml')
									->from('persons')->join('user_key_tables', 'LEFT')->on('persons.id', '=', 'user_key_tables.person_id')
									->join('base_of_members', 'LEFT')->on('user_key_tables.member_id', '=' , 'base_of_members.id')
									->where('persons.id', $id)->where('persons.deleted_at', 'IS', NULL)->where('user_key_tables.deleted_at', 'IS', NULL)
									->where('base_of_members.deleted_at', 'IS', NULL)->limit(1)->as_object()->execute();

		 if(\Input::post('backMembers')) 
		{
			\Response::redirect(\Session::get('backUrl'));
		}

		if(\Input::post('DeleteMembers')) 
		{
			\DB::update('persons')->set(array(
					'deleted_at'	=> date_timestamp_get(date_create()),
					'updated_at'	=> date_timestamp_get(date_create())
				))
				->where('persons.id', '=', $id)
				->as_object()
				->execute();

			\Response::redirect(\Session::get('backUrl'));
		}

		if(\Input::post('EditMembers'))
		{
			$val = \Model_Person::validate('create');

			if ($val->run())
			{
				$department			= \Input::post('department');
				$person_name		= \Input::post('name');
				$name_kana			= \Input::post('name_kana');
				$email				= \Input::post('email');
				$tel				= \Input::post('tel');
				$fax				= \Input::post('fax');
				$zip				= \Input::post('zip');
				$address01			= \Input::post('address01');
				$address02			= \Input::post('address02');
				$published_site_id	= \Input::post('published_site_id');
				$type_of_ml			= \Input::post('type_of_ml');

				\DB::update('persons')->set(array(
					'department' => $department,
					'name'		 => $person_name,
					'name_kana'	 => $name_kana,
					'email' 	 => $email,
					'tel' 		 => $tel,
					'fax' 		 => $fax,
					'zip' 		 => $zip,
					'address01'  => $address01,
					'address02'  => $address02,
					'published_site_id' => $published_site_id,
					'type_of_ml' => $type_of_ml
				))
				->where('persons.id', $id)
				->limit(1)
				->execute();
				\Response::redirect('manager/dashboard/index');
			}
			else
			{
				\Session::set_flash('error', $val->error());
				\Response::redirect('manager/members/editmembers/'. $id);
			}
		}
		$this->template->title = 'メンバー編集';
		$this->template->content 	= 	\View_Smarty::forge('members/editmembers.tpl', $data);
	}

    public function action_create() {
		
		if(\Input::referrer() == NULL)
		{
			\Session::delete('dataBaseofmember');
			\Session::delete('dataMember');
			\Session::delete('dataDelegate');
			\Session::delete('dataMainCurator');
			\Session::delete('dataSubCurator');
			\Session::delete('check_sub_curator');
			\Session::delete('check_main_curator');
			\Session::delete('check_new_sub_curator');
			\Session::delete('arrayNewSubCurator');
			\Session::delete('back');
			\Session::delete('check_delegate');
		}

		//Set session comeback link
		
		\Session::set('back', \Uri::update_query_string());
		
		if ($_POST)
		{
			if ( ! \Security::check_token())
    		{
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/members/create');
			}
			else
			{

				if (\Input::method() == 'POST')
				{

					$data['dataBaseofmember'] = array(
						'type'			=> \Input::post('type'),
						'profile_flag'	=> \Input::post('profile_flag'),
						'name_member'			=> \Input::post('name'),
						'name_member_kana'		=> \Input::post('name_kana'),
						'name_eng'		=> \Input::post('name_eng'),
						'description'	=> \Input::post('description'), 
					);

					$data['dataMember'] = array(
						'attendance_of_meeting'	=> \Input::post('attendance_of_meeting'),
						'proxy_of_meeting'		=> \Input::post('proxy_of_meeting'),
						'note'					=> \Input::post('note'),
					);

					//Set session in Form createMembers
					if ($data['dataBaseofmember'] != NULL)
					{
						\Session::set('dataBaseofmember', $data['dataBaseofmember']);
					}

					if ($data['dataMember'] != NULL)
					{
						\Session::set('dataMember', $data['dataMember']);
					}

					if(\Input::post('checkbutton') == 'delegate_setting')
					{

						$val	= \Model_Baseofmember::validate('create');

						if($val->run())
						{
							if(\Input::post('check_delegate')!=NULL && \Security::check_token())
							{
								\Session::set('check_delegate',1);
								\Response::redirect('manager/delegates/setting');
							}
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}

					//Click button Edit Delegate
					if(\Input::post('checkbutton') == 'edit_delegate')
					{
						$val	= \Model_Baseofmember::validate('create');

						if($val->run())
						{
							\Response::redirect('manager/delegates/edit');
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}

					//Click button Edit Main Curator
					if(\Input::post('checkbutton') == 'edit_curator')
					{

						$val	= \Model_Baseofmember::validate('create');

						if($val->run())
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
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}

					//Click button setting Curator
					if(\Input::post('checkbutton') == 'curator')
					{
						$val	= \Model_Baseofmember::validate('create');

						if($val->run())
						{
							//Check connect_type in user_key_tables
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

							if($check_sub_curator!=NULL)
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

							\Response::redirect('manager/curators/setting');
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}

					if(\Input::post('checkbutton') == 'createmember')
					{

						$val	= \Model_Baseofmember::validate('create');

						if ($val->run())
						{

							if(\Session::get('dataDelegate') != NULL && \Session::get('dataMainCurator') != NULL && \Session::get('arrayNewSubCurator') == NULL)
							{
								try
								{
									\DB::start_transaction();

									$dataDelegate		= \Session::get('dataDelegate');
									$dataMainCurator	= \Session::get('dataMainCurator');

									$basemember = \Model_Baseofmember::forge(array(
										'type'			=> \Input::post('type'),
										'profile_flag'	=> \Input::post('profile_flag'),
										'name'			=> \Input::post('name'),
										'name_kana'		=> \Input::post('name_kana'),
										'name_eng'		=> \Input::post('name_eng'),
										'description'	=> \Input::post('description')
									));

									$basemember->save();

									$member = \Model_Member::forge(array(
										'member_id'				=> $basemember->id,
										'attendance_of_meeting'	=> \Input::post('attendance_of_meeting'),
										'proxy_of_meeting'		=> \Input::post('proxy_of_meeting'),
										'note'					=> \Input::post('note'),
									));

									$member->save();
									
									$data_userkey_1 = \Model_Userkeytable::forge(array(
										'member_id'		=> $basemember->id,
										'connect_type' 	=> 1,
										'person_id'		=> $dataDelegate,
									));

									$data_userkey_1->save();

									$data_userkey_11 = \Model_Userkeytable::forge(array(
										'member_id'		=> $basemember->id,
										'connect_type' 	=> 11,
										'person_id'		=> $dataMainCurator,
									));

									$data_userkey_11->save();

									\DB::commit_transaction();

								}
								catch(Exception $e)
								{

									// rollback pending transactional queries
									\DB::rollback_transaction();

									throw $e;
									\Session::set_flash('error', e(' '));
									\Response::redirect('manager/members/create');

								}
							}
							elseif(\Session::get('dataDelegate') != NULL && \Session::get('dataMainCurator') != NULL && \Session::get('arrayNewSubCurator') != NULL)
							{
								try
								{
									\DB::start_transaction();

									$dataDelegate		= \Session::get('dataDelegate');
									$dataMainCurator	= \Session::get('dataMainCurator');
									$dataSubCurator 	= \Session::get('dataSubCurator');

									$basemember = \Model_Baseofmember::forge(array(
										'type'			=> \Input::post('type'),
										'profile_flag'	=> \Input::post('profile_flag'),
										'name'			=> \Input::post('name'),
										'name_kana'		=> \Input::post('name_kana'),
										'name_eng'		=> \Input::post('name_eng'),
										'description'	=> \Input::post('description')
									));

									$basemember->save();

									$member = \Model_Member::forge(array(
										'member_id' 			=> $basemember->id,
										'attendance_of_meeting'	=> \Input::post('attendance_of_meeting'),
										'proxy_of_meeting'		=> \Input::post('proxy_of_meeting'),
										'note'					=> \Input::post('note'),
									));

									$member->save();

									$data_userkey_1 = \Model_Userkeytable::forge(array(
										'member_id'		=> $basemember->id,
										'connect_type' 	=> 1,
										'person_id'		=> $dataDelegate,
									));

									$data_userkey_1->save();

									$data_userkey_11 = \Model_Userkeytable::forge(array(
										'member_id'		=> $basemember->id,
										'connect_type' 	=> 11,
										'person_id'		=> $dataMainCurator,
									));

									$data_userkey_11->save();

									$arrayNewSubCurator = \Session::get('arrayNewSubCurator');
									
									for($i = 0 ; $i < count($arrayNewSubCurator) ; $i++)
									{

										$data_userkey_12 = \Model_Userkeytable::forge(array(
											'member_id'		=> $basemember->id,
											'connect_type' 	=> 12,
											'person_id'		=> $arrayNewSubCurator[$i],
										));

										$data_userkey_12->save();

									}

									\DB::commit_transaction();
								}
								catch(Exception $e)
								{
									// rollback pending transactional queries
									\DB::rollback_transaction();
									throw $e;
									\Session::set_flash('error', e(' '));
									\Response::redirect('manager/members/create');
								}
							}
							elseif(\Session::get('dataDelegate') != NULL)
							{
								\Session::set_flash('error', '主担当の設定を行って下さい。');
								\Response::redirect('manager/members/create');
							}
							elseif(\Session::get('dataMainCurator') != NULL)
							{
								\Session::set_flash('error', '代表者の設定を行って下さい。');
								\Response::redirect('manager/members/create');
							}
							else
							{
								\Session::set_flash('error', '代表者と主担当の設定を行って下さい。');
								\Response::redirect('manager/members/create');
							}

							//Delete session
							\Session::delete('dataBaseofmember');
							\Session::delete('dataMember');
							\Session::delete('dataDelegate');
							\Session::delete('dataMainCurator');
							\Session::delete('dataSubCurator');
							\Session::delete('check_sub_curator');
							\Session::delete('check_main_curator');
							\Session::delete('check_new_sub_curator');
							\Session::delete('arrayNewSubCurator');
							\Session::delete('back');
							\Session::delete('check_delegate');
							
							\Session::set_flash('success', ' ');
							\Response::redirect('manager/dashboard/index');

						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}
				}

			}
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

		//Isset data Member in view
		$data['dataBaseofmember']	= \Session::get('dataBaseofmember');
		$data['dataMember']	= \Session::get('dataMember');

		
		
		//Isset data Delegate in view
		$dataDelegate		= \Session::get('dataDelegate');

		if($dataDelegate != NULL)
		{
			$data['dataDelegate'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $dataDelegate))
			));
		}
		else
		{
			\Session::delete('dataDelegate');
		}

		//Isset data Main Curator
		$dataMainCurator	= \Session::get('dataMainCurator');

		if($dataMainCurator != NULL)
		{
			$data['dataMainCurator'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $dataMainCurator))
			));
		}
		else
		{
			\Session::delete('dataMainCurator');
		}


		$this->template->header = '会員新規登録';
		$this->template->title = '会員新規登録';
		$this->template->content = \View_Smarty::forge('members/create.tpl',$data);

	}

	public function action_edit($id = NULL)
	{
		$data = NULL;
		
		//set session comeback link
		\Session::set('back', 'manager/members/edit');

		if ($_POST)
		{
			if ( ! \Security::check_token())
    		{
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/members/create');
			}
			else
			{
				if(\Input::method() == "POST")
				{
					$data['dataBaseofmember'] = array(
						'type'			=> \Input::post('type'),
						'profile_flag'	=> \Input::post('profile_flag'),
						'name_member'	=> \Input::post('name'),
						'name_member_kana'	=> \Input::post('name_kana'),
						'name_eng'		=> \Input::post('name_eng'),
						'description'	=> \Input::post('description'), 
					);

					$data['dataMember'] = array(
						'attendance_of_meeting'	=> \Input::post('attendance_of_meeting'),
						'proxy_of_meeting'		=> \Input::post('proxy_of_meeting'),
						'note'					=> \Input::post('note'),
					);

					//Set session in Form createMember
					if ($data['dataBaseofmember'] != NULL)
						\Session::set('dataBaseofmember', $data['dataBaseofmember']);

					if ($data['dataMember'] != NULL)
					{
						\Session::set('dataMember', $data['dataMember']);
					}

					if(\Input::post('checkbutton')=='delete_main_curator')
					{
						\Session::delete('dataMainCurator');
					}

					//Click button setting delegate or change setting
					if(\Input::post('checkbutton')=='delegate_setting')
					{
						// echo "voday";exit;
						$val	= \Model_Baseofmember::validate('edit');

						if($val->run())
						{
							if(\Input::post('check_delegate') != NULL)
							{
								\Session::set('check_delegate',1);
								\Response::redirect('manager/delegates/setting');
							}
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/edit');
						}
					}

					//Click button Edit Delegate
					if(\Input::post('checkbutton') == 'edit_delegate')
					{
						$val	= \Model_Baseofmember::validate('edit');

						if($val->run())
						{
							\Response::redirect('manager/delegates/edit');
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/edit');
						}
					}

					//Click button Edit Main or Sub Curator
					if(\Input::post('checkbutton') == 'edit_curator')
					{

						$val	= \Model_Baseofmember::validate('edit');

						if($val->run())
						{
							$check_main_curator = \Input::post('check_main_curator');
							$check_sub_curator = \Input::post('check_sub_curator');
							$check_new_sub_curator = \Input::post('check_new_sub_curator');

							if($check_main_curator != NULL)
							{

								\Session::set('check_main_curator',$check_main_curator);

								$data['check_main_curator'] = $check_main_curator;

								if(\Session::get('check_sub_curator') != NULL)
								{
									\Session::delete('check_sub_curator');
								}

								if(\Session::get('check_new_sub_curator') != NULL)
								{
									\Session::delete('check_new_sub_curator');
								}
							}

							if($check_sub_curator != NULL)
							{
								\Session::set('check_sub_curator',$check_sub_curator);

								$data['check_sub_curator'] = $check_sub_curator;

								if(\Session::get('check_main_curator') != NULL)
								{
									\Session::delete('check_main_curator');

								}

								if(\Session::get('check_new_sub_curator') != NULL)
								{
									\Session::delete('check_new_sub_curator');
								}
							}

							if($check_new_sub_curator != NULL)
							{
								\Session::set('check_new_sub_curator',$check_new_sub_curator);

								$data['check_new_sub_curator'] = $check_new_sub_curator;

								if(\Session::get('check_sub_curator') != NULL)
								{
									\Session::delete('check_sub_curator');
								}

								if(\Session::get('check_main_curator') != NULL)
								{
									\Session::delete('check_main_curator');
								}
								
							}

							\Response::redirect('manager/curators/edit');
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/create');
						}
					}

					//Click button setting Main Curator or sub curator
					if(\Input::post('checkbutton') == 'curator')
					{
						$val	= \Model_Baseofmember::validate('edit');

						if($val->run())
						{
							//Check connect_type in user_key_tables
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

							if($check_sub_curator!=NULL)
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

							\Response::redirect('manager/curators/setting');
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/edit');
						}
					}

					//Click submit
					if(\Input::post('checkbutton') == 'confirmEdit')
					{

						
						$val	= \Model_Baseofmember::validate('edit');

						if ($val->run())
						{

							if(\Session::get('dataDelegate') != NULL && \Session::get('dataMainCurator') != NULL)
							{	
								//Get value id Baseofmember old
								if(\Session::get('idBaseofmember')) $idBaseofmember = \Session::get('idBaseofmember');

								//Get value Main Curator old
								if(\Session::get('dataMainCurator_old')) $dataMainCurator_old = \Session::get('dataMainCurator_old');

								//Get value Sub Curator old
								if(\Session::get('arrayNewSubCurator_old')) $arrayNewSubCurator_old = \Session::get('arrayNewSubCurator_old');

								//Get value Delegate Current
								if(\Session::get('dataDelegate')) $dataDelegate = \Session::get('dataDelegate');

								//Get value Main Curator Current
								if(\Session::get('dataMainCurator')) $dataMainCurator = \Session::get('dataMainCurator');

								//Get value Sub Curator Current
								if(\Session::get('arrayNewSubCurator')) $dataMainCurator = \Session::get('arrayNewSubCurator');

								$data['dataBaseofmember'] = array(
									'type'			=> \Input::post('type'),
									'profile_flag'	=> \Input::post('profile_flag'),
									'name'			=> \Input::post('name'),
									'name_kana'		=> \Input::post('name_kana'),
									'name_eng'		=> \Input::post('name_eng'),
									'description'	=> \Input::post('description'), 
								);


								$data['dataMember'] = array(
									'attendance_of_meeting'	=> \Input::post('attendance_of_meeting'),
									'proxy_of_meeting'		=> \Input::post('proxy_of_meeting'),
									'note'					=> \Input::post('note'),
								);

								try
								{
									\DB::start_transaction();

									//Update Baseofmember
									$update_baseofmember = \Model_Baseofmember::find($idBaseofmember);
									$update_baseofmember->type = \Input::post('type');
									$update_baseofmember->profile_flag = \Input::post('profile_flag');
									$update_baseofmember->name = \Input::post('name');
									$update_baseofmember->name_kana = \Input::post('name_kana');
									$update_baseofmember->name_eng = \Input::post('name_eng');
									$update_baseofmember->description = \Input::post('description');
									$update_baseofmember->save();

									\Session::set('dataMember',$idBaseofmember); 
									//Update member
									$id_member  = \DB::select('id')->from('members')
															->where('members.member_id', '=',$idBaseofmember)
															->where('members.deleted_at', 'IS',NULL)
								  							->as_object()->execute();

									$update_member = \Model_Member::find($id_member[0]->id);
									$update_member->attendance_of_meeting = \Input::post('attendance_of_meeting');
									$update_member->proxy_of_meeting = \Input::post('proxy_of_meeting');
									$update_member->note = \Input::post('note');
									$update_member->save();


								    //Update UserKeyTables
								    if(\Session::get('dataDelegate') != \Session::get('dataDelegate_old'))
								  	{
								  		$dataDelegate = \Session::get('dataDelegate');
								  		$dataDelegate_old = \Session::get('dataDelegate_old');

								  		//Update userkeytable
										$update_userkeytable = \DB::update('user_key_tables')
																->where('user_key_tables.connect_type', '=',1)
																->where('user_key_tables.member_id', '=',$idBaseofmember)
																->where('user_key_tables.deleted_at', 'IS',NULL);
										$update_userkeytable->set(array(
											'person_id'	=> $dataDelegate,
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_userkeytable->execute();

								  		//get value edit history old
										$edited_history_old = \DB::select('edited_history')->from('members')
											->where('member_id','=',$idBaseofmember)
											->where('members.deleted_at', 'IS',NULL)
											->execute();
								  		//Update edit history	
										$update_member =  \DB::update('members')
															->where('member_id','=',$idBaseofmember)
															->where('members.deleted_at', 'IS',NULL);
										$update_member->set(array(
											'edited_history' => date('Y-m-d').'代表者が'.\Session::get('username').'さんから変更になりました'."\n".$edited_history_old[0]['edited_history'],
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_member->execute();
									}

									if(\Session::get('dataMainCurator') != \Session::get('dataMainCurator_old'))
							        {

							        	$dataMainCurator = \Session::get('dataMainCurator');
							        	$dataMainCurator_old = \Session::get('dataMainCurator_old');

							        	//Update userkeytable
										$update_userkeytable = \DB::update('user_key_tables')
																->where('user_key_tables.connect_type', '=',11)
																->where('user_key_tables.member_id', '=',$idBaseofmember)
																->where('user_key_tables.deleted_at', 'IS',NULL);
										$update_userkeytable->set(array(
											'person_id'	=> $dataMainCurator,
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_userkeytable->execute();

										//get value edit history old
										$edited_history_old = \DB::select('edited_history')->from('members')
											->where('member_id','=',$idBaseofmember)
											->where('members.deleted_at', 'IS',NULL)
											->execute();
								  		//Update edit history	
										$update_member =  \DB::update('members')
															->where('member_id','=',$idBaseofmember)
															->where('members.deleted_at', 'IS',NULL);
										$update_member->set(array(
											'edited_history' => date('Y-m-d').'主担当が'.\Session::get('username').'さんから変更になりました'."\n".$edited_history_old[0]['edited_history'],
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_member->execute();

									}

									if(\Session::get('arrayNewSubCurator') !=NULL && \Session::get('arrayNewSubCurator_old') !=NULL)
									{
										
										$arrayNewSubCurator = \Session::get('arrayNewSubCurator');
										$arrayNewSubCurator_old = \Session::get('arrayNewSubCurator_old');
										
										if($arrayNewSubCurator != $arrayNewSubCurator_old)
										{		
									  		//Delete userkeytabel
									  		$update_deleted_at = \DB::update('user_key_tables')
				  								->where('user_key_tables.member_id', '=', $idBaseofmember)
												->where('user_key_tables.connect_type', '=',12)
												->where('user_key_tables.deleted_at', 'IS',NULL);
											$update_deleted_at->set(array(
											    'deleted_at' => date_timestamp_get(date_create()),
											));
											$update_deleted_at->execute();

											//Create Sub Curator current					
											for($i = 0; $i< count($arrayNewSubCurator); $i++)
											{
												$data_userkey_12_new = \Model_Userkeytable::forge(array(
													'member_id'		=> $idBaseofmember,
													'connect_type' 	=> 12,
													'person_id'		=> $arrayNewSubCurator[$i],
												));

												$data_userkey_12_new->save();
											}

											//get value edit history old
											$edited_history_old = \DB::select('edited_history')->from('members')
												->where('member_id','=',$idBaseofmember)
												->where('members.deleted_at', 'IS',NULL)
												->execute();
									  		//Update edit history	
											$update_member =  \DB::update('members')
																->where('member_id','=',$idBaseofmember)
																->where('members.deleted_at', 'IS',NULL);
											$update_member->set(array(
												'edited_history' => date('Y-m-d').'サブ担当が'.\Session::get('username').'さんから変更になりました'."\n".$edited_history_old[0]['edited_history'],
											    'updated_at' => date_timestamp_get(date_create()),
											));
											$update_member->execute();
										}

									}
									elseif(\Session::get('arrayNewSubCurator') == NULL && \Session::get('arrayNewSubCurator_old') !=NULL)
									{
										$arrayNewSubCurator = \Session::get('arrayNewSubCurator');

							  			//Delete user_key_table
			  							$update_deleted_at = \DB::update('user_key_tables')
			  								->where('user_key_tables.member_id', '=', $idBaseofmember)
											->where('user_key_tables.connect_type', '=',12)
											->where('user_key_tables.deleted_at', 'IS',NULL);
										$update_deleted_at->set(array(
										    'deleted_at' => date_timestamp_get(date_create()),
										));
										$update_deleted_at->execute();

										//get value edit history old
										$edited_history_old = \DB::select('edited_history')->from('members')
											->where('member_id','=',$idBaseofmember)
											->where('members.deleted_at', 'IS',NULL)
											->execute();
								  		//Update edit history	
										$update_member =  \DB::update('members')
															->where('member_id','=',$idBaseofmember)
															->where('members.deleted_at', 'IS',NULL);
										$update_member->set(array(
											'edited_history' => date('Y-m-d').'サブ担当が'.\Session::get('username').'さんから変更になりました。'."\n".$edited_history_old[0]['edited_history'],
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_member->execute();

									}
									elseif(\Session::get('arrayNewSubCurator') !=NULL && \Session::get('arrayNewSubCurator_old') ==NULL)
									{
										$arrayNewSubCurator = \Session::get('arrayNewSubCurator');
										for($i = 0; $i< count($arrayNewSubCurator); $i++)
										{
											$data_userkey_12_new = \Model_Userkeytable::forge(array(
												'member_id'		=> $idBaseofmember,
												'connect_type' 	=> 12,
												'person_id'		=> $arrayNewSubCurator[$i],
											));

											$data_userkey_12_new->save();
										}

										//get value edit history old
										$edited_history_old = \DB::select('edited_history')->from('members')
											->where('member_id','=',$idBaseofmember)
											->where('members.deleted_at', 'IS',NULL)
											->execute();
								  		//Update edit history	
										$update_member =  \DB::update('members')
															->where('member_id','=',$idBaseofmember)
															->where('members.deleted_at', 'IS',NULL);
										$update_member->set(array(
											'edited_history' => date('Y-m-d').'サブ担当が'.\Session::get('username').'さんから変更になりました。'."\n".$edited_history_old[0]['edited_history'],
										    'updated_at' => date_timestamp_get(date_create()),
										));
										$update_member->execute();

									}

									\DB::commit_transaction();

									\Session::delete('idBaseofmember');
									\Session::delete('dataBaseofmember');
									\Session::delete('dataDelegate');
									\Session::delete('dataDelegate_old');
									\Session::delete('dataMainCurator');
									\Session::delete('dataMainCurator_old');
									\Session::delete('arrayNewSubCurator');
									\Session::delete('arrayNewSubCurator_old');
								}
								catch(Exception $e)
								{
									// rollback pending transactional queries
									\DB::rollback_transaction();
									throw $e;
									\Session::set_flash('error', e(''));
									\Response::redirect('error/404');
								}

								//edit cuccess
								if(\Session::get('back_addmember') != NULL)
								{
									$back_addmember = \Session::get('back_addmember');
									\Session::set('checkurladdmember',\Uri::update_query_string());
									\Session::delete('back_addmember');
									\Response::redirect($back_addmember);
								}
								elseif (\Session::get('back_searchbaseofmember') != NULL) {
									$back_searchbaseofmember = \Session::get('back_searchbaseofmember');
									\Session::set('checkurlsearch',\Uri::update_query_string());
									\Session::delete('back_searchbaseofmember');
									\Response::redirect($back_searchbaseofmember);
								}
								elseif (\Session::get('back_searchlistbaseofmember') != NULL) {
									$back_searchlistbaseofmember = \Session::get('back_searchlistbaseofmember');
									\Session::set('checkurlsearchlist',\Uri::update_query_string());
									\Session::delete('back_searchlistbaseofmember');
									\Response::redirect($back_searchlistbaseofmember);
								}
								elseif(\Session::get('backToOfficerSetup') != NULL)
								{
									$backToOfficerSetup = \Session::get('backToOfficerSetup');
									\Session::set('checkUrlOfficerSetup',\Uri::update_query_string());
									\Session::delete('backToOfficerSetup');
									\Response::redirect($backToOfficerSetup);
								}
								elseif(\Session::get('backToOfficerEdit') != NULL)
								{
									$backToOfficerEdit = \Session::get('backToOfficerEdit');
									\Session::set('checkUrlOfficerEdit',\Uri::update_query_string());
									\Session::delete('backToOfficerEdit');
									\Response::redirect($backToOfficerEdit);
								}
								elseif(\Session::get('back_editmember') != NULL)
								{
									$back_editmember = \Session::get('back_editmember');
									\Session::set('checkurleditmember',\Uri::update_query_string());
									\Session::delete('back_editmember');
									\Response::redirect($back_editmember);
								}
								else
								{
									\Response::redirect('manager/dashboard/index');
								}
							}
							elseif(\Session::get('dataDelegate') == NULL && \Session::get('dataMainCurator') != NULL)
							{
								\Session::set_flash('error', '代表者の設定を行って下さい。');
								\Response::redirect('manager/members/edit');
							}
							elseif(\Session::get('dataMainCurator') == NULL && \Session::get('dataDelegate') != NULL)
							{
								\Session::set_flash('error', '主担当の設定を行って下さい。');
								\Response::redirect('manager/members/edit');
							}
							else
							{
								\Session::set_flash('error', '代表者と主担当設定を行って下さい。');
								\Response::redirect('manager/members/edit');
							}
						}
						else
						{
							\Session::set_flash('error', $val->error());
							\Response::redirect('manager/members/edit');
						}
						
					}
				}
			}
		}

		//Isset data Member in view
		if(\Session::get('dataBaseofmember') != NULL)
		{
			$data['dataBaseofmember']	= \Session::get('dataBaseofmember');
		}

		if(\Session::get('dataMember') != NULL)
		{
			$data['dataMember']	= \Session::get('dataMember');
		}

		//Isset data Delegate in view
		if (\Session::get('dataDelegate')) 
		{
			
			$dataDelegate		= \Session::get('dataDelegate');

			if($dataDelegate != NULL)
			{
				$data['dataDelegate'] = \Model_Person::find('all', array(
					'where' => array(array('id', '=', $dataDelegate))
				));
			}
			else
			{
				\Session::delete('dataDelegate');
			}
		}

		//Isset data Main Curator
		if(\Session::get('dataMainCurator'))
		{
			$dataMainCurator	= \Session::get('dataMainCurator');

			if($dataMainCurator != NULL)
			{
				$data['dataMainCurator'] = \Model_Person::find('all', array(
					'where' => array(array('id', '=', $dataMainCurator))
				));
			}
			else
			{
				\Session::delete('dataMainCurator');
			}
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
		$this->template->header = '会員編集';
		$this->template->title = '会員編集';
		$this->template->content = \View_Smarty::forge('members/edit.tpl',$data);
	}

	public function action_temp($id = NULL)
	{
		\Session::delete('arrayNewSubCurator');
        \Session::delete('arrayNewSubCurator_old');
        \Session::delete('idBaseofmember');
        \Session::delete('idSubCuratorSetting');
        \Session::delete('dataMember');
        \Session::delete('dataBaseofmember');

		$dataBaseofmember	= \Model_Baseofmember::find('all', array(
			'where' => array(array('id', '=', $id))
		));

		if($dataBaseofmember != NULL)
		{
			if(isset($id))	\Session::set('idBaseofmember',$id);
			foreach ($dataBaseofmember as $value) {
				$data['dataBaseofmember']['type']				= $value->type;
				$data['dataBaseofmember']['profile_flag']		= $value->profile_flag;
				$data['dataBaseofmember']['name_member']		= $value->name;
				$data['dataBaseofmember']['name_member_kana']	= $value->name_kana;
				$data['dataBaseofmember']['name_eng']			= $value->name_eng;
				$data['dataBaseofmember']['description']		= $value->description;
			}

			\Session::set('dataBaseofmember',$data['dataBaseofmember']);
		}
		else
		{
			\Response::redirect('error/404');
		}

		$dataMember		= \Model_Member::find('all', array(
			'where' => array(array('member_id', '=', $id))
		));

		if($dataMember != NULL)
		{
			foreach ($dataMember as $value)
			{
				$data['dataMember']['attendance_of_meeting']	= $value->attendance_of_meeting;
				$data['dataMember']['proxy_of_meeting']			= $value->proxy_of_meeting;
				$data['dataMember']['note']						= $value->note;
			}

			\Session::set('dataMember',$data['dataMember']);
		}

		$id_delegate	= \DB::select('user_key_tables.person_id')->from('user_key_tables')
			->join('persons')->on('persons.id','=','user_key_tables.person_id')
			->where('user_key_tables.member_id','=',$id)
			->where('user_key_tables.connect_type', '=', 1)
			->where('user_key_tables.deleted_at','IS',NULL)
			->where('persons.deleted_at','IS',NULL)
			->execute();

		if($id_delegate != NULL)
		{
			\Session::set('dataDelegate',$id_delegate[0]['person_id']);
			\Session::set('dataDelegate_old', $id_delegate[0]['person_id']);
		}

		$id_maincurator	= \DB::select('user_key_tables.person_id')->from('user_key_tables')
			->join('persons')->on('persons.id','=','user_key_tables.person_id')
			->where('user_key_tables.member_id','=',$id)
			->where('user_key_tables.connect_type', '=', 11)
			->where('user_key_tables.deleted_at','IS',NULL)
			->where('persons.deleted_at','IS',NULL)
			->execute();

		if($id_maincurator != NULL)
		{	
			\Session::set('dataMainCurator',$id_maincurator[0]['person_id']);
			\Session::set('dataMainCurator_old',$id_maincurator[0]['person_id']);
		}

		$id_subcurator = \DB::select('user_key_tables.person_id')->from('user_key_tables')
			->join('persons')->on('persons.id','=','user_key_tables.person_id')
			->where('user_key_tables.member_id','=',$id)
			->where('user_key_tables.connect_type', '=', 12)
			->where('user_key_tables.deleted_at','IS',NULL)
			->where('persons.deleted_at','IS',NULL)
			->execute();

		if(count($id_subcurator)!=0)
		{
			$arrayNewSubCurator = array();
			for($i = 0; $i < count($id_subcurator); $i++)
			{
				array_push($arrayNewSubCurator, $id_subcurator[$i]['person_id']);
			}

			\Session::set('arrayNewSubCurator',$arrayNewSubCurator);
			\Session::set('arrayNewSubCurator_old',$arrayNewSubCurator);
		}

		\Response::redirect('manager/members/edit');
	}

	public function action_delete()
	{

		if ($_POST)
		{
			if ( ! \Security::check_token())
    		{
				\Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/members/edit');
			}
			else
			{
				try
				{
					\DB::start_transaction();

					//Delete baseofmember
					$delete_baseofmember = \Model_Baseofmember::find(\Session::get('idBaseofmember'));
					$delete_baseofmember->delete();	
					
					//Delete member
					$delete_member = \DB::update('members')
										->where('member_id','=',\Session::get('idBaseofmember'))
										->where('members.deleted_at', 'IS',NULL);
					$delete_member->set(array(
						'deleted_at' => date_timestamp_get(date_create()),
					    'updated_at' => date_timestamp_get(date_create()),
					));
					$delete_member->execute();

					//Delete userkeytable
					$delete_userkeytable = \DB::update('user_key_tables')
										->where('member_id','=',\Session::get('idBaseofmember'))
										->where('deleted_at', 'IS',NULL);
					$delete_userkeytable->set(array(
						'deleted_at' => date_timestamp_get(date_create()),
					    'updated_at' => date_timestamp_get(date_create()),
					));
					$delete_userkeytable->execute();

					\DB::commit_transaction();

				}
				catch(Exception $e)
				{
					// rollback pending transactional queries
					\DB::rollback_transaction();
					throw $e;
					\Session::set_flash('error', e(' '));
					\Response::redirect('manager/members/edit');
				}
					\Session::delete('idBaseofmember');
					\Session::delete('dataBaseofmember');
					\Session::delete('dataMember');
					\Session::delete('dataDelegate');
					\Session::delete('dataDelegate_old');
					\Session::delete('dataMainCurator');
					\Session::delete('dataMainCurator_old');
					\Session::delete('arrayNewSubCurator');
					\Session::delete('arrayNewSubCurator_old');
					
					//\Session::set_flash('success', 'Delete Member success');
					//DELETE cuccess
				if(\Session::get('back_addmember') != NULL)
				{
					$back_addmember = \Session::get('back_addmember');
					\Session::delete('back_addmember');
					\Session::set('checkurladdmember',\Uri::update_query_string());
					\Response::redirect($back_addmember);
				}
				elseif (\Session::get('back_searchbaseofmember') != NULL) {
					$back_searchbaseofmember = \Session::get('back_searchbaseofmember');
					\Session::set('checkurlsearchlist',\Uri::update_query_string());
					\Session::delete('back_searchbaseofmember');
					\Response::redirect($back_searchbaseofmember);
				}
				elseif (\Session::get('back_searchlistbaseofmember') != NULL) {
					$back_searchlistbaseofmember = \Session::get('back_searchlistbaseofmember');
					\Session::set('checkurlsearchlist',\Uri::update_query_string());
					\Session::delete('back_searchlistbaseofmember');
					\Response::redirect($back_searchlistbaseofmember);
				}
				elseif(\Session::get('backToOfficerSetup') != NULL)
				{
					$backToOfficerSetup = \Session::get('backToOfficerSetup');
					\Session::set('checkUrlOfficerSetup',\Uri::update_query_string());
					\Session::delete('backToOfficerSetup');
					\Response::redirect($backToOfficerSetup);
				}
				elseif(\Session::get('backToOfficerEdit') != NULL)
				{
					$backToOfficerEdit = \Session::get('backToOfficerEdit');
					\Session::set('checkUrlOfficerEdit',\Uri::update_query_string());
					\Session::delete('backToOfficerEdit');
					\Response::redirect($backToOfficerEdit);
				}
				elseif(\Session::get('back_editmember') != NULL)
				{
					$back_editmember = \Session::get('back_editmember');
					\Session::set('checkurleditmember',\Uri::update_query_string());
					\Session::delete('back_editmember');
					\Response::redirect($back_editmember);
				}
				else
				{
					\Response::redirect('manager/dashboard/index');
				}
			}
		}
	}	

	public function action_reset()
	{
		$data = NULL;
		$this->template->header = '年度管理';
		$this->template->title = '年度管理';
		$this->template->content = \View_Smarty::forge('members/reset.tpl',$data);
	}

	public function action_resetAttendanceOfMeeting()
	{
		$dataMember = \DB::select('members.id')
		->from('members')
		->where('members.deleted_at', 'IS', NULL)
		->execute();
		
		if($dataMember != NULL)
		{
			for($i=0; $i<count($dataMember); $i++)
			{
				\Model_Member::find($dataMember[$i]['id'])
				->set(array(
					'attendance_of_meeting'	=> NULL
				))->save();
			}
		}
		$error = ' 総会の出席 のリセットを行いました。';
		\Session::set_flash('error', $error);

		\Response::redirect('manager/members/reset');
	}

	public function action_resetProxyOfMeeting()
	{
		$dataMember = \DB::select('members.id')
		->from('members')
		->where('members.deleted_at', 'IS', NULL)
		->execute();
		
		if($dataMember != NULL)
		{
			for($i=0; $i<count($dataMember); $i++)
			{
				\Model_Member::find($dataMember[$i]['id'])
				->set(array(
					'proxy_of_meeting'	=> NULL
				))->save();
			}
		}

		$error = ' 総会の委任状のリセットを行いました。';
		\Session::set_flash('error', $error);

		\Response::redirect('manager/members/reset');
	}

	public function action_setting() 
    {   

        $data['back'] = \Session::get('back');

        if(\Input::method() == 'POST') 
        {
            $member_flag = \Input::POST('member_flag');
            \Session::set('member_flag', $member_flag);
        }

        $this->template->header = '会員設定';
		$this->template->title = '会員設定';
		$this->template->content= \View_Smarty::forge('members/setting.tpl', $data);
	}

	public function action_search() 
    {
        $data['back'] = \Session::get('back');
        
        if(\Input::method() == 'GET')
        {
            $type    		= \Input::GET('type');
            $profile_flag   = \Input::GET('profile_flag');
            $name           = \Input::GET('name');
            $name_kana      = \Input::GET('name_kana');
            $name_eng       = \Input::GET('name_eng');
            $note           = \Input::GET('note');

            switch(\Input::GET('sort'))
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

            if($type == 0 && $profile_flag == null && $name == null && $name_kana == null && $name_eng == null && $note == null)
            {
				$query   = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.created_at')
                    ->from('base_of_members')
                    ->join('members', 'LEFT')
                    ->on('members.member_id', '=', 'base_of_members.id')
                    ->join('user_key_tables', 'LEFT')
                    ->on('members.member_id', '=', 'user_key_tables.member_id')
                    ->join('persons', 'LEFT')
                    ->on('user_key_tables.person_id', '=', 'persons.id')
                    ->where('base_of_members.deleted_at', 'IS', NULL)
                    ->where('members.deleted_at', 'IS', NULL)
                    ->where('user_key_tables.deleted_at', 'IS', NULL)
                    ->where('persons.deleted_at', 'IS', NULL);
            }
            else if($type != 0 && $profile_flag == null && $name == null && $name_kana == null && $name_eng == null && $note == null)
            {
            	$query   = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.created_at')
                    ->from('base_of_members')
                    ->join('members', 'LEFT')
                    ->on('members.member_id', '=', 'base_of_members.id')
                    ->join('user_key_tables', 'LEFT')
                    ->on('members.member_id', '=', 'user_key_tables.member_id')
                    ->join('persons', 'LEFT')
                    ->on('user_key_tables.person_id', '=', 'persons.id')
                    ->where('base_of_members.type', '=', $type)
                    ->where('base_of_members.name', 'LIKE', "%".$name."%")
                    ->where('base_of_members.name_eng', 'LIKE', "%".$name_eng."%")
                    ->where('base_of_members.name_kana', 'LIKE', "%".$name_kana."%")
                    ->where('base_of_members.deleted_at', 'IS', NULL)
                    ->where('members.deleted_at', 'IS', NULL);
            }
            else if($type == 0 && $profile_flag != null && $name == null && $name_kana == null && $name_eng == null && $note == null)
            {
            	$query   = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.created_at')
                    ->from('base_of_members')
                    ->join('members', 'LEFT')
                    ->on('members.member_id', '=', 'base_of_members.id')
                    ->join('user_key_tables', 'LEFT')
                    ->on('members.member_id', '=', 'user_key_tables.member_id')
                    ->join('persons', 'LEFT')
                    ->on('user_key_tables.person_id', '=', 'persons.id')
                    ->where('base_of_members.profile_flag', '=', $profile_flag)
                    ->where('base_of_members.name', 'LIKE', "%".$name."%")
                    ->where('base_of_members.name_eng', 'LIKE', "%".$name_eng."%")
                    ->where('base_of_members.name_kana', 'LIKE', "%".$name_kana."%")
                    ->where('base_of_members.deleted_at', 'IS', NULL)
                    ->where('members.deleted_at', 'IS', NULL);
            }
            else
            {
            	$query   = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.created_at')
                    ->from('base_of_members')
                    ->join('members', 'LEFT')
                    ->on('members.member_id', '=', 'base_of_members.id')
                    ->join('user_key_tables', 'LEFT')
                    ->on('members.member_id', '=', 'user_key_tables.member_id')
                    ->join('persons', 'LEFT')
                    ->on('user_key_tables.person_id', '=', 'persons.id')
                    ->where('base_of_members.type', '=', $type)
                    ->where('base_of_members.profile_flag', '=', $profile_flag)
                    ->where('base_of_members.name', 'LIKE', "%".$name."%")
                    ->where('base_of_members.name_eng', 'LIKE', "%".$name_eng."%")
                    ->where('base_of_members.name_kana', 'LIKE', "%".$name_kana."%")
                    ->where('base_of_members.deleted_at', 'IS', NULL)
                    ->where('members.deleted_at', 'IS', NULL);
            }

            if($note != NULL)
            {
            	$query = $query->where('members.note', 'LIKE', "%".$note."%");
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

			$data['member'] = $query->order_by($sort, $order)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();

            for($i=0; $i < count($data['member']); $i++)
            {
            	//Get the date time to display at search screen.
            	$current_timestamp = $data['member'][$i]->created_at;
                $current_year = \Date::forge($current_timestamp)->format("%Y");
                $current_month = \Date::forge($current_timestamp)->format("%m");
                $current_day = \Date::forge($current_timestamp)->format("%d");
                $current_date = $current_year.'年'.$current_month.'月'.$current_day.'日';
                $data['member'][$i]->created_at = $current_date;
            }

            $data['pagination'] = $pagination;
        }

        $this->template->header = '会員設定';
        $this->template->title = '会員設定';
        $this->template->content= \View_Smarty::forge('members/search.tpl', $data);
    }

  	public function action_view($id=NULL) 
    {
        $data['back'] = \Session::get('back');

        $dataMember     = \DB::select('base_of_members.id','base_of_members.type', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'base_of_members.description', 'base_of_members.profile_flag', 'members.attendance_of_meeting', 'members.proxy_of_meeting', 'members.note')
                            ->from('base_of_members')
                            ->join('members', 'LEFT')
                            ->on('members.member_id', '=', 'base_of_members.id')
                            ->and_where_open()
                                ->where('base_of_members.id', '=', $id)
                                ->where('base_of_members.deleted_at', 'IS', NULL)
                                ->where('members.deleted_at', 'IS', NULL)
                            ->and_where_close()
                            ->as_object()
                            ->execute();

        if($dataMember->as_array() != NULL)
        {
        	$data['member'] = $dataMember;
        	$member_name = $data['member'][0]->name;
        	$dataBaseofmember['name_member'] = $member_name;
        }

        $dataDirector     = \DB::select(array('persons.name', 'director_name'), array('persons.department', 'director_department'))
                            ->from('persons')
                            ->join('user_key_tables', 'LEFT')
                            ->on('user_key_tables.person_id', '=', 'persons.id')
                            ->and_where_open()
                                ->where('user_key_tables.member_id', '=', $id)
                                ->where('user_key_tables.connect_type', '=', 1)
                                ->where('persons.deleted_at', 'IS', NULL)
                                ->where('user_key_tables.deleted_at', 'IS', NULL)
                            ->and_where_close()
                            ->as_object()
                            ->execute();

        if($dataDirector->as_array() != NULL)
        {
        	$data['director'] = $dataDirector;
        }

        $dataMainCurator     = \DB::select('persons.name', 'persons.department', 'persons.email', 'persons.tel', 'persons.fax', 'persons.zip', 'persons.address01', 'persons.address02')
                            ->from('persons')
                            ->join('user_key_tables', 'LEFT')
                            ->on('user_key_tables.person_id', '=', 'persons.id')
                            ->and_where_open()
                                ->where('user_key_tables.member_id', '=', $id)
                                ->where('user_key_tables.connect_type', '=', 11)
                                ->where('persons.deleted_at', 'IS', NULL)
                                ->where('user_key_tables.deleted_at', 'IS', NULL)
                            ->and_where_close()
                            ->as_object()
                            ->execute();

        if($dataMainCurator->as_array() != NULL)
        {
        	$data['dataMainCurator'] = $dataMainCurator;
        }

        $dataSubCurator     = \DB::select('persons.name', 'persons.department', 'persons.email', 'persons.tel', 'persons.fax', 'persons.zip', 'persons.address01', 'persons.address02')
                            ->from('persons')
                            ->join('user_key_tables', 'LEFT')
                            ->on('user_key_tables.person_id', '=', 'persons.id')
                            ->and_where_open()
                                ->where('user_key_tables.member_id', '=', $id)
                                ->where('user_key_tables.connect_type', '=', 12)
                                ->where('persons.deleted_at', 'IS', NULL)
                                ->where('user_key_tables.deleted_at', 'IS', NULL)
                            ->and_where_close()
                            ->as_object()
                            ->execute();

        if($dataSubCurator->as_array() != NULL)
        {
        	$data['dataSubCurator'] = $dataSubCurator;
        }

        //Get session member flag  
        if(\Session::get('member_flag'))
        {
        	$member_flag = \Session::get('member_flag');
        }

        if(\Input::method() == 'POST') {
        	\Session::set('dataMember', $id);
            \Session::set('member_name', $member_name);
            \Session::set('dataBaseofmember', $dataBaseofmember);
            \Response::redirect($data['back']);
        }
        $this->template->header = '会員設定';
        $this->template->title = '会員設定';
        $this->template->content= \View_Smarty::forge('members/view.tpl', $data);   
    }

    public function action_deletesession()
    {
        $data['back'] = \Session::get('back');

        if(\Input::method() == 'POST')
        {
            \Session::delete('dataMember');
        }

        \Response::redirect($data['back']);

    }

}
