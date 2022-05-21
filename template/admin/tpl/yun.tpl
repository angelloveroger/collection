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
    <style type="text/css">
    .layui-text{padding-top:5px;margin-bottom:20px;}
    .free{background-color:#1E9FFF;position: absolute;top:0;right:0;}
    .tpldown{background-color:#2F4056;width:50%;margin-top: 6px;}
    .b2{background: #b96363;}
    </style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>系统配置</a>
        <a><cite>模版配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                    <li><a href="<?=links('tpl/index/pc')?>">电脑模版</a></li>
                    <li><a href="<?=links('tpl/index/wap')?>">手机模版</a></li>
                    <li class="layui-this">模版中心</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-tab layui-tab-card">
                            <ul class="layui-tab-title tpltab">
                            <?php
                            $cls = 0 == $cid ? ' class="layui-this"' : '';
                            echo '<li'.$cls.'><a href="'.links('tpl/yun').'">全部模板</a></li>';
                            foreach($skins['class'] as $row){
                                $cls = $row['id'] == $cid ? ' class="layui-this"' : '';
                                echo '<li'.$cls.'><a href="'.links('tpl/yun/'.$row['id']).'">'.$row['name'].'</a></li>';
                            }
                            ?>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <div class="layui-text">
                                        <div class="layui-row">
                                            <div style="padding: 10px;">
                                                <?php 
                                                if(empty($skins['tpl'])) echo '<p style="text-align: center;padding: 100px;">没有模板数据</p>';
                                                foreach($skins['tpl'] as $row){ 
                                                ?>
                                                <div class="layui-col-xs6 layui-col-sm4 layui-col-md2">
                                                    <div class="vod-skin center">
                                                        <div class="pic"><a title="点击查看演示" href="<?=$row['demourl']?>" target="_blank"><img src="<?=$row['pic']?>"></a><div class="layui-btn layui-btn-xs layui-btn-radius free">免费</div></div>
                                                        <div class="text"><?=$row['name']?></div>
                                                        <div class="cmd">
                                                            <?php if(!empty($row['path']) AND file_exists(FCPATH.'template/'.$row['path'].'/tpl.php')){ ?>
                                                                <div class="layui-btn layui-btn-sm layui-btn-radius tpldown b2" data-url="<?=links('tpl/down/'.$row['id'])?>">重新下载</div>
                                                            <?php }else{ ?>
                                                            <div class="layui-btn layui-btn-sm layui-btn-radius tpldown" data-url="<?=links('tpl/down/'.$row['id'])?>">立即下载</div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <?php if($skins['pagejs'] > 1 AND $skins['pagejs'] > $page){ ?>
                                    <div style="text-align: center;"><a class="tpltab" style="padding: 8px 30px;background: #e8e7e7;border-radius: 5px;" href="<?=links('tpl/yun/'.$cid.'/'.($page+1))?>">点击加载下一页</a></div>
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
$(function(){
    if(wap){
        $('.vod-skin .pic').css('height','90px');
        $('.cmd .layui-btn').css('width','100%');
    }
    $('body').on('click','.tpldown',function(){
        var index = layer.load();
        $.get($(this).data('url'),function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                setTimeout(function() {
                    window.location.href = res.url;
                }, 1000);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    });
});
</script>
</body>
</html>