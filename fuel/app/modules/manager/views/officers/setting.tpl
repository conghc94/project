<!--Thiết lập cong chuc (S006) 1 -->
[+Asset::css(array('site/representative.css'))+]
<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
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
                    'action'    => 'manager/officers/search',
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
                                <input type="text" name="member_name" class="form-control" id="member_name" placeholder="会員名称">
                            </div>
                            <div class="col-xs-2">
                                <input type="submit" value="検索"  style="" class="btn btn-primary btn-block">    
                            </div>
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="name">氏名</label>
                            <div class="col-xs-6">
                                <input type="text" name="name" class="form-control" id="name" placeholder="氏名">
                            </div>
                        </div>
                        <!--所属・役職: department -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="department">所属・役職</label>
                            <div class="col-xs-6">
                                <input type="text" name="department" class="form-control" id="department" placeholder="所属・役職">
                            </div>
                        </div>
                        <!--メールアドレス: email -->
                        <div class="form-group">
                            <label class="col-xs-2 col-md-offset-1"  style="text-align: left" for="'email">メールアドレス</label>
                            <div class="col-xs-6">
                                <input type="text" name="email" class="form-control" id="email" placeholder="メールアドレス">
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
                    <div class="col-md-12">
                        <hr>
                    </div>
                    
                    <div class="col-md-7 col-md-offset-3" >
                        [+if isset($pagination)+]
                        [+html_entity_decode($pagination)+]
                        [+/if+]
                    </div>
                    
                    <div class="col-xs-2 col-md-offset-5">
                    [+if ($back)+]
                    <a href="[+$back+]">
                        <button type="button" class="btn btn-primary btn-block col-md-2">戻る</button>
                    </a>
                    [+else+]
                        <button type="button" class="btn btn-primary btn-block col-md-2">戻る</button>
                    [+/if+]
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
