<section class="content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">
                    メンバー編集
                </div>
                <div class="box-body">
                    [+if Session::get_flash('error') +]
                    [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-md-8 col-md-offset-3">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <strong>メンバー管理システム</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                    [+/if +]
                    [+assign var = formset 
                    value = [
                    'method'    => 'POST',
                    'class'     => 'form-horizontal padding-top20'
                    ]+]
                    [+Form::open($formset)+]
                    <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                    [+foreach $member as $item +]
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">会員名称</div>
                        <div class="col-xs-6">
                            [+$item->name+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            所属・役職
                        </div>
                        <div class="col-xs-6">
                            <input type="text" name="department" class="form-control" id="department" value="[+$item->department+]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2">
                            <label class="label label-primary">必須</label>
                            氏名
                        </div>
                        <div class="col-xs-6">
                            <input type="text" name="name" class="form-control" id="name" value="[+$item->person_name+]" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">氏名(ふりがな)</div>
                        <div class="col-xs-6">
                            <input type="text" name="name_kana" class="form-control" id="name_kana" value="[+$item->name_kana+]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">メール</div>
                        <div class="col-xs-6">
                            <input type="text" name="email" class="form-control" id="email" value="[+$item->email+]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">電話</div>
                        <div class="col-xs-6">
                            <input type="text" name="tel" class="form-control" id="tel" value="[+$item->tel+]" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">FAX</div>
                        <div class="col-xs-6">
                            <input type="text" name="fax" class="form-control" id="fax" value="[+$item->fax+]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">郵便番号</div>
                        <div class="col-xs-6">
                            <input type="text" name="zip" class="form-control" id="zip" value="[+$item->zip+]" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">住所1</div>
                        <div class="col-xs-6">
                            <input type="text" name="address01" class="form-control" id="address01" value="[+$item->address01+]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">住所2 <br /> (ビル名・階数)</div>
                        <div class="col-xs-6">
                            <input type="text" name="address02" class="form-control" id="address02" value="[+$item->address02+]" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">会員サイトID発行</div>
                        <div class="col-xs-6">
                            [+Form::select('published_site_id', $item->published_site_id, ['1' => '発行済み','0' => 'なし'], ['class' => 'form-control'])+]
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-2 col-xs-offset-2 padding-left-50">登録MLの種別</div>
                        <div class="col-xs-6">
                            <input type="text" name="type_of_ml" class="form-control" id="type_of_ml" value="[+$item->type_of_ml+]" />
                        </div>
                    </div>
                    [+/foreach+]
                    <div class="form-group" style="margin-top: 8%;">
                        <div class="col-md-1 col-md-offset-4">
                            <input class="btn btn-primary" style="margin-bottom: 20px; height: 5%;" type="submit" id="backMembers" name="backMembers" value="戻る" >
                        </div>
                        <div class="col-md-1">
                            <input class="btn btn-primary" style="margin-bottom: 20px; height: 5%; width: 80px;" type="submit" id="DeleteMembers" name="DeleteMembers" value="削除">
                        </div>
                        <div class="col-md-2">
                            <input class="btn btn-primary" style="margin-bottom: 20px; height: 5%; width: 130px;" type="submit" id="EditMembers" name="EditMembers" value="登録">
                        </div>
                    [+Form::close()+]
                </div>
            </div>
        </div>
    </div>
</section>
[+Asset::js(array('membermanage/editmembers.js'))+]