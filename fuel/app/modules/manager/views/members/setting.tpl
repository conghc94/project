[+Asset::css(array('site/representative.css'))+]
<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">

                    <div class="col-xs-12">
                        <hr/>
                    </div>

                    [+assign var = formset 
                    value = ['name' => 'settingMembers',
                    'method'    => 'GET',
                    'action'    => 'manager/members/search',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'settingMembers'
                    ]+]

                    [+Form::open($formset)+]

                    <div class="col-xs-12">
                        <div class="form-group">
                            <h3 class="col-xs-4 col-xs-offset-1" style="font-weight: bold">会員の検索</h3>
                        </div>
                        <!-- type -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="type">会員属性</label>
                            <div class="col-xs-6">
                                [+Form::select('type', Input::get('type'), 
                                ['0'        => 'なし',
                                '1'        => '企業',
                                '2'        => '団体',
                                '3'        => '研究機関',
                                '4'        => '個人',
                                '5'        => '地方自治体'],
                                ['class'   => 'form-control'])+]
                            </div>
                            <div class="col-xs-2">
                                <input type="submit" value="検索"  style="" class="btn btn-primary btn-block">    
                            </div>
                        </div>
                        <!-- profile flag -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="profile_flag">会員フラグ</label>
                            <div class="col-xs-6">
                                <label class="radio-inline"><input type="radio" id="profile_flag" name="profile_flag" value="1">RRI会員</label>
                                <label class="radio-inline"><input type="radio" id="profile_flag" name="profile_flag" value="0">RRI会員ではない</label>
                            </div>
                        </div>

                        <!--会員名称: name -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="name">会員名称</label>
                            <div class="col-xs-6    ">
                                <input type="text" name="name" class="form-control" id="name" placeholder="会員名称">
                            </div>
                        </div>
                        <!--会員名称(ふりがな): name kana -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="name_kana">会員名称(ふりがな)</label>
                            <div class="col-xs-6">
                                <input type="text" name="name_kana" class="form-control" id="name_kana" placeholder="会員名称(ふりがな)">
                            </div>
                        </div>
                        <!--会員名称(英語): name eng -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="name_eng">会員名称(英語)</label>
                            <div class="col-xs-6">
                                <input type="text" name="name_eng" class="form-control" id="name_eng" placeholder="会員名称(英語)">
                            </div>
                        </div>
                        <!--備考: note -->
                        <div class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="note">備考</label>
                            <div class="col-xs-6">
                                <input type="text" name="note" class="form-control" id="note" placeholder="備考">
                            </div>
                        </div>
                        <!--ソート順: sort ordering -->
                        <div id ="form-group" class="form-group">
                            <label class="col-xs-3 col-xs-offset-1"  style="text-align: left" for="sort">ソート順</label>
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
                    
                    <div class="col-md-3 col-md-offset-4">
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
