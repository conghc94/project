<?php

namespace Manager;

class Controller_Delegates extends Controller_Base {

	public function action_setting()
	{
		$data = NULL;

		if(\Session::get('dataBaseofmember') == NULL)
		{
			\Response::redirect('error/404');
		}

		if(\Session::get('back'))
		{
			$data['back'] = \Session::get('back');
		}

		$this->template->header  = '代表者設定';
		$this->template->title = '代表者設定';
		$this->template->content = \View_Smarty::forge('delegates/setting.tpl', $data);
	}

	public function action_search()
	{	
		if(\Session::get('dataBaseofmember') == NULL)
		{
			\Response::redirect('error/404');
		}

		if(\Session::get('back'))
		{
			$data['back'] = \Session::get('back');
		}


		if(\Input::method() == 'GET' )
		{
			$name_member			=	\Input::get('name_member');
			$name					=	\Input::get('name');
			$department				=	\Input::get('department');
			$email					=	\Input::get('email');
			$sort_order				=	\Input::get('sort');

			switch($sort_order)
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

			$query =\DB::select('persons.id','persons.name','persons.department','persons.email','persons.tel',
							'persons.fax','persons.address01',array('base_of_members.name', 'name_member'),
							array('base_of_members.name_kana', 'name_member_kana'),'user_key_tables.connect_type',array('user_key_tables.id', 'id_userkey'))
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

			$data['count_sear'] = count($query->order_by($created_at, $asc)->distinct()->execute());

			if($data['count_sear'] < 1)
		   	{
				\Session::set_flash('error', '一致するレコードが見つかりません');
		   	}

			$config = array(
				'pagination_url' => \Uri::update_query_string(),
				'total_items'	 => $data['count_sear'],
				'num_links' 	 => 4,
				'per_page'		 => 20,
				'uri_segment'	 => 'page',
			);

			$pagination = \Pagination::forge('mypagination', $config);

			\Session::set('backUrl', \Uri::update_query_string());

			$data['delegates'] = $query->order_by($created_at, $asc)->offset($pagination->offset)->limit($pagination->per_page)->distinct()->as_object()->execute();
			$data['pagination'] = $pagination;
		}

		$this->template->header  = '代表者設定';
		$this->template->title = '代表者設定';
		$this->template->content = \View_Smarty::forge('delegates/search.tpl', $data);
	}

	public function action_view() {

		if(\Session::get('dataBaseofmember') == NULL)
		{
			\Response::redirect('error/404');
		}

		if(\Session::get('back'))
		{
			$data['back'] = \Session::get('back');
		}

		$data['dataBaseofmember'] = \Session::get('dataBaseofmember');	

		$id 	= \Input::get('id');	

		if( $id != NULL ){

			$data['dataDelegate'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $id))
			));
		}
		
		if(\Input::method() == "POST")
		{
			$id = \Input::POST('id');
			
			$data['dataDelegate'] = \Model_Person::find('all', array(
				'where' => array(array('id', '=', $id))
			));

			\Session::set('dataDelegate',$id);

			\Response::redirect($data['back']);
		}

		$this->template->header  = '代表者追加';
		$this->template->title = '代表者追加';
		$this->template->content = \View_Smarty::forge('delegates/view.tpl', $data);
	}

	public function action_create() {

		if(\Session::get('dataBaseofmember') == NULL)
		{
			\Response::redirect('error/404');
		}

		if(\Session::get('back'))
		{
			$data['back'] = \Session::get('back');
		}

		$data['dataBaseofmember']	= \Session::get('dataBaseofmember');
		
			if (\Input::method() == 'POST') 
			{
				$val	= \Model_Person::validate('create');

				if ($val->run())
				{

					$delegate_person	= \Model_Person::forge(array(
						'department'		=> \Input::post('department'),
						'name'				=> \Input::post('name'),
						'name_kana'			=> \Input::post('name_kana'),
						'email'				=> \Input::post('email'),
						'tel'				=> \Input::post('tel'),
						'fax'				=> \Input::post('fax'),
						'zip'				=> \Input::post('zip'),
						'address01'			=> \Input::post('address01'),
						'address02'			=> \Input::post('address02'),
						'published_site_id' => \Input::post('published_site_id'),
						'type_of_ml'		=> \Input::post('type_of_ml'),
					));

					$delegate_person->save();

					\Session::set('dataDelegate',$delegate_person->id);

					//\Session::set_flash('success', e(''));
					\Response::redirect($data['back']);
			}
			else
			{
				\Session::set_flash('error', $val->error());
			}
		}
		
		$this->template->header  = '代表者追加';
		$this->template->title = '代表者追加';
		$this->template->content = \View_Smarty::forge('delegates/create.tpl', $data);
	}
	
	public function action_delete()
	{
		if(\Session::get('dataBaseofmember') == NULL)
		{
			\Response::redirect('error/404');
		}

		$link = \Session::get('back');

		((\Input::post('delete_delegate')) && (\Session::get('dataDelegate'))) and \Session::delete('dataDelegate');

		\Response::redirect($link);
	}

}