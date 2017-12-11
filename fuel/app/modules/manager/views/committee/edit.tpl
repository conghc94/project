<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
                    委員会編集
				</div>
				<div class="box-body">
					<form  method="post">
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
									<div class="col-md-6">
                                        [+Form::select('committee_id',$get_committee_by_ID['parent_committee_id'],$get_committee_name,
										['class' => 'form-control select2 select2-hidden-accessible','id' => 'custom_input_type_'])+]
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称</label>
									<div class="col-md-6">
										<input type="text" class="form-control"  value="[+$get_committee_by_ID['committee_name']+]" name="committee_name">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称(ふりがな)</label>
									<div class="col-md-6">
										<input type="text" class="form-control"  value="[+$get_committee_by_ID['committee_name_kana']+]" name="committee_name_kana">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 col-md-offset-2 control-common-label text-left">委員会名称(英語)</label>
									<div class="col-md-6">
										<input type="text" class="form-control"  value="[+$get_committee_by_ID['committee_name_eng']+]" name="committee_name_eng">
									</div>
								</div>
							</div>
						</div>
						<div class=" row col-md-8 col-md-offset-2 control-common-label text-left" style="border-bottom: 3px solid #3c8dbc;">
							<span >カスタム入力欄</span>

						</div>
						<div class="row form-horizontal _group" style="margin-top: 10px;">
							<div class="form-group" style="padding-top:30px">
								<label class="col-md-2 col-md-offset-3 control-common-label text-left">役職 選択肢</label>
								<div class="col-md-4">
									<textarea class="form-control" rows="4" name="selectable_officer">[+$get_committee_by_ID['selectable_officer']+]</textarea>
								</div>
							</div>
						</div>
						[+for $group=1 to 20+]
                            [+if $group >= 10+]
                                [+$n = $group+]
                            [+else+]
                                [+$n = "0"|cat:$group+]
                            [+/if+]

							<div class="row form-horizontal _group_[+$group+]"  style="margin-top: 10px;">
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]タイプ</label>
									<div class="col-md-4">
										[+Form::select('custom_input_type'|cat:$group,$get_committee_by_ID['custom_input_type'|cat:$n],[
                                                                                            '1' => 'テキスト',
																							'2' => 'テキストボックス',
																							'3' => 'ラジオ',
																							'4' => 'ドロップダウン',
																							'5' => 'チェックボックス'],
										['class' => 'form-control select2 select2-hidden-accessible','id' => 'custom_input_type_'|cat:$group])+]
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]タイトル</label>
									<div class="col-md-4">
										<input type="text" class="form-control custom_input_name[+$group+]"  value="[+$get_committee_by_ID['custom_input_name'|cat:$n]+]" name="custom_input_name[+$group+]" >
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 col-md-offset-3 control-common-label text-left">入力[+$group+]選択肢</label>
									<div class="col-md-4">
										<textarea class="form-control custom_input_selectable[+$group+]" rows="4" id="comment" name="custom_input_selectable[+$group+]">[+$get_committee_by_ID['custom_input_selectable'|cat:$n]+]</textarea>
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
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearch" style="width: 40%;" value="登録" />
							</div>
						</div>
					</form>
                </div>
			</div>
		</div>
	</div>
</section>

[+Asset::js(array('membermanage/committee_edit.js'))+]
