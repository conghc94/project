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

		// 履歴にスタックしたかどうかのflag

		if(document.referrer == document.getElementById('backurl').value)
		{
			// alert(document.referrer);
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