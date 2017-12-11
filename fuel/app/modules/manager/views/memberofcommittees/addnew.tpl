<!-- Them member uy vien hoi (S008) -->
[+Asset::css(array('site/common.css'))+]
[+Asset::css(array('site/member.css'))+]
<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    [+if Session::get_flash('error') +]
                    [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-xs-7 col-md-offset-3">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                [+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                    [+/if +]
                    [+assign var = formset 
                    value = ['name' => 'createCommittees',
                    'method'    => 'POST',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'createCommittees'
                    ]+]

                    [+Form::open($formset)+]
                    <div class="form-group">
                        <!--会員名称: name member -->
                        [+if isset($member_name)+]
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" for="member_name">会員名称</label>
                            <div class="col-xs-7">
                                <label name="member_name" id="member_name" >[+$member_name+]</label>
                            </div>
                        </div>
                        [+/if+]

                        <!--所属・役職: Department -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">
                                <label class="label label-primary">必須</label>
                                <label for="department">所属・役職</label>
                            </div>
                            <div class="col-xs-7">
                                <input type="text" name="department" class="form-control" value="[+Input::post('department')+]" id="department" placeholder="所属・役職" />
                            </div>
                        </div>
                        <!--氏名: name -->
                        <div class="form-group">
                            <div class="col-xs-2 col-xs-offset-1">
                                <label class="label label-primary">必須</label>
                                <label for="department">氏名</label>
                            </div>
                            <div class="col-xs-7">
                                <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name')+]" placeholder="氏名" />
                            </div>
                        </div>
                        <!--氏名(ふりがな): Name kana-->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="name_kana">氏名(ふりがな)</label>
                            <div class="col-xs-7">
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+Input::post('name_kana')+]" placeholder="氏名(ふりがな)">
                            </div>
                        </div>
                        <!--メール: email -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="email">メール</label>
                            <div class="col-xs-7">
                                <input type="text" name="email" class="form-control" value="[+Input::post('email')+]" id="email" placeholder="メール" >
                            </div>
                        </div>
                        <!--電話: telephone -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="tel">電話</label>
                            <div class="col-xs-7">
                                <input type="text" name="tel" class="form-control" value="[+Input::post('tel')+]" id="tel" placeholder="電話" >
                            </div>
                        </div>
                        <!--FAX: fax -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="fax">FAX</label>
                            <div class="col-xs-7">
                                <input type="text" name="fax" class="form-control" value="[+Input::post('fax')+]" id="fax" placeholder="FAX" >
                            </div>
                        </div>
                        <!--郵便番号: zip -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="zip">郵便番号</label>
                            <div class="col-xs-7">
                                <input type="text" name="zip" class="form-control" value="[+Input::post('zip')+]" id="zip" placeholder="郵便番号" >
                            </div>
                        </div>
                        <!--住所2: Address 1 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="address01">住所1</label>
                            <div class="col-xs-7">
                                <input type="text" name="address01" class="form-control" value="[+Input::post('address01')+]" id="address01" placeholder="住所1" >
                            </div>
                        </div>
                        <!--住所2: Address 2 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="address02">住所2 (ビル名・階数)</label>
                            <div class="col-xs-7">
                                <input type="text" name="address02" class="form-control" value="[+Input::post('address02')+]" id="address02" placeholder="住所2" >
                            </div>
                        </div>
                        <!--会員サイトID発行: Published site ID -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="published_site_id">会員サイトID発行</label>
                            <div class="col-xs-7">
                                [+Form::select('published_site_id', Input::post('plsiteid'), 
                                ['0' => 'なし',
                                '1' => '発行済み'], 
                                ['class' => 'form-control'])+]
                            </div>
                        </div>
                        <!--登録MLの種別: Type of registration ML -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50" " for="type_of_ml">登録MLの種別</label>
                            <div class="col-xs-7">
                                <input type="text" name="type_of_ml" class="form-control" value="[+Input::post('type_of_ml')+]" id="type_of_ml" placeholder="会員サイトID発行" >
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                        <div class="col-xs-2" style="margin-left: 24%;">
                            [+if isset($back)+]
                            <a href="[+$back+]">
                                <button type="button" class="btn btn-md btn-primary">戻る</button>
                            </a>
                            [+else+]
                                <button type="button" class="btn btn-md btn-primary">戻る</button>
                            [+/if+]
                        </div>

                        <div class="col-xs-7" style="margin-left: -8%;">
                            <input type="submit" id="send" name="send" form="createCommittees" class="btn btn-md btn-primary btn-lg" value="入力内容を登録してメンバーとしてセットする">
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content  -->
[+Asset::js(array('membermanage/committee_create.js'))+]