<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-success box-solid">
				<div class="box-header with-border">
					所属メンバー検索
				</div>
				<div class="box-body">
					[+assign var = formset value = [
						'name'   => 'searchposts',
						'method' => 'get',
						'class'  => 'form-horizontal',
						'id'	 => 'submitSearch'
					]+]
					[+Form::open($formset)+]
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">会員名称</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="nameMember" value="[+Input::get('nameMember')+]" name="nameMember">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">会員所属・役職</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="officer_in_commitee" value="[+Input::get('officer_in_commitee')+]" name="officer_in_commitee">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">会員属性</label>
							<div class="col-md-4">
								[+Form::select('attributes_member', Input::get('attributes_member'), ['1' => '企業','2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">年会費の請求</label>
							<div class="col-md-6">
								<label class="checkbox-inline">
									[+Form::checkbox("request_of_cost[]", '0')+] 
									未請求
								</label>
								<label class="checkbox-inline">
									[+Form::checkbox("request_of_cost[]", '1')+] 
									請求済み
								</label>
								<label class="checkbox-inline">
									[+Form::checkbox("request_of_cost[]", '9')+] 
									請求必要なし
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">年会費の入金</label>
							<div class="col-md-6">
								<label class="checkbox-inline">
									[+Form::checkbox("receipt_of_cost[]", '0')+] 
									未入金
								</label>
								<label class="checkbox-inline">
									[+Form::checkbox("receipt_of_cost[]", '1')+] 
									入金済み
								</label>
								<label class="checkbox-inline">
									[+Form::checkbox("receipt_of_cost[]", '9')+] 
									入金必要なし
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">備考</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="noteMemberofCommitte" value="[+Input::get('noteMemberofCommitte')+]" name="noteMemberofCommitte">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">ソート順</label>
							<div class="col-md-4">
							[+Form::select('sortmemberofCommitte', Input::get('sortmemberofCommitte'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順','2' => 'No.昇順', '3' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-right">検索出力形式</label>
							<div class="col-md-6">
								<label class="radio-inline">
									<input type="radio" name="outputSearch" checked="true" value="1">検索結果
								</label>
								<label class="radio-inline">
									<input type="radio" name="outputSearch" value="2">リスト表示
								</label>
								<label class="radio-inline">
									<input type="radio" name="outputSearch" value="3">CSV出力
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4 col-md-offset-5">
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearchMemberofCommitte" style="width: 40%;" value="検索" /> 
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
			</div>
		</div>
	</div>
</section>
[+Asset::js(array('membermanage/memberofcommitte.js'))+]
