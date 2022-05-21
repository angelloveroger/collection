<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title><?=$title?></title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/md5.js"></script>
    <script src="/packs/admin/js/common.js"></script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo"><a>后台管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="layui-icon">&#xe668;</i></a>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item"><a onclick="Admin.delcache('<?=links('ajax/delcaches')?>');" title="刷新缓存"><i class="layui-icon" style="font-size:16px;">&#xe669;</i></a></li>
        <li class="layui-nav-item">
            <a href="javascript:;"><?=$admin['name']?>，欢迎回来</a>
            <dl class="layui-nav-child">
                <dd><a href="<?=links('login/ext')?>">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index"><a href="/" target="_blank">前台首页</a></li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="layui-side left-nav">
    <div class="layui-side-scroll" id="side-nav">
        <ul id="nav">
        <?php 
        foreach($nav as $k=>$v){
            $arr = explode(',',$v['file']);
            $qx = 0;
            foreach($arr as $v2){
                if(strpos($admin['qx'],$v2) !== false){
                    $qx = 1;
                    break;
                }
            }
            if(empty($admin['qx']) || $qx == 1){
        ?>
            <li>
                <a href="javascript:;" class="left-nav-li" lay-tips="<?=$v['name']?>">
                    <i class="layui-icon nav-tps"><?=$v['icon']?></i>
                    <cite><?=$v['name']?></cite>
                    <i class="layui-icon nav_right">&#xe603;</i>
                </a>
                <ul class="sub-menu">
                    <?php 
                    foreach($v['list'] as $kk=>$vv){ 
                        if((empty($admin['qx']) || strpos($admin['qx'],$vv['url']) !== false) and $vv['init'] == 1){
                    ?>
                    <li>
                        <a onclick="Admin.add_tab('<?=$vv['name']?>','<?=links($vv['url'])?>')">
                            <i class="layui-icon">&#xe602;</i>
                            <cite><?=$vv['name']?></cite>
                        </a>
                    </li>
                    <?php } } ?>
                </ul>
            </li>
        <?php } } ?>
        </ul>
    </div>
</div>
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="iframe" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>后台首页</li>
        </ul>
        <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
            <dl>
                <dd data-type="this">关闭当前</dd>
                <dd data-type="other">关闭其它</dd>
                <dd data-type="all">关闭全部</dd>
            </dl>
        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show" style="padding-bottom:44px;">
                <iframe src='<?=links('home/main')?>' frameborder="0" scrolling="yes" class="iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="layui-footer layui-text">
    <?=base64decode('Y29weXJpZ2h0IMKpIDIwMjEgPGEgaHJlZj0iaHR0cDovL3d3dy55aGNtcy5jYy8iIHRhcmdldD0iX2JsYW5rIj5ZSENNU-inhumikeezu-e7nzwvYT4gYWxsIHJpZ2h0cyByZXNlcnZlZC4')?>
    <span class="pull-right">Version <?=VER?></span>
</div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
</html>