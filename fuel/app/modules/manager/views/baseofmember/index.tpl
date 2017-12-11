<!-- M004-01 : 会員検索-->
<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					会員検索
				</div>
				<div class="box-body">
					<!-- open form method GET -->
					[+assign var = formset value = [
						'name'   => 'searchposts',
						'method' => 'get',
						'class'  => 'form-horizontal',
						'id'	 => 'submitSearch'
					]+]
					[+Form::open($formset)+]
						<!-- 会員名称: nameMember -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員名称</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="nameMember" value="[+Input::get('nameMember')+]" name="nameMember">
							</div>
						</div>
						<!-- 会員フラグ: checkbox RRI[] -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員フラグ</label>
							<div class="col-md-6">[+$a=Input::get('RRI')+][+$count=count($a)+] <!--save checkbox RRI -->
								[+if $count == 1+]
									<label class="checkbox-inline" >
										[+Form::checkbox("RRI[]", '1',$a[0])+] 
										RRI会員
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("RRI[]", '0',$a[0])+] 
										RRI会員ではない
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline" >
									[+Form::checkbox("RRI[]", '1',$a[0])+] 
									RRI会員
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("RRI[]", '0',$a[1])+] 
										RRI会員ではない
									</label>
								[+else+]
									<label class="checkbox-inline" >
									[+Form::checkbox("RRI[]", '1')+] 
									RRI会員
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("RRI[]", '0')+] 
										RRI会員ではない
									</label>
								[+/if+]
							</div>
						</div>
						<!-- 会員属性: attributes_member -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員属性</label>
							<div class="col-md-4">
								[+Form::select('attributes_member', Input::get('attributes_member'), ['0' => 'なし', '1' => '企業','2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<!-- 総会の出席: checkbox listPresent[] -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">総会の出席</label>
							<div class="col-md-6">[+$a=Input::get('listPresent')+][+$count=count($a)+] <!--save checkbox listPresent -->
								[+if $count == 1+]
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '0', $a[0])+] 
										未定
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '1', $a[0])+] 
										代表者出席
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '2', $a[0])+] 
										代理者出席
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '9', $a[0])+] 
										欠席
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline" >
										[+if $a[0] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[0])+] 
											未定
										[+else if $a[1] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[1])+] 
											未定
										[+else+]
											[+Form::checkbox("listPresent[]", '0')+] 
											未定
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[0])+] 
											代表者出席
										[+else if $a[1] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[1])+] 
											代表者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '1')+] 
											代表者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[0])+] 
											代理者出席
										[+else if $a[1] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[1])+] 
											代理者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '2')+] 
											代理者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[0])+] 
											欠席
										[+else if $a[1] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[1])+]
											欠席
										[+else+]
											[+Form::checkbox("listPresent[]", '9')+] 
											欠席
										[+/if+]
									</label>
								[+else if $count == 3+]
									<label class="checkbox-inline" >
										[+if $a[0] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[0])+] 
											未定
										[+else if $a[1] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[1])+] 
											未定
										[+else if $a[2] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[2])+] 
											未定
										[+else+]
											[+Form::checkbox("listPresent[]", '0')+] 
											未定
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[0])+] 
											代表者出席
										[+else if $a[1] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[1])+] 
											代表者出席
										[+else if $a[2] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[2])+] 
											代表者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '1')+] 
											代表者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[0])+] 
											代理者出席
										[+else if $a[1] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[1])+] 
											代理者出席
										[+else if $a[2] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[2])+] 
											代理者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '2')+] 
											代理者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[0])+] 
											欠席
										[+else if $a[1] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[1])+] 
											欠席
										[+else if $a[2] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[2])+] 
											欠席
										[+else+]
											[+Form::checkbox("listPresent[]", '9')+] 
											欠席
										[+/if+]
									</label>
								[+else if $count == 4+]
									<label class="checkbox-inline" >
										[+if $a[0] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[0])+] 
											未定
										[+else if $a[1] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[1])+] 
											未定
										[+else if $a[2] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[2])+] 
											未定
										[+else if $a[3] == 0+]
											[+Form::checkbox("listPresent[]", '0', $a[3])+] 
											未定
										[+else+]
											[+Form::checkbox("listPresent[]", '0')+] 
											未定
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[0])+] 
											代表者出席
										[+else if $a[1] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[1])+] 
											代表者出席
										[+else if $a[2] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[2])+] 
											代表者出席
										[+else if $a[3] == 1+]
											[+Form::checkbox("listPresent[]", '1', $a[3])+] 
											代表者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '1')+] 
											代表者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[0])+] 
											代理者出席
										[+else if $a[1] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[1])+] 
											代理者出席
										[+else if $a[2] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[2])+] 
											代理者出席
										[+else if $a[3] == 2+]
											[+Form::checkbox("listPresent[]", '2', $a[3])+] 
											代理者出席
										[+else+]
											[+Form::checkbox("listPresent[]", '2')+] 
											代理者出席
										[+/if+]
									</label>
									<label class="checkbox-inline" >
										[+if $a[0] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[0])+] 
											欠席
										[+else if $a[1] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[1])+] 
											欠席
										[+else if $a[2] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[2])+] 
											欠席
										[+else if $a[3] == 9+]
											[+Form::checkbox("listPresent[]", '9', $a[3])+] 
											欠席
										[+else+]
											[+Form::checkbox("listPresent[]", '9')+] 
											欠席
										[+/if+]
									</label>
								[+else+]
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '0')+] 
										未定
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '1')+] 
										代表者出席
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '2')+] 
										代理者出席
									</label>
									<label class="checkbox-inline" >
										[+Form::checkbox("listPresent[]", '9')+] 
										欠席
									</label>
								[+/if+]
							</div>
						</div>
						<!-- 総会の委任状: checkbox listProxy[] -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">総会の委任状</label>
							<div class="col-md-6">[+$a=Input::get('listProxy')+][+$count=count($a)+] <!--save checkbox listProxy -->
								[+if $count == 1+]
									<label class="checkbox-inline" >
										[+Form::checkbox("listProxy[]", '0', $a[0])+] 
										未定
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("listProxy[]", '1', $a[0])+] 
										代理者委任状
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("listProxy[]", '2', $a[0])+] 
										議長委任
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline" >
										[+if $a[0] == 0+]
											[+Form::checkbox("listProxy[]", '0', $a[0])+] 
											未定
										[+else if $a[1] == 0+]
											[+Form::checkbox("listProxy[]", '0', $a[1])+] 
											未定
										[+else+]
											[+Form::checkbox("listProxy[]", '0')+] 
											未定
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("listProxy[]", '1', $a[0])+] 
											代理者委任状
										[+else if $a[1] == 1+]
											[+Form::checkbox("listProxy[]", '1', $a[1])+] 
											代理者委任状
										[+else+]
											[+Form::checkbox("listProxy[]", '1')+] 
											代理者委任状
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0]  == 2+]
											[+Form::checkbox("listProxy[]", '2', $a[0])+] 
											議長委任
										[+else if $a[1] == 2+]
											[+Form::checkbox("listProxy[]", '2', $a[1])+] 
											議長委任
										[+else+]
											[+Form::checkbox("listProxy[]", '2')+] 
											議長委任
										[+/if+]
									</label>
								[+else if $count == 3+]
									<label class="checkbox-inline" >
										[+if $a[0] == 0+]
											[+Form::checkbox("listProxy[]", '0', $a[0])+] 
											未定
										[+else if $a[1] == 0+]
											[+Form::checkbox("listProxy[]", '0', $a[1])+] 
											未定
										[+else if $a[2] == 0+]
											[+Form::checkbox("listProxy[]", '0', $a[2])+] 
											未定
										[+else+]
											[+Form::checkbox("listProxy[]", '0')+] 
											未定
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("listProxy[]", '1', $a[0])+] 
											代理者委任状
										[+else if $a[1] == 1+]
											[+Form::checkbox("listProxy[]", '1', $a[1])+] 
											代理者委任状
										[+else if $a[2] == 1+]
											[+Form::checkbox("listProxy[]", '1', $a[2])+] 
											代理者委任状
										[+else+]
											[+Form::checkbox("listProxy[]", '1')+] 
											代理者委任状
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0]  == 2+]
											[+Form::checkbox("listProxy[]", '2', $a[0])+] 
											議長委任
										[+else if $a[1] == 2+]
											[+Form::checkbox("listProxy[]", '2', $a[1])+] 
											議長委任
										[+else if $a[2] == 2+]
											[+Form::checkbox("listProxy[]", '2', $a[2])+] 
											議長委任
										[+else+]
											[+Form::checkbox("listProxy[]", '2')+] 
											議長委任
										[+/if+]
									</label>
								[+else+]
									<label class="checkbox-inline" >
										[+Form::checkbox("listProxy[]", '0')+] 
										未定
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("listProxy[]", '1')+] 
										代理者委任状
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("listProxy[]", '2')+] 
										議長委任
									</label>
								[+/if+]
							</div>
						</div>
						<!-- 備考: noteMember -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">備考</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="noteMember" value="[+Input::get('noteMember')+]" name="noteMember">
							</div>
						</div>
						<!-- ソート順: sortmember -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">ソート順</label>
							<div class="col-md-4">
							[+Form::select('sortmember', Input::get('sortmember'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順','2' => 'No.昇順', '3' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<!-- 検索出力形式: outputSearch -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">検索出力形式</label>
							<div class="col-md-6">
								<!-- 検索結果: move to M004-02 -->
								<label class="radio-inline">
									<input type="radio" name="outputSearch" checked="true" value="1">検索結果
								</label>
								<!-- リスト表示: move to M004-03 -->
								<label class="radio-inline">
									<input type="radio" name="outputSearch" value="2">リスト表示
								</label>
								<!-- CSV出力: move to M004-04 -->
								<label class="radio-inline">
									<input type="radio" name="outputSearch" value="3">CSV出力
								</label>
							</div>
						</div>
						<!-- 検索: action Search -->
						<div class="form-group">
							<div class="col-md-4 col-md-offset-5">
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearch" style="width: 40%;" value="検索" /> 
							</div>
						</div>
					[+Form::close()+]
					<!-- close form method GET -->
				</div>
				<!-- dispay session_flash -->
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

<!-- code js move to M004-02, M004-03, M004-04 -->
[+Asset::js(array('membermanage/baseofmember.js'))+]
