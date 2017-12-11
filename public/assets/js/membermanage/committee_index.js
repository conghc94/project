	$('.click').click(function() {
		if (confirm('このデータを削除します。よろしいですか？')) {
			var key = $(this).data("id");
			$('.custom_input_name'+key).val('');
			$('.custom_input_selectable'+key).val('');
			$(".custom_input_type_"+key+" option:first").prop("selected", "selected");
	   }
	})
