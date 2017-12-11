<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
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
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員名称</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="nameMember" value="[+Input::get('nameMember')+]" name="nameMember">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員所属・役職</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="officer_in_commitee" value="[+Input::get('officer_in_commitee')+]" name="officer_in_commitee">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員属性</label>
							<div class="col-md-4">
								[+Form::select('attributes_member', Input::get('attributes_member'), ['0' => 'なし', '1' => '企業','2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">年会費の請求</label>
							<div class="col-md-6">[+$a=Input::get('request_of_cost')+][+$count=count($a)+]
								[+if $count == 1+]
									<label class="checkbox-inline">
										[+Form::checkbox("request_of_cost[]", '0', $a[0])+] 
										未請求
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("request_of_cost[]", '1', $a[0])+] 
										請求済み
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("request_of_cost[]", '9', $a[0])+] 
										請求必要なし
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline">
										[+if $a[0] == 0+]
											[+Form::checkbox("request_of_cost[]", '0', $a[0])+] 
											未請求
										[+else if $a[1] = 0+]
											[+Form::checkbox("request_of_cost[]", '0', $a[1])+] 
											未請求
										[+else+]
											[+Form::checkbox("request_of_cost[]", '0')+] 
											未請求
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("request_of_cost[]", '1', $a[0])+] 
											請求済み
										[+else if $a[1] == 1+]
											[+Form::checkbox("request_of_cost[]", '1', $a[1])+] 
											請求済み
										[+else+]
											[+Form::checkbox("request_of_cost[]", '1')+] 
											請求済み
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 9+]
											[+Form::checkbox("request_of_cost[]", '9', $a[0])+] 
											請求必要なし
										[+else if $a[1] == 9+]
											[+Form::checkbox("request_of_cost[]", '9', $a[1])+] 
											請求必要なし
										[+else+]
											[+Form::checkbox("request_of_cost[]", '9')+] 
											請求必要なし
										[+/if+]
									</label>
								[+else if $count == 3+]
									<label class="checkbox-inline">
										[+if $a[0] == 0+]
											[+Form::checkbox("request_of_cost[]", '0', $a[0])+] 
											未請求
										[+else if $a[1] = 0+]
											[+Form::checkbox("request_of_cost[]", '0', $a[1])+] 
											未請求
										[+else if $a[2] = 0+]
											[+Form::checkbox("request_of_cost[]", '0', $a[2])+] 
											未請求
										[+else+]
											[+Form::checkbox("request_of_cost[]", '0')+] 
											未請求
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("request_of_cost[]", '1', $a[0])+] 
											請求済み
										[+else if $a[1] == 1+]
											[+Form::checkbox("request_of_cost[]", '1', $a[1])+] 
											請求済み
										[+else if $a[2] == 1+]
											[+Form::checkbox("request_of_cost[]", '1', $a[2])+] 
											請求済み
										[+else+]
											[+Form::checkbox("request_of_cost[]", '1')+] 
											請求済み
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 9+]
											[+Form::checkbox("request_of_cost[]", '9', $a[0])+] 
											請求必要なし
										[+else if $a[1] == 9+]
											[+Form::checkbox("request_of_cost[]", '9', $a[1])+] 
											請求必要なし
										[+else if $a[2] == 9+]
											[+Form::checkbox("request_of_cost[]", '9', $a[2])+] 
											請求必要なし
										[+else+]
											[+Form::checkbox("request_of_cost[]", '9')+] 
											請求必要なし
										[+/if+]
									</label>
								[+else+]
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
								[+/if+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">年会費の入金</label>
							<div class="col-md-6">[+$a=Input::get('receipt_of_cost')+][+$count=count($a)+]
								[+if $count == 1+]
									<label class="checkbox-inline">
										[+Form::checkbox("receipt_of_cost[]", '0', $a[0])+] 
										未入金
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("receipt_of_cost[]", '1', $a[0])+] 
										入金済み
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("receipt_of_cost[]", '9', $a[0])+] 
										入金必要なし
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline">
										[+if $a[0] == 0+]
											[+Form::checkbox("receipt_of_cost[]", '0', $a[0])+] 
											未入金
										[+else if $a[1] == 0+]
											[+Form::checkbox("receipt_of_cost[]", '0', $a[1])+] 
											未入金
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '0')+] 
											未入金
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("receipt_of_cost[]", '1', $a[0])+] 
											入金済み
										[+else if $a[1] == 1+]
											[+Form::checkbox("receipt_of_cost[]", '1', $a[1])+] 
											入金済み
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '1')+] 
											入金済み
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 9+]
											[+Form::checkbox("receipt_of_cost[]", '9', $a[0])+] 
											入金必要なし
										[+else if $a[1] == 9+]
											[+Form::checkbox("receipt_of_cost[]", '9', $a[1])+] 
											入金必要なし
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '9')+] 
											入金必要なし
										[+/if+]
									</label>
								[+else if $count == 3+]
									<label class="checkbox-inline">
										[+if $a[0] == 0+]
											[+Form::checkbox("receipt_of_cost[]", '0', $a[0])+] 
											未入金
										[+else if $a[1] == 0+]
											[+Form::checkbox("receipt_of_cost[]", '0', $a[1])+] 
											未入金
										[+else if $a[2] == 0+]
											[+Form::checkbox("receipt_of_cost[]", '0', $a[2])+] 
											未入金
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '0')+] 
											未入金
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("receipt_of_cost[]", '1', $a[0])+] 
											入金済み
										[+else if $a[1] == 1+]
											[+Form::checkbox("receipt_of_cost[]", '1', $a[1])+] 
											入金済み
										[+else if $a[2] == 1+]
											[+Form::checkbox("receipt_of_cost[]", '1', $a[2])+] 
											入金済み
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '1')+] 
											入金済み
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 9+]
											[+Form::checkbox("receipt_of_cost[]", '9', $a[0])+] 
											入金必要なし
										[+else if $a[1] == 9+]
											[+Form::checkbox("receipt_of_cost[]", '9', $a[1])+] 
											入金必要なし
										[+else if $a[2] == 9+]
											[+Form::checkbox("receipt_of_cost[]", '9', $a[2])+] 
											入金必要なし
										[+else+]
											[+Form::checkbox("receipt_of_cost[]", '9')+] 
											入金必要なし
										[+/if+]
									</label>
								[+else+]
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
								[+/if+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">備考</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="noteMemberofCommitte" value="[+Input::get('noteMemberofCommitte')+]" name="noteMemberofCommitte">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">ソート順</label>
							<div class="col-md-4">
							[+Form::select('sortmemberofCommitte', Input::get('sortmemberofCommitte'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順','2' => 'No.昇順', '3' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">検索出力形式</label>
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
								[+if isset($dataCheckurl)+]
									<input type="hidden" id="backurl" name="backurl" value="[+$dataCheckurl+]">
								[+else+]
									<input type="hidden" id="backurl" name="backurl" value="0">
								[+/if+]
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearchMemberofCommitte" style="width: 40%;" value="検索" /> 
							</div>
						</div>
					[+Form::close()+]
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
					[+if isset($memberofcommitte_serach) && $count_sear != 0 +]
					<div class="col-md-offset-4">
						[+Pagination::instance('mypagination')->render()+]
					</div>
						[+$pagina_counter = Pagination::instance('mypagination')+]
						[+$no_counter = (($pagina_counter->current_page - 1) * $pagina_counter->per_page) + 1+]
						<div class="pd-top">
							<table class="table table-hover">
								<tbody>
									<tr class="tbl-header">
										<th></th>
										<th>No</th>
										<th>会員属性</th>
										<th>会員名称</th>
										<th>登録日</th>
									</tr> 
									[+foreach $memberofcommitte_serach as $item +]	
									<tr>
										<td>
											<a class="btn btn-sm btn-primary" href="manager/memberofcommittees/temp/[+$item->id_memberofcommittee+]">
												<span>確認/編集</span>
											</a>
										</td>
										<td>[+$no_counter+]</td>
										[+if $item->type == 0+]
											<td>なし</td>
										[+/if+]
										[+if $item->type == 1+]
											<td>企業</td>
										[+/if+]
										[+if $item->type == 2+]
											<td>団体</td>
										[+/if+]
										[+if $item->type == 3+]
											<td>研究機関</td>
										[+/if+]
										[+if $item->type == 4+]
											<td>個人</td>
										[+/if+]
										[+if $item->type == 5+]
											<td>地方自治体</td>
										[+/if+]
										<td>[+(strlen($item->name) > 25) ? Str::truncate($item->name, 20, '...') : $item->name+]</td>
										<td>[+Date::forge($item->created_at)->format("%Y")+] 年 [+Date::forge($item->created_at)->format("%m")+] 月 [+Date::forge($item->created_at)->format("%d")+] 日</td>
									</tr>
									[+$no_counter = $no_counter + 1+]
									[+/foreach +]
								</tbody>
							</table>			
						</div>
					<div class="col-md-offset-4">
						[+Pagination::instance('mypagination')->render()+]
					</div>
					[+/if +]
				</div>
			</div>
		</div>
	</div>
</section>
[+Asset::js(array('membermanage/memberofcommittesearch.js'))+]

