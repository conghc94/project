[+*assign var=formset value=['action'=>'user/photolist/index','name'=>'searchform','method'=>'get']*+]
[+*Form::open($formset)*+]
[+*Form::close()*+]

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">登録一覧リスト</h3>
            </div>
            <div class="panel-body">
                [+$pagination+]

                <table class="table">
                    <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th>撮影日</th>
                        <th>撮影場所</th>
                        <th>タイトル</th>
                        <th>&nbsp;</th>
                    </tr>
                    </thead>
                    [+foreach $photodata as $onecase+]
                    <tr>
                        <td>[+$onecase['id']+]</td>
                        <td>[+$onecase['shotdate']+]</td>
                        <td>[+$onecase['shotplace']+]</td>
                        <td>[+$onecase['title']+]</td>
                        <td>
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary" onclick="goedit([+$onecase['id']+])">詳細情報</button>
                                <button type="button" class="btn btn-success" onclick="gopanorama([+$onecase['id']+])">パノラマ表示</button>
                            </div>
                        </td>
                    </tr>
                    [+/foreach+]
                </table>

                [+$pagination+]

            </div>
        </div>
    </div>
</div>


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


