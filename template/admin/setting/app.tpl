<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网站配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <script src="/packs/admin/js/md5.js"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>系统配置</a>
        <a><cite>APP配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/app_save')?>">
            <div class="layui-card-body">
                <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">APP接口秘钥:</label>
                        <div class="layui-input-block">
                            <input type="text" id="rand" name="appkey" placeholder="APP接口秘钥，请谨慎修改" value="<?=$app['appkey']?>" class="layui-input"/>
                            <?php if(empty($app['appkey'])){ ?>
                            <div class="layui-btn layui-btn-danger" onclick="get_appkey();" style="position: absolute;top: 0px;right: 0;">随机生成</div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">最新版本号:</label>
                        <div class="layui-input-block">
                            <input type="text" name="version" placeholder="最新版本号" value="<?=$app['version']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">热更新地址:</label>
                        <div class="layui-input-block">
                            <input type="text" name="wgturl" placeholder="热更新wgt下载地址" value="<?=$app['wgturl']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">安卓下载地址:</label>
                        <div class="layui-input-block">
                            <input type="text" name="android_downurl" placeholder="安卓APK下载地址" value="<?=$app['android_downurl']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">IOS下载地址:</label>
                        <div class="layui-input-block">
                            <input type="text" name="ios_downurl" placeholder="IOS下载地址" value="<?=$app['ios_downurl']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">强制更新开关:</label>
                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                            <input type="radio" name="force" value="0" title="关闭"<?php if($app['force']==0) echo ' checked';?>>
                            <input type="radio" name="force" value="1" title="开启"<?php if($app['force']==1) echo ' checked';?>>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">APP更新文案:</label>
                        <div class="layui-input-block">
                            <textarea style="min-height:100px;" name="text" placeholder="APP更新文案" class="layui-textarea"><?=$app['text']?></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-filter="*" lay-submit>
                                更新配置信息
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
function get_appkey(){
    var rand = Math.random().toString(36).substr(2)+Math.random().toString(36).substr(5);
    $('#rand').val(md5(rand));
}
</script>
</body>
</html>