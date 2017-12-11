<section class="content">
    <div class="row">
        <div class="col-lg-8 col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
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
                    [+assign var = formset 
                    value = ['name' => 'createCurator',
                    'method'    => 'POST',
                    'action'    => 'manager/curators/create',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'createCurator'
                    ]+]

                    [+Form::open($formset)+]

                    <div class="form-group">
                        <!--会員名称: name member -->
                       <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">会員名称</div>
                            <div class="col-xs-6">
                                [+if isset($dataBaseofmember)+]
                                <label  style="text-align: left;  " for="name_member">[+$dataBaseofmember['name_member']+]</label>
                                [+/if+]
                            </div>
                        </div>

                        <!--所属・役職: Affiliation / title -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2">
                                <label class="label label-primary">必須</label>
                                所属・役職
                            </div>
                            <div class="col-xs-6">
                                <input type="text" name="department" class="form-control" value="[+Input::post('department')+]" id="department" placeholder="所属・役職" />
                            </div>
                        </div>

                        <!--氏名: name -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2">
                                <label class="label label-primary">必須</label>
                                氏名
                            </div>
                            <div class="col-xs-6">
                                <input type="text" name="name" class="form-control" value="[+Input::post('name')+]" id="name" placeholder="氏名" />
                            </div>
                        </div>
                        <!--氏名(ふりがな): Name (Furigana)-->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">氏名(ふりがな)</div>
                            <div class="col-xs-6">
                                <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+Input::post('name_kana')+]" placeholder="氏名(ふりがな)">
                            </div>
                        </div>
                        <!--メール: email -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">メール</div>
                            <div class="col-xs-6">
                                <input type="text" name="email" class="form-control" value="[+Input::post('email')+]"  id="email" placeholder="メール">
                            </div>
                        </div>
                        <!--電話: phone -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">電話</div>
                            <div class="col-xs-6">
                                <input type="text" name="tel" class="form-control"  value="[+Input::post('tel')+]" id="tel" placeholder="電話">
                            </div>
                        </div>
                        <!--FAX: fax -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">FAX</div>
                            <div class="col-xs-6">
                                <input type="text" name="fax" class="form-control" value="[+Input::post('fax')+]" id="fax" placeholder="FAX">
                            </div>
                        </div>
                        <!--郵便番号: Postal code -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">郵便番号</div>
                            <div class="col-xs-6">
                                <input type="text" name="zip" class="form-control" value="[+Input::post('zip')+]" id="zip" placeholder="郵便番号">
                            </div>
                        </div>
                        <!--住所2: Address 1 -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">住所1</div>
                            <div class="col-xs-6">
                                <input type="text" name="address01" class="form-control" value="[+Input::post('address01')+]" id="address01" placeholder="住所1">
                            </div>
                        </div>
                        <!--住所2: Address 2 -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">住所2 <br /> (ビル名・階数)</div>
                            <div class="col-xs-6">
                                <input type="text" name="address02" class="form-control" value="[+Input::post('address02')+]" id="address02" placeholder="住所2">
                            </div>
                        </div>
                        <!--会員サイトID発行: Issuing member site ID -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">会員サイトID発行</div>
                            <div class="col-xs-6">
                                [+Form::select('published_site_id', Input::post('published_site_id'), ['0' => 'なし','1' => '発行済み'], ['class' => 'form-control'])+]
                            </div>
                        </div>
                        <!--登録MLの種別: Type of registration ML -->
                        <div class="form-group">
                            <div class="col-xs-3 col-xs-offset-2 padding-left-50">登録MLの種別</div>
                            <div class="col-xs-6">
                                <input type="text" name="type_of_ml" class="form-control" value="[+Input::post('type_of_ml')+]" id="type_of_ml" placeholder="登録MLの種別">
                            </div>
                        </div>

                    </div>
                    <div class="form-group" style="">
                        <div class="col-xs-12">
                            <div class="col-xs-2 col-md-offset-3">
                                <a href="manager/curators/setting">
                                    <button name="backFromSettingCurators" id="backFromViewCurators" type="button" class="btn btn-primary btn-block col-md-5">戻る</button>
                                </a>
                            </div>
                            <div class="col-xs-7">
                            <button type="submit" form="createCurator" id="submitCreateCurator" class="btn btn-md btn-primary col-md-9">
                                入力内容を登録して担当としてセットする
                            </button>
                            </div>
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/curator_create.js'))+]