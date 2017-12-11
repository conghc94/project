<!--Màn hình quan ly nam (M021 - 01)-->
[+Asset::css(array('site/common.css'))+]
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
                    <div class="col-md-4 col-md-offset-3">
                        <button onclick="resetAttendance()" type="button" name="reset_attendance_of_meeting" id="reset_attendance_of_meeting" class="btn btn-md btn-primary btn-lg reset-btn">総会の出席のリセット</button>

                        <button onclick="resetProxy()" type="button" name="reset_proxy_of_meeting" id="reset_proxy_of_meeting" class="btn btn-md btn-primary btn-lg reset-btn-5">総会の委任状のリセット</button>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4 col-md-offset-5">
                            <a href="manager/dashboard/index" class="btn btn-md btn-primary btn-lg back-btn-at-reset-form">戻る</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /.content -->

<script>
function resetAttendance() {
    if (confirm(" 総会の出席 のリセットを行いました。?") == true)  {
        window.location = 'manager/members/resetAttendanceOfMeeting';
    }
}

function resetProxy() {
    if (confirm(" 総会の委任状のリセットを行いました。?") == true)  {
        window.location = 'manager/members/resetProxyOfMeeting';
    }
}



</script>

