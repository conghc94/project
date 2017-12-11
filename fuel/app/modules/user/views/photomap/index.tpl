
<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">登録地図</h3>
            </div>
            <div class="panel-body">
                <!-- 地図の埋め込み表示 -->
                <div id="map-canvas"></div>
            </div>
        </div>
    </div>
</div>
<style>
    #map-canvas {
        width: 100%;
        height: 400px;
        margin: 0px;
        padding: 0px
    }

</style>
<script>
    /* 緯度・経度：静岡市役所 */
    var homelat = 34.975460;
    var homelng = 138.382615;

    // 現在位置の取得
    navigator.geolocation.getCurrentPosition(geoSuccess, geoError);

    // 取得成功
    function geoSuccess(position) {
        // 緯度
        homelat = position.coords.latitude;
        // 軽度
        homelng = position.coords.longitude;
        // 緯度経度の誤差(m)
        accuracy = Math.floor(position.coords.accuracy);
    }

    // 取得失敗(拒否)
    function geoError() {
        console.log("Geolocation Error")
    }

</script>
<script src="//maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&key=AIzaSyCDmaatypIG3kNXIIOf7gC2V6In8J23hf4"></script>
<script type="text/javascript">
    /* ページ読み込み時に地図を初期化 */
    $(function(){
        initialize();
    });


    /* Mapオブジェクト */
    var map;
    var myLatlng  = new google.maps.LatLng(homelat, homelng);

    //マーカーオブジェクト
    var marker_list = new google.maps.MVCArray();

    /* 地図の初期化 */
    function initialize() {
        var mapDiv = document.getElementById('map-canvas');
        var myOptions = {
            /* ズームレベル */
            zoom: 13,
            /* 中心地点 */
            center: myLatlng,
            /* 地図タイプ */
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        /* 地図インスタンス生成 */
        map=new google.maps.Map(mapDiv, myOptions);
        /* 地図上にマウスが乗った時 */
//        google.maps.event.addListener(map, 'dragstart', function() {
//            $("#res").prepend("地図のドラッグが開始されました\n");
//        });
//        /* 地図上からマウスが外れた時 */
//        google.maps.event.addListener(map, 'drag', function() {
//            $("#res").prepend("地図がドラッグされています\n");
//        });
        /* 地図上でマウスが移動された時 */
        google.maps.event.addListener(map, 'dragend', function() {
            latlng = map.getCenter();
            homelat = latlng.lat();
            homelng = latlng.lng();
            readJsonMarker();

//            $("#res").prepend("地図のドラッグが終了しました\n");
//            $("#res").prepend("地図がクリックされました\n\n緯度:"+latlng.lat()+"/経度:"+latlng.lng()+"\n文字列:"+latlng.toString()+"\n小数点以下3位に丸める:"+latlng.toUrlValue(3)+"\n");

        });


        /* マーカー生成 */
        readJsonMarker();

    }


    function readJsonMarker(){
        checkurl = '/user/photolist/rest.json';
        console.log('latlng='+homelat+','+homelng);
        //JSONファイル読み込み開始
        $.ajax({
            url:checkurl,
            cache:false,
            data: 'latlng='+homelat+','+homelng,
            dataType:"json",
            success:function(json){
                var data=jsonRequest(json);
                buildmarker(data);
            },
            error : function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest); // XMLHttpRequestオブジェクト
                console.log(XMLHttpRequest.responseText); // XMLHttpRequestオブジェクト
                console.log(textStatus); // status は、リクエスト結果を表す文字列
                console.log(errorThrown); // errorThrown は、例外オブジェクト
            }
        });
    }

    // JSONファイル読み込み完了
    function jsonRequest(json){
        var data=[];
        if(json.Marker){
            var n=json.Marker.length;
            for(var i=0;i<n;i++){
                data.push(json.Marker[i]);
            }
        }
        return data;
    }

    // Attach Message
    function attach_message( map, marker, msg, infoindow ){
        google.maps.event.addListener(marker, 'click', function( event ){
            infoindow.setContent( msg );
            infoindow.open(map, marker);
        });
    }

    function buildmarker(data){

        var infoindow  = new google.maps.InfoWindow();
        if (data != null) {
            var i=data.length;
        }

        //マーカー全削除
        marker_list.forEach(function(mkr, idx){
            mkr.setMap(null);
        });

        while(i-- >0){
            var datum=data[i];
            var latlngbase = datum.latitude_longitude;
            var latlng = latlngbase.split(',');
            //console.log(latlng);

            var obj={
                position:new google.maps.LatLng(latlng[0],latlng[1]),
                map: map,
                title:datum.title
            };

            var marker=new google.maps.Marker(obj);
            marker_list.push(marker);

            message = datum.title + '<br>';
            message += datum.shotplace + '<br>';
            message += datum.shotdate + '<br>';
            message += '<div class="btn-group">';
            message += '<button type="button" class="btn btn-primary" onclick="goedit('+datum.id+')">詳細情報</button>';
            message += '<button type="button" class="btn btn-success" onclick="gopanorama('+datum.id+')">パノラマ表示</button>';
            message += '</div>';
            attach_message(map, marker, message,infoindow);

            //マップクリックイベントを追加
            google.maps.event.addListener(map, 'click', function(e) {
                //インフォウィンドウを消去
                infoindow.close();
            });

        }
    }
</script>

[+assign var=formset2 value=['action'=>'user/photolist/index','name'=>'editform','method'=>'post']+]
[+Form::open($formset2)+]
<input type="hidden" id="key" name="[+\Config::get('security.csrf_token_key')+]" value="[+\Security::fetch_token()+]"/>
<input type="hidden" id="id" name="id" value=""/>
[+Form::close()+]

[+assign var=formset3 value=['action'=>'user/panorama/index','name'=>'panoramaform','method'=>'post','traget'=>'_blank']+]
[+Form::open($formset3)+]
<input type="hidden" id="id" name="id" value=""/>
[+Form::close()+]

<script>
    function goedit(id){
        document.editform.action = 'user/photoedit/index';
        document.editform.id.value = id;
        document.editform.submit();
    }

    function gopanorama(id){
        document.panoramaform.target = '_blank';
        document.panoramaform.action = 'user/panorama/index';
        document.panoramaform.id.value = id;
        document.panoramaform.submit();
    }

</script>

