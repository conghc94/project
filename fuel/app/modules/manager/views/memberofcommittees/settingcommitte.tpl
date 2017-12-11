<section class="content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">
                    メンバー設定
                </div>
                <div class="box-body">
                    <a class="btn btn-primary" style="margin-left: 39%; margin-bottom: 3%; height: 5%; margin-top: 20px;" href='manager/committees/create'>
                        <span>メンバーの新規登録</span>
                    </a>
                    <hr>
                        [+assign var = formset value = [
                            'name'   => 'searchposts',
                            'method' => 'get',
                            'class'  => 'form-horizontal',
                            'id'     => 'submitSearch',
                            'action' => 'manager/memberofcommittees/searchsettingcommitte'
                        ]+]
                        [+Form::open($formset)+]
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left" >メンバーの検索</label>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left">会員名称</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="nameMember" value="[+Input::get('nameMember')+]" name="nameMember">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left">氏名</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="namePerson" value="[+Input::get('namePerson')+]" name="namePerson">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left">所属・役職</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="department" value="[+Input::get('department')+]" name="department">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left">メールアドレス</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="email" value="[+Input::get('email')+]" name="email">
                                </div>
                            </div>
                            [+for $group=1 to 20+]
                                <div class="form-group">
                                    <label class="col-md-3 col-md-offset-2 control-common-label text-left">カスタム入力項目[+$group+]</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control custom_input_name[+$group+]"  name="cumstom_input[+$group+]" >
                                    </div>
                                </div>
                            [+/for+]
                            <div class="form-group">
                                <label class="col-md-3 col-md-offset-2 control-common-label text-left">ソート順</label>
                                <div class="col-md-6">
                                    [+Form::select('sortcommitte', Input::get('sortcommitte'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順', '2' => '氏名(ふりがな)  昇順', '3' => '氏名(ふりがな)  降順', '4' => 'No.昇順', '5' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="margin-top: 6%" >
                            <div class="form-group">
                                <div class="col-md-4">
                                    <input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearch" style="width: 100%;" value="検索" /> 
                                </div>
                            </div>
                        </div>  
                    [+Form::close()+]           
                </div>
                [+if Session::get_flash('error') +]
                [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-md-4 col-md-offset-4">
                            <div class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <strong>一致するレコードが見つかりません</strong>
                            </div>
                        </div>
                    </div>
                [+/if +]
                <hr>
                    [+if isset($back)+]
                    <a class="btn btn-primary" style="margin-left: 40%; margin-bottom: 8%; width: 10%; height: 5%; margin-top: 20px;" href='[+$back+]'>
                        <span>戻る</span>
                        </a>
                    [+else+]
                    <a class="btn btn-primary" style="margin-left: 40%; margin-bottom: 8%; width: 10%; height: 5%; margin-top: 20px;" href=''>
                        <span>戻る</span>
                        </a>
                    [+/if+]
            </div>
        </div>
    </div>
</section>