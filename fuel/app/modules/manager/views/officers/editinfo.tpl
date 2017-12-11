<!-- Chinh sua member (M020-01) -->
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
                                <strong>メンバー管理システム</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                    [+/if +]
                    [+assign var = formset 
                    value = ['name' => 'editPerson',
                    'method'    => 'POST',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'editPerson'
                    ]+]

                    [+Form::open($formset)+]
                    [+foreach $member as $item+]
                    <div class="form-group">
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="member_name">会員名称</label>
                            <div class="col-xs-7">
                                <label name="member_name" id="member_name"  style="text-align: left;    width: 135px;"">[+$item->member_name+]</label>
                            </div>
                        </div>

                        <!--所属・役職: Department -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="department">所属・役職</label>
                            <div class="col-xs-7">
                                <input type="text" name="department" class="form-control" value="[+Input::post('department', $item->department)+]" id="department" placeholder="所属・役職"/>
                            </div>
                        </div>

                        <!--氏名: name -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="name">氏名</label>
                            <div class="col-xs-7">
                                <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name', $item->name)+]" placeholder="氏名"/>
                            </div>
                        </div>
                        <!--氏名(ふりがな): Name kana-->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="name_kana">氏名(ふりがな)</label>
                            <div class="col-xs-7">
                                <input type="text" name="name_kana" class="form-control" id="name_furigana" value="[+Input::post('name_kana', $item->name_kana)+]" placeholder="氏名(ふりがな)" >
                            </div>
                        </div>
                        <!--メール: email -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="emai">メール</label>
                            <div class="col-xs-7">
                                <input type="text" name="email" class="form-control" value="[+Input::post('email', $item->email)+]" id="email_address" placeholder="メール" >
                            </div>
                        </div>
                        <!--電話: phone -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="tel">電話</label>
                            <div class="col-xs-7">
                                <input type="text" name="tel" class="form-control" value="[+Input::post('tel', $item->tel)+]" id="tel" placeholder="電話" >
                            </div>
                        </div>
                        <!--FAX: fax -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="fax">FAX</label>
                            <div class="col-xs-7">
                                <input type="text" name="fax" class="form-control" value="[+Input::post('fax', $item->fax)+]" id="fax" placeholder="FAX" >
                            </div>
                        </div>
                        <!--郵便番号: Zip -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="postal_code">郵便番号</label>
                            <div class="col-xs-7">
                                <input type="text" name="zip" class="form-control" value="[+Input::post('zip', $item->zip)+]" id="zip" placeholder="郵便番号" >
                            </div>
                        </div>
                        <!--住所2: Address 1 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="address_one">住所1</label>
                            <div class="col-xs-7">
                                <input type="text" name="address01" class="form-control" value="[+Input::post('address01', $item->address01)+]" id="address01" placeholder="郵便番号" >
                            </div>
                        </div>
                        <!--住所2: Address 2 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="address_two">住所2 <br /> (ビル名・階数)</label>
                            <div class="col-xs-7">
                                <input type="text" name="address02" class="form-control" value="[+Input::post('address02', $item->address02)+]" id="address02" placeholder="住所2" >
                            </div>
                        </div>
                        <!--会員サイトID発行: Published site ID -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="published_site_id">会員サイトID発行</label>
                            <div class="col-xs-7">
                                [+Form::select('published_site_id', Input::post('published_site_id', $item->published_site_id), 
                                ['0' => 'なし',
                                '1' => '発行済み'], 
                                ['class' => 'form-control', ''])+]
                            </div>
                        </div>
                        <!--登録MLの種別: Type of registration ML -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1 padding-left-50"  style="text-align: left;    width: 135px;" for="type_of_ml">登録MLの種別</label>
                            <div class="col-xs-7">
                                <input type="text" name="type_of_ml" class="form-control" value="[+Input::post('type_of_ml', $item->type_of_ml)+]" id="type_of_ml" placeholder="会員サイトID発行" >
                            </div>
                        </div>
                    [+/foreach+]
                    </div>
                    <div class="form-group" style="">
                        <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                        <div class="col-md-2" style="margin-left: 23%;">
                            <button class="btn btn-md btn-primary " type="button" onclick="history.back();">戻る</button>
                        </div>
                        <div class="col-md-2">
                            <input type="submit" id="del" name="del" form="editPerson" class="btn btn-md btn-primary " value="削除">
                        </div>
                        <div class="col-md-2">
                            <input type="submit" id="send" name="send" form="editPerson" class="btn btn-md btn-primary" value="登録">
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content  -->
[+Asset::js(array('membermanage/officer_editinfo.js'))+]