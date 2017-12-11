<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>[+$title+]</title>
    <base href="[+Uri::base()+]" />
    <!-- Sets initial viewport load and disables zooming  -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- site css -->
    [+Asset::css(array('site.min.css','family.css'))+]
    [+Asset::css(array('dist/css/AdminLTE.min.css','dist/css/skins/skin-blue.min.css','dist/css/page/page.css'))+]
    [+Asset::css(array('bootstrap/css/bootstrap.min.css'))+]

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'> -->
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    [+Asset::css(array('site/common.css','site/member.css','site/representative.css'))+]
    [+Asset::js(array('site.min.js','js.cookie.js','jquery.mask.min.js'))+]
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="manager/dashboard/index" class="logo">
        <span  class="logo-lg">メンバー管理システム
        </span> -->
    </a>
    <nav style="" class="navbar navbar-static-top">

        <a class="sidebar-toggle">[+$header+]
        </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li class="user user-menu">
            <a href="[+Uri::base()+]manager/index/logout">
              <span>
                <i class="fa fa-sign-out"></i>
                ログアウト
              </span>
            </a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
            
<!--全体-->
<div class="content-wrapper padding-top20 font-size-12">
    [+$content+]
</div>
<!--全体END-->   

<!--フッター-->
<!--footer-->
<!-- jQuery 2.2.3 -->
[+Asset::css(array('plugins/jQuery/jquery-2.2.3.min.js'))+]
[+Asset::js(array('site.min.js'))+]
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Bootstrap 3.3.6 -->
[+Asset::css(array('bootstrap/js/bootstrap.min.js'))+]
<!-- Slimscroll -->
[+Asset::css(array('plugins/slimScroll/jquery.slimscroll.min.js'))+]
<!-- FastClick -->
[+Asset::css(array('plugins/fastclick/fastclick.js'))+]
<!-- AdminLTE App -->
[+Asset::css(array('dist/js/app.min.js'))+]
</body>
</html>

