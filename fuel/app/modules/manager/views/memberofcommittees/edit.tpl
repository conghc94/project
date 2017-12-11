<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-success box-solid">
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
                        value = ['name' => 'editMember',
                        'method'    => 'post',
                        'action'    => 'manager/members/edit', 
                        'class'     => 'form-horizontal padding-top20',
                        'id'        => 'editMember'
                            ]+]

                    [+Form::open($formset)+]
                    <div class="form-group">
                        <div class="col-md-2 col-md-offset-1"><label class="control-common-label">会員属性</label></div>
                        <div class="col-md-4">
                            [+if isset($dataBaseofmember)+]
                                    [+Form::select('type', Input::post('type',$dataBaseofmember['type']), ['0' => 'なし', '1' => '企業', '2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control'])+]       
                            [+else+]
                                [+Form::select('type', Input::post('type'), ['0' => 'なし', '1' => '企業', '2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control'])+]
                            [+/if+]

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">会員フラグ</label>
                        <div class="col-sm-6">
                            [+if isset($dataBaseofmember)+]
                                    [+if ($dataBaseofmember['profile_flag'] == 0)+]
                                        <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" checked="true" value="0" required>RRI会員</label>
                                        <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="1" />RRI会員ではない</label>
                                    [+else+]
                                        <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="0">RRI会員</label>
                                        <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" checked="true" value="1">RRI会員ではない</label>
                                    [+/if+]
                            [+else+]
                                <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="0">RRI会員</label>
                                <label class="radio-inline"><input type="radio" name="profile_flag" id="profile_flag" value="1">RRI会員ではない</label>
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="name">会員名称</label>
                        <div class="col-sm-8">
                            [+if isset($dataBaseofmember['name'])+]
                                <input type="text" name="name" class="form-control" id="name" value="[+$dataBaseofmember['name']+]" placeholder="会員名称" />
                            [+else+]
                                <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name')+]" placeholder="会員名称" />
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="name_kana">会員名称(ふりがな)</label>
                        <div class="col-sm-8">
                            [+if isset($dataBaseofmember['name_kana'])+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+$dataBaseofmember['name_kana']+]" placeholder="会員名称(ふりがな)" />
                            [+else+]
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+Input::post('name_kana')+]" placeholder="会員名称(ふりがな)">
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="name_eng">会員名称(英語)</label>
                        <div class="col-sm-8">
                            [+if isset($dataBaseofmember['name_eng'])+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+$dataBaseofmember['name_eng']+]" placeholder="会員名称(英語)">
                            [+else+]
                                <input type="text" name="name_eng" class="form-control" id="name_eng" value="[+Input::post('name_eng')+]" placeholder="会員名称(英語)">
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1 text-left"  for="description">事業概要</label>
                        <div class="col-sm-8">
                            [+if isset($dataBaseofmember['description'])+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要">[+$dataBaseofmember['description']+]</textarea>
                            [+else+]
                                <textarea class="form-control" name="description" rows="5" id="description" placeholder="事業概要">[+Input::post('description')+]</textarea>
                            [+/if+]
                        </div>
                    </div>
                    <hr style="height: 1px; background: blue;">

                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">総会の出席</label>
                        <div class="col-sm-8">
                            [+if isset($dataMember)+]
                                    [+if isset($dataMember['attendance_of_meeting'])+]
                                        [+if ($dataMember['attendance_of_meeting'] == 0)+]
                                            <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="0">未定</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                                        [+elseif ($dataMember['attendance_of_meeting'] == 1)+]
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                            <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="1">代表者出席</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="2">代理者出席</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="9">欠席</label>
                                        [+elseif ($dataMember['attendance_of_meeting'] == 9)+]
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="0">未定</label>
                                            <label class="radio-inline"><input type="radio" name="attendance_of_meeting" value="1">代表者出席</label>
                                            <label class="radio-inline"><input type="radio" checked="true" name="attendance_of_meeting" value="2">代理者出席</label>
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
                            [+/if+]
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">総会の委任状</label>
                        <div class="col-sm-8" >
                            [+if isset($dataMember)+]
                                    [+if isset($dataMember['proxy_of_meeting'])+]
                                        [+if ($dataMember['proxy_of_meeting'] == 0)+]
                                            <label class="radio-inline"><input type="radio" checked="true" name="proxy_of_meeting" value="0">未定</label>
                                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="1">代理者委任状</label>
                                                <label class="radio-inline"><input type="radio" name="proxy_of_meeting" value="2">議長委任</label>
                                            [+elseif ($dataMember['proxy_of_meeting'] == 1)+]
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
                            [+/if+]
                        </div>
                    </div>

                    <hr style="height: 1px; background: blue;">

                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">代表者</label>
                        <div class="col-md-6">
                            [+if isset($dataDelegate)+]
                                [+foreach $dataDelegate as $item+]
                                    <label class="col-md-4"  style="text-align: left" for="member attributes">所属・役職</label>
                                    <label class="col-md-8"  style="text-align: left" for="member attributes">[+$item['department']+]</label>
                                    <label class="col-md-4"  style="text-align: left" for="member attributes">氏名</label>
                                    <label class="col-md-8"  style="text-align: left" for="member attributes">[+$item['name']+]</label>
                                    <input type="hidden" id="connect_type_delegate" name="connect_type_delegate" value="1">
                                [+/foreach+]

                            [+/if+]
                        </div>
                        <div class="col-md-2" style="
                             float: right; margin-right: 8%;">
                            <input type="hidden" id="check_delegate" name="check_delegate" value="">
                            [+if isset($dataDelegate)+]
                                <button type="button" id="delegate_setting" name="delegate_setting"  class="btn btn-primary col-md-12 " style="float: right;">
                                    代表者を変更する
                                </button>
                            [+else+]
                                <button type="button" id="delegate_setting" name="delegate_setting"  class="btn btn-primary col-md-12 " style="float: right;">
                                    代表者をセットする
                                </button>
                            [+/if+]
                            [+if isset($dataDelegate)+]
                                <button  type="button" id="edit_delegate" name="edit_delegate" class="btn btn-primary col-md-12 " style="
                                        float: right;
                                        margin-top: 10%;">代表者情報を編集する</button>
                                <input type="button" id="delete_delegate" name="delete_delegate" class="btn btn-primary col-md-12 " style="
                                        float: right;
                                        margin-top: 10%;" value="代表者を解除する" />
                            [+/if+]
                        </div>
                        <label class="col-md-12 col-md-offset-1"  style="text-align: left;" for="member attributes">担当者</label>
                    </div>

                    <hr style="height: 1px; background: blue;">

                    <div class="form-group">
                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">主担当</label>
                        [+if isset($dataMainCurator)+]
                        [+foreach $dataMainCurator as $items+]
                        <div class="col-md-6">
                            <label class="col-md-4"  style="text-align: left" for="member attributes">所属・役職</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->department+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">氏名</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->name+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">メール</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->email+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">電話</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->tel+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">FAX</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->fax+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">郵便番号</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->zip+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">住所1</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->address01+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">住所2</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->address02+]</label>
                            <label class="col-md-4"  style="text-align: left" for="member attributes">(ビル名・階数)</label>
                            <label class="col-md-8"  style="text-align: left" for="member attributes"></label>
                            <input type="hidden" id="connect_type_delegate" name="connect_type_main_curator" value="11">
                        </div>
                        [+/foreach+]
                        [+/if+]
                        <div class="col-md-2" style="
                             float: right; margin-right: 8%;" >
                            <input type="hidden" id="check_main_curator" name="check_main_curator" value="">
                            <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                            [+if isset($dataMainCurator)+]
                                <button type="button" id="main_curator" name="main_curator" class="btn btn-primary col-md-12 " style="float: right;">
                                    主担当を変更する
                                </button>
                            [+else+]
                                <button type="button" id="main_curator" name="main_curator" class="btn btn-primary col-md-12 " style="float: right;">
                                    主担当情報を編集する
                                </button>
                            [+/if+]
                            [+if isset($dataMainCurator)+]
                                <button type="button" id="edit_main_curator" class="btn btn-primary col-md-12 " style="float: right;margin-top: 10%;">主担当を解除する</button>
                                <input type="button" id="delete_main_curator" name="delete_main_curator" form="createMember" class="btn btn-primary col-md-12 " style="float: right;margin-top: 10%;" value="代表者を解除する" />
                            [+/if+]
                        </div>
                    </div>

                    [+if isset($arrayNewSubCurator)+]

                        <hr style="border-top: 1px dashed blue;">

                            [+for $i=0 to ($arrayNewSubCurator|@count - 1)+]

                                [+foreach $arrayNewSubCurator[$i] as $items+]

                                    <div class="form-group" id="form[+$i+]">
                                        
                                        <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">会員フラグ</label>
                                        
                                        <div class="col-md-6">
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">所属・役職</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->department+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">氏名</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->name+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">メール</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->email+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">電話</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->tel+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">FAX</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->fax+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">郵便番号</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->zip+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">住所1</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->address01+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">住所2</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes">[+$items->address02+]</label>
                                            <label class="col-md-4"  style="text-align: left" for="member attributes">(ビル名・階数)</label>
                                            <label class="col-md-8"  style="text-align: left" for="member attributes"></label>
                                        </div>

                                        <div class="col-md-2" style="float: right; margin-right: 8%;" >
                                            <input type="hidden" id="check_sub_curator" name="check_sub_curator" value="">

                                            <input type="hidden" id="check_number_id" name="check_number_id" value="[+$i+]">

                                            <a href="[+Uri::base()+]manager/curators/setting/[+$i+]"  style="float: right; margin-top: 10%;" class="btn btn-primary col-md-12">サブ担当を変更する</a>

                                            <!-- <button type="button" id="setting_new_sub_curator" value="setting_new_sub_curator"  name="setting_new_sub_curator" class="btn btn-primary col-md-12 " style="float: right;">サブ担当を変更する</button> -->

                                            <a href="[+Uri::base()+]manager/curators/edit/[+$i+]"  style="float: right; margin-top: 10%;" class="btn btn-primary col-md-12">サブ担当情報を編集する</a>

                                           <!--  <button type="button" id="edit_new_sub_curator_[+$i+]" class="btn btn-primary col-md-12" style="float: right;margin-top: 10%;">サブ担当情報を編集する</button> -->

                                           <!--  <input type="button" id="delete_new_sub_curator" name="delete_new_sub_curator[+$i+]" form="createMember" class="btn btn-primary col-md-12 "style="float: right;margin-top: 10%;" value="代表者を解除する" /> -->

                                           <a data-id="[+$i+]" style="float: right;margin-top: 10%;" class="deleteClick btn btn-primary col-md-12">サブ担当を解除する</a>

                                        </div>
                                    </div>

                                    <hr style="border-top: 1px dashed blue;" id="hr[+$i+]">

                                [+/foreach+]
                            [+/for+] 
                        
                            <div class="form-group">
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <button type="button" id="new_sub_curator" name="new_sub_curator" class="btn btn-primary col-md-4 col-md-offset-4 ">サブ担当を追加する</button>
                            </div>

                    [+else+]
                        <hr style="border-top: 1px dashed blue;">

                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">サブ担当</label>
                            <div class="col-md-2" style="float: right; margin-right: 8%;" >
                                <input type="hidden" id="check_new_sub_curator" name="check_new_sub_curator" value="">
                                <button type="button" id="sub_curator" value="sub_curator"  name="sub_curator" class="btn btn-primary col-md-12 " style="float: right;">サブ担当をセットする</button>
                            </div>    
                        </div>

                    [+/if+]

                     <hr style="height: 1px; background: blue;">

                    <div class="form-group">
                        
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member attributes">備考</label>

                        <div class="col-sm-8"> 
                            <textarea class="form-control" name="note" style="max-width: 100%;" rows="5" id="note" placeholder="備考"></textarea>
                        </div>
                    </div>
                    <div class="form-group">

                        <div class="col-md-2 col-md-offset-4">
                            <button type="button" id ="delete_member" name="delete_member" class="btn btn-md btn-primary btn-lg">
                                削除
                            </button>
                        </div>

                        <div class="col-md-6">
                            <input type="hidden" id="checkbutton" name="checkbutton" value="">
                            <button type="button" id ="submit_edit" name="submit_edit" class="btn btn-md btn-primary btn-lg">
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
[+Asset::js(array('membermanage/member_edit.js'))+]
<script >

    $('.deleteClick').click(function(){
        if (confirm("Are you sure you want to delete?") == true) 
            {
                var result;
                var id = $(this).data('id');

                console.log(id);

                var data ={
                    'id': id
                };

                $.ajax({
                      type: "POST",
                      url: 'http://localhost/member/public/manager/curators/deletetest',
                      data: data,
                      success: function(data){
                        console.log(data);
                        result = data;
                      },
                    });

                // lay id cua cai form mình muon xoa

                // dung jquery xoa han di

                // kieam tra array neu phu phu het roi thi mình edit button

                location.reload();

                return result;
            }
    });

</script>