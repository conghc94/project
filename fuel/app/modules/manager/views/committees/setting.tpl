<!--Thiết lập member uy vien hoi (S009) 1 -->

<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-success box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    <div class="col-md-4 col-md-offset-4">
                        <a href="manager/committees/create"><button type="button"  class="btn btn-primary btn-block">メンバーの新規登録</button></a>
                    </div>
                    <div class="col-md-12">
                        <hr style="height: 2px; background: blue;" />
                    </div>
                    
                    
                    [+assign var = formset 
                    value = ['name' => 'settingCommittees',
                    'method'    => 'GET',
                    'action'    => 'manager/committees/search',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'settingOfficers'
                    ]+]

                    [+Form::open($formset)+]

                    <div class="col-lg-10">
                        <div class="form-group">
                           <h3 class="col-md-4 col-md-offset-1" style="font-weight: bold">メンバーの検索</h3>
                        </div>
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="member_name">会員名称</label>
                            <div class="col-sm-8">
                                <input type="text" name="member_name" class="form-control" id="member_name" placeholder="会員名称">
                            </div>
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="name">氏名</label>
                            <div class="col-sm-8">
                                <input type="text" name="name" class="form-control" id="name" placeholder="氏名">
                            </div>
                        </div>
                        <!--所属・役職: department -->
                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="department">所属・役職</label>
                            <div class="col-sm-8">
                                <input type="text" name="department" class="form-control" id="department" placeholder="所属・役職">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="'email">メールアドレス</label>
                            <div class="col-sm-8">
                                <input type="text" name="email" class="form-control" id="email" placeholder="メールアドレス" value="[+Input::get('email')+]">
                            </div>
                        </div>
                        [+for $i=1 to 20+]
                        <!--カスタム入力項目1: custom input 1 -->
                        <div class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="'custom_input_[+$i+]">カスタム入力項目[+$i+]</label>
                            <div class="col-sm-8">
                                <input type="text" name="custom_input_[+$i+]" class="form-control" id="custom_input_[+$i+]" placeholder="カスタム入力項目[+$i+]">
                            </div>
                        </div>
                        [+/for+]
                        <!--ソート順: sort ordering -->
                        <div id ="form-group" class="form-group">
                            <label class="col-md-2 col-md-offset-1"  style="text-align: left" for="sort">ソート順</label>
                            <div class="col-sm-8">
                               [+Form::select('sort', Input::post('sort', ''), 
                                ['base_of_members.name_kana_ASC' => '会員名称(ふりがな)  昇順',
                                'base_of_members.name_kana_DESC' => '会員名称(ふりがな)  降順',
                                'persons.name_kana_ASC'         => '氏名(ふりがな)  昇順',
                                'persons.name_kana_DESC'        => '氏名(ふりがな)  降順',
                                'persons.id_ASC'                => 'No. 昇順',
                                'persons.id_DESC'               => 'No. 降順'], ['class' => 'form-control'])+]
                            </div>
                        </div>
                        
                        
                    </div>
                    <div class="col-lg-2" style="margin-left: -40px; margin-top: 80px " >
                            <input type="submit" value="検索"  style="" class="btn btn-primary btn-lg btn-block">    
                    </div>
                    [+Form::close()+]
                    <div class="col-md-12">
                        <hr style="height: 1px; background: blue;" />
                    </div>
                    
                    <div class="col-md-7 col-md-offset-3" >
                        [+if isset($pagination)+]
                        [+html_entity_decode($pagination)+]
                        [+/if+]
                    </div>

                    [+if isset($member)+]
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th></th>
                                <th>会員名称</th>       <!--member name -->
                                <th>区分</th>         <!--Classification -->
                                <th>お名前</th>           <!--name-->
                                <th>所属・役職</th>         <!--department -->
                                <th>メールアドレス</th>     <!--mail address-->
                                <th>住所</th>               <!--Street address-->
                                <th>電話</th>               <!--Telephone-->
                                <th>FAX</th>                <!--FAX-->
                            </tr>
                        </thead>
                        <tbody>
                            [+foreach $member as $item+]<tr>
                                <td>
                                    <a href="[+Uri::base()+]manager/officers/view/[+$item->id+]"><button type="button" name="[+$item->id+]" class="btn btn-primary btn-xs" action="[+Uri::base()+]manager/officers/view/[+$item->id+]">確認</button></a>
                                </td>
                                <td>[+$item->name_member+]</td>
                                <td>
                                [+if ($item->connect_type == 0)+]
                                        連携な
                                    [+else if ($item->connect_type == 1)+]
                                        会員代表者
                                    [+else if ($item->connect_type == 2)+]
                                        RRI役員
                                    [+else if ($item->connect_type == 11)+]
                                        会員主担当
                                    [+else if ($item->connect_type == 12)+]
                                        会員サブ担当
                                    [+else if ($item->connect_type == 21)+]
                                        役員主担当
                                    [+else if ($item->connect_type == 22)+]
                                        役員サブ担当
                                    [+else if ($item->connect_type == 31)+]
                                        委員会所属メンバー
                                [+/if+]    
                                </td>
                                <td>[+$item->name+]</td>
                                <td>[+$item->department+]</td>
                                <td>[+$item->email+]</td>
                                <td>[+$item->address01+]</td>
                                <td>[+$item->tel+]</td>
                                <td>[+$item->fax+]</td>
                            </tr>
                            [+/foreach+]    </tbody>
                    </table>
                    [+else+]
                    [+/if+]

                    <div class="col-md-7 col-md-offset-3" >
                        [+if isset($pagination)+]
                        [+html_entity_decode($pagination)+]
                        [+/if+]
                    </div>

                    <div class="col-md-3 col-md-offset-4">
                    [+if isset($back)+]
                    <a href="[+$back+]">
                        <button type="button" class="btn btn-primary btn-block">戻る</button>
                    </a>
                    [+else+]
                        <button type="button" class="btn btn-primary btn-block">戻る</button>
                    [+/if+]
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</section>
<!-- /.content -->