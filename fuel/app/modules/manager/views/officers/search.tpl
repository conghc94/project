<!--Thiết lập cong chuc(S006) 2 -->
[+Asset::css(array('site/representative.css'))+]
[+Asset::css(array('site/common.css'))+]
<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    <div class="col-md-3" style="margin-left: 37%">
                        <a href="manager/officers/create"><button type="button"  class="btn btn-primary btn-block">役員の新規登録</button></a>
                    </div>

                    <div class="col-md-12">
                        <hr>
                    </div>


                    [+assign var = formset 
                    value = ['name' => 'settingOfficers',
                    'method'    => 'GET',
                    'action'    => Uri::base()+'manager/officers/search',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'settingOfficers'
                    ]+]

                    [+Form::open($formset)+]

                    <div class="col-xs-12">
                        <div class="form-group">
                            <h3 class="col-xs-4 col-md-offset-1" style="font-weight: bold">役員の検索</h3>
                        </div>
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="member_name">会員名称</label>
                            <div class="col-xs-6">
                                <input type="text" name="member_name" class="form-control" id="member_name" placeholder="会員名称" value="[+Input::get('member_name')+]">
                            </div>
                            <div class="col-xs-2">
                                <input type="submit" value="検索"  style="" class="btn btn-primary btn-block">    
                            </div>
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="name">氏名</label>
                            <div class="col-xs-6">
                                <input type="text" name="name" class="form-control" id="name" placeholder="氏名" value="[+Input::get('name')+]">
                            </div>
                        </div>
                        <!--所属・役職: group -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="group">所属・役職</label>
                            <div class="col-xs-6">
                                <input type="text" name="department" class="form-control" id="department" placeholder="所属・役職" value="[+Input::get('department')+]">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="'email">メールアドレス</label>
                            <div class="col-xs-6">
                                <input type="text" name="email" class="form-control" id="email" placeholder="メールアドレス" value="[+Input::get('email')+]">
                            </div>
                        </div>
                        <!--ソート順: sort ordering -->
                        <div id ="form-group" class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="sort">ソート順</label>
                            <div class="col-xs-6">
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

                    [+if isset($member)+]
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th width="50px"></th>
                                <th >会員名称</th>       <!--member name -->
                                <th >区分</th>         <!--Classification -->
                                <th >お名前</th>           <!--name-->
                                <th >所属・役職</th>         <!--department -->
                                <th style="width: 110px">メールアドレス</th>     <!--mail address-->
                                <th >住所</th>               <!--Street address-->
                                <th >電話</th>               <!--Telephone-->
                                <th >FAX</th>                <!--FAX-->
                            </tr>
                        </thead>
                        <tbody>
                            [+foreach $member as $item+]<tr>
                                <td >
                                    <a href="[+Uri::base()+]manager/officers/view/[+$item->id+]"><button type="button" name="[+$item->id+]" class="btn btn-primary btn-xs" action="[+Uri::base()+]manager/officers/view/[+$item->id+]">確認</button></a>
                                </td>
                                <td >[+(strlen($item->name_member) > 20) ? Str::truncate($item->name_member, 20, '...') : $item->name_member+]</td>
                                <td >
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
                                <td >[+(strlen($item->name) > 20) ? Str::truncate($item->name, 20, '...') : $item->name+]</td>
                                <td >[+(strlen($item->department) > 20) ? Str::truncate($item->department, 20, '...') : $item->department+]</td>
                                <td >[+(strlen($item->email) > 20) ? Str::truncate($item->email, 20, '...') : $item->email+]</td>
                                <td >[+(strlen($item->address01) > 20) ? Str::truncate($item->address01, 20, '...') : $item->address01+]</td>
                                <td >[+(strlen($item->tel) > 20) ? Str::truncate($item->tel, 20, '...') : $item->tel+]</td>
                                <td >[+(strlen($item->fax) > 20) ? Str::truncate($item->fax, 20, '...') : $item->fax+]</td>
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
                    <div class="col-md-2 col-md-offset-5 back-btn">
                        [+if ($back)+]
                        <a href="[+$back+]">
                            <button type="button" class="btn btn-primary btn-block col-md-5">戻る</button>
                        </a>
                        [+else+]
                            <button type="button" class="btn btn-primary btn-block col-md-5">戻る</button>
                        [+/if+]
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
