<section class="content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 ">
            <div class="panel panel-primary">
                <div class="panel-heading"> 
                    [+$list_committee_name[0]['committee_name']+]
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">委員会編集</h3>
                </div>
                <div class="panel-body">
                    <div class="list-group">
                        <a href="manager/committee/editCommittee/[+$list_committee_name[0]['id']+]" class="list-group-item">委員会編集</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">所属メンバ</h3>
                </div>
                <div class="panel-body">
                    <div class="list-group">
                        <a href="manager/Memberofcommittees/addmember/[+$list_committee_name[0]['id']+]" class="list-group-item">所属メンバー新規登録</a>
                        <a href="manager/Memberofcommittees/index" class="list-group-item">所属メンバー検索</a>
                        <ul style = "margin-top: 5px;">
                            <li>所属メンバー情報変更</li>
                            <li>リスト表示</li>
                            <li>CSV出力</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">システム管理</h3>
                </div>
                <div class="panel-body">
                    <div class="list-group">
                        <a href="manager/committees/reset/[+$list_committee_name[0]['id']+]" class="list-group-item">年度管理</a>
                        <ul style = "margin-top: 5px;">
                            <li>年会費のリセット</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>