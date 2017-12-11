<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
                   委員会追加
				</div>
				<div class="box-body">
					[+assign var = formset value = [
						'name'   => 'addCommittee',
						'method' => 'POST',
						'action' => 'manager/committee/index',
						'class'  => 'form-horizontal',
						'id'	 => 'submitRegister'
					]+]

					[+if Input::method() == "POST"+]
						[+$parent_committee_id = Input::post('parent_committee_id')+]
					[+else+]
						[+$parent_committee_id = ""+]
					[+/if+]
					[+Form::open($formset)+]
					<input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
						<div class="row">
							[+if Session::get_flash('error_CSRF') +]
							[+$error_CSRF = Session::get_flash('error_CSRF') +]
							<div class="row">
								<div class="col-md-8 col-md-offset-2">
									<div class="alert alert-danger alert-dismissable">
										<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
										<strong>メンバー管理システム</strong>[+foreach $error_CSRF as $one+]<br>[+$one+][+/foreach+]
									</div>
								</div>
							</div>
							[+/if +]
							[+if Session::get_flash('error') +]
							[+$error = Session::get_flash('error') +]
							<div class="row">
								<div class="col-md-8 col-md-offset-2">
									<div class="alert alert-danger alert-dismissable">
										<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
										<strong>メンバー管理システム</strong>[+foreach $error as $one+]<br>[+$one+][+/foreach+]
									</div>
								</div>
							</div>
							[+/if +]
							<div class="form-horizontal">
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">親委員会</label>
									<div class="col-md-5">
										[+Form::select('parent_committee_id', $parent_committee_id ,$list_committee_name, ['class' => 'form-control select2 select2-hidden-accessible'])+]
						
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称</label>
									<div class="col-md-5">
										<input type="text" class="form-control" id="committee_name" name="committee_name" value="[+Input::post('committee_name')+]">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称(ふりがな)</label>
									<div class="col-md-5">
										<input type="text" class="form-control" id="committee_name_kana"  name="committee_name_kana" value="[+Input::post('committee_name_kana')+]">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称(英語)</label>
									<div class="col-md-5">
										<input type="text" class="form-control" id="committee_name_eng" value="[+Input::post('committee_name_eng')+]" name="committee_name_eng">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">カスタム入力欄</label>
								</div>
							</div>
						</div>
						<hr>
						<div class="row form-horizontal _group" style="margin-top: 10px;">
							<div class="form-group" style="padding-top:30px">
								<label class="col-md-2 col-md-offset-3 control-common-label text-left">役職 選択肢</label>
								<div class="col-md-4">
									<textarea class="form-control" rows="4" id="selectable_officer" name="selectable_officer">[+Input::post('selectable_officer')+]</textarea>
								</div>
							</div>
						</div>
						[+for $group=1 to 20+]
						[+$abc = 'custom_input_name'|cat: $group+]
							<div class="row form-horizontal _group_[+$group+]"  style="margin-top: 10px;">
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]タイプ</label>
									<div class="col-md-4">
										[+if Input::method() == "POST"+]
											[+$abc = Input::post('custom_input_type'|cat:$group)+]
										[+else+]
											[+$abc = ""+]
										[+/if+]
										[+Form::select('custom_input_type'|cat:$group, $abc , [ '1' => 'テキスト',
																							'2' => 'テキストボックス',
																							'3' => 'ラジオ',
																							'4' => 'ドロップダウン',
																							'5' => 'チェックボックス'],
										['class' => 'form-control select2 select2-hidden-accessible custom_input_type_'|cat:$group,'id' => 'custom_input_type'|cat:$group])+]
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]タイトル</label>
									<div class="col-md-4">
										<input type="text" class="form-control custom_input_name[+$group+]" id="custom_input_name[+$group+]" value="[+Input::post('custom_input_name'|cat:$group)+]" name="custom_input_name[+$group+]" >
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]選択肢</label>
									<div class="col-md-4">
										<textarea class="form-control custom_input_selectable[+$group+]" rows="4" id="custom_input_selectable[+$group+]" value="[+Input::post('custom_input_selectable'|cat:$group)+]" name="custom_input_selectable[+$group+]"></textarea>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-4 col-md-offset-4">
										<input data-id="[+$group+]" type="button" class="click btn btn-md btn-primary"  style="width: 100%;" value="メンバーに入力した内容をリセット" />
									</div>
								</div>
							</div>
						[+/for+]
						<div class="form-group">
							<div class="col-md-4 col-md-offset-5">
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnRegisterCommittee" style="width: 40%;" value="登録" />
							</div>
						</div>
					[+Form::close()+]
                </div>
			</div>
		</div>
	</div>
</section>
[+Asset::js(array('membermanage/committee_index.js'))+]

<script type="text/javascript">

	// document.getElementById("committee_name").value = JSON.parse($.cookie("cookieMember"))['committee_name'];
	// document.getElementById("committee_name_kana").value 	= JSON.parse($.cookie("cookieMember"))['committee_name_kana'];
	// document.getElementById("committee_name_eng").value 	= JSON.parse($.cookie("cookieMember"))['committee_name_eng'];
	// document.getElementById("selectable_officer").value 	= JSON.parse($.cookie("cookieMember"))['selectable_officer'];


	// $(document).ready(function(){
	// 	$('#btnRegisterCommittee').click(function() 
	// 	{
	// 		var customMemberObject = {};
	// 		var custom_input_type = [];
	// 		var custom_input_name = [];
	// 		var custom_input_selectable = [];
	// 		var custom_name = [];

	// 		// alert(JSON.stringify(custom_input_selectable));

		
	// 		var committee_id = 	$('#sel1').val();
	// 		var committee_name 	= 	$('#committee_name').val();
	// 		var committee_name_kana	= 	$('#committee_name_kana').val();
	// 		var committee_name_eng	= 	$('#committee_name_eng').val();
	// 		var selectable_officer	= 	$('#selectable_officer').val();

	// 		custom_name.push(committee_id, committee_name, committee_name_kana, committee_name_eng, selectable_officer);

	// 		for(var i = 1; i <= 20; i++)
	// 		{
	// 			custom_input_type[i]	= 	$('#custom_input_type'+i).val();
	// 			custom_input_name[i]	=	$('#custom_input_name'+i).val();
	// 			custom_input_selectable[i]	=	$('#custom_input_selectable'+i).val();
	// 		}

	// 		customMemberObject = $.merge($.merge($.merge( $.merge( [], custom_name ), custom_input_type ), custom_input_name), custom_input_selectable);

	// 		var jsonString = JSON.stringify(customMemberObject);

	// 		$.cookie("cookieMember", jsonString,{ expires: 7 });

	// 	});
	// });

	
</script>