$(document).ready(function () {
    //Click button setting member
    $('#setting_member').on('click', function (){
        document.getElementById("checkbutton").value = 'setting_member';
        $("#editMember").attr('type','submit');
        $('#editMember').submit();
    });
    //Click button delete member
    $('#delete_member').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            document.getElementById("checkbutton").value = 'delete_member';
            $("#editMember").attr('type','submit');
            $('#editMember').submit();
        }
    });

    //Click button setting committee
    $('#setting_committee').on('click', function (){
        document.getElementById("checkbutton").value = 'setting_committee';
        $("#editMember").attr('type','submit');
        $('#editMember').submit();
    });
    //Click button delete committee
    $('#delete_committee').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            document.getElementById("checkbutton").value = 'delete_committee';
            $("#editMember").attr('type','submit');
            $('#editMember').submit();
        }
    });

    //Click submit confirm edit member of committee
    $('#submit_editmember').on('click', function (){
        document.getElementById("checkbutton").value = 'submit_editmember';
        $("#editMember").attr('type','submit');
        $('#editMember').submit();
    });

    $('#submit_deletemember').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            document.getElementById("checkbutton").value = 'submit_deletemember';
            $("#editMember").attr('type','submit');
            $('#editMember').submit();
        }
    });

    if(document.referrer == document.getElementById('backurl').value)
    {
        var isHistoryPush = true;
        (function() {
            if (history && history.pushState && history.state !== undefined) {
                // history イベントの監視
                history.pushState(null, null, document.URL);
                window.addEventListener('popstate', function (e) {
                    if (isHistoryPush) {
                        alert('ブラウザでの戻るボタンは禁止されております。');
                        history.pushState(null, null, document.URL);
                    }
                }, false);
            }
        })();
    }
});
