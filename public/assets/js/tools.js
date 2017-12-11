function goedit(id){
    document.editform.target = '_self';
    document.editform.action = 'manager/photoedit/index';
    document.editform.id.value = id;
    document.editform.submit();
}

function gopanorama(id){
    document.panoramaform.target = '_blank';
    document.panoramaform.action = 'manager/panorama/index';
    document.panoramaform.id.value = id;
    document.panoramaform.submit();
}

function godelete(id){
    // 「OK」時の処理開始 ＋ 確認ダイアログの表示
    if (window.confirm("削除いたします。\r\nよろしいですか？")) {
        document.editform.action = 'manager/photoedit/delete';
        document.editform.id.value = id;

        document.editform.submit();

    }
}


