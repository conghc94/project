[+Asset::css(array('site/common.css'))+]
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					会員一覧
				</div>
				<div class="box-body">
					<a class="btn btn-primary" style="margin-left: 10%; margin-bottom: 20px; width: 6%; height: 5%;" href='manager/baseofmember/index'>
						<span>戻る</span>
					</a>
					[+if isset($searchlist) && $count_sear != 0+]
					<div class="col-md-offset-4">
					</div>
						<div class="std-searchlist">
							<table class="table table-striped" style="width: 100%;">
								<thead>
									<tr>
										<th width="90px"></th>
										<th width="40px">No</th>
										<th width="70px">会員属性</th>
										<th width="110px">会員名称</th>
										<th width="110px">代表者役職</th>
										<th width="90px">代表者</th>
										<th width="110px">担当者役職</th>
										<th width="90px">担当者</th>
										<th width="120px">メールアドレス</th>
										<th width="110px">電話番号</th>
										<th width="110px">FAX</th>
										<th width="110px">郵便番号</th>
										<th width="90px">住所1</th>
										<th width="90px">住所2</th>
										<th width="110px">サブ担当役職</th>
										<th width="90px">サブ担当</th>
										<th width="120px">メールアドレス</th>
										<th width="90px">電話番号</th>
										<th width="110px">FAX</th>
										<th width="110px">郵便番号</th>
										<th width="90px">住所1</th>
										<th width="90px">住所2</th>
										<th width="130px">変更履歴コメント</th>
										<th width="110px">備考</th>
									</tr>
								</thead>
								<tbody>
									[+$i = 1 +] 
									[+foreach $searchlist as $item +]
									<tr>
										<td width="90px">
											<a class="btn btn-sm btn-primary" href="manager/members/temp/[+$item['id']+]">
												<span>確認/編集</span>
											</a>
										</td>
										<td width="40px">[+$i+]</td>
										[+if $item['type'] == 0+]
											<td width="70px">なし</td>
										[+/if+]
										[+if $item['type'] == 1+]
											<td width="70px">企業</td>
										[+/if+]
										[+if $item['type'] == 2+]
											<td width="70px">団体</td>
										[+/if+]
										[+if $item['type'] == 3+]
											<td width="70px">研究機関</td>
										[+/if+]
										[+if $item['type'] == 4+]
											<td width="70px">個人</td>
										[+/if+]
										[+if $item['type'] == 5+]
											<td width="70px">地方自治体</td>
										[+/if+]
										<td width="110px">
											[+(strlen($item['name']) > 20) ? Str::truncate($item['name'], 20, '...') : $item['name']+]
										</td>
										<td>
											[+(strlen($item['person_department']) > 20) ? Str::truncate($item['person_department'], 20, '...') : $item['person_department']+]
										</td>
										<td>
											[+(strlen($item['person_name']) > 20) ? Str::truncate($item['person_name'], 20, '...') : $item['person_name']+]
										</td>
										<td>
											[+(strlen($item['department_contact11']) > 20) ? Str::truncate($item['department_contact11'], 20, '...') : $item['department_contact11']+]
										</td>
										<td>
											[+(strlen($item['name_contact11']) > 20) ? Str::truncate($item['name_contact11'], 20, '...') : $item['name_contact11']+]
										</td>
										<td>
											[+(strlen($item['email_contact11']) > 20) ? Str::truncate($item['email_contact11'], 20, '...') : $item['email_contact11']+]
										</td>
										<td>
											[+(strlen($item['tel_contact11']) > 20) ? Str::truncate($item['tel_contact11'], 20, '...') : $item['tel_contact11']+]
										</td>
										<td>
											[+(strlen($item['fax_contact11']) > 20) ? Str::truncate($item['fax_contact11'], 20, '...') : $item['fax_contact11']+]
										</td>
										<td>
											[+(strlen($item['zip_contact11']) > 20) ? Str::truncate($item['zip_contact11'], 20, '...') : $item['zip_contact11']+]
										</td>
										<td>
											[+(strlen($item['address01_contact11']) > 20) ? Str::truncate($item['address01_contact11'], 20, '...') : $item['address01_contact11']+]
										</td>
										<td>
											[+(strlen($item['address02_contact11']) > 20) ? Str::truncate($item['address02_contact11'], 20, '...') : $item['address02_contact11']+]
										</td>
										<td>
											[+(strlen($item['department_contact12']) > 20) ? Str::truncate($item['department_contact12'], 20, '...') : $item['department_contact12']+]
										</td>
										<td>
											[+(strlen($item['name_contact12']) > 20) ? Str::truncate($item['name_contact12'], 20, '...') : $item['name_contact12']+]
										</td>
										<td>
											[+(strlen($item['email_contact12']) > 20) ? Str::truncate($item['email_contact12'], 20, '...') : $item['email_contact12']+]
										</td>
										<td>
											[+(strlen($item['tel_contact12']) > 20) ? Str::truncate($item['tel_contact12'], 20, '...') : $item['tel_contact12']+]
										</td>
										<td>
											[+(strlen($item['fax_contact12']) > 20) ? Str::truncate($item['fax_contact12'], 20, '...') : $item['fax_contact12']+]
										</td>
										<td>
											[+(strlen($item['zip_contact12']) > 20) ? Str::truncate($item['zip_contact12'], 20, '...') : $item['zip_contact12']+]
										</td>
										<td>
											[+(strlen($item['address01_contact12']) > 20) ? Str::truncate($item['address01_contact12'], 20, '...') : $item['address01_contact12']+]
										</td>
										<td>
											[+(strlen($item['address02_contact12']) > 20) ? Str::truncate($item['address02_contact12'], 20, '...') : $item['address02_contact12']+]
										</td>
										<td>[+(strlen($item['member_edit']) > 20) ? Str::truncate($item['member_edit'], 20, '...') : $item['member_edit']+]</td>
										<td width="110px">[+(strlen($item['member_note']) > 20) ? Str::truncate($item['member_note'], 20, '...') : $item['member_note']+]</td>
									</tr>
									[+$i = $i + 1+]
									[+/foreach +]
								</tbody>
							</table>
						</div>
					<div class="col-md-offset-4">
					</div>
					[+/if +]
					[+if $count_sear == 0 +]	
						<div class="col-md-4 col-md-offset-4">
							<div class="alert alert-danger alert-dismissable">
								<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
								<strong>一致するレコードが見つかりません</strong>
							</div>
						</div>
					[+/if+]
					[+if isset($dataCheckurl)+]
						<input type="hidden" id="backurl" name="backurl" value="[+$dataCheckurl+]">
					[+else+]
						<input type="hidden" id="backurl" name="backurl" value="0">
					[+/if+]
				</div>
			</div>
		</div>
	</div>
</section>
[+Asset::js(array('membermanage/baseofmember_searchlist.js'))+]