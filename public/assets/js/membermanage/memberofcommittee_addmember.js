$(document).ready(function () {
    //Click button setting member
    $('#setting_member').on('click', function (){
        document.getElementById("checkbutton").value = 'setting_member';
        $("#addMember").attr('type','submit');
        $('#addMember').submit();
    });

    $('#edit_member').on('click', function (){
        document.getElementById("checkbutton").value = 'edit_member';
        $('#addMember').submit();
    });

    $('#delete_member').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true)
        {
            document.getElementById("checkbutton").value = 'delete_member';
            $('#addMember').submit();
        }
    });

    //Click button setting member 
    $('#setting_committee').on('click', function (){
        document.getElementById("checkbutton").value = 'setting_committee';
        $("#addMember").attr('type','submit');
        $('#addMember').submit();
    });
    //Click button delete committee
    $('#delete_committee').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true)
        {
            document.getElementById("checkbutton").value = 'delete_committee';
            $("#addMember").attr('type','submit');
            $('#addMember').submit();
        }
    });

    $('#submit_addmember').on('click', function (){
        document.getElementById("checkbutton").value = 'submit_addmember';
        $("#addMember").attr('type','submit');
        $('#addMember').submit();
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
