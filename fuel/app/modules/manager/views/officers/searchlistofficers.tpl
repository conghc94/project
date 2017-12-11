<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					役員一覧
				</div>
				<div class="box-body">
					<a class="btn btn-primary" style="margin-left: 10%; margin-bottom: 20px; width: 6%; height: 5%;" href='manager/officers/index'>
						<span>戻る</span>
					</a>
					[+if isset($searchlist) && $count_sear != 0+]
					<div class="col-md-offset-4">
					</div>
						<div class="std-searchlist">
							<table class="table table-hover">
								<tbody>
									<tr class="tbl-header">
										<th width="90px"></th>
										<th width="50px">NO</th>
										<th width="100px">会員属性</th>
										<th width="110px">会員名称</th>
										<th width="110px">代表者役職</th>
										<th width="110px">代表者</th>
										<th width="110px">担当者役職</th>
										<th width="120px">担当者</th>
										<th width="120px">メールアドレス</th>
										<th width="110px">電話番号</th>
										<th width="110px">FAX</th>
										<th width="110px">郵便番号</th>
										<th width="90px">住所1</th>
										<th width="90px">住所2</th>
										<th width="110px">サブ担当役職</th>
										<th width="120px">サブ担当</th>
										<th width="120px">メールアドレス</th>
										<th width="110px">電話番号</th>
										<th width="110px">FAX</th>
										<th width="110px">郵便番号</th>
										<th width="90px">住所1</th>
										<th width="90px">住所2</th>
										<th width="150px">変更履歴コメント</th>
										<th width="110px">備考</th>
									</tr>
									[+$i = 1 +] 
									[+foreach $searchlist as $item +]	
									<tr>
										<td width="90px">
											<a class="btn btn-sm btn-primary" href="manager/officers/getEdit/[+$item['officer_id']+]">
												<span>確認/編集</span>        
											</a>
										</td>
										<td width="50px">[+$i+]</td>
										[+if $item['type'] == 0+]
											<td width="100px">なし</td>
										[+/if+]
										[+if $item['type'] == 1+]
											<td width="100px">企業</td>
										[+/if+]
										[+if $item['type'] == 2+]
											<td width="100px">団体</td>
										[+/if+]
										[+if $item['type'] == 3+]
											<td width="100px">研究機関</td>
										[+/if+]
										[+if $item['type'] == 4+]
											<td width="100px">個人</td>
										[+/if+]
										[+if $item['type'] == 5+]
											<td width="100px">地方自治体</td>
										[+/if+]
										<td width="110px">
											[+(strlen($item['name']) > 11) ? Str::truncate($item['name'], 8, '...') : $item['name']+]
										</td>
										<td width="110px">
											[+(strlen($item['person_department']) > 11) ? Str::truncate($item['person_department'], 8, '...') : $item['person_department']+]
										</td>
										<td width="110px">
											[+(strlen($item['person_name']) > 11) ? Str::truncate($item['person_name'], 8, '...') : $item['person_name']+]
										</td>
										<td width="110px">
											[+(strlen($item['department_contact21']) > 11) ? Str::truncate($item['department_contact21'], 8, '...') : $item['department_contact21']+]
										</td>
										<td width="120px">
											[+(strlen($item['name_contact21']) > 11) ? Str::truncate($item['name_contact21'], 8, '...') : $item['name_contact21']+]
										</td>
										<td width="120px">
											[+(strlen($item['email_contact21']) > 11) ? Str::truncate($item['email_contact21'], 8, '...') : $item['email_contact21']+]
										</td>
										<td width="110px">
											[+(strlen($item['tel_contact21']) > 11) ? Str::truncate($item['tel_contact21'], 8, '...') : $item['tel_contact21']+]
										</td>
										<td width="110px">
											[+(strlen($item['fax_contact21']) > 11) ? Str::truncate($item['fax_contact21'], 8, '...') : $item['fax_contact21']+]
										</td>
										<td width="110px">
											[+(strlen($item['zip_contact21']) > 11) ? Str::truncate($item['zip_contact21'], 8, '...') : $item['zip_contact21']+]
										</td>
										<td  width="90px">
											[+(strlen($item['address01_contact21']) > 11) ? Str::truncate($item['address01_contact21'], 8, '...') : $item['address01_contact21']+]
										</td>
										<td width="90px">
											[+(strlen($item['address02_contact21']) > 11) ? Str::truncate($item['address02_contact21'], 8, '...') : $item['address02_contact21']+]
										</td>
										<td width="110px">
											[+(strlen($item['department_contact22']) > 11) ? Str::truncate($item['department_contact22'], 8, '...') : $item['department_contact22']+]
										</td>
										<td width="120px">
											[+(strlen($item['name_contact22']) > 11) ? Str::truncate($item['name_contact22'], 8, '...') : $item['name_contact22']+]
										</td>
										<td width="120px">
											[+(strlen($item['email_contact22']) > 11) ? Str::truncate($item['email_contact22'], 8, '...') : $item['email_contact22']+]
										</td>
										<td width="110px">
											[+(strlen($item['tel_contact22']) > 11) ? Str::truncate($item['tel_contact22'], 8, '...') : $item['tel_contact22']+]
										</td>
										<td width="110px">
											[+(strlen($item['fax_contact22']) > 11) ? Str::truncate($item['fax_contact22'], 8, '...') : $item['fax_contact22']+]
										</td>
										<td width="110px">
											[+(strlen($item['zip_contact22']) > 11) ? Str::truncate($item['zip_contact22'], 8, '...') : $item['zip_contact22']+]
										</td>
										<td width="90px">
											[+(strlen($item['address01_contact22']) > 11) ? Str::truncate($item['address01_contact22'], 8, '...') : $item['address01_contact22']+]
										</td>
										<td width="90px">
											[+(strlen($item['address02_contact22']) > 11) ? Str::truncate($item['address02_contact22'], 8, '...') : $item['address02_contact22']+]
										</td>
										<td width="150px">[+(strlen($item['edit_officers']) > 11) ? Str::truncate($item['edit_officers'], 8, '...') : $item['edit_officers']+]</td>
										<td width="110px">[+(strlen($item['note_officers']) > 11) ? Str::truncate($item['note_officers'], 8, '...') : $item['note_officers']+]</td>
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
[+Asset::js(array('membermanage/searchlistofficers.js'))+]

