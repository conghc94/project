<section class="content">
[+Asset::css(array('site/representative.css'))+]
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
                    委員会検索
				</div>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<a class="btn btn-primary" style=" margin-bottom: 2%; height: 5%; margin-top: 20px;" href='manager/committee/index'>
							<span>委員会追加</span>
						</a>
					</div>
				</div>
				<hr>
				<div class="box-body">
					[+assign var = formset value = [
						'name'   => 'searchposts',
						'method' => 'post',
						'class'  => 'form-horizontal',
						'id'	 => 'submitSearchCommittee'
					]+]
					[+Form::open($formset)+]
						<div class="row">
							<div class="form-horizontal">
								<div class="form-group">
									<label class="col-md-2 col-md-offset-2 control-common-label text-left">親委員会</label>
									<div class="col-md-3">
										<select class="form-control" id="committe_select" name="committe_select">
											<option value="0"></option>
											[+foreach $list_committee_name as $key => $item+]
												<option value="[+$item['id']+]">[+$item['committee_name']+]</option>
											[+/foreach+]
										</select>
									</div>
								</div>
							</div>
						</div>
					[+Form::close()+]
					<hr>
					[+if isset($newArray)+]
						<div class="pd-top">
							<table class="table table-hover">
						        <thead>
						            <tr class="tbl-header">
						                <th>NO</th>
						                <th>組織名</th>
						                <th>登録日</th>
						                <th></th>
						            </tr>
						        </thead>
						        <tbody>
						            [+$total_records = 0+]
							        [+foreach $newArray as $item+]
							        	[+if $item['level'] == 1+]
							        		[+$total_records = $total_records + 1+]
							        	[+/if+]
							        [+/foreach+]
							        [+$i = 0+]
							        [+foreach $newArray as $item +]
							        		[+$padding = ($item['level'] - 1)*30|cat:'px'+]
											[+$padding = 'padding-left: '|cat: $padding +]
											[+if $item['level'] == 1+]
												[+$i= $i + 1+]
													[+if $page * $record_per_page - $record_per_page + 1 <= $i && $i <= $page * $record_per_page+]
														<tr>
															<td>[+$i+]</td>
															<td>[+$item['committee_name']+]</td>
															<td>[+Date::forge($item['created_at'])->format("%Y/%m/%d")+]</td>
															<td>
																<a class="btn btn-sm btn-primary" href="manager/committee/exportCSVcommitte/[+$item['id']+]">
																	<span>CSV出力</span>
																</a>
																<a class="btn btn-sm btn-primary" href="manager/committee/menuCommittee/[+$item['id']+]">
																	<span>委員会管理</span>
																</a>
															</td>
														</tr>
													[+/if+]
											[+/if+]
											[+if $item['level'] != 1+]
												[+if $page * $record_per_page - $record_per_page + 1 <= $i && $i <= $page * $record_per_page+]
													<tr>
														<td></td>
														<td style="[+$padding+]">[+$item['id']+] [+$item['committee_name']+]</td>
														<td>[+Date::forge($item['created_at'])->format("%Y/%m/%d")+]</td>
														<td>
															<a class="btn btn-sm btn-primary" href="manager/committee/exportCSVcommitte/[+$item['id']+]">
																<span>CSV出力</span>
															</a>
															<a class="btn btn-sm btn-primary" href="manager/committee/menuCommittee/[+$item['id']+]">
																<span>委員会管理</span>
															</a>
														</td>
													</tr>
												[+/if+]
											[+/if+]
									[+/foreach+]
								</tbody>
							</table>
						</div>
					<div class="col-md-offset-5">
						<ul class="pagination">
							[+$total_pages = ceil($total_records/$record_per_page)+]
							[+for $i=1 to $total_pages+]
								[+if $total_pages == 1+]
									<li>
									</li>
								[+/if+]
								[+if $total_pages > 1+]
									<li>
										<a class="pagination_link" style="cursor:pointer" href='manager/committee/searchCommittee?page=[+$i+]' >[+$i+]</a>
									</li>
								[+/if+]

							[+/for+]
						</ul>
					</div>
					</div> 
					[+/if +]

					</div> 
                </div>
			</div>
		</div>
	</div>
</section>
[+Asset::js(array('membermanage/searchcommittes.js'))+]

<!--  <script>  
 $(document).ready(function(){  
      function load_data(page)  
      {  
	       $.ajax({  
	            url:"manager/committee/searchcommittes",  
	            method:"GET",  
	            data:{page:page},  
	            success:function(data){  
	                 $('#pagination_data').html(data);  
	            }  
	       })
      }
      $(document).on('click', '.pagination_link', function(){  
           var page = $(this).attr("id");
           load_data(page);
      });
 });  
 </script> -->