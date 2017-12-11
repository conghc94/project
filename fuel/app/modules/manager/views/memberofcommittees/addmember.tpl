<section class="content">
[+Asset::css(array('site/addmember.css'))+]
    <div class="row">
        <div class="col-lg-8 col-xs-8 row-left">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">

                    [+if Session::get_flash('error') +]
                        [+$error = Session::get_flash('error') +]
                        <div class="row">
                            <div class="col-md-8 col-md-offset-3">
                                <div class="alert alert-danger alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <strong>エラーがありました。</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
                                </div>
                            </div>
                        </div>
                    [+/if +]

                    [+if Session::get_flash('success') +]
                        [+$success = Session::get_flash('success') +]
                        <div class="row">
                            <div class="col-md-8 col-md-offset-3">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <strong>おめでとうございます</strong>[+foreach $success as $one+]<br>[+$one+][+/foreach+]
                                </div>
                            </div>
                        </div>
                    [+/if +]

                    [+assign var = formset 
                    value = ['name' => 'addMember',
                    'method'    => 'post',
                    'action'    => '', 
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'addMember'
                    ]+]

                    [+Form::open($formset)+]
                        <div class="form-group">
                            <div class ="col-md-9">
                                <div class="col-md-12">
                                    <div class="col-md-4 col-md-offset-1">
                                        <label class="control-common-label">役職</label>
                                    </div>
                                    <div class="col-md-7">
                                        <select name="officer_in_commitee" id="officer_in_commitee" class="form-control">
                                        [+if isset($data_selectable_officer)+]
                                            [+for $i=0 to (count($data_selectable_officer)-1)+]
                                            [+if isset($dataMemberofcommittees['officer_in_commitee']) && ($dataMemberofcommittees['officer_in_commitee'] == $data_selectable_officer[$i])+]
                                                <option value="[+$data_selectable_officer[$i]+]" selected="true">[+$data_selectable_officer[$i]+]</option>
                                            [+else+]
                                                 <option value="[+$data_selectable_officer[$i]+]" >[+$data_selectable_officer[$i]+]</option>
                                            [+/if+]
                                            [+/for+]
                                        [+else+]
                                            <option value="役職なし">役職なし</option>
                                        [+/if+]
                                        </select>
                                    </div>
                                </div>
                                [+if isset($dataMember)+]
                                    [+foreach $dataMember as $key => $item+]
                                        <div class="col-md-12">
                                            <div class="col-md-4 col-md-offset-1">
                                                <label class="control-common-label">会員属性</label>
                                            </div>
                                            <div class="col-md-7">
                                                [+if ($item->type == 0)+]
                                                    <label class="control-common-label">なし</label>
                                                [+elseif ($item->type == 1)+]
                                                    <label class="control-common-label">企業</label>
                                                [+elseif ($item->type == 2)+]
                                                    <label class="control-common-label">団体</label>
                                                [+elseif ($item->type == 3)+]
                                                    <label class="control-common-label">研究機関</label>
                                                [+elseif ($item->type == 4)+]
                                                    <label class="control-common-label">個人</label>
                                                [+else+]
                                                    <label class="control-common-label">地方自治体</label>
                                                [+/if+]
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="col-md-4 col-md-offset-1">
                                                <label class="control-common-label">会員名称</label>
                                            </div>
                                            <div class="col-md-7">
                                             <label class="control-common-label">[+(strlen($item->name) > 25) ? Str::truncate($item->name, 20, '...') : $item->name+]</label>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="col-md-4 col-md-offset-1">
                                                <label class="control">会員名称(ふりがな)</label>
                                            </div>
                                            <div class="col-md-7">
                                                <label class="control-common-label">[+(strlen($item->name_kana) > 25) ? Str::truncate($item->name_kana, 20, '...') : $item->name_kana+]</label>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="col-md-4 col-md-offset-1">
                                                <label class="control">会員名称(英語)</label>
                                            </div>
                                            <div class="col-md-7">
                                                <label class="control">
                                                [+(strlen($item->name_eng) > 25) ? Str::truncate($item->name_eng, 20, '...') : $item->name_eng+]</label>
                                            </div>
                                        </div>
                                    [+/foreach+]
                                [+else+]
                                    <div class="col-md-12">
                                        <div class="col-md-4 col-md-offset-1">
                                            <label class="control-common-label">会員属性</label>
                                        </div>
                                        <div class="col-md-7">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4 col-md-offset-1">
                                            <label class="control-common-label">会員名称</label>
                                        </div>
                                        <div class="col-md-4">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4 col-md-offset-1">
                                            <label class="control-common-label">会員名称(ふりがな)</label>
                                        </div>
                                        <div class="col-md-4">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4 col-md-offset-1">
                                            <label class="control-common-label">会員名称(英語)</label>
                                        </div>
                                        <div class="col-md-4">
                                        </div>
                                    </div>
                                [+/if+]
                            </div>
                            <div class ="col-md-3">
                                [+if isset($dataMember)+]
                                    [+foreach $dataMember as $key => $item+]
                                    <div class ="col-md-12 btn-first">
                                        <button type="submit" id="setting_member" name="setting_member" class="btn btn-primary col-md-12 ">会員を変更する
                                        </button>
                                    </div>
                                    <div class ="col-md-12 btn-after">
                                        <a href="[+Uri::base()+]manager/members/temp/[+$item->id+]" class="btn btn-primary col-md-12" >会員情報を編集する</a>
                                    </div>
                                    <div class ="col-md-12 btn-after">
                                        <button type="button" id="delete_member" name="delete_member" class="btn btn-primary col-md-12 " >会員を解除する
                                        </button>
                                    </div>
                                    [+/foreach+]
                                [+else+]
                                    <div class ="col-md-12 btn-first" style="padding-top: 20%">
                                        <button type="button" id="setting_member" name="setting_member" class="btn btn-primary col-md-12" >会員をセットする
                                        </button>
                                    </div>
                                [+/if+]
                            </div>
                        </div>
                        <div class="form-group">
                            <div class ="col-md-12">
                                <div class ="col-md-12 ">
                                    <div class="col-md-3 data-memberofcommittees">
                                        <label class="control-common-label">年会費の請求</label>
                                    </div>
                                    [+if isset($dataMemberofcommittees['request_of_cost'])+]
                                        [+if ($dataMemberofcommittees['request_of_cost'] == 0)+]
                                            <div class="col-md-8 request-of-cost">
                                                <label class="radio-inline"><input type="radio" checked="true" name="request_of_cost" value="0">未請求</label>
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="1">請求済み</label>
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="9">請求必要なし</label>
                                            </div>
                                        [+elseif ($dataMemberofcommittees['request_of_cost'] == 1)+]
                                            <div class="col-md-8 request-of-cost">
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="0">未請求</label>
                                                <label class="radio-inline"><input type="radio" checked="true" name="request_of_cost" value="1">請求済み</label>
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="9">請求必要なし</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-8 request-of-cost">
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="0">未請求</label>
                                                <label class="radio-inline"><input type="radio" name="request_of_cost" value="1">請求済み</label>
                                                <label class="radio-inline"><input type="radio" checked="true" name="request_of_cost" value="9">請求必要なし</label>
                                            </div>
                                        [+/if+]
                                    [+else+]
                                        <div class="col-md-8" style="padding-left: 7.333%">
                                            <label class="radio-inline"><input type="radio" name="request_of_cost" value="0">未請求</label>
                                            <label class="radio-inline"><input type="radio" name="request_of_cost" value="1">請求済み</label>
                                            <label class="radio-inline"><input type="radio" name="request_of_cost" value="9">請求必要なし</label>
                                        </div>
                                    [+/if+]
                                </div>
                                <div class ="col-md-12">
                                    <div class="col-md-3 data-memberofcommittees">
                                        <label class="control-common-label">年会費の入金</label>
                                    </div>
                                    [+if isset($dataMemberofcommittees['receipt_of_cost'])+]
                                        [+if ($dataMemberofcommittees['receipt_of_cost'] == 0)+]
                                            <div class="col-md-8" style="padding-left: 7.333%">
                                                <label class="radio-inline"><input type="radio" checked="true" name="receipt_of_cost" value="0">未入金</label>
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="1">入金済み</label>
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="9">入金必要なし</label>
                                            </div>
                                        [+elseif ($dataMemberofcommittees['receipt_of_cost'] == 1)+]
                                            <div class="col-md-8" style="padding-left: 7.333%">
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="0">未入金</label>
                                                <label class="radio-inline"><input type="radio" checked="true" name="receipt_of_cost" value="1">入金済み</label>
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="9">入金必要なし</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-8" style="padding-left: 7.333%">
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="0">未入金</label>
                                                <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="1">入金済み</label>
                                                <label class="radio-inline"><input type="radio" checked="true" name="receipt_of_cost" value="9">入金必要なし</label>
                                            </div>
                                        [+/if+]
                                    [+else+]
                                        <div class="col-md-8" style="padding-left: 7.333%">
                                            <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="0">未入金</label>
                                            <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="1">入金済み</label>
                                            <label class="radio-inline"><input type="radio" name="receipt_of_cost" value="2">入金必要なし</label>
                                        </div>
                                    [+/if+]
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class ="col-md-9">
                                <div class ="col-md-12">
                                    [+if isset($dataCommitteeOld)+]
                                        [+for $group=1 to 9+]
                                            [+$temp_current = 'cumstom_input0'|cat:$group+]
                                            [+$temp_name = 'custom_input_name0'|cat:$group+]
                                            [+$temp_type = 'custom_input_type0'|cat:$group+]
                                            [+$temp_selectable = 'custom_input_selectable0'|cat:$group+]
                                            [+if ($dataCommitteeOld[0][$temp_name] != NULL)&&($dataCommitteeOld[0][$temp_type] != 0) &&($dataCommitteeOld[0][$temp_selectable]) != NULL+]
                                                <div class="col-md-4 col-md-offset-1" style="">
                                                    <label class="control-common-label">[+(strlen($dataCommitteeOld[0][$temp_name]) > 25) ? Str::truncate($dataCommitteeOld[0][$temp_name], 20, '...') : $dataCommitteeOld[0][$temp_name]+]</label>
                                                </div>
                                                [+if ($dataCommitteeOld[0][$temp_type] == 1)+]
                                                    [+if isset($dataMemberofcommittees[$temp_current])+]
                                                        <div class="col-md-7" style="padding-top: 10px">
                                                            <input type="text" value="[+$dataMemberofcommittees[$temp_current]+]" class="form-control"  name="[+$temp_current+]" />
                                                        </div>
                                                    [+else+]
                                                        <div class="col-md-7" style="padding-top: 10px">
                                                            <input type="text" value="[+input::post('cumstom_input[+$temp_current+]')+]" class="form-control"  name="[+$temp_current+]" />
                                                        </div>
                                                    [+/if+]
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 2)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        [+if isset($dataMemberofcommittees[$temp_current])+]
                                                                <textarea class="form-control" name="[+$temp_current+]" rows="5" id="[+$temp_current+]" >[+$dataMemberofcommittees[$temp_current]+]</textarea>
                                                        [+else+]
                                                            <textarea class="form-control" name="[+$temp_current+]" rows="5" id="[+$temp_current+]" >[+input::post('cumstom_input[+$temp_current+]')+]</textarea>
                                                        [+/if+]
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 3)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                    [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                        [+if isset($dataMemberofcommittees[$temp_current]) && ($dataMemberofcommittees[$temp_current] == $dataCustomCommittee[$temp_selectable][$i])+]
                                                        <label class="radio-inline"><input type="radio" name="[+$temp_current+]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]+]" checked="true">[+$dataCustomCommittee[$temp_selectable][$i]+]</label>
                                                        [+else+]
                                                            <label class="radio-inline"><input type="radio" name="[+$temp_current+]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]+]" >[+$dataCustomCommittee[$temp_selectable][$i]+]</label>
                                                        [+/if+]
                                                    [+/for+]
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 4)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        <select name="[+$temp_current+]" id="[+$temp_current+]" class="form-control">
                                                            [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                            [+if isset($dataMemberofcommittees[$temp_current])&&($dataMemberofcommittees[$temp_current] == $dataCustomCommittee[$temp_selectable][$i])+]
                                                             <option value="[+$dataCustomCommittee[$temp_selectable][$i]+]" selected="true">[+$dataCustomCommittee[$temp_selectable][$i]+]</option>
                                                             [+else+]
                                                             <option value="[+$dataCustomCommittee[$temp_selectable][$i]+]">[+$dataCustomCommittee[$temp_selectable][$i]+]</option>
                                                             [+/if+]
                                                            [+/for+]
                                                        </select>
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 5)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        [+if isset($dataCheckbox)+]
                                                            [+$array = array_diff($dataCustomCommittee[$temp_selectable],$dataCheckbox[$temp_current])+]
                                                            [+if (count($array) >= 1)+]
                                                                [+foreach $array as $key  => $item+]
                                                                    <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$item+]" >[+$item+]</label>
                                                                [+/foreach+]
                                                                [+foreach $dataCheckbox[$temp_current] as $key1  => $item1+]
                                                                    [+if ($item1 != NULL)+]
                                                                        <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$item1+]" checked="true">[+$item1+]</label>
                                                                    [+/if+]
                                                                [+/foreach+]
                                                            [+else+]
                                                                [+foreach $dataCheckbox[$temp_current] as $key  => $item+]
                                                                    [+if ($item != NULL)+]
                                                                    <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$item+]" checked="true">[+$item+]</label>
                                                                    [+/if+]
                                                                [+/foreach+]
                                                            [+/if+]
                                                        [+else+]
                                                            [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                                <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]|strip+]">[+$dataCustomCommittee[$temp_selectable][$i]|strip+]</label>
                                                            [+/for+]
                                                        [+/if+]
                                                    </div>
                                                [+/if+]
                                            [+/if+]
                                        [+/for+]
                                        [+for $group=10 to 20+]
                                            [+$temp_current = 'cumstom_input'|cat:$group+]
                                            [+$temp_name = 'custom_input_name'|cat:$group+]
                                            [+$temp_type = 'custom_input_type'|cat:$group+]
                                            [+$temp_selectable = 'custom_input_selectable'|cat:$group+]
                                            [+if ($dataCommitteeOld[0][$temp_name] != NULL)&&($dataCommitteeOld[0][$temp_type] != 0)&&($dataCommitteeOld[0][$temp_selectable] != NULL)+]
                                                <div class="col-md-4 col-md-offset-1" style="">
                                                    <label class="control">[+(strlen($dataCommitteeOld[0][$temp_name]) > 25) ? Str::truncate($dataCommitteeOld[0][$temp_name], 20, '...') : $dataCommitteeOld[0][$temp_name]+]</label>
                                                </div>
                                                [+if ($dataCommitteeOld[0][$temp_type] == 1)+]
                                                    [+if isset($dataMemberofcommittees[$temp_current])+]
                                                        <div class="col-md-7" style="padding-top: 10px">
                                                            <input type="text" value="[+$dataMemberofcommittees[$temp_current]+]" class="form-control"  name="[+$temp_current+]" />
                                                        </div>
                                                    [+else+]
                                                        <div class="col-md-7" style="padding-top: 10px">
                                                            <input type="text" value="[+input::post('cumstom_input[+$temp_current+]')+]" class="form-control"  name="[+$temp_current+]" />
                                                        </div>
                                                    [+/if+]
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 2)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        [+if isset($dataMemberofcommittees[$temp_current])+]
                                                                <textarea class="form-control" name="[+$temp_current+]" rows="5" id="[+$temp_current+]" >[+$dataMemberofcommittees[$temp_current]+]</textarea>
                                                        [+else+]
                                                            <textarea class="form-control" name="[+$temp_current+]" rows="5" id="[+$temp_current+]" >[+input::post('cumstom_input[+$temp_current+]')+]</textarea>
                                                        [+/if+]
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 3)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                    [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                        [+if isset($dataMemberofcommittees[$temp_current]) && ($dataMemberofcommittees[$temp_current] == $dataCustomCommittee[$temp_selectable][$i])+]
                                                        <label class="radio-inline"><input type="radio" name="[+$temp_current+]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]+]" checked="true">[+$dataCustomCommittee[$temp_selectable][$i]+]</label>
                                                        [+else+]
                                                            <label class="radio-inline"><input type="radio" name="[+$temp_current+]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]+]" >[+$dataCustomCommittee[$temp_selectable][$i]+]</label>
                                                        [+/if+]
                                                    [+/for+]
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 4)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        <select name="[+$temp_current+]" id="[+$temp_current+]" class="form-control">
                                                            [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                            [+if isset($dataMemberofcommittees[$temp_current])&&($dataMemberofcommittees[$temp_current] == $dataCustomCommittee[$temp_selectable][$i])+]
                                                             <option value="[+$dataCustomCommittee[$temp_selectable][$i]+]" selected="true">[+$dataCustomCommittee[$temp_selectable][$i]+]</option>
                                                             [+else+]
                                                             <option value="[+$dataCustomCommittee[$temp_selectable][$i]+]">[+$dataCustomCommittee[$temp_selectable][$i]+]</option>
                                                             [+/if+]
                                                            [+/for+]
                                                        </select>
                                                    </div>
                                                [+elseif ($dataCommitteeOld[0][$temp_type] == 5)+]
                                                    <div class="col-md-7" style="padding-top: 10px">
                                                        [+if isset($dataCheckbox)+]
                                                            [+$array = array_diff($dataCustomCommittee[$temp_selectable],$dataCheckbox[$temp_current])+]
                                                            [+if (count($array) >= 1)+]
                                                                [+foreach $array as $key  => $item+]
                                                                    <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$item+]" >[+$item+]</label>
                                                                [+/foreach+]
                                                                [+foreach $dataCheckbox[$temp_current] as $key1  => $item1+]
                                                                    [+if ($item1 != NULL)+]
                                                                        <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$item1+]" checked="true">[+$item1+]</label>
                                                                    [+/if+]
                                                                [+/foreach+]
                                                            [+else+]
                                                                [+foreach $dataCheckbox[$temp_current] as $key  => $item+]
                                                                    [+if ($item != NULL)+]
                                                                    <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="" value="[+$item+]" checked="true">[+$item+]</label>
                                                                    [+/if+]
                                                                [+/foreach+]
                                                            [+/if+]
                                                        [+else+]
                                                            [+for $i=0 to (count($dataCustomCommittee[$temp_selectable])-1)+]
                                                                <label class="checkbox-inline"><input type="checkbox" name="[+$temp_current+][]" id="[+$temp_current+]" value="[+$dataCustomCommittee[$temp_selectable][$i]|strip+]">[+$dataCustomCommittee[$temp_selectable][$i]|strip+]</label>
                                                            [+/for+]
                                                        [+/if+]
                                                    </div>
                                                [+/if+]
                                            [+/if+]
                                        [+/for+]
                                    [+else+]
                                        
                                    [+/if+]
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="form-group">
                            <div class ="col-md-9">
                                <div class ="col-md-12">
                                    <div class="col-md-3 col-md-offset-1" style="">
                                        <label class="control">所属メンバー</label>
                                    </div>
                                        [+if isset($dataCommittee)+]
                                            [+foreach $dataCommittee as $key => $item+]
                                                <div class="col-md-8">
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">所属・役職</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->department) > 25) ? Str::truncate($item->department, 20, '...') : $item->department+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">氏名</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->name) > 25) ? Str::truncate($item->name, 20, '...') : $item->name+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">メール</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->name_kana) > 25) ? Str::truncate($item->name_kana, 20, '...') : $item->name_kana+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">電話</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->tel) > 25) ? Str::truncate($item->tel, 20, '...') : $item->tel+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">FAX</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item ->email) > 20) ? Str::truncate($item ->email, 15, '...') : $item ->email+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">郵便番号</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->zip) > 25) ? Str::truncate($item->zip, 20, '...') : $item->zip+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">住所1</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->address01) > 25) ? Str::truncate($item->address01, 20, '...') : $item->address01+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control" >住所2</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control">[+(strlen($item->address02) > 25) ? Str::truncate($item->address02, 20, '...') : $item->address02+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <label class="control" >(ビル名・階数)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            [+/foreach+]
                                        [+else+]
                                            <div class="col-md-8">
                                                    <div class="col-md-12" style="">
                                                        <div class="col-md-5">
                                                            <label class="control">所属・役職</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">氏名</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">メール</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">電話</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">FAX</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">郵便番号</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">郵便番号</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control">住所1</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label class="control" >住所2</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label class="control"></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <label class="control" >(ビル名・階数)</label>
                                                        </div>
                                                    </div>
                                            </div>
                                        [+/if+]
                                </div>
                            </div>
                            <div class ="col-md-3">
                                [+if isset($dataCommittee)+]
                                    [+foreach $dataCommittee as $key => $item+]
                                    <div class ="col-md-12 btn-first">
                                        <button type="button" id="setting_committee" name="setting_committee" class="btn btn-primary col-md-12 " >メンバーを変更する
                                        </button>
                                    </div>
                                    <div class ="col-md-12 btn-after">
                                        <a href="[+Uri::base()+]manager/persons/editinfo/[+$item->id+]"   class="btn btn-primary col-md-12">メンバー情報を編集す</a>
                                    </div>
                                    <div class ="col-md-12 btn-after">
                                        <button type="button" id="delete_committee" name="delete_committee" class="btn btn-primary col-md-12" >メンバーを解除する
                                        </button>
                                    </div>
                                    [+/foreach+]
                                [+else+]
                                    <div class ="col-md-12 btn-first">
                                        <button type="button" id="setting_committee" name="setting_committee" class="btn btn-primary col-md-12">メンバーをセットする
                                        </button>
                                    </div>
                                [+/if+]
                            </div>
                        </div>

                        <hr />

                        <div class="form-group">
                            <div class ="col-md-12">
                                <div class ="col-md-12">
                                    <div class="col-md-2 " style="padding-left: 8.5%">
                                        <label class="control">備考</label>
                                    </div>
                                    <div class="col-md-8" style="padding-top: 10px;padding-left: 10.6%">
                                        [+if isset($dataMemberofcommittees)+]
                                            <textarea class="form-control" name="note" style="max-width: 100%;" rows="5" id="note" placeholder="備考">[+$dataMemberofcommittees['note']+]</textarea>
                                        [+else+]
                                            <textarea class="form-control" name="note" style="max-width: 100%;" rows="5" id="note" placeholder="備考">[+Input::post('note')+]</textarea>
                                        [+/if+]
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-5 ">
                            <input type="hidden" id="checkbutton" name="checkbutton" value="">
                            <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                            [+if isset($dataCheckurl)+]
                                <input type="hidden" id="backurl" name="backurl" value="[+$dataCheckurl+]">
                            [+else+]
                                <input type="hidden" id="backurl" name="backurl" value="0">
                            [+/if+]
                            <button type="button" id ="submit_addmember" name="submit_addmember" class="btn btn-md btn-primary">
                                登録
                            </button>
                        </div>
                        </div>
                    [+Form::close()+]
                </div>
            </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/memberofcommittee_addmember.js'))+]