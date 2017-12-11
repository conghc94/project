<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					会員検索
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
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員フラグ</label>
							<div class="col-md-6">[+$a=Input::get('RRI')+][+$count=count($a)+]
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
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員属性</label>
							<div class="col-md-4">
								[+Form::select('attributes_member', Input::get('attributes_member'), ['0' => 'なし', '1' => '企業','2' => '団体', '3' => '研究機関', '4' => '個人', '5' => '地方自治体'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">総会の出席</label>
							<div class="col-md-6">[+$a=Input::get('listPresent')+][+$count=count($a)+]
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
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">総会の委任状</label>
							<div class="col-md-6">[+$a=Input::get('listProxy')+][+$count=count($a)+]
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
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">備考</label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="noteMember" value="[+Input::get('noteMember')+]" name="noteMember">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">ソート順</label>
							<div class="col-md-4">
							[+Form::select('sortmember', Input::get('sortmember'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順','2' => 'No.昇順', '3' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
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
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearch" style="width: 40%;" value="検索" /> 
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
					[+if isset($manager_search) && $count_sear != 0 +]
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
									[+foreach $manager_search as $item +]
									<tr>
										<td>
											<a class="btn btn-sm btn-primary" href="manager/members/temp/[+$item->id+]">
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
[+Asset::js(array('membermanage/baseofmember_searchmember.js'))+]
