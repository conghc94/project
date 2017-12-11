[+Asset::css(array('site/representative.css'))+]
<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    <div class="col-xs-3" style="margin-left: 37%">
                        <button type="button" name="createDelegate" id="createDelegate" class="btn btn-primary btn-block">代表者の新規登録</button>
                    </div>

                    <div class="col-xs-12">
                        <hr/>
                    </div>

                    [+assign var = formset 
                    value = ['name' => 'settingDelegates',
                    'method'    => 'GET',
                    'action'    => 'manager/delegates/search',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'settingDelegates'
                    ]+]

                    [+Form::open($formset)+]

                    <div class="col-xs-12">
                        <div class="form-group">
                            <h3 class="col-xs-4 col-xs-offset-1" class="font-bold">代表者の検索</h3>
                        </div>
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">会員名称</div>
                            <div class="col-xs-6">
                                <input type="text" name="name_member" class="form-control" value="[+Input::get('name_member')+]" id="name_member" placeholder="会員名称">
                            </div>
                            <div class="col-xs-2">
                                <input type="submit" value="検索"  style="" class="btn btn-primary btn-block">    
                            </div>                            
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">氏名</div>
                            <div class="col-xs-6">
                                <input type="text" name="name" class="form-control" value="[+Input::get('name')+]" id="name" placeholder="氏名">
                            </div>
                        </div>
                        <!--所属・役職: group -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">所属・役職</div>
                            <div class="col-xs-6">
                                <input type="text" name="department" value="[+Input::get('department')+]" class="form-control" id="department" placeholder="所属・役職">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">メールアドレス</div>
                            <div class="col-xs-6">
                                <input type="text" name="email" value="[+Input::get('email')+]" class="form-control" id="email" placeholder="メールアドレス">
                            </div>
                        </div>
                        <!--ソート順: sort ordering -->
                        <div id ="form-group" class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">ソート順</div>
                            <div class="col-xs-6">
                                [+Form::select('sort', Input::get('sort', ''),
                                ['0'    => '会員名称(ふりがな)  昇順',
                                '1'    => '会員名称(ふりがな)  降順',
                                '2'             => '氏名(ふりがな)  昇順',
                                '3'            => '氏名(ふりがな)  降順',
                                '4'                     => 'No. 昇順',
                                '5'                    => 'No. 降順'], ['class' => 'form-control'])+]
                            </div>
                        </div>

                    </div>
                    [+Form::close()+]

                    <div class="col-md-12">
                        <hr/>
                    </div>

                    [+if Session::get_flash('error') +]
                        [+$error = Session::get_flash('error')+]
                        <div class="row">
                            <div class="col-md-4 col-md-offset-4">
                            <div class="alert alert-danger alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <strong>一致するレコードが見つかりません</strong>
                           </div>
                          </div>
                         </div>
                    [+else+]
                        <div class="settingPagination" style="text-align: center" >
                            [+if isset($pagination)+]
                            [+html_entity_decode($pagination)+]
                            [+/if+]
                        </div>

                        [+if isset($delegates)+]
                        <table class="table">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>会員名称</th>       <!--name member-->
                                    <th>区分</th>         <!--Classification -->
                                    <th>お名前</th>           <!--name-->
                                    <th>所属・役職</th>         <!--Department -->
                                    <th style="width: 110px">メールアドレス</th>     <!--mail address-->
                                    <th>住所</th>               <!--Street address-->
                                    <th>電話</th>               <!--Telephone-->
                                    <th>FAX</th>                <!--FAX-->
                                </tr>
                            </thead>
                            <tbody>
                                [+foreach $delegates as $item+]
                                <tr>
                                    <td>
                                        <a class="btn btn-primary" role="button" href="[+Uri::base()+]manager/delegates/view?id=[+$item->id+]">確認</a>
                                    </td>
                                    <td>[+(strlen($item->name_member) > 15) ? Str::truncate($item->name_member, 10, '...') : $item->name_member+]</td>
                                    <td>
                                        [+if ($item->connect_type ==0)+]
                                                連携なし
                                            [+else if ($item->connect_type ==1)+]
                                                会員代表者
                                            [+else if ($item->connect_type ==2)+]
                                                RRI役員
                                            [+else if ($item->connect_type ==11)+]
                                                会員主担当
                                            [+else if ($item->connect_type ==12)+]
                                                会員サブ担当
                                            [+else if ($item->connect_type ==21)+]
                                                役員主担当
                                            [+else if ($item->connect_type ==22)+]
                                                役員サブ担当
                                            [+else if ($item->connect_type ==31)+]
                                                委員会所属メンバー
                                        [+/if+]
                                    </td>
                                    <td>[+(strlen($item->name) > 15) ? Str::truncate($item->name, 10, '...') : $item->name+]</td>
                                    <td>[+(strlen($item->department) > 15) ? Str::truncate($item->department, 10, '...') : $item->department+]</td>
                                    <td>[+(strlen($item->email) > 15) ? Str::truncate($item->email, 10, '...') : $item->email+]</td>
                                    <td>[+(strlen($item->address01) > 15) ? Str::truncate($item->address01, 10, '...') : $item->address01+]</td>
                                    <td>[+(strlen($item->tel) > 15) ? Str::truncate($item->tel, 10, '...') : $item->tel+]</td>
                                    <td>[+(strlen($item->fax) > 15) ? Str::truncate($item->fax, 10, '...') : $item->fax+]</td>
                                </tr>
                                [+/foreach+]
                            </tbody>
                        </table>
                        [+else+]
                           
                        [+/if+]
                        <div class="settingPagination" style="text-align: center" >
                            [+if isset($pagination)+]
                            [+html_entity_decode($pagination)+]
                            [+/if+]
                        </div>
                    [+/if +]
                    <div class="col-xs-2 col-xs-offset-5 padding-top-30">
                        [+if ($back)+]
                            <a href="[+$back+]">
                                <button name="backFromSettingDelegates" id="backFromSettingDelegates" type="button" class="btn btn-primary btn-block ">戻る</button>
                            </a>
                        [+else+]
                            <a href="[+Uri::base()+]manager/members/create">
                            <button name="backFromSettingDelegates" id="backFromSettingDelegates" type="button" class="btn btn-primary btn-block">戻る</button>
                            </a>
                        [+/if+]
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/delegate_search.js'))+]
