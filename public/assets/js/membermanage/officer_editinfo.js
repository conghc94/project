$('#tel').mask('00-0000-0000');
$('#fax').mask('00-0000-0000');
$('#zip').mask('000-0000');

$(document).ready(function () {
    $('#del').on('click', function (){
        if (confirm("このデータを削除します。よろしいですか？") == true) 
        {
            $('#editPerson').attr('action', windows.location.href);
            $("#del").attr('type','submit');
            $('#del').on('click', function (){
                 $('#editPerson').submit();
            });
        }
        else
        {
            return false;
        }
    });

});