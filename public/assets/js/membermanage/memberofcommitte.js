
	$(document).ready(function(){
		$('#btnSearchMemberofCommitte').click(function() 
		{
			var radio = $('input[name="outputSearch"]:checked').val()
			var action = null;
			if (radio == 1){
				action = "manager/memberofcommittees/searchmemberofcommitte";
			}
			else if(radio == 2){
				action = "manager/memberofcommittees/searchlistmemberofcommitte"
			}
			else{
				action = "manager/memberofcommittees/exportcsvmemberofcommitte";
			}
			$('#submitSearch').attr('action', action);
		});
	});