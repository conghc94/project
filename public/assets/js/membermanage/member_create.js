$(document).ready(function () {
    //Button Delegate
    $('#delegate_setting').on('click', function (){
        document.getElementById("check_delegate").value = 1;
        document.getElementById("checkbutton").value = 'delegate_setting';
        $('#createMember').attr('action', 'manager/members/create');
       
        $("#delegate_setting").attr('type','submit');
        
            $('#createMember').submit();

    });

     $('#edit_delegate').on('click', function (){
        document.getElementById("checkbutton").value = 'edit_delegate';
        $('#createMember').attr('action', 'manager/members/create');
        $("#edit_delegate").attr('type','submit');
        $('#createMember').submit();
    });

    $('#delete_delegate').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true)
        {
            document.getElementById("checkbutton").value = 'delete_delegate';
            $('#createMember').attr('action', 'manager/delegates/delete');
            $("#delete_delegate").attr('type','submit');
            $('#createMember').submit();
        }
    });

    //Click Button Main Curator
    $('#main_curator').on('click', function (){
        document.getElementById("check_main_curator").value = 11;
        document.getElementById("checkbutton").value = 'curator';
        $('#createMember').attr('action', 'manager/members/create');
        $("#main_curator").attr('type','submit');
        $('#createMember').submit();
    });

    $('#delete_main_curator').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true)
            {
                document.getElementById("checkbutton").value = 'delete_main_curator';
                $('#createMember').attr('action', 'manager/curators/delete');
                $("#delete_main_curator").attr('type','submit');
                $('#createMember').submit();
            }
    });
    
    //Click Button Sub Curator
    $('#sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        document.getElementById("checkbutton").value = 'curator';
        $('#createMember').attr('action', 'manager/members/create');
        $("#sub_curator").attr('type','submit');
        $('#createMember').submit();
    });

    $('#edit_new_sub_curator').on('click', function (){
        document.getElementById("checkbutton").value = 'edit_curator';
        $('#createMember').attr('action', 'manager/members/create');
        $("#edit_delegate").attr('type','submit');
        $('#createMember').submit();

    });

    //Click Button Sub Curator
    $('#new_sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        document.getElementById("checkbutton").value = 'curator';
        $('#createMember').attr('action', 'manager/members/create');
        $("#new_sub_curator").attr('type','submit');
        $('#createMember').submit();

    });

    //Click button Submit Confirm Create member
    $('#submit_create').on('click', function (){
        document.getElementById("checkbutton").value = 'createmember';
        $('#createMember').attr('action', 'manager/members/create');
        $("#submit_create").attr('type','submit');
        $('#createMember').submit();

    });

    $('.deleteClick').click(function(){
        if(confirm("このデータを削除します。よろしいですか？") == true)
        {
            var result;
            var id = $(this).data('id');
            window.location.href = "manager/curators/delsubcuratorsession/"+id;
        }
    });
});
