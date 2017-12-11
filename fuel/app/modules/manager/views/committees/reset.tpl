<!--Màn hình quan ly nam (M022 - 01)-->

<section class="content">
    <div class="row">
        <div class="col-xs-8" style="margin-left: 16.66666667%">
            <div class="box box-primary box-solid">
                <div class="box-header with-border">[+$title+]</div>
                <div class="box-body">
                [+if Session::get_flash('error') +]
                    [+$error = Session::get_flash('error') +]
                    <div class="row">
                        <div class="col-md-8 col-md-offset-3">
                            <div class="alert alert-success alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                [+foreach $error as $one+]<br>[+$one+][+/foreach+]
                            </div>
                        </div>
                    </div>
                [+/if+]
                    <div class="col-md-4 col-md-offset-4">
                        <input type="hidden" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]" />
                        <button onclick="resetRequestOfCost([+$id+])" type="submit" name="reset_request_of_cost" id="reset_request_of_cost" class="btn btn-md btn-primary btn-lg" style=" margin-bottom: 5%;">年会費の請求のリセット</button>

                        <button onclick="resetReceiptOfCost([+$id+])" type="submit" name="reset_receipt_of_cost" id="reset_receipt_of_cost" class="btn btn-md btn-primary btn-lg" style="margin-bottom: 5%;">年会費の入金のリセット</button>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-md-offset-5">
                            <a href="manager/committee/menuCommittee/[+$id+]" style="margin-top: 30%; margin-bottom: 90%;" class="btn btn-md btn-primary btn-lg">戻る</a>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->

<script>
function resetRequestOfCost(id) {
    if (confirm("年会費の請求のリセットを行いました。?") == true)  {
        window.location = 'manager/committees/resetRequestOfCost/'+ id;
    }
}

function resetReceiptOfCost(id) {
    if (confirm("年会費の入金のリセットを行いました。?") == true)  {
        window.location = 'manager/committees/resetReceiptOfCost/' + id;
    }
}
</script>

