$(document).ready(function () {
    $('#submitViewDelegate').on('click', function () {
    	
        $('#viewCurator').attr('action', "manager/delegates/view");
        $("#submitViewDelegate").attr('type', 'submit');
        $('#submitViewDelegate').on('click', function () {
            $('#viewCurator').submit();
        });

    });
});
