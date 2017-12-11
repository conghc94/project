$(document).ready(function () {
    $('#subViewCurator').on('click', function () {
        $('#viewCurator').attr('action', "manager/curators/view");
        $("#subViewCurator").attr('type', 'submit');
        $('#subViewCurator').on('click', function () {
            $('#viewCurator').submit();
        });
    });
});