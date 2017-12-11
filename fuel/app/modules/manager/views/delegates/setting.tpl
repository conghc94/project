[+Asset::css(array('site/representative.css'))+]
<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
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
                            <h3 class="col-xs-4 col-xs-offset-1">代表者の検索</h3>
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
                                <input type="text" name="name" class="form-control" id="name" placeholder="氏名">
                            </div>
                        </div>
                        <!--所属・役職: group -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">所属・役職</div>
                            <div class="col-xs-6">
                                <input type="text" name="department" class="form-control" id="department" placeholder="所属・役職">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">メールアドレス</div>
                            <div class="col-xs-6">
                                <input type="text" name="email" class="form-control" id="email" placeholder="メールアドレス">
                            </div>
                        </div>
                        <!--ソート順: sort ordering -->
                        <div id ="form-group" class="form-group">
                            <div class="col-xs-2 col-md-offset-1">ソート順</div>
                            <div class="col-xs-6">
                                [+Form::select('sort', Input::post('sort', ''), 
                                ['0'    => '会員名称(ふりがな)  昇順',
                                '1'     => '会員名称(ふりがな)  降順',
                                '2' => '氏名(ふりがな)  昇順',
                                '3' => '氏名(ふりがな)  降順',
                                '4' => 'No. 昇順',
                                '5' => 'No. 降順'], ['class' => 'form-control'])+]
                            </div>
                        </div>
                    </div>
                    [+Form::close()+]

                    <div class="col-xs-12">
                        <hr/>
                    </div>
                    <div class="col-xs-2 col-xs-offset-5">
                        [+if ($back)+]
                            <a href="[+$back+]"><button name="backFromSettingDelegates" id="backFromSettingDelegates" type="button" class="btn btn-primary btn-block col-md-5">戻る</button></a>
                        [+else+]
                            <a href="[+Uri::base()+]manager/dashboard/index"><button name="backFromSettingDelegates" id="backFromSettingDelegates" type="button" class="btn btn-primary btn-block">戻る</button></a>
                        [+/if+]
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/delegate_setting.js'))+]
