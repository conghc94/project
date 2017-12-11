<section class="content">
[+Asset::css(array('site/member.css'))+]
    <div class="row">
        <div class="col-xs-8 col-md-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    [+if Session::get_flash('error') +]
                        [+$error = Session::get_flash('error') +]
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
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
                            <div class="col-xs-8 col-xs-offset-1">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <strong>おめでとうございます</strong>[+foreach $success as $one+]<br>[+$one+][+/foreach+]
                                </div>
                            </div>
                        </div>
                    [+/if +]
                    [+assign var = formset 
                    value = ['name' => 'createMember',
                    'method'    => 'post',
                    'action'    => 'manager/members/create', 
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'createMember'
                    ]+]
                    [+Form::open($formset)+]
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 lb-required">
                            <label class="control-common-label"><span class="label label-primary">必須</span>会員属性</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['type'])+]
                                [+Form::select('type', Input::post('type',$dataBaseofmember['type'] ), ['' => '','1' => '企業', '2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
                            [+else+]
                                [+Form::select('type', Input::post('type',$dataBaseofmember['type'] ), ['' => '','1' => '企業', '2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control'])+]
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 lb-required">
                            <label class="control-common-label"><span class="label label-primary">必須</span>会員フラグ</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['profile_flag'])+]
                                [+if ($dataBaseofmember['profile_flag'] == 1)+]
                                    <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" checked="true" value="1" required>RRI会員</label>
                                    <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="0" />RRI会員ではない</label>
                                [+else+]
                                    <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="1">RRI会員</label>
                                    <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" checked="true" value="0">RRI会員ではない</label>
                                [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="1">RRI会員</label>
                                <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="0">RRI会員ではない</label>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 lb-required">
                            <label class="control-common-label"><span class="label label-primary">必須</span>会員名称</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['name_member'])+]
                                <input type="text" name="name" class="form-control" id="name" value="[+$dataBaseofmember['name_member']+]" placeholder="会員名称" />
                            [+else+]
                                <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name')+]" placeholder="会員名称" />
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 lb-required">
                            <label  class="control-common-label"><span class="label label-primary">必須</span>会員名称(ふりがな)</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['name_member_kana'])+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+$dataBaseofmember['name_member_kana']+]" placeholder="会員名称(ふりがな)" />
                            [+else+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+$dataBaseofmember['name_member_kana']+]" placeholder="会員名称(ふりがな)">
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 lb-required">
                            <label  class="control-common-label" for="name_eng"><span class="label label-primary">必須</span>会員名称(英語)</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['name_eng'])+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+$dataBaseofmember['name_eng']+]" placeholder="会員名称(英語)">
                            [+else+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+$dataBaseofmember['name_eng']+]" placeholder="会員名称(英語)">
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 padding-left-45 lb-required">
                            <label class="control-common-label">事業概要</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataBaseofmember['description'])+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要">[+$dataBaseofmember['description']+]</textarea>
                            [+else+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要">[+Input::post('description')+]</textarea>
                            [+/if+]
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 padding-left-45 lb-required">
                            <label class="control-common-label">総会の出席</label>
                        </div>
                        <div class="col-xs-7 lb-radio">
                            [+if isset($dataMember['attendance_of_meeting'])+]
                                [+if ($dataMember['attendance_of_meeting'] == 0)+]
                                    <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                                [+elseif ($dataMember['attendance_of_meeting']==1)+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="1">代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                                [+elseif ($dataMember['attendance_of_meeting']==1)+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                    <label class="radio-inline"><input type="radio" checked="true"name="attendance_of_meeting" value="2">代理者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                                [+else+]
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                    <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                    <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="9">欠席</label>
                                [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 padding-left-45 lb-required">
                            <label class="control-common-label">総会の委任状</label>
                        </div>
                        <div class="col-xs-7 lb-radio">
                            [+if isset($dataMember['proxy_of_meeting'])+]
                                [+if ($dataMember['proxy_of_meeting'] == 0)+]
                                <label class="radio-inline"><input type="radio" checked="true" name="proxy_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="1">代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="2">議長委任</label>
                                [+elseif ($dataMember['proxy_of_meeting']==1)+]
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" checked="true" name="proxy_of_meeting" value="1">代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="2">議長委任</label>
                                [+else+]
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="0">未定</label>
                                    <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="1">代理者委任状</label>
                                    <label class="radio-inline"><input type="radio" checked="true" name="proxy_of_meeting" value="2">議長委任</label>
                                [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="0">未定</label>
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="1">代理者委任状</label>
                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="2">議長委任</label>
                            [+/if+]
                        </div>
                    </div>
                    <hr>
                   <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-1 lb-required">
                            <label class="control"><span class="label label-primary">必須</span>代表者</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataDelegate)+]
                                [+foreach $dataDelegate as $item+]
                                    <div class="col-xs-12">
                                        <div class="col-xs-12" style="float:left">
                                            <div class="col-xs-5">
                                                <label style="text-align: left">所属・役職</label>
                                            </div>
                                            <div class="col-xs-7">
                                                [+if ($item->department)+]
                                                <label  style="text-align: left">[+(strlen($item->department) > 25) ? Str::truncate($item->department, 20, '...') : $item->department+]</label>
                                                [+/if+]
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="col-xs-5">
                                                <label style="text-align: left">氏名</label>
                                            </div>
                                            <div class="col-xs-7">
                                                [+if ($item->name)+]
                                                <label  style="text-align: left">[+(strlen($item->name) > 25) ? Str::truncate($item->name, 20, '...') : $item->name+]</label>
                                                [+/if+]
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" id="connect_type_delegate" name="connect_type_delegate" value="1">
                                [+/foreach+]
                            [+/if+]
                        </div>
                        <div class="col-xs-3 btn-right-side">
                            <input type="hidden" id="check_delegate" name="check_delegate" value="">
                            [+if isset($dataDelegate)+]
                                <button type="button" id="delegate_setting" name="delegate_setting"  class="btn btn-primary col-md-12 font-size-12" style="float: right;">
                                    代表者を変更する
                                </button>
                            [+else+]
                                <button type="button" id="delegate_setting" name="delegate_setting"  class="btn btn-primary col-md-12 font-size-12" style="float: right;">
                                    代表者をセットする
                                </button>
                            [+/if+]
                            [+if isset($dataDelegate)+]
                                [+foreach $dataDelegate as $item+]
                                <a type="button" href="[+Uri::base()+]manager/persons/editinfo/[+$item->id+]" class="btn btn-primary col-md-12 font-size-12"  style="float: right;margin-top: 10%;">代表者情報を編集する</a>
                                <input type="button" id="delete_delegate" name="delete_delegate" class="btn btn-primary col-md-12 font-size-12" style="
                                        float: right;
                                        margin-top: 10%;" value="代表者を解除する" />
                                [+/foreach+]
                            [+/if+]
                        </div>
                        [+if isset($dataDelegate)+]
                            <div class="col-xs-12 col-xs-offset-1 padding-left-45">
                                <label class="control-common-label">担当者</label>
                            </div>
                        [+else+]
                            <div class="col-xs-12 col-xs-offset-1 padding-left-45 padding-top-60">
                                <label class="control-common-label">担当者</label>
                            </div>
                        [+/if+]
                    </div>
                    <hr>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-1 lb-required">
                            <label class="control"><span class="label label-primary">必須</span>主担当</label>
                        </div>
                        <div class="col-xs-5">
                            [+if isset($dataMainCurator)+]
                                [+foreach $dataMainCurator as $items+]
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">所属・役職</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <label  style="text-align: left">
                                                        [+if ($items->department)+]
                                                        [+(strlen($items->department) > 25) ? Str::truncate($items->department, 20, '...') : $items->department+][+/if+]
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">氏名</label>
                                                </div>
                                                <div class="col-md-7">
                                                <label  style="text-align: left" for="member attributes">
                                                [+if ($items->name)+]
                                                [+(strlen($items ->name) > 25) ? Str::truncate($items ->name, 20, '...') : $items ->name+][+/if+]
                                                </label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">メール</label>
                                                </div>
                                                <div class="col-md-7">
                                                <label  style="text-align: left" for="member attributes">[+if ($items->email)+][+(strlen($items ->email) > 20) ? Str::truncate($items ->email, 15, '...') : $items ->email+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">電話</label>
                                                </div>
                                                <div class="col-md-7">
                                                <label  style="text-align: left" for="member attributes">[+if ($items->tel)+][+(strlen($items ->tel) > 25) ? Str::truncate($items ->tel, 20, '...') : $items ->tel+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">FAX</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <label  style="text-align: left" for="member attributes">[+if ($items->fax)+][+(strlen($items ->fax) > 25) ? Str::truncate($items ->fax, 20, '...') : $items ->fax+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">郵便番号</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <label  style="text-align: left" for="member attributes">[+if ($items->zip)+][+(strlen($items ->zip) > 25) ? Str::truncate($items ->zip, 20, '...') : $items ->zip+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">住所1</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <label  style="text-align: left" for="member attributes">[+if ($items->address01)+][+(strlen($items ->address01) > 25) ? Str::truncate($items ->address01, 20, '...') : $items ->address01+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <label style="text-align: left">住所2</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <label  style="text-align: left" for="member attributes">[+if ($items->address02)+][+(strlen($items ->address02) > 25) ? Str::truncate($items ->address02, 20, '...') : $items ->address02+][+/if+]</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label style="text-align: left" for="member attributes">(ビル名・階数)</label>
                                                </div>
                                            </div>
                                        </div>
                                <input type="hidden" id="connect_type_delegate" name="connect_type_main_curator" value="11">
                                [+/foreach+]
                            [+/if+]
                            </div>
                        <div class="col-xs-3 btn-right-side">
                            <input type="hidden" id="check_main_curator" name="check_main_curator" value="">
                            <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                            [+if isset($dataMainCurator)+]
                                <button type="button" id="main_curator" name="main_curator" class="btn btn-primary col-md-12 font-size-12" style="float: right;">
                                    主担当を変更する
                                </button>
                            [+else+]
                                <button type="button" id="main_curator" name="main_curator" class="btn btn-primary col-md-12 font-size-12" style="float: right;">
                                    主担当をセットする
                                </button>
                            [+/if+]
                            [+if isset($dataMainCurator)+]
                                [+foreach $dataMainCurator as $items+]                                    
                                <a type="button" href="[+Uri::base()+]manager/persons/editinfo/[+$items->id+]" class="btn btn-primary col-md-12 font-size-12" style="float: right;margin-top: 10%;">主担当情報を編集する</a>
                                [+/foreach+]
                                <input type="button" id="delete_main_curator" name="delete_main_curator" form="createMember" class="btn btn-primary col-md-12 font-size-12" style="float: right;margin-top: 10%;" value="主担当を解除する" />
                            [+/if+]
                        </div>
                         <div class="col-md-12">
                            <div class="col-md-1 col-md-offset-1">
                            </div>
                            <div class="col-md-2" style="margin-left: -1%;">
                            </div>
                        </div>
                    </div>
                    [+if isset($arrayNewSubCurator)+]
                        <hr>
                            [+for $i=0 to ($arrayNewSubCurator|@count - 1)+]
                                [+foreach $arrayNewSubCurator[$i] as $items+]
                                    <div class="form-group">
                                            <div class="col-xs-2 col-xs-offset-1 padding-left-45 lb-required">
                                                <label class="control">サブ担当</label>
                                            </div>
                                            <div class="col-xs-5">
                                                <div class="col-md-12">
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">所属・役職</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label  style="text-align: left" for="member attributes">
                                                                [+if ($items->department)+]
                                                                [+(strlen($items->department) > 25) ? Str::truncate($items->department, 20, '...') : $items->department+][+/if+]
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">氏名</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                        <label  style="text-align: left" for="member attributes">
                                                        [+if ($items->name)+]
                                                        [+(strlen($items ->name) > 25) ? Str::truncate($items ->name, 20, '...') : $items ->name+][+/if+]
                                                        </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">メール</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                        <label  style="text-align: left" for="member attributes">[+if ($items->email)+][+(strlen($items ->email) > 20) ? Str::truncate($items ->email, 15, '...') : $items ->email+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">電話</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                        <label  style="text-align: left" for="member attributes">[+if ($items->tel)+][+(strlen($items ->tel) > 25) ? Str::truncate($items ->tel, 20, '...') : $items ->tel+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">FAX</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label  style="text-align: left" for="member attributes">[+if ($items->fax)+][+(strlen($items ->fax) > 25) ? Str::truncate($items ->fax, 20, '...') : $items ->fax+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">郵便番号</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label  style="text-align: left" for="member attributes">[+if ($items->zip)+][+(strlen($items ->zip) > 25) ? Str::truncate($items ->zip, 20, '...') : $items ->zip+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">住所1</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label  style="text-align: left" for="member attributes">[+if ($items->address01)+][+(strlen($items ->address01) > 25) ? Str::truncate($items ->address01, 20, '...') : $items ->address01+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-5">
                                                            <label style="text-align: left">住所2</label>
                                                        </div>
                                                        <div class="col-md-7">
                                                            <label  style="text-align: left" for="member attributes">[+if ($items->address02)+][+(strlen($items ->address02) > 25) ? Str::truncate($items ->address02, 20, '...') : $items ->address02+][+/if+]</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <label style="text-align: left" for="member attributes">(ビル名・階数)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 btn-right-side">
                                                <input type="hidden" id="check_sub_curator" name="check_sub_curator" value="">
                                                <input type="hidden" id="check_number_id" name="check_number_id" value="[+$i+]">
                                                <a href="[+Uri::base()+]manager/curators/setting/[+$i+]"  style="float: right; margin-top: 10%;" class="btn btn-primary col-md-12 font-size-12">サブ担当を変更する</a>
                                                <a href="[+Uri::base()+]manager/persons/editinfo/[+$items->id+]"  style="float: right; margin-top: 10%;" class="btn btn-primary col-md-12 font-size-12">サブ担当情報を編集する</a>
                                                <a data-id="[+$i+]" style="float: right;margin-top: 10%;" class="deleteClick btn btn-primary col-md-12 font-size-12">サブ担当を解除する</a>
                                            </div>
                                    </div>
                                    <hr>
                                [+/foreach+]
                            [+/for+] 
                            <div class="form-group">
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <button type="button" id="new_sub_curator" name="new_sub_curator" class="btn btn-primary col-md-4 col-md-offset-4 font-size-12">サブ担当を追加する</button>
                            </div>
                    [+else+]
                        <hr>
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-1 padding-left-45 lb-required">
                                <label class="control-common-label">サブ担当</label>
                            </div>
                            <div class="col-xs-3">
                            </div>
                            <div class="col-xs-3 btn-right-side">
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <button type="button" id="sub_curator" value="sub_curator"  name="sub_curator" class="btn btn-primary col-md-12 font-size-12" style="float: right;">サブ担当をセットする</button>
                            </div>    
                        </div>

                    [+/if+]

                    <hr>

                    <div class="form-group">
                        <div class="col-xs-3 col-xs-offset-1 padding-left-45 lb-required">
                            <label class="control-common-label" style="text-align: left" >備考</label>
                        </div>
                        
                        <div class="col-xs-5">
                            [+if isset($dataMember['note'])+]
                                <textarea class="form-control" name="note" rows="5" id="note" placeholder="備考">[+$dataMember['note']+]</textarea>
                            [+else+]
                                <textarea class="form-control" name="note" rows="5" id="note" placeholder="備考">[+Input::post('note')+]</textarea>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">

                        <div class="col-md-4 col-md-offset-5">
                            <input type="hidden" id="checkbutton" name="checkbutton" value="">
                            <button type="button" id ="submit_create" name="submit_create" class="btn btn-md btn-primary col-md-4">
                                登録
                            </button>
                        </div>

                    </div>

                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/member_create.js'))+]
