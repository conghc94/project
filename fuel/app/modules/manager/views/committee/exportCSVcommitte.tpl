
<section class="content">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					CSV出力する内容を選択してください。
				</div>
				<div class="box-body">
					[+assign var = formset value = [
						'method' => 'post',
						'class'  => 'form-horizontal'
					]+]
					[+Form::open($formset)+]

						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left" style="font-weight: bold;">
								CSV出力する内容を選択してください。
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="attributesMemberCSV" value="attributesMemberCSV">会員属性
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="flatMemberCSV" value="flatMemberCSV">会員フラグ
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="nameMemberCSV" value="nameMemberCSV">会員名称
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="nameKanaMemberCSV" value="nameKanaMemberCSV">会員名称(ふりがな)
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="namEngMemberCSV" value="namEngMemberCSV">会員名称(英語)
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="CustomCSV" value="CustomCSV">カスタム入力欄
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="repreInfoCSV" value="repreInfoCSV">所属メンバー情報
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="historyCommentCSV" value="historyCommentCSV">変更履歴コメント
								</label>
							</div>
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="remarksCSV" value="remarksCSV">備考
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-3 control-common-label text-left">ソート順</label>
							<div class="col-md-4">
								<select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="sortCSV">
									<option selected="selected" value="0">会員名称(ふりがな)  昇順</option>
									<option value="1">会員名称(ふりがな)  降順</option>
									<option value="2">No.昇順</option>
									<option value="3">No.降順</option>
								</select>
						</div>
						</div>
						<div class="form-group">
							<div class="col-md-4 col-md-offset-5">
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="exportCSV" style="width: 40%;" value="出力"/> 
							</div>
						</div> 
					[+Form::close()+]
				</div>
			</div>
		</div>
	</div>
</section>



