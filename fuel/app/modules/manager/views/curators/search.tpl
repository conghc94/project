[+Asset::css(array('site/representative.css'))+]
<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    <div class="col-xs-3" style="margin-left: 37%">
                        <button type="button" name="createCurator" id="createCurator" class="btn btn-primary btn-block">担当の新規登録</button>
                    </div>
                    <div class="col-xs-12">
                        <hr>
                    </div>
                    [+assign var = formset 
                    value = ['name' => 'settingCurators',
                    'method'    => 'GET',
                    'action'    => Uri::base()+'manager/curators/search',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'settingDelegates'
                    ]+]

                    [+Form::open($formset)+]
                    <div class="col-xs-12">
                        <div class="form-group">
                            <h3 class="col-xs-4 col-md-offset-1">担当の検索</h3>
                        </div>
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">会員名称</div>
                            <div class="col-xs-6">
                                <input type="text" name="name_member" class="form-control" id="name_member" placeholder="会員名称">
                            </div>
                            <div class="col-xs-2">
                                <input type="submit" value="検索"  style="" class="btn btn-primary btn-block">    
                            </div>                            
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">氏名</div>
                            <div class="col-xs-6">
                                <input type="text" name="name" class="form-control" id="name" placeholder="氏名">
                            </div>
                        </div>
                        <!--所属・役職: group -->
                        <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">所属・役職</div>
                            <div class="col-xs-6">
                                <input type="text" name="department" class="form-control" id="department" placeholder="所属・役職">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">メールアドレス</div>
                            <div class="col-xs-6">
                                <input type="text" name="email" class="form-control" id="email" placeholder="メールアドレス">
                            </div>
                        </div>
                        <!--ソート順: sort ordering -->
                        <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">ソート順</div>
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
                    <div class="col-xs-12">
                        <hr>
                    </div>
                    [+if Session::get_flash('error') +]
                        [+$error = Session::get_flash('error')+]
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3">
                            <div class="alert alert-danger alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <strong>一致するレコードが見つかりません</strong>
                           </div>
                          </div>
                         </div>
                    [+else+]
                        <div class="searchPagination" style="text-align: center" >
                            [+if isset($pagination)+]
                            [+html_entity_decode($pagination)+]
                            [+/if+]
                        </div>

                        [+if isset($curators)+]
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>会員名称</th>      
                                    <th>区分</th>        
                                    <th>お名前</th>           
                                    <th>所属・役職</th>       
                                    <th style="width: 110px">メールアドレス</th>     
                                    <th>住所</th>              
                                    <th>電話</th>              
                                    <th>FAX</th>           
                                </tr>
                            </thead>
                            <tbody>
                                [+foreach $curators as $item+]<tr>
                                    <td>
                                        <a class="btn btn-info" role="button" href="[+Uri::base()+]manager/curators/view?id=[+$item->id+]">確認</a>
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
                                [+/foreach+]	</tbody>
                        </table>
                        [+else+]
                        [+/if+]

                        <div class="searchPagination" style="text-align: center" >
                            [+if isset($pagination)+]
                            [+html_entity_decode($pagination)+]
                            [+/if+]
                        </div>
                    [+/if+]

                    <div class="col-md-2 col-md-offset-5">
                        [+if ($back)+]
                            <a href="[+$back+]">
                                <button name="backFromSearchCurators" id="backFromSearchCurators" type="button" class="btn btn-primary btn-block ">戻る</button>
                            </a>

                        [+else+]
                            <a href="[+Uri::base()+]manager/members/create">
                            <button name="backFromSearchCurators" id="backFromSearchCurators" type="button" class="btn btn-primary btn-block">戻る</button></a>
                        [+/if+]
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/curator_search.js'))+]
