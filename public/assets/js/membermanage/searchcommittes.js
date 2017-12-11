
	$(document).ready(function(){
		$('#committe_select').change(function() 
		{
			var $id = $(this).val();
			$('#submitSearchCommittee').attr('action', 'manager/committee/menuCommittee/'+ $id);

			$("#submitSearchCommittee").submit();
		});
	});


