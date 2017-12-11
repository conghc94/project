[+if isset($error) +]
<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<strong>エラーがありました。</strong>[+foreach $error as $one+][+$one+][+/foreach+]
		</div>
	</div>
</div>
[+/if +]
<div class="row">
	[+assign var=formset value=['name'=>'loginform','method'=>'post']+]
	[+Form::open($formset)+]
	<div class="col-md-8 col-md-offset-2">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">ログイン</h3>
			</div>
			<div class="panel-body">
				<div class="form-group has-primary has-feedback">
					<label class="control-label" for="username">ログインID</label>
					<input type="text" class="form-control" placeholder="ログインID" id="username" name="username" size="35">
				</div>
				<div class="form-group has-primary has-feedback">
					<label class="control-label" for="password">パスワード</label>
					<input type="password" class="form-control" placeholder="パスワード" id="password" name="password" size="35">
				</div>
				<button type="submit" class="btn btn-primary btn-block">ログイン</button>
			</div>
		</div>
	</div>
	[+Form::close()+]
</div>


