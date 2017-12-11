

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


		// 履歴にスタックしたかどうかのflag
		if(document.referrer == document.getElementById('backurl').value)
		{
			var isHistoryPush = true;
			(function() {
			    if (history && history.pushState && history.state !== undefined) {
			        // history イベントの監視
			        history.pushState(null, null, document.URL);
			        window.addEventListener('popstate', function (e) {
			            if (isHistoryPush) {
			                alert('ブラウザでの戻るボタンは禁止されております。');
			                history.pushState(null, null, document.URL);
			            }
			        }, false);
			    }
			})();
		}
});
