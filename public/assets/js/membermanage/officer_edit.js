// onclick event is assigned to the #button element.
    $(document).ready(function () {
        $('#setupMember').on('click', function (){
            $('#editOfficer').attr('action', 'manager/members/setting');
            $("#setupMember").attr('type','submit');
            $('#setupMember').on('click', function (){
                 $('#editOfficer').submit();
            });
            
        });

    });

    $('#MainCuratorSetting').on('click', function (){
        document.getElementById("check_main_curator").value = 11;
        $('#editOfficer').attr('action', windows.location.href);
        $("#MainCuratorSetting").attr('type','submit');
        $('#MainCuratorSetting').on('click', function (){
            $('#editOfficer').submit();
        });
    });

    $(document).ready(function () {
    $('#delMember').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            $('#editOfficer').attr('action', 'manager/members/deletesession');
            $("#delMember").attr('type','submit');
            $('#delMember').on('click', function (){
                 $('#editOfficer').submit();
            });
        }
    });
});

    $(document).ready(function () {
    $('#delOfficer').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            $('#editOfficer').attr('action', 'manager/officers/delete');
            $("#delOfficer").attr('type','submit');
            $('#delOfficer').on('click', function (){
                 $('#editOfficer').submit();
            });
        }
    });

});

    $(document).ready(function () {
        $('#officer').on('click', function (){
            $('#editOfficer').attr('action', 'manager/officers/setting');
            $("#officer").attr('type','submit');
            $('#officer').on('click', function (){
                 $('#editOfficer').submit();
            });
            
        });

    });

    $(document).ready(function () {
        $('#delete_main_curator').on('click', function (){
            if (confirm("このデータを削除します。よろしいですか？") == true) 
            {
                $('#editOfficer').attr('action', 'manager/curators/delete');
                $("#delete_main_curator").attr('type','submit');
                $('#delete_main_curator').on('click', function (){
                     $('#editOfficer').submit();
                });
            }
        });

    });

    $(document).ready(function () {
        $('#delete_sub_curator').on('click', function (){
            if (confirm("このデータを削除します。よろしいですか？") == true) 
            {
                $('#editOfficer').attr('action', 'manager/curators/delete');
                $("#delete_sub_curator").attr('type','submit');
                $('#delete_sub_curator').on('click', function (){
                     $('#editOfficer').submit();
                });
            }
        });

    });

    $(document).ready(function () {
        $('#deleteOfficer').on('click', function (){
            if (confirm("このデータを削除します。よろしいですか？") == true) 
            {
                $('#editOfficer').attr('action', 'manager/officers/edit');
                $("#deleteOfficer").attr('type','submit');
                $('#deleteOfficer').on('click', function (){
                     $('#editOfficer').submit();
                });
            }
            else
            {
                return false;
            }
        });

    });

    $('#new_sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        $('#editOfficer').attr('action', 'manager/officers/edit');
        $("#new_sub_curator").attr('type','submit');
            $('#new_sub_curator').on('click', function (){
            $('#editOfficer').submit();
        });
    });

    $('#sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        $('#editOfficer').attr('action', 'manager/officers/edit');
        $("#sub_curator").attr('type','submit');
        $('#sub_curator').on('click', function (){
            $('#editOfficer').submit();
        });
    });

    $('.deleteClick').click(function(){
        if(confirm("このデータを削除します。よろしいですか？") == true)
        {
            var result;
            var id = $(this).data('id');
            window.location.href = "manager/curators/delsubcuratorsession/"+id;
        }
    });

$(document).ready(function () {
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