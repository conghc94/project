<!-- Thiết lập cong chuc(S009-2) -->

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
                                <strong>メンバー管理システム</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                    [+/if +]
                    [+assign var = formset 
                    value = ['name' => 'viewCommittees',
                    'method'    => 'POST',
                    'class'     => 'form-horizontal padding-top20',
                    'id'        => 'viewCommittees'
                    ]+]

                    [+Form::open($formset)+]
                    [+foreach $member as $item+]
                    <div class="form-group">
                        <!--会員名称: name member -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="member_name">会員名称</label>
                            <div class="col-xs-8">
                                <label name="member_name" id="member_name"  style="text-align: left;    width: 135px;"">[+(strlen($item->member_name) > 50) ? Str::truncate($item->member_name, 45, '...') : $item->member_name+]</label>
                            </div>
                        </div>

                        <!--所属・役職: Department -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="department">所属・役職</label>
                            <div class="col-sm-8">
                                <input type="text" name="department" class="form-control" value="[+Input::post('department', $item->department)+]" id="department" placeholder="所属・役職" disabled />
                            </div>
                        </div>

                        <!--氏名: name -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="name">氏名</label>
                            <div class="col-sm-8">
                                <input type="text" name="name" class="form-control" id="name" value="[+Input::post('name', $item->name)+]" placeholder="氏名" disabled />
                            </div>
                        </div>
                        <!--氏名(ふりがな): Name kana-->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="name_kana">氏名(ふりがな)</label>
                            <div class="col-sm-8">
                                <input type="text" name="name_kana" class="form-control" id="name_furigana" value="[+Input::post('name_kana', $item->name_kana)+]" placeholder="氏名(ふりがな)" disabled>
                            </div>
                        </div>
                        <!--メール: email -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="emai">メール</label>
                            <div class="col-sm-8">
                                <input type="text" name="email" class="form-control" value="[+Input::post('email', $item->email)+]" id="email_address" placeholder="メール" disabled>
                            </div>
                        </div>
                        <!--電話: phone -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="tel">電話</label>
                            <div class="col-sm-8">
                                <input type="text" name="tel" class="form-control" value="[+Input::post('tel', $item->tel)+]" id="phone" placeholder="電話" disabled>
                            </div>
                        </div>
                        <!--FAX: fax -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="fax">FAX</label>
                            <div class="col-sm-8">
                                <input type="text" name="fax" class="form-control" value="[+Input::post('fax', $item->fax)+]" id="fax" placeholder="FAX" disabled>
                            </div>
                        </div>
                        <!--郵便番号: Zip -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="postal_code">郵便番号</label>
                            <div class="col-sm-8">
                                <input type="text" name="postal_code" class="form-control" value="[+Input::post('zip', $item->zip)+]" id="postal_code" placeholder="郵便番号" disabled>
                            </div>
                        </div>
                        <!--住所2: Address 1 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="address_one">郵便番号</label>
                            <div class="col-sm-8">
                                <input type="text" name="address_one" class="form-control" value="[+Input::post('address01', $item->address01)+]" id="address_one" placeholder="郵便番号" disabled>
                            </div>
                        </div>
                        <!--住所2: Address 2 -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="address_two">住所2 <br /> (ビル名・階数)</label>
                            <div class="col-sm-8">
                                <input type="text" name="address_two" class="form-control" value="[+Input::post('address02', $item->address02)+]" id="address_two" placeholder="住所2" disabled>
                            </div>
                        </div>
                        <!--会員サイトID発行: Published site ID -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="published_site_id">会員サイトID発行</label>
                            <div class="col-sm-8">
                                [+Form::select('published_site_id', Input::post('plsiteid', $item->published_site_id), 
                                ['0' => 'なし',
                                '1' => '発行済み'], 
                                ['class' => 'form-control', 'disabled'])+]
                            </div>
                        </div>
                        <!--登録MLの種別: Type of registration ML -->
                        <div class="form-group">
                            <label class="col-xs-2 col-xs-offset-1"  style="text-align: left;    width: 135px;" for="type_of_ml">登録MLの種別</label>
                            <div class="col-sm-8">
                                <input type="text" name="type_of_ml" class="form-control" value="[+Input::post('type_of_ml', $item->type_of_ml)+]" id="type_of_ml" placeholder="会員サイトID発行" disabled>
                            </div>
                        </div>
                    [+/foreach+]
                    </div>
                    <div class="form-group" style="margin-left: 6%;">
                        <div class="col-xs-2 col-xs-offset-2">
                            <a href="manager/memberofcommittees/settingcommitte">
                                <button type="button" class="btn btn-md btn-primary">戻る</button>
                            </a>
                        </div>

                        <div class="col-xs-8" style="margin-left: -7%;">
                            <button type="submit" form="viewCommittees" class="btn btn-md btn-primary">
                                メンバーとしてセットする
                            </button>
                        </div>
                    </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content 