
	$(document).ready(function(){
		$('#btnSearch').click(function() 
		{
			var radio = $('input[name="outputSearch"]:checked').val()
			var action = null;
			if (radio == 1){
				action = "manager/baseofmember/searchmember";
			}
			else if(radio == 2){
				action = "manager/baseofmember/searchlist"
			}
			else{
				action = "manager/baseofmember/exportcsv";
			}
			$('#submitSearch').attr('action', action);
		});
	});

