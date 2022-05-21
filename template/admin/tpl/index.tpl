<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>模板配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js?v=1.2"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>系统配置</a>
        <a><cite>模版管理</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title" id="tplbox">
                    <li data-type="pc"<?php if($type == 'pc') echo ' class="layui-this"';?>>电脑模版</li>
                    <li data-type="wap"<?php if($type == 'wap') echo ' class="layui-this"';?>>手机模版</li>
                    <li><a onclick="layer.load();" href="<?=links('tpl/yun')?>">模版中心</a></li>
                    <div style="float:right;">
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" id="uptpl" style="float:right;margin-top:5px;"><i class="layui-icon">&#xe67c;</i>上传模板</button>
                    </div>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item<?php if($type == 'pc') echo ' layui-show';?>">
                        <div class="layui-text" style="padding-top:5px;margin-bottom:20px;">
                            <div class="layui-row">
                                <div style="padding: 10px;">
                                    <?php foreach($pc as $row){ ?>
                                    <div class="layui-col-xs12 layui-col-sm4 layui-col-md2">
                                        <div class="yhcms-skin center">
                                            <div class="pic" style="position: relative;">
                                            	<img src="<?=$row['pic']?>">
                                                <div class="layui-btn layui-btn-xs layui-btn-normal" style="position: absolute;top: 3px;left: 3px;padding: 0px 4px;" onclick="parent.Admin.add_tab('模板广告','<?=links('tpl/ads/pc')?>?dir=<?=$row['dir']?>')">广告管理</div>
                                            <?php if($row['init'] == 0){ ?>
                                            	<div class="layui-btn layui-btn-xs layui-btn-danger" style="position: absolute;top: 3px;right: 3px;padding: 0px 4px;" onclick="Admin.skin_del('<?=links('tpl/del/pc')?>','<?=$row['dir']?>');"><i class="layui-icon layui-icon-delete" style="font-size: 22px;"></i></div>
                                            <?php } ?>
                                            </div>
                                            <div class="text"><?=$row['name']?></div>
                                            <div class="cmd">
                                            <?php if($row['init'] == 0){ ?>
                                                <div class="layui-btn layui-btn-xs layui-btn-radius" onclick="Admin.skin_init('<?=links('tpl/init/pc')?>','<?=$row['dir']?>');">设为默认</div>
                                            <?php }else{ ?>
                                                <div class="layui-btn layui-btn-xs layui-btn-radius layui-btn-disabled">默认模版</div>
                                            <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-tab-item<?php if($type == 'wap') echo ' layui-show';?>">
                        <div class="layui-text" style="padding-top:5px;margin-bottom:20px;">
                            <div class="layui-row">
                                <div style="padding: 10px;">
                                    <?php foreach($wap as $row){ ?>
                                    <div class="layui-col-xs12 layui-col-sm4 layui-col-md2">
                                        <div class="yhcms-skin center">
                                            <div class="pic" style="position: relative;">
                                            	<img src="<?=$row['pic']?>">
                                                <div class="layui-btn layui-btn-xs layui-btn-normal" style="position: absolute;top: 3px;left: 3px;padding: 0px 4px;" onclick="parent.Admin.add_tab('模板广告','<?=links('tpl/ads/wap')?>?dir=<?=$row['dir']?>')">广告管理</div>
                                            <?php if($row['init'] == 0){ ?>
                                            	<div class="layui-btn layui-btn-xs layui-btn-danger" style="position: absolute;top: 3px;right: 3px;padding: 0px 4px;" onclick="Admin.skin_del('<?=links('tpl/del/wap')?>','<?=$row['dir']?>');"><i class="layui-icon layui-icon-delete" style="font-size: 22px;"></i></div>
                                            <?php } ?>
                                            </div>
                                            <div class="text"><?=$row['name']?></div>
                                            <div class="cmd">
                                            <?php if($row['init'] == 0){ ?>
                                                <div class="layui-btn layui-btn-xs layui-btn-radius" onclick="Admin.skin_init('<?=links('tpl/init/wap')?>','<?=$row['dir']?>');">设为默认</div>
                                            <?php }else{ ?>
                                                <div class="layui-btn layui-btn-xs layui-btn-radius layui-btn-disabled">默认模版</div>
                                            <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
layui.use('upload', function(){
    var upload = layui.upload;
    upload.render({
        elem: '#uptpl',
        url: '',
        accept: 'file',
        acceptMime: 'application/zip',
        exts: 'zip',
        before: function(obj){
            this.url = '<?=links('tpl/uptpl')?>?type='+$('#tplbox .layui-this').data('type');
            layer.load();
        },
        done: function(res){
            layer.closeAll('loading');
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                setTimeout(function() {
                    window.location.reload();
                }, 1500);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        }
    });
});
</script>
</body>
</html>