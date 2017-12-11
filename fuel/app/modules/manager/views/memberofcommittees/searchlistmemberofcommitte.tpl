<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					所属メンバー検索
				</div>
				<div class="box-body">
					<a class="btn btn-primary" style="margin-left: 10%; margin-bottom: 20px; width: 6%; height: 5%;" href='manager/memberofcommittees/index'>
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
										<th width="30px">No</th>
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
									[+$i = 1 +] 
									[+foreach $searchlist as $item +]	
									<tr>
										<td width="90px">
											<a class="btn btn-sm btn-primary" href="manager/memberofcommittees/temp/[+$item['id_memberofcommittee']+]">
												<span>確認/編集</span>
											</a>
										</td>
										<td width="30px">[+$i+]</td>
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
											[+(strlen($item['name']) > 13) ? Str::truncate($item['name'], 10, '...') : $item['name']+]
										</td>
										<td width="110px">
											[+(strlen($item['person_department']) > 13) ? Str::truncate($item['person_department'], 10, '...') : $item['person_department']+]
										</td>
										<td width="90px">
											[+(strlen($item['person_name']) > 13) ? Str::truncate($item['person_name'], 10, '...') : $item['person_name']+]
										</td>
										<td width="110px">
											[+(strlen($item['department_contact11']) > 13) ? Str::truncate($item['department_contact11'], 10, '...') : $item['department_contact11']+]
										</td>
										<td width="90px">
											[+(strlen($item['name_contact11']) > 13) ? Str::truncate($item['name_contact11'], 10, '...') : $item['name_contact11']+]
										</td>
										<td width="120px">
											[+(strlen($item['email_contact11']) > 13) ? Str::truncate($item['email_contact11'], 10, '...') : $item['email_contact11']+]
										</td>
										<td width="110px">
											[+(strlen($item['tel_contact11']) > 13) ? Str::truncate($item['tel_contact11'], 10, '...') : $item['tel_contact11']+]
										</td>
										<td width="110px">
											[+(strlen($item['fax_contact11']) > 13) ? Str::truncate($item['fax_contact11'], 10, '...') : $item['fax_contact11']+]
										</td>
										<td width="110px">
											[+(strlen($item['zip_contact11']) > 13) ? Str::truncate($item['zip_contact11'], 10, '...') : $item['zip_contact11']+]
										</td>
										<td  width="90px">
											[+(strlen($item['address01_contact11']) > 13) ? Str::truncate($item['address01_contact11'], 10, '...') : $item['address01_contact11']+]
										</td>
										<td width="90px">
											[+(strlen($item['address02_contact11']) > 13) ? Str::truncate($item['address02_contact11'], 10, '...') : $item['address02_contact11']+]
										</td>
										<td width="110px">
											[+(strlen($item['department_contact12']) > 13) ? Str::truncate($item['department_contact12'], 10, '...') : $item['department_contact12']+]
										</td>
										<td width="90px">
											[+(strlen($item['name_contact12']) > 13) ? Str::truncate($item['name_contact12'], 10, '...') : $item['name_contact12']+]
										</td>
										<td width="120px">
											[+(strlen($item['email_contact12']) > 13) ? Str::truncate($item['email_contact12'], 10, '...') : $item['email_contact12']+]
										</td>
										<td width="110px">
											[+(strlen($item['tel_contact12']) > 13) ? Str::truncate($item['tel_contact12'], 10, '...') : $item['tel_contact12']+]
										</td>
										<td width="110px">
											[+(strlen($item['fax_contact12']) > 13) ? Str::truncate($item['fax_contact12'], 10, '...') : $item['fax_contact12']+]
										</td>
										<td width="110px">
											[+(strlen($item['zip_contact12']) > 13) ? Str::truncate($item['zip_contact12'], 10, '...') : $item['zip_contact12']+]
										</td>
										<td width="90px">
											[+(strlen($item['address01_contact12']) > 13) ? Str::truncate($item['address01_contact12'], 10, '...') : $item['address01_contact12']+]
										</td>
										<td width="90px">
											[+(strlen($item['address02_contact12']) > 13) ? Str::truncate($item['address02_contact12'], 10, '...') : $item['address02_contact12']+]
										</td>
										<td width="130px">[+(strlen($item['memberofcommittees_edit']) > 13) ? Str::truncate($item['memberofcommittees_edit'], 10, '...') : $item['memberofcommittees_edit']+]</td>
										<td width="110px">[+(strlen($item['memberofcommittees_note']) > 13) ? Str::truncate($item['memberofcommittees_note'], 10, '...') : $item['memberofcommittees_note']+]</td>
									</tr>
									[+$i = $i + 1+]
									[+/foreach +]
								</tbody>
							</table>
						</div>
					<div class="col-md-offset-4">
					</div>
					[+/if +]
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
[+Asset::js(array('membermanage/memberofcommittesearchlist.js'))+]