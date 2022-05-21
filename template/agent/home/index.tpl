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
    <link rel="stylesheet" href="/packs/admin/css/agent.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/md5.js"></script>
    <script src="/packs/admin/js/common.js"></script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo"><a>代理后台管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="layui-icon">&#xe668;</i></a>
    </div>
    <ul class="layui-nav right">
        <li class="layui-nav-item">
            <a href="javascript:;"><?=$agent['name']?>，欢迎回来</a>
            <dl class="layui-nav-child">
                <dd><a href="<?=links('agent/login/ext')?>">退出</a></dd>
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
            <li>
                <a href="<?=links('agent/home/main')?>" target="agent" class="left-nav-li active" lay-tips="后台首页">
                    <i class="layui-icon nav-tps">&#xe68e;</i>
                    <cite>后台首页</cite>
                </a>
            </li>
            <li>
                <a href="<?=links('agent/user')?>" target="agent" class="left-nav-li" lay-tips="用户列表">
                    <i class="layui-icon nav-tps">&#xe770;</i>
                    <cite>用户列表</cite>
                </a>
            </li>
            <li>
                <a href="<?=links('agent/card')?>" target="agent" class="left-nav-li" lay-tips="卡密列表">
                    <i class="layui-icon nav-tps">&#xe735;</i>
                    <cite>卡密列表</cite>
                </a>
            </li>
            <li>
                <a href="<?=links('agent/pay')?>" target="agent" class="left-nav-li" lay-tips="充值记录">
                    <i class="layui-icon nav-tps">&#xe65e;</i>
                    <cite>充值记录</cite>
                </a>
            </li>
            <li>
                <a href="<?=links('agent/withdrawal')?>" target="agent" class="left-nav-li" lay-tips="结算记录">
                    <i class="layui-icon nav-tps">&#xe609;</i>
                    <cite>结算记录</cite>
                </a>
            </li>
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
            <div class="layui-tab-item layui-show">
                <iframe id="agent" name="agent" src='<?=links('agent/home/main')?>' frameborder="0" scrolling="yes" class="iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
</html>