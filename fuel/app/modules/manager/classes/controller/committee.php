<?php

namespace Manager;

class Controller_Committee extends Controller_Base {

    public function before()
    {
        parent::before();
    }

    private static function get_all_committee()
    {

        $result = \DB::select('*')->from('committees')->execute();
        return $result;
    }

    private static function get_all_category()
    {
        $result = \DB::select('*')->from('categories')->as_object()->execute();
    }

    public function action_index()
    {
        // echo "<pre>";
        $data['list_committee_name']   = $this->get_all_committee()->as_array();



        $arraydata  = \Arr::assoc_to_keyval($data['list_committee_name'], 'id', 'committee_name');
        $arraykey = array_keys($arraydata);
        array_push($arraykey," ");
        $arrayvalue = array_values ($arraydata);
        array_push($arrayvalue,"");
        $data['list_committee_name'] = array_combine($arraykey,$arrayvalue);
        asort($data['list_committee_name']);
        if(\Input::method() == "POST")
        {
            // check for a valid CSRF token
            if ( ! \Security::check_token())
            {
                \Session::set_flash('error_CSRF',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/committee/index');
            }
            else
            {
                // token is valid, you can process the form input
                $val = \Model_Committee::validate('create');
                if ($val->run())
                {
                    $arrayName = array(
                            'parent_committee_id'   => \Input::post('parent_committee_id') ? \Input::post('parent_committee_id') : NULL,
                            'committee_name'        => \Input::post('committee_name'),
                            'committee_name_kana'   => \Input::post('committee_name_kana'),
                            'committee_name_eng'    => \Input::post('committee_name_eng'),
                            "selectable_officer"    => \Input::post('selectable_officer'),
                    );

                    for ($i=1; $i <= 20 ; $i++)
                    {
                        $i < 10 ? $n = "0{$i}" : $n = $i;
                            $second_array = array(
                                "custom_input_name{$n}"         => \Input::post("custom_input_name{$i}"),
                                "custom_input_type{$n}"         => \Input::post("custom_input_type{$i}"),
                                "custom_input_selectable{$n}"   => \Input::post("custom_input_selectable{$i}"),
                            );

                        $arrayName = array_merge((array)$arrayName, (array)$second_array);
                    }


                    $add_committee  = \Model_Committee::forge($arrayName);

                    $add_committee->save();

                    \Response::redirect('manager/committee/searchCommittee/');
                }
                else
                {
                    \Session::set_flash('error', $val->error());
                }
            }
        }

        $this->template->title = '委員会追加';
        $this->template->header = '委員会追加';
        $this->template->content = \View_Smarty::forge('committee/index.tpl',$data);

    }

    private static function get_committee_by_ID($id = null)
    {
        $result = \DB::select('*')->from('committees')->where('id', $id)->execute()->as_array();
        if($result == null)
        {
            \Response::redirect('error/404');
        }
        else
        {
            return $result;
        }
    }



    public function action_editCommittee($id = null)
    {
        $arrayNew =[];
        $list_committee_name = $this->get_all_committee()->as_array();

        $this->recursive($list_committee_name, $id, 1, $data['newArray']);
 
        if(count($data['newArray']) == 0)
        {
            $list_committee_name = \DB::select('*')->from('committees')->where('id', '!=', $id )->execute()->as_array();
        }
        else
        {
            $arrayID = [];
            for ($i=0; $i <count($data['newArray']) ; $i++)
            { 
                array_push($arrayID,$data['newArray'][$i]['id']);
            }

            $list_committee_name = \DB::select('*')->from('committees')->where('id', 'not in',$arrayID )->where('id', '!=', $id )->execute()->as_array();
        }
    

        $list_committee_name = \Arr::assoc_to_keyval($list_committee_name, 'id', 'committee_name');
        $list_committee_name['0'] = '';

        $data['get_committee_name'] = $list_committee_name;

        $data['get_committee_by_ID'] = $this->get_committee_by_ID($id)[0];

        if ($data['get_committee_by_ID']['parent_committee_id'] == "") $data['get_committee_by_ID']['parent_committee_id'] = 0;

        $this->template->title = '委員会編集';
        $this->template->header = '委員会編集';
        $this->template->content = \View_Smarty::forge('committee/edit.tpl',$data);
        if(\Input::method()== "POST")
        {
            if (!\Security::check_token())
            {
                \Session::set_flash('error_CSRF',  \Constants::$error_message['expired_csrf_token']);;
                \Response::redirect('manager/committee/editCommittee/'.$id);
            }
            else
            {
                $date = date_create();
                $query = \DB::update('committees')->where('id', $id);

                $arrayName = array(
                    'parent_committee_id'=> \Input::post('committee_id') ? \Input::post('committee_id') : NULL,
                    'committee_name' => \Input::post('committee_name'),
                    'committee_name_kana' => \Input::post('committee_name_kana'),
                    'committee_name_eng' => \Input::post('committee_name_eng'),
                    "selectable_officer" => \Input::post('selectable_officer'),
                    'updated_at'        => date_timestamp_get($date)
                );

                for ($i=1; $i <= 20 ; $i++)
                {
                    if($i < 10)
                        $n = "0{$i}";
                    else
                        $n = $i;
                        $second_array = array(
                            "custom_input_name{$n}" => \Input::post("custom_input_name{$i}"),
                            "custom_input_type{$n}" => \Input::post("custom_input_type{$i}"),
                            "custom_input_selectable{$n}" => \Input::post("custom_input_selectable{$i}"),
                        );

                    $arrayName = array_merge((array)$arrayName, (array)$second_array);
                }

                if($query->set($arrayName)->execute())
                {
                    \Session::set('id',$id);
                    \Response::redirect('manager/committee/menuCommittee/'.$id);
                }
                else
                {
                    \Session::set_flash('error', $val->error());
                    \Response::redirect('manager/committee/editCommittee/'.$id);
                }
            }
        }
    }


    private static function recursive($source, $parent, $level, &$newArray)
    {
        if(count($source) > 0)
        {
            foreach ($source as $key => $value)
            {
                if($value['parent_committee_id'] == $parent)
                {
                    $value['level'] = $level;
                    $newArray[]     = $value;
                    unset($source[$key]);
                    $newParent = $value['id'];
                    Controller_Committee::recursive($source, $newParent, $level + 1, $newArray);
                }
            }
        }   
    }

    // private static function recursive($source, $parent, &$newString)
    // {
    //     if(count($source) > 0)
    //     {
    //         $newString .= '<ul>';
    //         foreach ($source as $key => $value)
    //         {
    //             if($value['parent_id'] == $parent)
    //             {
    //                 $value['title'] = '<a href="category.php?cateid='.$value['id'].'">' . $value['title'] . '</a>';
    //                 $newString .= '<li>'. $value['title'];
    //                 unset($source[$key]);
    //                 $newParent = $value['id'];
    //                 Controller_Committee::recursive($source, $newParent, $newString);
    //                 $newString .= '</li>';
    //             }
    //         }
    //         $newString .= '</ul>';
    //     }
    // }



    public function action_searchCommittee()
    {

        $data['list_committee_name'] = $this->get_all_committee()->as_array();
        $menu = \DB::select('*')->from('committees')->execute()->as_array();

        $this->recursive($menu, 0, 1, $data['newArray']);


         $data['record_per_page'] =20;  
         $data['page'] = '';  
         // $output = '';  
        // echo \Input::get('page');

         if(\Input::method()== "GET")  
         {  
             $data['page'] = \Input::get('page');  
         }  
         if($data['page'] != NULL)
         {
             $data['page'] = \Input::get('page'); 
         }
         else
         {
           $data['page'] = 1;
         }

        $this->template->title = '委員会検索';
        $this->template->header = '委員会検索';
        $this->template->content = \View_Smarty::forge('committee/searchCommittee.tpl', $data);
    }


    private static function list_committee($array,$parents)
    {
        foreach($array as $key => $value)
        {
            if($value['parent_id'] == $parents)
            {
                $value['level'] = $value['level'] + 1;
                $data['newArray'][] = $value;
                unset($menu[$key]);
            }
        }
    }

    public function action_menuCommittee($id = NULL)
    {

        $data['list_committee_name'] = $this->get_committee_by_ID($id);

        $this->template->title = '委員会管理';
        $this->template->header = '委員会管理';
        $this->template->content = \View_Smarty::forge('committee/menuCommittee.tpl', $data);
    }

   public function action_exportCSVcommitte($id = NULL)
    {
        if(\Input::method() == "POST" )
        {
            $attributesMemberCSV    =   \Input::post('attributesMemberCSV');
            $flatMemberCSV          =   \Input::post('flatMemberCSV');
            $nameMemberCSV          =   \Input::post('nameMemberCSV');
            $nameKanaMemberCSV      =   \Input::post('nameKanaMemberCSV');
            $namEngMemberCSV        =   \Input::post('namEngMemberCSV');
            $CustomCSV              =   \Input::post('CustomCSV');
            $repreInfoCSV           =   \Input::post('repreInfoCSV');
            $sortCSV                =   \Input::post('sortCSV');
            $historyCommentCSV      =   \Input::post('historyCommentCSV');
            $remarksCSV             =   \Input::post('remarksCSV');

            switch($sortCSV)
            {
                case'0':
                        $created_at =   'base_of_members.name_kana';
                        $asc        =   'asc';
                    break;
                case'1':
                        $created_at =   'base_of_members.name_kana';
                        $asc        =   'desc';
                    break;
                case'2':
                        $created_at =   'base_of_members.id';
                        $asc        =   'asc';
                    break;
                case'3':
                        $created_at =   'base_of_members.id';
                        $asc        =   'desc';
                    break;
                default:
                        $created_at =   '';
                        $asc        =   '';
                    break;
            }

            $data['manager_exportCSV'] = \DB::select('base_of_members.id', 'base_of_members.profile_flag', 'base_of_members.type', 'base_of_members.created_at', 'base_of_members.name', 'base_of_members.name_kana', 'base_of_members.name_eng', 'base_of_members.description', array('members_of_committees.note','memberofcommittees_note'), array('members_of_committees.edited_history', 'memberofcommittees_edit'), 'members_of_committees.cumstom_input01', 'members_of_committees.cumstom_input02', 'members_of_committees.cumstom_input03', 'members_of_committees.cumstom_input04', 'members_of_committees.cumstom_input05', 'members_of_committees.cumstom_input06', 'members_of_committees.cumstom_input07', 'members_of_committees.cumstom_input08', 'members_of_committees.cumstom_input09', 'members_of_committees.cumstom_input10', 'members_of_committees.cumstom_input11', 'members_of_committees.cumstom_input12', 'members_of_committees.cumstom_input13', 'members_of_committees.cumstom_input14', 'members_of_committees.cumstom_input15', 'members_of_committees.cumstom_input16', 'members_of_committees.cumstom_input17', 'members_of_committees.cumstom_input18', 'members_of_committees.cumstom_input19', 'members_of_committees.cumstom_input20',  array('persons.name','person_name'), array('persons.department','person_department') , array('persons.name_kana','pserson_name_kana'), array('persons.email','person_email'), array('persons.tel','person_tel'), array('persons.fax','person_fax'), array('persons.zip','person_zip'), array('persons.address01','person_address01'), array('persons.address02','person_address02'), array('persons.updated_at','person_updated') )
                        ->from('base_of_members')->join('members_of_committees')->on('base_of_members.id', '=', 'members_of_committees.member_id')
                        ->join('user_key_tables')->on('members_of_committees.member_id', '=', 'user_key_tables.member_id')->on('members_of_committees.committee_id', '=', 'user_key_tables.committee_id')
                        ->join('persons')->on('user_key_tables.person_id', '=' , 'persons.id')
                        ->where('members_of_committees.committee_id', '=',$id)
                        ->order_by($created_at, $asc)
                        ->execute();


                $data['searchlist']                              = array();
                $data['searchlist']['type']                      = NULL;
                $data['searchlist']['profile_flag']              = NULL;
                $data['searchlist']['name']                      = NULL;
                $data['searchlist']['name_kana']                 = NULL;
                $data['searchlist']['name_eng']                  = NULL;
                $data['searchlist']['memberofcommittees_edit']   = NULL;
                $data['searchlist']['memberofcommittees_note']   = NULL;
                $data['searchlist']['cumstom_input01']           = NULL;
                $data['searchlist']['cumstom_input02']           = NULL;
                $data['searchlist']['cumstom_input03']           = NULL;
                $data['searchlist']['cumstom_input04']           = NULL;
                $data['searchlist']['cumstom_input05']           = NULL;
                $data['searchlist']['cumstom_input06']           = NULL;
                $data['searchlist']['cumstom_input07']           = NULL;
                $data['searchlist']['cumstom_input08']           = NULL;
                $data['searchlist']['cumstom_input09']           = NULL;
                $data['searchlist']['cumstom_input10']           = NULL;
                $data['searchlist']['cumstom_input11']           = NULL;
                $data['searchlist']['cumstom_input12']           = NULL;
                $data['searchlist']['cumstom_input13']           = NULL;
                $data['searchlist']['cumstom_input14']           = NULL;
                $data['searchlist']['cumstom_input15']           = NULL;
                $data['searchlist']['cumstom_input16']           = NULL;
                $data['searchlist']['cumstom_input17']           = NULL;
                $data['searchlist']['cumstom_input18']           = NULL;
                $data['searchlist']['cumstom_input19']           = NULL;
                $data['searchlist']['cumstom_input20']           = NULL;
                $data['searchlist']['name_memberof']             = NULL;
                $data['searchlist']['department_memberof']       = NULL;
                $data['searchlist']['email_memberof']            = NULL;
                $data['searchlist']['tel_memberof']              = NULL;
                $data['searchlist']['fax_memberof']              = NULL;
                $data['searchlist']['zip_memberof']              = NULL;
                $data['searchlist']['address01_memberof']        = NULL;
                $data['searchlist']['address02_memberof']        = NULL;


            foreach ($data['manager_exportCSV'] as $item)
            {

                if($attributesMemberCSV == 'attributesMemberCSV')
                {
                    $data['searchlist']['type'] = $item['type'];
                    switch($data['searchlist']['type'])
                    {
                        case'0':
                            $data['searchlist']['type'] = mb_convert_encoding('なし', "SJIS");
                            break;
                        case'1':
                            $data['searchlist']['type'] = mb_convert_encoding('企業', "SJIS");
                            break;
                        case'2':
                            $data['searchlist']['type'] = mb_convert_encoding('団体', "SJIS");
                            break;
                        case'3':
                            $data['searchlist']['type'] = mb_convert_encoding('研究機関', "SJIS");
                            break;
                        case'4':
                            $data['searchlist']['type'] = mb_convert_encoding('個人', "SJIS");
                            break;
                        default:
                            $data['searchlist']['type'] = mb_convert_encoding('地方自治体', "SJIS");
                            break;
                    }
                }
                if($flatMemberCSV == 'flatMemberCSV')
                {
                    $data['searchlist']['profile_flag'] = $item['profile_flag'];
                    switch($data['searchlist']['profile_flag'])
                    {
                        case'0':
                            $data['searchlist']['profile_flag'] = mb_convert_encoding('RRI会員ではない', "SJIS");
                            break;
                        default:
                            $data['searchlist']['profile_flag'] = mb_convert_encoding('RRI会員', "SJIS");
                            break;
                    }
                }
                if($nameMemberCSV == 'nameMemberCSV')
                {
                    $data['searchlist']['name'] = $item['name'];
                    $data['searchlist']['name'] = mb_convert_encoding($data['searchlist']['name'], "SJIS");
                }
                if($nameKanaMemberCSV == 'nameKanaMemberCSV')
                {
                    $data['searchlist']['name_kana'] = $item['name_kana'];
                    $data['searchlist']['name_kana'] = mb_convert_encoding($data['searchlist']['name_kana'], "SJIS");
                }
                if($namEngMemberCSV == 'namEngMemberCSV')
                {
                    $data['searchlist']['name_eng']  = $item['name_eng'];
                    $data['searchlist']['name_eng'] = mb_convert_encoding($data['searchlist']['name_eng'], "SJIS");
                }
                if($repreInfoCSV == 'repreInfoCSV')
                {
                    $data['searchlist']['name_memberof']         = $item['person_name'];
                    $data['searchlist']['department_memberof']   = $item['person_department'];
                    $data['searchlist']['email_memberof']        = $item['person_email'];
                    $data['searchlist']['tel_memberof']          = $item['person_tel'];
                    $data['searchlist']['fax_memberof']          = $item['person_fax'];
                    $data['searchlist']['zip_memberof']          = $item['person_zip'];
                    $data['searchlist']['address01_memberof']    = $item['person_address01'];
                    $data['searchlist']['address02_memberof']    = $item['person_address02'];
                    $data['searchlist']['name_memberof']         = mb_convert_encoding($data['searchlist']['name_memberof'], "SJIS");
                    $data['searchlist']['department_memberof']   = mb_convert_encoding($data['searchlist']['department_memberof'], "SJIS");
                    $data['searchlist']['email_memberof']        = mb_convert_encoding($data['searchlist']['email_memberof'], "SJIS");
                    $data['searchlist']['tel_memberof']          = mb_convert_encoding($data['searchlist']['tel_memberof'], "SJIS");
                    $data['searchlist']['fax_memberof']          = mb_convert_encoding($data['searchlist']['fax_memberof'], "SJIS");
                    $data['searchlist']['zip_memberof']          = mb_convert_encoding($data['searchlist']['zip_memberof'], "SJIS");
                    $data['searchlist']['address01_memberof']    = mb_convert_encoding($data['searchlist']['address01_memberof'], "SJIS");
                    $data['searchlist']['address02_memberof']    = mb_convert_encoding($data['searchlist']['address02_memberof'], "SJIS");
                }
                if($historyCommentCSV == 'historyCommentCSV')
                {
                    $data['searchlist']['memberofcommittees_edit'] = $item['memberofcommittees_edit'];
                    $data['searchlist']['memberofcommittees_edit'] = mb_convert_encoding($data['searchlist']['memberofcommittees_edit'], "SJIS");
                }
                if($remarksCSV == 'remarksCSV')
                {
                    $data['searchlist']['memberofcommittees_note'] = $item['memberofcommittees_note'];
                    $data['searchlist']['memberofcommittees_note'] = mb_convert_encoding($data['searchlist']['memberofcommittees_note'], "SJIS");
                }

                if($CustomCSV == 'CustomCSV')
                {
                    $data['searchlist']['cumstom_input01'] = $item['cumstom_input01'];
                    $data['searchlist']['cumstom_input02'] = $item['cumstom_input02'];
                    $data['searchlist']['cumstom_input03'] = $item['cumstom_input03'];
                    $data['searchlist']['cumstom_input04'] = $item['cumstom_input04'];
                    $data['searchlist']['cumstom_input05'] = $item['cumstom_input05'];
                    $data['searchlist']['cumstom_input06'] = $item['cumstom_input06'];
                    $data['searchlist']['cumstom_input07'] = $item['cumstom_input07'];
                    $data['searchlist']['cumstom_input08'] = $item['cumstom_input08'];
                    $data['searchlist']['cumstom_input09'] = $item['cumstom_input09'];
                    $data['searchlist']['cumstom_input10'] = $item['cumstom_input10'];
                    $data['searchlist']['cumstom_input11'] = $item['cumstom_input11'];
                    $data['searchlist']['cumstom_input12'] = $item['cumstom_input12'];
                    $data['searchlist']['cumstom_input13'] = $item['cumstom_input13'];
                    $data['searchlist']['cumstom_input14'] = $item['cumstom_input14'];
                    $data['searchlist']['cumstom_input15'] = $item['cumstom_input15'];
                    $data['searchlist']['cumstom_input16'] = $item['cumstom_input16'];
                    $data['searchlist']['cumstom_input17'] = $item['cumstom_input17'];
                    $data['searchlist']['cumstom_input18'] = $item['cumstom_input18'];
                    $data['searchlist']['cumstom_input19'] = $item['cumstom_input19'];
                    $data['searchlist']['cumstom_input20'] = $item['cumstom_input20'];
                    $data['searchlist']['cumstom_input01'] = mb_convert_encoding($data['searchlist']['cumstom_input01'], "SJIS");
                    $data['searchlist']['cumstom_input02'] = mb_convert_encoding($data['searchlist']['cumstom_input02'], "SJIS");
                    $data['searchlist']['cumstom_input03'] = mb_convert_encoding($data['searchlist']['cumstom_input03'], "SJIS");
                    $data['searchlist']['cumstom_input04'] = mb_convert_encoding($data['searchlist']['cumstom_input04'], "SJIS");
                    $data['searchlist']['cumstom_input05'] = mb_convert_encoding($data['searchlist']['cumstom_input05'], "SJIS");
                    $data['searchlist']['cumstom_input06'] = mb_convert_encoding($data['searchlist']['cumstom_input06'], "SJIS");
                    $data['searchlist']['cumstom_input07'] = mb_convert_encoding($data['searchlist']['cumstom_input07'], "SJIS");
                    $data['searchlist']['cumstom_input08'] = mb_convert_encoding($data['searchlist']['cumstom_input08'], "SJIS");
                    $data['searchlist']['cumstom_input09'] = mb_convert_encoding($data['searchlist']['cumstom_input09'], "SJIS");
                    $data['searchlist']['cumstom_input10'] = mb_convert_encoding($data['searchlist']['cumstom_input10'], "SJIS");
                    $data['searchlist']['cumstom_input11'] = mb_convert_encoding($data['searchlist']['cumstom_input11'], "SJIS");
                    $data['searchlist']['cumstom_input12'] = mb_convert_encoding($data['searchlist']['cumstom_input12'], "SJIS");
                    $data['searchlist']['cumstom_input13'] = mb_convert_encoding($data['searchlist']['cumstom_input13'], "SJIS");
                    $data['searchlist']['cumstom_input14'] = mb_convert_encoding($data['searchlist']['cumstom_input14'], "SJIS");
                    $data['searchlist']['cumstom_input15'] = mb_convert_encoding($data['searchlist']['cumstom_input15'], "SJIS");
                    $data['searchlist']['cumstom_input16'] = mb_convert_encoding($data['searchlist']['cumstom_input16'], "SJIS");
                    $data['searchlist']['cumstom_input17'] = mb_convert_encoding($data['searchlist']['cumstom_input17'], "SJIS");
                    $data['searchlist']['cumstom_input18'] = mb_convert_encoding($data['searchlist']['cumstom_input18'], "SJIS");
                    $data['searchlist']['cumstom_input19'] = mb_convert_encoding($data['searchlist']['cumstom_input19'], "SJIS");
                    $data['searchlist']['cumstom_input20'] = mb_convert_encoding($data['searchlist']['cumstom_input20'], "SJIS");

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
            if($historyCommentCSV == 'historyCommentCSV')
            {
                array_push($arrayExportCsv,'memberofcommittees_edit');
            }
            if($remarksCSV == 'remarksCSV')
            {
                array_push($arrayExportCsv,'memberofcommittees_note');
            }
            if($repreInfoCSV == 'repreInfoCSV')
            {
                array_push($arrayExportCsv,'name_memberof','department_memberof', 'email_memberof', 'tel_memberof', 'fax_memberof', 'zip_memberof', 'address01_memberof', 'address02_memberof');
            }
            if($CustomCSV == 'CustomCSV')
            {
                array_push($arrayExportCsv,'cumstom_input01','cumstom_input02', 'cumstom_input03', 'cumstom_input04', 'cumstom_input05', 'cumstom_input06', 'cumstom_input07', 'cumstom_input08', 'cumstom_input09','cumstom_input10', 'cumstom_input11', 'cumstom_input12', 'cumstom_input13', 'cumstom_input14', 'cumstom_input15', 'cumstom_input16', 'cumstom_input17', 'cumstom_input18', 'cumstom_input19', 'cumstom_input20');
            }


            $array = [];
            for ($i=0; $i <count($arrayExportCsv); $i++)
            {
                array_push($array,$data['searchlist'][$arrayExportCsv[$i]]);
            }
            array_push($arrayBigExportCsv,$array);


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
        $this->template->content = \View_Smarty::forge('committee/exportCSVcommitte.tpl');
    }


}

/* End of file committee.php */

        // if(\Input::method() == 'GET')
        // {
        //     $id_committe = \Input::get('committe_select');
        //     if(isset($id_committe))
        //     {
        //         $menu = \DB::select('*')->from('committees')->execute()->as_array();
        //         $this->recursive($menu, $id_committe, 1, $data['newArray']);
                
        //     }
        //     else
        //     {
        //         $menu = \DB::select('*')->from('committees')->execute()->as_array();
        //         $this->recursive($menu, 0, 1, $data['newArray']);
        //     }
        // }

        // $this->recursive($menu, 0, $newString);
        // $newString = str_replace('<ul></ul>', '', $newString);
        // echo $newString;exit;

        // foreach($menu as $key => $value)
        // {
        //     if($value['parent_id'] == 0)
        //     {
        //         $value['level'] = 1;
        //         $data['newArray'][] = $value;
        //         unset($menu[$key]);
                
        //         $parents = $value['id'];
        //         foreach($menu as $key_1 => $value_1)
        //         {
        //             if($value_1['parent_id'] == $parents)
        //             {
        //                 $value_1['level'] = $value['level'] + 1;
        //                 $data['newArray'][] = $value_1;
        //                 unset($menu[$key_1]);
                    
        //                 $parents_1 = $value_1['id'];
        //                 foreach($menu as $key_2 => $value_2)
        //                 {
        //                     if($value_2['parent_id'] == $parents_1)
        //                     {
        //                         $value_2['level'] = $value_1['level'] + 1;
        //                         $data['newArray'][]     = $value_2;
        //                         unset($menu[$key_2]);

        //                         $parents_2 = $value_2['id'];
        //                         foreach($menu as $key_3 => $value_3)
        //                         {
        //                             if($value_3['parent_id'] == $parents_2)
        //                             {
        //                                 $value_3['level'] = $value_2['level'] + 1;
        //                                 $data['newArray'][] = $value_3;
        //                                 unset($menu[$key_3]);
        //                             }
        //                         }

        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }

        // echo "<pre>";
        // var_dump($data['newArray']);exit;