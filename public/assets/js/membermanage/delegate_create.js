$('#tel').mask('00-0000-0000');
$('#fax').mask('00-0000-0000');
$('#zip').mask('000-0000');

$(document).ready(function () {
	$('#submitCreateDelegate').on('click', function () {
        $('#createDelegate').attr('action', "manager/delegates/create");
        $("#createDelegate").attr('type', 'submit');
        $('#submitCreateDelegate').on('click', function () {
            $('#createDelegate').submit();
        });

    });
});
	