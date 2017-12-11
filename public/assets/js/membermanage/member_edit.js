$(document).ready(function () {
    //Button Delegate
    $('#delegate_setting').on('click', function (){
        document.getElementById("check_delegate").value = 1;
        document.getElementById("checkbutton").value = 'delegate_setting';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#delegate_setting").attr('type','submit');
        $('#delegate_setting').on('click', function (){
             $('#editMember').submit();
        });
        
    });
    
    $('#edit_delegate').on('click', function (){
        document.getElementById("checkbutton").value = 'edit_delegate';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#edit_delegate").attr('type','submit');
        $('#edit_delegate').on('click', function (){
             $('#editMember').submit();
        });
    });

    $('#delete_delegate').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true)
        {
            document.getElementById("checkbutton").value = 'delete_delegate';
            $('#editMember').attr('action', 'manager/delegates/delete');
            $("#delete_delegate").attr('type','submit');
            $('#delete_delegate').on('click', function (){
                 $('#editMember').submit();
            });
        }
    });
    
    //Click Button Main Curator
    $('#main_curator').on('click', function (){
        document.getElementById("check_main_curator").value = 11;
        document.getElementById("checkbutton").value = 'curator';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#main_curator").attr('type','submit');
        $('#main_curator').on('click', function (){
             $('#editMember').submit();
        });
    });

    $('#edit_main_curator').on('click', function (){
        document.getElementById("check_main_curator").value = 11;
        document.getElementById("checkbutton").value = 'edit_curator';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#edit_main_curator").attr('type','submit');
        $('#edit_main_curator').on('click', function (){
             $('#editMember').submit();
        });
    });

    $('#delete_main_curator').on('click', function (){
        if(confirm("このデータを削除します。よろしいですか？") == true)
        {
            document.getElementById("checkbutton").value = 'delete_main_curator';
            $("#delete_main_curator").attr('type','submit');
            $('#editMember').submit();
        }
    });
    
    //Click Button Sub Curator
    $('#sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        document.getElementById("checkbutton").value = 'curator';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#sub_curator").attr('type','submit');
        $('#sub_curator').on('click', function (){
            $('#editMember').submit();
        });
    });

    $('#edit_new_sub_curator').on('click', function (){
        document.getElementById("checkbutton").value = 'edit_curator';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#edit_delegate").attr('type','submit');
        $('#edit_delegate').on('click', function (){
             $('#editMember').submit();
        });
    });
    
    $('#delete_new_sub_curator').on('click', function (){
        document.getElementById("checkbutton").value = 'delete_sub_curator';
        $('#editMember').attr('action', 'manager/curators/delete');
        $("#delete_sub_curator").attr('type','submit');
        $('#delete_sub_curator').on('click', function (){
             $('#editMember').submit();
        });
    });

    //Click Button Sub Curator
    $('#new_sub_curator').on('click', function (){
        document.getElementById("check_new_sub_curator").value = 12;
        document.getElementById("checkbutton").value = 'curator';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#new_sub_curator").attr('type','submit');
        $('#new_sub_curator').on('click', function (){
            $('#editMember').submit();
        });
    });

    //Click button Submit Confirm Create member
    $('#submit_edit').on('click', function (){
        document.getElementById("checkbutton").value = 'confirmEdit';
        $('#editMember').attr('action', 'manager/members/edit');
        $("#submit_edit").attr('type','submit');
        $('#submit_edit').on('click', function (){
             $('#editMember').submit();
        });
    });

    //Click Delete Member
    $('#delete_member').on('click', function (){
        if(confirm("このデータを削除します。よろしいですか？") == true)
        {
            $('#editMember').attr('action', 'manager/members/delete');
            $("#delete_member").attr('type','submit');
            $('#editMember').submit();
        }
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
