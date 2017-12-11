
	$(document).ready(function(){
		$('#btnSearchOfficers').click(function() 
		{

			var radio = $('input[name="outputSearchOfficers"]:checked').val()
			var action = null;
			if(radio == 1){
				action = "manager/Officers/searchofficers";
			}
			else if(radio == 2){
				action = "manager/Officers/searchlistofficers"
			}
			else{
				action = "manager/Officers/exportcsvofficers";
			}
			$('#submitSearchOfficers').attr('action', action);
		});
	});
