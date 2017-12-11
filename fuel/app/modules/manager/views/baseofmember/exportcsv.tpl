<!-- M004-04 -->
<section class="content">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					 会員のCSV出力
				</div>
				<div class="box-body">
					[+assign var = formset value = [
						'name'   => 'searchposts',
						'method' => 'post',
						'class'  => 'form-horizontal',
						'id'	 => 'submitSearch',
						'action' => 'manager/baseofmember/exportcsv'
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
							<!-- 会員属性 type.base_of_members -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="attributesMemberCSV" value="attributesMemberCSV">会員属性
								</label>
							</div>
							<!-- 会員フラグ profile_flag.base_of_members -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="flatMemberCSV" value="flatMemberCSV">会員フラグ
								</label>
							</div>
							<!-- 会員名称 name.base_of_members -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="nameMemberCSV" value="nameMemberCSV">会員名称
								</label>
							</div>
							<!-- 会員名称(ふりがな) name_kana.base_of_members -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="nameKanaMemberCSV" value="nameKanaMemberCSV">会員名称(ふりがな)
								</label>
							</div>
							<!-- 会員名称(英語) name_eng.base_of_members -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="namEngMemberCSV" value="namEngMemberCSV">会員名称(英語)
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<!-- 代表者情報 Get data name.personss,department.persons 代表者 connect_type == 1 -->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="repreInfoCSV" value="repreInfoCSV">代表者情報
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<!-- 主担当者・サブ担当者をすべて出力 Get data 担当者 connect_type == 11 && サブ担当 connect_type == 12 -->
							<div class="col-md-6 col-md-offset-4 control-common-label text-left">
								<label class="radio-inline">
									<input type="radio" name="contactMemberCSV" checked="true" value="0">主担当者・サブ担当者をすべて出力
								</label>
							</div>
							<!-- 担当者を出力しない not get data -->
							<div class="col-md-6 col-md-offset-4 control-common-label text-left">
								<label class="radio-inline">
									<input type="radio" name="contactMemberCSV" value="1">担当者を出力しない
								</label>
							</div>
							<!-- 主担当者のみ出力 Get data 担当者 connect_type == 11-->
							<div class="col-md-6 col-md-offset-4 control-common-label text-left">
								<label class="radio-inline">
									<input type="radio" name="contactMemberCSV" value="2">主担当者のみ出力
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<hr>
							</div>
							<!-- 変更履歴コメント Get data members.edited_history 変更履歴コメント-->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="historyCommentCSV" value="historyCommentCSV">変更履歴コメント
								</label>
							</div>
							<!-- 備考 Get data members.note 備考-->
							<div class="col-md-6 col-md-offset-3 control-common-label text-left">
								<label class="checkbox-inline">
									<input type="checkbox" name="remarksCSV" value="remarksCSV">備考
								</label>
							</div>
						</div>
						<!-- ソート順: sortCSV -->
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
						<!-- 出力: exportCSV -->
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