[+if isset($error) +]
<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <strong>エラーがありました。</strong>[+foreach $error as $one+][+$one+][+/foreach+]
        </div>
    </div>
</div>
[+/if +]
<section class="content">
    <div class="row">
        <div class="col-lg-6 col-md-6 box-layout">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">
                    <span>
                        <i class="fa fa-user"></i>
                    </span>
                    ログイン
                </div>
                
                [+assign var=formset value=['name'=>'loginform','method'=>'post', class=>'form-horizontal padding-top20','id'=>'loginform']+]
                [+Form::open($formset)+]
                <div class="form-group">
                    <label class="col-lg-4 col-md-4 control-common-label text-right">ログインID</label>
                    <div class="col-lg-4 col-md-4">
                        <input type="text" id="username" name="username" class="form-control" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-4 col-md-4 control-common-label text-right">パスワード</label>
                    <div class="col-lg-4 col-md-4">
                        <input type="password" id="password" name="password" class="form-control" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 control-common-label text-right"></label>
                    <div class="col-xs-4">
                        <a class="btn btn-md btn-primary" style="margin-left: 30%" href="javascript:$('#loginform').submit();">
                            <i class="fa fa-lock"></i>
                            <span>ログイン</span>
                        </a>
                    </div>
                </div>
                [+Form::close()+]          

            </div>
        </div>
    </div>
    <!-- /.row -->
</section>
<!-- /.content -->