<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>定时任务地址</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <div class="layui-form" style="padding-top: 20px;">
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="layui-form-mid layui-word-aux">WIN地址：将下面地址复制后在服务器浏览器打开挂机即可</div>
                <textarea placeholder="WIN挂机地址" onfocus="this.select();" name="win" class="layui-textarea" style="min-height: 40px;"><?=$winurl?></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="layui-form-mid layui-word-aux">LIUNX地址：将下面地址复制后添加到计划任务即可</div>
                <textarea placeholder="LIUNX地址" onfocus="this.select();" name="os" class="layui-textarea" style="min-height: 40px;"><?=$osurl?></textarea>
            </div>
        </div>
    </div>
</div>
</body>
</html>