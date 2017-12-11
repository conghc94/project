$('#tel').mask('00-0000-0000');
$('#fax').mask('00-0000-0000');
$('#zip').mask('000-0000');
$(document).ready(function () {
	$('#delete').on('click', function () {
		if (confirm("このデータを削除します。よろしいですか？") == true)
		{
			document.getElementById("checkbutton").value = 'delete_curator';
			$('#editCurator').attr('action', "manager/curators/edit");
			$("#delete").attr('type', 'submit');
			$('#delete').on('click', function () {
				$('#editCurator').submit();
			});
		}
	});
	$('#edit').on('click', function () {
		document.getElementById("checkbutton").value = 'edit_curator';
		$('#editCurator').attr('action', "manager/curators/edit");
		$("#edit").attr('type', 'submit');
		$('#edit').on('click', function () {
			$('#editCurator').submit();
		});
	});
});
