<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">写真情報確認</h3>
            </div>
            <div class="panel-body">


                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="published">表示ステータス</label>
                    [+$publish_status[$photodata['published']]+]
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="shotdate">撮影日</label>
                    <input type="text" class="form-control" placeholder="撮影日時" id="shotdate" name="shotdate" size="35" value="[+if isset($photodata['shotdate'])+][+$photodata['shotdate']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="type">種別</label>
                    <input type="text" class="form-control" placeholder="種別" id="type" name="type" value="[+if isset($photodata['type'])+][+$photodata['type']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="title">タイトル</label>
                    <input type="text" class="form-control" placeholder="タイトル" id="title" name="title" value="[+if isset($photodata['title'])+][+$photodata['title']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="latitude_longitude">緯度経度</label>
                    <input type="text" class="form-control" placeholder="緯度経度" id="latitude_longitude" name="latitude_longitude" value="[+if isset($photodata['latitude_longitude'])+][+$photodata['latitude_longitude']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="shotplace">撮影場所</label>
                    <input type="text" class="form-control" placeholder="撮影場所" id="shotplace" name="shotplace" value="[+if isset($photodata['shotplace'])+][+$photodata['shotplace']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="shotplace">パノラマ写真</label>
                    <div class="btn-group">
                        <button type="button" class="btn btn-success" onclick="gopanorama([+$photodata['id']+])">パノラマ表示</button>
                    </div>
                </div>
                    <input name="photofile" id="photofile" type="file" style="display:none">
                    <input name="image" type="hidden" id="image" value="[+if isset($photodata['image'])+][+$photodata['image']+][+/if+]">
                    <div id="setphotoimage">[+if isset($photodata['image']) && $photodata['image'] != ''+]<img src="/uploads/[+$photodata['image']+]" class="img-responsive">[+/if+]</div>
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="keywords">キーワード</label>
                    <input type="text" class="form-control" placeholder="キーワード" id="keywords" name="keywords" value="[+if isset($photodata['keywords'])+][+$photodata['keywords']+][+/if+]">
                </div>
                <div class="form-group has-primary has-feedback">
                    <label class="control-label" for="note">備考</label>
                    <textarea class="form-control" rows="3" id="note" name="note">[+if isset($photodata['note'])+][+$photodata['note']+][+/if+]</textarea>
                </div>
            </div>
        </div>
    </div>
</div>


[+assign var=formset3 value=['action'=>'user/panorama/index','name'=>'panoramaform','method'=>'post','traget'=>'_blank']+]
[+Form::open($formset3)+]
<input type="hidden" id="id" name="id" value=""/>
[+Form::close()+]

<script>

    function gopanorama(id){
        document.panoramaform.target = '_blank';
        document.panoramaform.action = 'user/panorama/index';
        document.panoramaform.id.value = id;
        document.panoramaform.submit();
    }

</script>









