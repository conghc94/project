<?php 

namespace Manager;

class Controller_Persons extends Controller_Base {

    public function action_editinfo($id=NULL)
    {
        $data['back'] = \Session::get('back');

        $data['member'] = \DB::select('persons.*', array('base_of_members.name', 'member_name'))
            ->from('persons')
            ->join('user_key_tables','LEFT')
            ->on('user_key_tables.person_id', '=', 'persons.id')
            ->join('base_of_members','LEFT')
            ->on('base_of_members.id', '=', 'user_key_tables.member_id')
            ->where('persons.id', '=', $id)
            ->where('persons.deleted_at', 'IS', NULL)
            ->where('user_key_tables.deleted_at', 'IS', NULL)
            ->where('base_of_members.deleted_at', 'IS', NULL)
            ->as_object()
            ->limit(1)
            ->execute();

        if($data['member'][0]->member_name == NULL && \Session::get('dataBaseofmember') != NULL)
        { 
            $baseofmember = \Session::get('dataBaseofmember');
            $data['member'][0]->member_name = $baseofmember['name_member'];
        }

        if($data['member']->as_array() == NULL)
        {
            \Response::redirect('error/404');
        }

        if ($_POST)
        {   
            if ( ! \Security::check_token())
            {    
                \Session::set_flash('error',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/officers/editinfo/'.$id);
            }   
            else   
            {
                if(\Input::post('del')) 
                {
                    $arr = \DB::update('persons')->where('persons.id', '=', $id);
                    $arr->set(array(
                        'persons.deleted_at' =>  date_timestamp_get(date_create()),
                        'persons.updated_at' =>  date_timestamp_get(date_create()),
                    ))->execute();

                    if(\Session::get('dataOfficer') && \Session::get('dataOfficer') == $id)
                    {
                        \Session::delete('dataOfficer');
                    }

                    if(\Session::get('dataMainCurator') && \Session::get('dataMainCurator') == $id)
                    {
                        \Session::delete('dataMainCurator');
                    }

                    if(\Session::get('dataCommittee') && \Session::get('dataCommittee') == $id)
                    {
                        \Session::delete('dataCommittee');
                    }

                    if(\Session::get('dataDelegate') && \Session::get('dataDelegate') == $id)
                    {
                        \Session::delete('dataDelegate');
                    }

                    if(\Session::get('arrayNewSubCurator'))
                    {
                        $arraySubCurator = \Session::get('arrayNewSubCurator');
                        for($i=0; $i<count($arraySubCurator); $i++)
                        {
                            if($arraySubCurator[$i] == $id)
                            {
                                array_splice($arraySubCurator, $i, 1);
                            }
                        }
                        \Session::set('arrayNewSubCurator', $arraySubCurator);
                    }

                    \Response::redirect($data['back']);
                }

                if(\Input::post('send'))
                {
                    $val = \Model_Person::validate('edit');

                    if ($val->run())
                    {
                        $department     = \Input::post('department');
                        $name           = \Input::post('name');
                        $name_kana      = \Input::post('name_kana');
                        $email          = \Input::post('email');
                        $tel            = \Input::post('tel');
                        $fax            = \Input::post('fax');
                        $zip            = \Input::post('zip');
                        $address01      = \Input::post('address01');
                        $address02      = \Input::post('address02');
                        $published_site_id = \Input::post('published_site_id');
                        $type_of_ml     = \Input::post('type_of_ml');

                        \DB::update('persons')->set(array(
                            'department' => $department,
                            'name'       => $name,
                            'name_kana'  => $name_kana,
                            'email'      => $email,
                            'tel'        => $tel,
                            'fax'        => $fax,
                            'zip'        => $zip,
                            'address01'  => $address01,
                            'address02'  => $address02,
                            'published_site_id' => $published_site_id,
                            'type_of_ml' => $type_of_ml,
                            'updated_at' => date_timestamp_get(date_create())
                        )) 
                        ->where('persons.id', '=', $id)
                        ->execute();

                        $data['member'] = \DB::select('persons.id','persons.name','persons.name_kana','persons.department','persons.email','persons.tel','persons.fax','persons.zip','persons.address01','persons.address02','persons.published_site_id','persons.type_of_ml',array('base_of_members.name', 'member_name'),array('base_of_members.name_kana', 'name_member_kana'),'user_key_tables.connect_type')
                                ->from('persons')
                                ->join('user_key_tables','LEFT')
                                ->on('user_key_tables.person_id', '=', 'persons.id')
                                ->join('base_of_members','LEFT')->on('base_of_members.id', '=', 'user_key_tables.member_id')
                                ->and_where_open()
                                    ->where('persons.id','=', $id)
                                ->and_where_close()
                                ->as_object()
                                ->execute();

                        \Response::redirect($data['back']);
                    }
                    else
                    {
                        \Session::set_flash('error', $val->error());
                    }   
                }

            }
        }

        $this->template->header  = 'メンバー編集';
        $this->template->title = 'メンバー編集';
        $this->template->content = \View_Smarty::forge('persons/editinfo.tpl', $data);
    }

}