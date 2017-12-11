<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <title>[+$title+]</title>
    <base href="[+Uri::base()+]" />
    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- site css -->
    [+Asset::css(array('site.min.css','family.css'))+]
    <!-- <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'> -->
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    [+Asset::js(array('site.min.js'))+]
</head>


<body>

<div class="docs-header">
    <!--nav-->
    <nav class="navbar navbar-default navbar-custom" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="user/dashboard/index"><img src="assets/img/logo.png" height="40"></a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a class="nav-link[+if $controller == 'photolist' +] current[+/if+]" href="user/photolist/index">XXXX</a></li>
                    <li><a class="nav-link[+if $controller == 'photomap' +] current[+/if+]" href="user/photomap/index">XXXX</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <!--header-->
</div>


<!--全体-->
<div class="container documents">
    [+$content+]
</div>
<!--全体END-->


<!--フッター-->
<!--footer-->
<div class="site-footer">
    <div class="container">
        <div class="copyright clearfix">
            <p><b>XXXXXXX</b>&nbsp;&nbsp;&nbsp;&nbsp;&copy; 2016 XXXXXXXXx. All rights reserved.</p>
        </div>
    </div>
</div>    <!--フッターEND-->
</body>
</html>