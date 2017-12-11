<!--Màn hình chinh sua cong chuc (M009-01)-->
[+Asset::css(array('site/common.css'))+]
[+Asset::css(array('site/member.css'))+]
<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                [+if Session::get_flash('error') +]
                    [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <strong>[+$error+]</strong>
                            </div>
                        </div>
                    </div>
                [+/if +]

                    [+assign var = formset 
                    value = ['name' => 'editOfficer',
                    'method'    => 'post', 
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'editOfficer'
                    ]+]

                    [+Form::open($formset)+]
                    <div class="form-group">
                        <label class="col-xs-2 col-xs-offset-2 padding-left-50"  style="text-align: left; margin-top: 1%;" for="officer attributes">RRI 役職</label>
                        [+if isset($member_flag)+]
                        [+if ($member_flag == 1)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1" checked="checked">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 2)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2" checked="checked">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 11)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11" checked="checked">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 12)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12" checked="checked">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 21)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12" checked="checked">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21" checked="checked">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 22)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12" checked="checked">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22" checked="checked">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+else if ($member_flag == 23)+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23" checked="checked">評議員</label>
                        </div>
                        [+/if+]
                        [+else+]
                        <div class="col-xs-6">
                            <div class="row">
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="1">会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="2">副会長</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="11">運営幹事</label>
                                <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="12">監査役</label>
                            </div>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="21">実務者連絡員</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="22">参与</label>
                            <label class="radio-inline"><input type="radio" id="member_flag" name="member_flag" value="23">評議員</label>
                        </div>
                        [+/if+]

                    </div> 

                    <!-- cai dat hoi vien -->
                    <div class="form-group">
                    [+if isset($member)+]
                    [+foreach $member as $item_member+]
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            <label class="control-common-label" for="member attributes">会員属性</label>
                            <label class="control-common-label padding-left-50"  style="text-align: left; margin-left: -19px; " for="member name">会員名称</label>
                            <label class="control-common-label padding-left-50" style="text-align: left; margin-left: -19px; " for="member name kana">会員名称(ふりがな)</label>
                        </div>
                        <div class="col-xs-3" style="margin-top: 1%">
                            [+if isset($item_member->type)+]
                            <label class="col-xs-8" id="member_atr" name="member_atr" style="text-align: left" for="member attributes">
                                [+if ($item_member->type == 0)+]
                                    なし
                                [+else if ($item_member->type == 1)+]
                                    企業
                                [+else if ($item_member->type == 2)+]
                                    団体
                                [+else if ($item_member->type == 3)+]
                                    研究機関
                                [+else if ($item_member->type == 4)+]
                                    個人
                                [+else if ($item_member->type == 5)+]
                                    地方自治体
                            [+/if+]    
                            </label>
                            [+else+]
                            <label class="col-xs-4" id="member_atr" name="member_atr" style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            [+if isset($item_member->name)+]
                                <label class="col-xs-8"  style="text-align: left" for="member name">[+(strlen($item_member->name) > 25) ? Str::truncate($item_member->name, 20, '...') : $item_member->name+]</label>
                            [+else+]
                                <label class="col-xs-12"  style="text-align: left" for="member name"></label>
                            [+/if+]
                            [+if isset($item_member->name_kana)+]
                                <label class="col-xs-8"  style="text-align: left" for="member name kana">[+(strlen($item_member->name_kana) > 25) ? Str::truncate($item_member->name_kana, 20, '...') : $item_member->name_kana+]</label>
                            [+else+]
                                <label class="col-xs-12"  style="text-align: left" for="member name kana"></label>
                            [+/if+]
                        </div>
                        <div class="col-xs-2" style="float: right; margin-right: 12%;" >
                            <button type="button" id="setupMember" name="setupMember" class="btn btn-primary col-xs-12" style="float: right; margin-top: 10%; width: 135%">会員を変更する</button>        
                            <a type="button" href="[+Uri::base()+]manager/members/temp/[+$item_member->id+]" class="btn btn-primary col-xs-12 " id="editMember" name="editMember" style="float: right;margin-top: 10%; width: 135%">会員情報を編集する</a>
                            <input type="submit" id="delMember" name="delMember" style="float: right;margin-top: 10%; width: 135%" value="会員を解除する" class="btn btn-primary col-md-12">
                        </div>
                    [+/foreach+]
                    [+else+]
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            <label class="control-common-label" for="member attributes">会員属性</label>
                            <label class="control-common-label padding-left-50"  style="text-align: left; margin-left: -19px; " for="member name">会員名称</label>
                            <label class="control-common-label padding-left-50"  style="text-align: left; margin-left: -19px; " for="member name kana">会員名称(ふりがな)</label>
                        </div>
                        <div class="col-xs-2" style="float: right; margin-right: 12%;" >
                            <!-- button for M007 - 01 1 -->
                            <button type="submit" id="setupMember" name="setupMember" class="btn btn-primary col-md-12 " form="setupOfficer" style="float: right; width: 135%">会員をセットする</button>
                        </div>
                    [+/if+]
                    </div>

                    <hr>
                    
                    <!-- cai dat cong chuc -->
                    <div class="form-group">
                    [+if isset($dataOfficer)+]
                    [+foreach $dataOfficer as $item_officer+]
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            <label class="control-common-label"  style="text-align: left" for="member attributes">役員</label>
                        </div>
                        <div class="col-xs-5" style="margin-top: 1%;">
                        [+if ($member_flag > 12)+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">所属・役職</label>
                            [+if ($item_officer->department)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->department) > 25) ? Str::truncate($item_officer->department, 20, '...') : $item_officer->department+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">氏名</label>
                            [+if ($item_officer->name)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->name) > 25) ? Str::truncate($item_officer->name, 20, '...') : $item_officer->name+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">メール</label>
                            [+if ($item_officer->email)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->email) > 25) ? Str::truncate($item_officer->email, 20, '...') : $item_officer->email+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">電話</label>
                            [+if ($item_officer->tel)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->tel) > 25) ? Str::truncate($item_officer->tel, 20, '...') : $item_officer->tel+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">FAX</label>
                            [+if ($item_officer->fax)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->fax) > 25) ? Str::truncate($item_officer->fax, 20, '...') : $item_officer->fax+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">郵便番号</label>
                            [+if ($item_officer->zip)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->zip) > 25) ? Str::truncate($item_officer->zip, 20, '...') : $item_officer->zip+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">住所1</label>
                            [+if ($item_officer->address01)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->address01) > 25) ? Str::truncate($item_officer->address01, 20, '...') : $item_officer->address01+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">住所2 (ビル名・階数)</label>
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->address02) > 25) ? Str::truncate($item_officer->address02, 20, '...') : $item_officer->address02+]</label>
                        [+else+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">所属・役職</label>
                            [+if ($item_officer->department)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->department) > 25) ? Str::truncate($item_officer->department, 20, '...') : $item_officer->department+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">氏名</label>
                            [+if ($item_officer->name)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_officer->name) > 25) ? Str::truncate($item_officer->name, 20, '...') : $item_officer->name+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                        [+/if+]
                        </div>
                        <div class="col-xs-2" class="btn-right-side" style="margin-left: -3.5%;">
                            <!-- button for M007 - 01 2 -->
                            <button type="button" class="btn btn-primary col-md-12 " id="officer" name="officer" style="float: right;margin-top: 10%; width: 135%">役員を変更する</button>        
                            <a type="button" href="[+Uri::base()+]manager/persons/editinfo/[+$item_officer->id+]" class="btn btn-primary col-md-12 " id="editOfficer" name="editOfficer" style="float: right;margin-top: 10%; width: 135%">役員情報を編集する</a>
                            <button type="button" class="btn btn-primary col-md-12 " id="delOfficer" name="delOfficer" style="float: right;margin-top: 10%; width: 135%">役員を解除する</button>
                        </div>
                    [+/foreach+]
                        <div class="col-xs-12 col-xs-offset-2 padding-left-50">
                                <label>担当者</label>
                        </div>
                    [+else+]
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            <label style="text-align: left" for="member attributes">役員</label>    
                        </div>
                        <div class="col-xs-2" style="float: right; margin-right: 12%;">
                             <!-- button for M007 - 01 1 -->
                            <button type="button" id="officer" name="officer" class="btn btn-primary col-md-12 " style="float: right; width: 135%" >役員をセットする</button>
                        </div>
                        <div class="col-xs-12 col-xs-offset-2 padding-left-50" style="padding-top: 50px">
                                <label>担当者</label>
                        </div>
                    [+/if+]
                        
                    </div>

                    <hr>

                    <!-- Cai dat phu trach chinh -->
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">
                            <label style="text-align: left" for="member attributes">主担当</label>
                        </div>
                        [+if isset($dataMainCurator)+]
                        [+foreach $dataMainCurator as $item_maincurator+]
                        <div class="col-xs-5">
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">所属・役職</label>
                            [+if ($item_maincurator->department)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->department) > 25) ? Str::truncate($item_maincurator->department, 20, '...') : $item_maincurator->department+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">氏名</label>
                            [+if ($item_maincurator->name)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->name) > 25) ? Str::truncate($item_maincurator->name, 20, '...') : $item_maincurator->name+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">メール</label>
                            [+if ($item_maincurator->email)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->email) > 25) ? Str::truncate($item_maincurator->email, 20, '...') : $item_maincurator->email+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">電話</label>
                            [+if ($item_maincurator->tel)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->tel) > 25) ? Str::truncate($item_maincurator->tel, 20, '...') : $item_maincurator->tel+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">FAX</label>
                            [+if ($item_maincurator->fax)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->fax) > 25) ? Str::truncate($item_maincurator->fax, 20, '...') : $item_maincurator->fax+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">郵便番号</label>
                            [+if ($item_maincurator->zip)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->zip) > 25) ? Str::truncate($item_maincurator->zip, 20, '...') : $item_maincurator->zip+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">住所1</label>
                            [+if ($item_maincurator->address01)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->address01) > 25) ? Str::truncate($item_maincurator->address01, 20, '...') : $item_maincurator->address01+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                            <label class="col-xs-4"  style="text-align: left" for="member attributes">住所2 (ビル名・階数)</label>
                            [+if ($item_maincurator->address02)+]
                            <label class="col-xs-8"  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->address02) > 25) ? Str::truncate($item_maincurator->address02, 20, '...') : $item_maincurator->address02+]</label>
                            [+else+]
                            <label class="col-xs-12"  style="text-align: left" for="member attributes"></label>
                            [+/if+]
                        </div>
                        <div class="col-xs-2" class="btn-right-side" style="margin-left: -3.5%; margin-top: -1%;" >
                            <input type="hidden" id="check_main_curator" name="check_main_curator">
                            <input type="submit" id="MainCuratorSetting" name="MainCuratorSetting" style="float: right;margin-top: 10%; width: 135%" value="主担当をセットする" class="btn btn-primary col-md-12">
                            <a type="button" href="[+Uri::base()+]manager/persons/editinfo/[+$item_maincurator->id+]" class="btn btn-primary col-md-12 " id="editOfficer" name="editOfficer" style="float: right;margin-top: 10%; width: 135%">主担当情報を編集する</a>
                            <input type="button" class="btn btn-primary col-md-12" name="delete_main_curator" id="delete_main_curator" value="主担当を解除する" style="float: right; margin-top: 10%; width: 135%">
                        </div>
                        [+/foreach+]
                        [+else+]
                        <div class="col-xs-2" style="float: right; margin-right: 16.5%;">
                            <input type="hidden" id="check_main_curator" name="check_main_curator">
                            <input type="submit" id="MainCuratorSetting" name="MainCuratorSetting" value="主担当をセットする" class="btn btn-primary col-md-12" style="width: 135%">
                        </div>
                        [+/if+]
                    </div>

                    <hr>
                    
                    <!-- cai dat phu trach phu -->
                    [+if isset($arrayNewSubCurator)+]
                            [+for $i=0 to ($arrayNewSubCurator|@count - 1)+]

                                [+foreach $arrayNewSubCurator[$i] as $items+]
                                    <div class="form-group">
                                            <div class="col-xs-2 col-xs-offset-2 padding-left-50">
                                                <label  style="" for="">サブ担当</label>
                                            </div>
                                            <div class="col-xs-5">
                                                [+if ($items->department)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">所属・役職</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->department) > 25) ? Str::truncate($items->department, 20, '...') : $items->department+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">所属・役職</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->name)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">氏名</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->name) > 25) ? Str::truncate($items->name, 20, '...') : $items->name+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">氏名</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->email)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">メール</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->email) > 25) ? Str::truncate($items->email, 20, '...') : $items->email+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">メール</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->tel)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">電話</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->tel) > 25) ? Str::truncate($items->tel, 20, '...') : $items->tel+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">電話</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->fax)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">FAX</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->fax) > 25) ? Str::truncate($items->fax, 20, '...') : $items->fax+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">FAX</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->zip)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">郵便番号</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->zip) > 25) ? Str::truncate($items->zip, 20, '...') : $items->zip+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">郵便番号</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->address01)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">住所1</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->address01) > 25) ? Str::truncate($items->address01, 20, '...') : $items->address01+]</label>
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">住所1</label>
                                                    </div>
                                                [+/if+]
                                                [+if ($items->address02)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">住所2</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items->address02) > 25) ? Str::truncate($items->address02, 20, '...') : $items->address02+]</label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">ビル名・階数)</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                    </div>
                                                [+else+]
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">住所2</label>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <label style="text-align: left" for="member attributes">ビル名・階数)</label>
                                                    </div>
                                                [+/if+]
                                        </div>
                                        <div class="col-md-2" class="btn-right-side" style="margin-left: -3.5%; margin-top: -1%;">
                                            <input type="hidden" id="check_sub_curator" name="check_sub_curator" value="">

                                            <input type="hidden" id="check_number_id" name="check_number_id" value="[+$i+]">

                                            <a href="[+Uri::base()+]manager/curators/setting/[+$i+]"  style="float: right; margin-top: 10%; width: 135%" class="btn btn-primary col-md-12">サブ担当を変更する</a>
                                           
                                            <a href="[+Uri::base()+]manager/persons/editinfo/[+$items->id+]"  style="float: right; margin-top: 10%; width: 135%" class="btn btn-primary col-md-12">サブ担当情報を編集する</a>

                                            <a data-id="[+$i+]" style="float: right;margin-top: 10%; width: 135%" class="deleteClick btn btn-primary col-md-12">サブ担当を解除する</a>

                                        </div>
                                    </div>

                                    <hr >
                                [+/foreach+]
                            [+/for+] 
                        
                            <div class="form-group">
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <input type="button" name="new_sub_curator" id="new_sub_curator" class="btn btn-primary col-md-4 col-md-offset-4" value="サブ担当を追加する">
                            </div>

                    [+else+]
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-2 padding-left-50">
                                <label  style="" for="">サブ担当</label>
                            </div>
                            <div class="col-xs-4">
                            </div>
                            <div class="col-md-2" class="btn-right-side" style="float: right; margin-right: 16.5%">
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <input type="button" name="sub_curator" id="sub_curator" class="btn btn-primary col-md-12 " style=" width: 135%" value="サブ担当をセットする">
                            </div>    
                        </div>
                    [+/if+]

                    <hr class="hr">
                    
                    [+if isset($note)+]
                    <div id ="form-group" class="form-group">
                        <label class="col-xs-2 col-xs-offset-2 padding-left-50"  style="text-align: left" for="member attributes">備考</label>
                        <div class="col-xs-6">
                            <textarea class="form-control" name="note" style="max-width: 100%;" rows="5" id="note" placeholder="備考">[+$note+]</textarea>
                        </div>
                    </div>
                    [+else+]
                    <div id ="form-group" class="form-group">
                        <label class="col-xs-2 col-xs-offset-2 padding-left-50"  style="text-align: left" for="member attributes">備考</label>
                        <div class="col-xs-6">
                            <textarea class="form-control" name="note" style="max-width: 100%;" rows="5" id="note" placeholder="備考"></textarea>
                        </div>
                    </div>
                    [+/if+]
                    
                    <div class="form-group">
                        <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                        <div class="col-md-1 col-md-offset-4" style="margin-right: 2%;">
                            <input type="submit" name="deleteOfficer" form="editOfficer" id="deleteOfficer" class="btn btn-md btn-primary " value="削除">
                        </div>

                        <div class="col-md-4">
                            <input type="submit" name="submitOfficer" id="submitOfficer" class="btn btn-md btn-primary " value="登録">
                            [+if isset($dataCheckurl)+]
                                <input type="hidden" id="backurl" name="backurl" value="[+$dataCheckurl+]">
                            [+else+]
                                <input type="hidden" id="backurl" name="backurl" value="0">
                            [+/if+]
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/officer_edit.js'))+]