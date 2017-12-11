$('#tel').mask('00-0000-0000');
$('#fax').mask('00-0000-0000');
$('#zip').mask('000-0000');
$(document).ready(function () {
	$('#delete').on('click', function () {
		if (confirm("このデータを削除します。よろしいですか？") == true)
		{
			document.getElementById("checkbutton").value = 'delete_delegate';
			$('#editDelegate').attr('action', "manager/delegates/edit");
			$("#delete").attr('type', 'submit');
			$('#delete').on('click', function () {
				$('#editDelegate').submit();
			});
		}
	});
	$('#edit').on('click', function () {
		document.getElementById("checkbutton").value = 'edit_delegate';
		$('#editDelegate').attr('action', "manager/delegates/edit");
		$("#edit").attr('type', 'submit');
		$('#edit').on('click', function () {
			$('#editDelegate').submit();
		});
	});
});
