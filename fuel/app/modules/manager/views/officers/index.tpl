<section class="content">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
					役員検索
				</div>
				<div class="box-body">
					[+assign var = formset value = [
						'name'   => 'searchposts',
						'method' => 'get',
						'class'  => 'form-horizontal',
						'id'	 => 'submitSearchOfficers'
					]+]
					[+Form::open($formset)+]
						<!-- 役職: checkbox officer_in_group -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">役職</label>
							<div class="col-md-6">[+$a=Input::get('officer_in_group')+][+$count=count($a)+]
								[+if $count == 1+]
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
											会長
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
											副会長
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
											運営幹事
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
											監査役
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
											実務者連絡員
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
											参与
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
											評議員
									</label>
								[+else if $count == 2+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 222+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else if $count == 3+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else if $a[2] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[2])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else if $a[2] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[2])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else if $a[2] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[2])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else if $a[2] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[2])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else if $a[2] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[2])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else if $a[2] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[2])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else if $a[2] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[2])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else if $count == 4+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else if $a[2] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[2])+] 
												会長
										[+else if $a[3] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[3])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else if $a[2] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[2])+] 
												副会長
										[+else if $a[3] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[3])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else if $a[2] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[2])+] 
												運営幹事
										[+else if $a[3] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[3])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else if $a[2] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[2])+] 
												監査役
										[+else if $a[3] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[3])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else if $a[2] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[2])+] 
												実務者連絡員
										[+else if $a[3] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[3])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else if $a[2] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[2])+] 
												参与
										[+else if $a[3] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[3])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else if $a[2] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[2])+] 
												評議員
										[+else if $a[3] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[3])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else if $count == 5+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else if $a[2] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[2])+] 
												会長
										[+else if $a[3] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[3])+] 
												会長
										[+else if $a[4] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[4])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else if $a[2] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[2])+] 
												副会長
										[+else if $a[3] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[3])+] 
												副会長
										[+else if $a[4] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[4])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else if $a[2] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[2])+] 
												運営幹事
										[+else if $a[3] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[3])+] 
												運営幹事
										[+else if $a[4] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[4])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else if $a[2] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[2])+] 
												監査役
										[+else if $a[3] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[3])+] 
												監査役
										[+else if $a[4] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[4])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else if $a[2] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[2])+] 
												実務者連絡員
										[+else if $a[3] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[3])+] 
												実務者連絡員
										[+else if $a[4] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[4])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else if $a[2] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[2])+] 
												参与
										[+else if $a[3] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[3])+] 
												参与
										[+else if $a[4] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[4])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else if $a[2] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[2])+] 
												評議員
										[+else if $a[3] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[3])+] 
												評議員
										[+else if $a[4] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[4])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else if $count == 6+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else if $a[2] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[2])+] 
												会長
										[+else if $a[3] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[3])+] 
												会長
										[+else if $a[4] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[4])+] 
												会長
										[+else if $a[5] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[5])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else if $a[2] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[2])+] 
												副会長
										[+else if $a[3] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[3])+] 
												副会長
										[+else if $a[4] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[4])+] 
												副会長
										[+else if $a[5] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[5])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else if $a[2] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[2])+] 
												運営幹事
										[+else if $a[3] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[3])+] 
												運営幹事
										[+else if $a[4] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[4])+] 
												運営幹事
										[+else if $a[5] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[5])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else if $a[2] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[2])+] 
												監査役
										[+else if $a[3] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[3])+] 
												監査役
										[+else if $a[4] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[4])+] 
												監査役
										[+else if $a[5] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[5])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else if $a[2] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[2])+] 
												実務者連絡員
										[+else if $a[3] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[3])+] 
												実務者連絡員
										[+else if $a[4] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[4])+] 
												実務者連絡員
										[+else if $a[5] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[5])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else if $a[2] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[2])+] 
												参与
										[+else if $a[3] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[3])+] 
												参与
										[+else if $a[4] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[4])+] 
												参与
										[+else if $a[5] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[5])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else if $a[2] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[2])+] 
												評議員
										[+else if $a[3] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[3])+] 
												評議員
										[+else if $a[4] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[4])+] 
												
										[+else if $a[5] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[5])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else if $count == 7+]
									<label class="checkbox-inline">
										[+if $a[0] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[0])+] 
												会長
										[+else if $a[1] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[1])+] 
												会長
										[+else if $a[2] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[2])+] 
												会長
										[+else if $a[3] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[3])+] 
												会長
										[+else if $a[4] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[4])+] 
												会長
										[+else if $a[5] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[5])+] 
												会長
										[+else if $a[6] == 1+]
											[+Form::checkbox("officer_in_group[]", '1', $a[6])+] 
												会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '1')+] 
												会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[0])+] 
												副会長
										[+else if $a[1] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[1])+] 
												副会長
										[+else if $a[2] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[2])+] 
												副会長
										[+else if $a[3] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[3])+] 
												副会長
										[+else if $a[4] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[4])+] 
												副会長
										[+else if $a[5] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[5])+] 
												副会長
										[+else if $a[6] == 2+]
											[+Form::checkbox("officer_in_group[]", '2', $a[6])+] 
												副会長
										[+else+]
											[+Form::checkbox("officer_in_group[]", '2')+] 
												副会長
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[0])+] 
												運営幹事
										[+else if $a[1] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[1])+] 
												運営幹事
										[+else if $a[2] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[2])+] 
												運営幹事
										[+else if $a[3] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[3])+] 
												運営幹事
										[+else if $a[4] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[4])+] 
												運営幹事
										[+else if $a[5] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[5])+] 
												運営幹事
										[+else if $a[6] == 11+]
											[+Form::checkbox("officer_in_group[]", '11', $a[6])+] 
												運営幹事
										[+else+]
											[+Form::checkbox("officer_in_group[]", '11')+] 
												運営幹事
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[0])+] 
												監査役
										[+else if $a[1] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[1])+] 
												監査役
										[+else if $a[2] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[2])+] 
												監査役
										[+else if $a[3] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[3])+] 
												監査役
										[+else if $a[4] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[4])+] 
												監査役
										[+else if $a[5] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[5])+] 
												監査役
										[+else if $a[6] == 12+]
											[+Form::checkbox("officer_in_group[]", '12', $a[6])+] 
												監査役
										[+else+]
											[+Form::checkbox("officer_in_group[]", '12')+] 
												監査役
										[+/if+]
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+if $a[0] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[0])+] 
												実務者連絡員
										[+else if $a[1] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[1])+] 
												実務者連絡員
										[+else if $a[2] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[2])+] 
												実務者連絡員
										[+else if $a[3] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[3])+] 
												実務者連絡員
										[+else if $a[4] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[4])+] 
												実務者連絡員
										[+else if $a[5] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[5])+] 
												実務者連絡員
										[+else if $a[6] == 21+]
											[+Form::checkbox("officer_in_group[]", '21', $a[6])+] 
												実務者連絡員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '21')+] 
												実務者連絡員
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[0])+] 
												参与
										[+else if $a[1] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[1])+] 
												参与
										[+else if $a[2] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[2])+] 
												参与
										[+else if $a[3] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[3])+] 
												参与
										[+else if $a[4] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[4])+] 
												参与
										[+else if $a[5] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[5])+] 
												参与
										[+else if $a[6] == 22+]
											[+Form::checkbox("officer_in_group[]", '22', $a[6])+] 
												参与
										[+else+]
											[+Form::checkbox("officer_in_group[]", '22')+] 
												参与
										[+/if+]
									</label>
									<label class="checkbox-inline">
										[+if $a[0] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[0])+] 
												評議員
										[+else if $a[1] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[1])+] 
												評議員
										[+else if $a[2] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[2])+] 
												評議員
										[+else if $a[3] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[3])+] 
												評議員
										[+else if $a[4] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[4])+] 
												
										[+else if $a[5] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[5])+] 
												評議員
										[+else if $a[6] == 23+]
											[+Form::checkbox("officer_in_group[]", '23', $a[6])+] 
												評議員
										[+else+]
											[+Form::checkbox("officer_in_group[]", '23')+] 
												評議員
										[+/if+]
									</label>
								[+else+]
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '1')+] 
											会長
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '2')+] 
											副会長
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '11')+] 
											運営幹事
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '12')+] 
											監査役
									</label>
									<br/><br/>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '21')+] 
											実務者連絡員
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '22')+] 
											参与
									</label>
									<label class="checkbox-inline">
										[+Form::checkbox("officer_in_group[]", '23')+] 
											評議員
									</label>
								[+/if+]
							</div>
						</div>
						<!-- 会員名称: nameMember -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">会員名称</label>
							<div class="col-md-4">
								<input type="text" style="width: 80%;" class="form-control" value="[+Input::get('nameMember')+]" id="nameMember" name="nameMember">
							</div>
						</div>
						<!-- 役員氏名: nameOfficers -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">役員氏名</label>
							<div class="col-md-4">
								<input type="text" style="width: 80%;" class="form-control" value="[+Input::get('nameOfficers')+]" id="nameOfficers" name="nameOfficers">
							</div>
						</div>
						<!-- 担当者氏名: nameCurator -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">担当者氏名</label>
							<div class="col-md-4">
								<input type="text" style="width: 80%;" class="form-control" value="[+Input::get('nameCurator')+]" id="nameCurator" name="nameCurator">
							</div>
						</div>
						<!-- 備考: noteOfficers -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">備考</label>
							<div class="col-md-4">
								<input type="text" style="width: 80%;" class="form-control" value="[+Input::get('noteOfficers')+]" id="noteOfficers" name="noteOfficers">
							</div>
						</div>
						<!-- ソート順: sortOfficers -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">ソート順</label>
							<div class="col-md-4">
								[+Form::select('sortOfficers', Input::get('sortOfficers'), ['0' => '会員名称(ふりがな)  昇順','1' => '会員名称(ふりがな)  降順','2' => 'No.昇順', '3' => 'No.降順'], ['class' => 'form-control select2 select2-hidden-accessible'])+]
							</div>
						</div>
						<!-- 検索出力形式: outputSearchOfficers -->
						<div class="form-group">
							<label class="col-md-2 col-md-offset-2 control-common-label text-left">検索出力形式</label>
							<div class="col-md-6">
								<label class="radio-inline">
									<input type="radio" name="outputSearchOfficers" checked="true" value="1">検索結果
								</label>
								<label class="radio-inline">
									<input type="radio" name="outputSearchOfficers" value="2">リスト表示
								</label>
								<label class="radio-inline">
									<input type="radio" name="outputSearchOfficers" value="3">CSV出力
								</label>
							</div>
						</div>
						<!-- 検索: SearchOfficers -->
						<div class="form-group">
							<div class="col-md-4 col-md-offset-5">
								<input type="submit" name="submit" class="btn btn-md btn-primary" id="btnSearchOfficers" style="width: 40%;" value="検索" /> 
							</div>
						</div>
					[+Form::close()+]
				</div>
				<!-- set_flash errors -->
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
<!-- move to M008-02, M008-03, M008-04 -->
[+Asset::js(array('membermanage/officers.js'))+]