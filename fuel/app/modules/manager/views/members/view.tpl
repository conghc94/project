<!--Màn hình thiet lap hoi vien(S010 - 2)-->
<section class="content">
[+Asset::css(array('site/common.css'))+]
[+Asset::css(array('site/member.css'))+]
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">

                    [+assign var = formset 
                    value = ['name' => 'viewMember',
                    'method'    => 'post',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'createMember'
                    ]+]

                    [+Form::open($formset)+]
                    [+if isset($member)+]
                    [+foreach $member as $item+]
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                             
                            <label class="control-common-label">会員属性</label>
                        </div>
                        <div class="col-xs-6">
                            [+Form::select('type', $item->type, [
                                '0'        => 'なし',
                                '1'        => '企業',
                                '2'        => '団体',
                                '3'        => '研究機関',
                                '4'        => '個人',
                                '5'        => '地方自治体'], ['class' => 'form-control', 'disabled'])+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2"> <label class="control-common-label">会員属性</label>
                        </div>
                        <div class="col-xs-6">
                            [+if ($item->profile_flag == 0)+]
                            <label class="radio-inline"><input type="radio" name="profile_flag" value="profile_flag" disabled>RRI会員</label>
                            <label class="radio-inline"><input type="radio" name="profile_flag" value="profile_flag" disabled checked="checked">RRI会員ではない</label>
                        [+else+]
                            <label class="radio-inline"><input type="radio" name="profile_flag" value="profile_flag" disabled checked="checked">RRI会員</label>
                            <label class="radio-inline"><input type="radio" name="profile_flag" value="profile_flag" disabled>RRI会員ではない</label>
                        [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                             
                            <label class="control-common-label">会員名称</label>
                        </div>
                        <div class="col-xs-6">
                            [+if ($item->name)+]
                                <input type="text" name="name_member" class="form-control" id="name_member" placeholder="会員名称" value="[+$item->name+]" disabled>
                            [+else+]
                                <input type="text" name="name" class="form-control" id="name" value="" placeholder="会員名称" disabled/>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                             
                            <label  style="text-align: left">会員名称(ふりがな)</label>
                        </div>
                        <div class="col-xs-6">
                            [+if ($item->name_kana)+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+$item->name_kana+]" placeholder="会員名称(ふりがな)" disabled/>
                            [+else+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana"  placeholder="会員名称(ふりがな)" disabled>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                             
                            <label  style="text-align: left" for="name_eng">会員名称(英語)</label>
                        </div>
                        <div class="col-xs-6">
                            [+if ($item->name_eng)+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+$item->name_eng+]" placeholder="会員名称(英語)" disabled>
                            [+else+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+$item->name_eng+]" placeholder="会員名称(英語)" disabled>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div  class="col-xs-2 col-xs-offset-2">
                            <label  style="text-align: left" for="description">事業概要</label>
                        </div>
                        <div class="col-xs-6">
                            [+if ($item->description)+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要" disabled>[+$item->description+]</textarea>
                            [+else+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要" disabled></textarea>
                            [+/if+]
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <div  class="col-xs-2 col-xs-offset-2">
                            <label>総会の出席</label>
                        </div>
                        <div class="col-xs-7">
                            [+if isset($item->attendance_of_meeting)+]
                                [+if ($item->attendance_of_meeting == 0)+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  checked="checked" disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>欠席</label>
                                [+else if ($item->attendance_of_meeting == 1)+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  checked="checked" disabled>代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>欠席</label>
                                [+else if ($item->attendance_of_meeting == 2)+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  checked="checked" disabled>代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>欠席</label>
                                [+else+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  disabled>代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting"  checked="checked" disabled>欠席</label>
                                [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0" disabled>未定</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1" disabled>代表者出席</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2" disabled>代理者出席</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9" disabled>欠席</label>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div  class="col-xs-2 col-xs-offset-2">
                            <label>総会の委任状</label>
                        </div>
                        <div class="col-xs-7" >
                            [+if ($item->proxy_of_meeting)+]
                                [+if ($item->proxy_of_meeting == 0)+]                        
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled checked="checked">未定</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>議長委任</label>
                                [+else if ($item->proxy_of_meeting == 1)+]
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled checked="checked">代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>議長委任</label>
                                [+else+]
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>未定</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled>代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="proxy_of_meeting" disabled checked="checked">議長委任</label>
                                [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="0" disabled>未定</label>
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="1" disabled>代理者委任状</label>
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="2" disabled>議長委任</label>
                            [+/if+]
                        </div>
                    </div>

                    <hr>

                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                            <label>代表者</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($director)+]
                                [+foreach $director as $item_director+]
                                    [+if isset($item_director->director_department)+]
                                        <div class="col-xs-4">
                                            <label style="text-align: left" for="member attributes">所属・役職</label>
                                        </div>
                                        <div class="col-xs-8">
                                            <label  style="text-align: left" for="member attributes">[+(strlen($item_director->director_department) > 45) ? Str::truncate($item_director->director_department, 40, '...') : $item_director->director_department+]</label>
                                        </div>
                                    [+else+]
                                        <div class="col-xs-12">
                                            <label style="text-align: left" for="member attributes">所属・役職</label>
                                        </div>
                                    [+/if+]
                                    [+if isset($item_director->director_name)+]
                                        <div class="col-xs-4">
                                            <label style="text-align: left" for="member attributes">氏名</label>
                                        </div>
                                        <div class="col-xs-8">
                                            <label  style="text-align: left" for="member attributes">[+(strlen($item_director->director_name) > 45) ? Str::truncate($item_director->director_name, 40, '...') : $item_director->director_name+]</label>
                                        </div>
                                    [+else+]
                                        <div class="col-xs-12">
                                            <label style="text-align: left" for="member attributes">氏名</label>
                                        </div>
                                    [+/if+]
                                [+/foreach+]
                            [+/if+]
                        </div>                        
                            <div class="col-xs-12 col-xs-offset-2">
                                <label>担当者</label>
                            </div>
                    </div>

                    <hr>

                    <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-2">
                                 
                                <label>主担当</label>
                            </div>
                            <div class="col-xs-5">
                                [+if isset($dataMainCurator)+]
                                    [+foreach $dataMainCurator as $item_maincurator+]
                                        [+if ($item_maincurator->department)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">所属・役職</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->department) > 45) ? Str::truncate($item_maincurator->department, 40, '...') : $item_maincurator->department+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">所属・役職</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->name)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">氏名</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->name) > 45) ? Str::truncate($item_maincurator->name, 40, '...') : $item_maincurator->name+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">氏名</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->email)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">メール</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator ->email) > 45) ? Str::truncate($item_maincurator ->email, 40, '...') : $item_maincurator ->email+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">メール</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->tel)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">電話</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->tel) > 45) ? Str::truncate($item_maincurator->tel, 40, '...') : $item_maincurator->tel+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">電話</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->fax)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">FAX</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->fax) > 45) ? Str::truncate($item_maincurator->fax, 40, '...') : $item_maincurator->fax+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">FAX</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->zip)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">郵便番号</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->zip) > 45) ? Str::truncate($item_maincurator ->zip, 40, '...') : $item_maincurator->zip+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">郵便番号</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->address01)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">住所1</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->address01) > 45) ? Str::truncate($item_maincurator->address01, 40, '...') : $item_maincurator->address01+]</label>
                                            </div>
                                        [+else+]
                                            <div class="col-md-12">
                                                <label style="text-align: left" for="member attributes">住所1</label>
                                            </div>
                                        [+/if+]
                                        [+if ($item_maincurator->address02)+]
                                            <div class="col-md-4">
                                                <label style="text-align: left" for="member attributes">住所2</label>
                                            </div>
                                            <div class="col-md-8">
                                                <label  style="text-align: left" for="member attributes">[+(strlen($item_maincurator->address02) > 45) ? Str::truncate($item_maincurator ->address02, 40, '...') : $item_maincurator->address02+]</label>
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
                                    [+/foreach+]
                                [+/if+]
                                </div>
                             <div class="col-md-12">
                                <div class="col-md-1 col-md-offset-1">
                                </div>
                                <div class="col-md-2" style="margin-left: -1%;">
                                </div>
                            </div>
                    </div>
                        
                    [+if isset($dataSubCurator)+]
                        <hr>
                            [+foreach $dataSubCurator as $items+]
                                    <div class="form-group">
                                            <div class="col-xs-2 col-xs-offset-2">
                                                <label  style="" for="">サブ担当</label>
                                            </div>
                                            <div class="col-xs-5">
                                                [+if ($items->department)+]
                                                    <div class="col-md-4">
                                                        <label style="text-align: left" for="member attributes">所属・役職</label>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->department) > 45) ? Str::truncate($items ->department, 40, '...') : $items ->department+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->name) > 45) ? Str::truncate($items ->name, 40, '...') : $items ->name+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->email) > 45) ? Str::truncate($items ->email, 40, '...') : $items ->email+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->tel) > 45) ? Str::truncate($items ->tel, 40, '...') : $items ->tel+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->fax) > 45) ? Str::truncate($items ->fax, 40, '...') : $items ->fax+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->zip) > 45) ? Str::truncate($items ->zip, 40, '...') : $items ->zip+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->address01) > 45) ? Str::truncate($items ->address01, 40, '...') : $items ->address01+]</label>
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
                                                        <label  style="text-align: left" for="member attributes">[+(strlen($items ->address02) > 45) ? Str::truncate($items ->address02, 40, '...') : $items ->address02+]</label>
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
                                    </div>
                                [+/foreach+]
                    [+else+]
                        <hr>
                        <div class="form-group">
                            <div  class="col-xs-2 col-xs-offset-2">
                                <label  style="" for="">サブ担当</label>
                            </div>
                            <div class="col-xs-4"></div>
                        </div>
                    [+/if+]

                     <hr>

                    <div class="form-group">
                        <div  class="col-xs-2 col-xs-offset-2">
                            <label class="control-common-label" style="text-align: left" for="name_member">備考</label>
                        </div>
                        
                        <div class="col-xs-6">
                            [+if isset($item->note)+]
                                <textarea class="form-control" name="note" rows="5" id="note" placeholder="備考" disabled>[+$item->note+]</textarea>
                            [+else+]
                                <textarea class="form-control" name="note" rows="5" id="note" placeholder="備考" disabled></textarea>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 col-md-offset-4 ">
                            <a href="manager/members/setting">
                                <button type="button" class="btn btn-md btn-primary">戻る</button>
                            </a>
                        </div>
                        <div class="col-md-4" style="margin-left: -7%;">
                            <button type="submit" name="submit" class="btn btn-md btn-primary">
                                会員としてセットする
                            </button>
                        </div>
                    </div>
                    [+/foreach+]
                    [+/if+]
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->