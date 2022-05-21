<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>广告列表</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>模板管理</a>
        <a><cite>广告列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                <?php
                    $k = 0;
                    foreach($ads as $op=>$v){
                        $cls = $k == 0 ? ' class="layui-this"' : '';
                        echo '<li'.$cls.'>'.$v['name'].'</li>';
                        $k++;
                    }
                ?>
                </ul>
                <div class="layui-tab-content">
                <?php 
                    $i = 0;
                    foreach($ads as $op=>$v){
                    $cls = $i == 0 ? ' layui-show' : '';
                ?>
                    <div class="layui-tab-item<?=$cls?>">
                        <div class="layui-text" style="max-width: 800px;">
                            <table class="layui-table" lay-even lay-skin="line" style="margin-bottom:20px;">
                                <tbody>
                                    <tr>
                                        <th>序</th>
                                        <th>广告位名</th>
                                        <th class="hide">广告JS路径</th>
                                        <th style="text-align:center">状态</th>
                                        <th style="text-align:center">操作</th>
                                    </tr>
                                    <?php
                                    foreach($v['list'] as $k=>$row){
                                        $kk = $k+1;
                                        $jsfile = 'template/'.$type.'/'.$dir.'/adv/'.$row['jspath'];
                                        if($row['init'] == 1){
                                            $zt = '<div style="color:#080;cursor: pointer;" class="layui-icon open" data-op="'.$op.'" data-init="0" data-js="'.sys_auth($row['jspath']).'" title="已开启，点击关闭">&#xe605;</div>';
                                        }else{
                                            $zt = '<div style="color:#f30;cursor: pointer;" class="layui-icon open" data-op="'.$op.'" data-init="1" data-js="'.sys_auth($row['jspath']).'" title="已关闭，点击开启">&#x1006;</div>';
                                        }
                                        echo '<tr style="background-color: #f6f6f6;"><td align="center">'.$kk.'</td><td>'.$row['name'].'</td><td class="hide">'.$jsfile.'</td><td align="center">'.$zt.'</td><td align="center"><div class="layui-table-cell laytable-cell-1-0-7"><button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open(\'广告编辑\',\''.links('tpl/edit/'.$type.'/'.$op).'?js='.sys_auth($row['jspath']).'&dir='.sys_auth($dir).'\',600,300)"><i class="layui-icon">&#xe642;</i>编辑</button></div></td></tr>';
                                    }
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <?php $i++;} ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
    $(document).on('click','.open',function(){
        var _this = $(this);
        var js = $(this).attr('data-js');
        var init = $(this).attr('data-init');
        var op = $(this).attr('data-op');
        var index = layer.load();
        $.post('<?=links('tpl/ads_init/'.$type)?>', {dir:'<?=sys_auth($dir)?>',op:op,init:init,js:js}, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                if(init == 1){
                    _this.html('&#xe605;').attr('data-init','0').css('color','#080');
                }else{
                    _this.html('&#x1006;').attr('data-init','1').css('color','#f30');
                }
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    });
})
</script>
</body>
</html>