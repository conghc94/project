<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                    [+if Session::get_flash('error') +]
                    [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-xs-8 col-md-offset-3">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <strong>エラーがありました。</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                    [+/if +]
                    
                    [+assign var = formset 
                    value = ['name' => 'viewCurator',
                    'method'    => 'POST',
                    'action'    => '',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'viewCurator'
                    ]+]

                    [+Form::open($formset)+]
                    <div class="form-group">
                        <!--会員名称: name member -->
                        
                        <div class="form-group">
                            <div class="form-group">
                            <div class="col-xs-2 col-md-offset-1">会員名称</div>
                            <div class="col-xs-8">
                                [+if isset($dataBaseofmember)+]
                                <label class="" style="text-align: left;    width: 135px;" for="name_member">[+(strlen($dataBaseofmember['name_member']) > 50) ? Str::truncate($dataBaseofmember['name_member'], 45, '...') : $dataBaseofmember['name_member']+]</label>
                                [+/if+]
                            </div>
                        </div>

                        [+if isset($dataCurator)+]
                        
                            [+foreach $dataCurator as $item+]
                                <!--所属・役職: Affiliation / title -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">所属・役職</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="department" class="form-control" value="[+Input::post('department', $item->department)+]" id="department" placeholder="所属・役職" disabled/>
                                    </div>
                                </div>

                                <!--氏名: name -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">氏名</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name', $item->name)+]" placeholder="氏名" disabled/>
                                    </div>
                                </div>
                                <!--氏名(ふりがな): Name (Furigana)-->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">氏名(ふりがな)</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+Input::post('name_kana', $item->name_kana)+]" placeholder="氏名(ふりがな)" disabled/>
                                    </div>
                                </div>
                                <!--メール: email -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">メール</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="email" class="form-control" value="[+Input::post('email', $item->email)+]" id="email" placeholder="メール" disabled/>
                                    </div>
                                </div>
                                <!--電話: phone -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-xs-offset-1">電話</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="tel" class="form-control" value="[+Input::post('tel', $item->tel)+]" id="tel" placeholder="電話" disabled/>
                                    </div>
                                </div>
                                <!--FAX: fax -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">FAX</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="fax" class="form-control" value="[+Input::post('fax', $item->fax)+]" id="fax" placeholder="FAX" disabled/>
                                    </div>
                                </div>
                                <!--郵便番号: Postal code -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-xs-offset-1">郵便番号</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="zip" class="form-control" value="[+Input::post('zip', $item->zip)+]" id="zip" placeholder="郵便番号" disabled/>
                                    </div>
                                </div>
                                <!--住所2: Address 1 -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">郵便番号</div>
                                    <div class="col-sm-8">
                                        <input type="text" name="address01" class="form-control" value="[+Input::post('address01', $item->address01)+]" id="address01" placeholder="郵便番号" disabled/>
                                    </div>
                                </div>
                                <!--住所2: Address 2 -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">住所2 <br /> (ビル名・階数)</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="address02" class="form-control" value="[+Input::post('address02', $item->address02)+]" id="address02" placeholder="住所2" disabled/>
                                    </div>
                                </div>
                                <!--会員サイトID発行: Issuing member site ID -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-md-offset-1">会員サイトID発行</div>
                                    <div class="col-xs-8">
                                        [+Form::select('published_site_id', Input::post('published_site_id', $item->published_site_id), ['1' => '発行済み','0' => 'なし'], ['class' => 'form-control','disabled' => 'true']  )+]
                                    </div>
                                </div>
                                <!--登録MLの種別: Type of registration ML -->
                                <div class="form-group">
                                    <div class="col-xs-2 col-xs-offset-1">登録MLの種別</div>
                                    <div class="col-xs-8">
                                        <input type="text" name="type_of_ml" class="form-control" value="[+Input::post('type_of_ml', $item->type_of_ml)+]" id="type_of_ml" placeholder="住所2" disabled/>
                                    </div>
                                </div>
                                <input type="hidden" name="id" value="[+Input::post('id', $item->id)+]" />
                            [+/foreach+]
                        [+/if+]    
                    </div>
                        
                    <div class="form-group" style="">
                        <div class="col-xs-2 col-md-offset-3">
                            <a href="manager/curators/setting">
                            <button name="backFromSearchCurators" id="backFromViewCurators" type="button" class="btn btn-primary btn-block">戻る</button></a>
                        </div>
                        <div class="col-xs-7">
                            <input type="button" id="subViewCurator" name="subViewCurator" form="viewCurator" class="btn btn-md btn-primary col-md-6" value="担当としてセットする">
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->
[+Asset::js(array('membermanage/curator_view.js'))+]