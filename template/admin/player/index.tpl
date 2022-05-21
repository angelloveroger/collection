<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>播放器列表</title>
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
        <a>视频管理</a>
        <a><cite>播放器列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('player/del')?>','player')"><i class="layui-icon">&#xe640;</i>删除</button>
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增播放器','<?=links('player/edit')?>',600,460);"><i class="layui-icon">&#xe624;</i>新增播放器</button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('player/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'player'}" lay-filter="player">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'name'}">播放器名称</th>
                    <th lay-data="{align:'center',width:160,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:100,align:'center'}">播放器ID</th>
                    <th lay-data="{field:'name'}">播放器名称</th>
                    <th lay-data="{field:'text'}">播放器介绍</th>
                    <th lay-data="{field:'alias',width:100,align:'center'}">唯一标识</th>
                    <th lay-data="{field:'type',width:160,align:'center',templet:'#typeTpl'}">类型</th>
                    <th lay-data="{field:'xid',sort: true,width:100,align:'center'}">排序</th>
                    <th lay-data="{field:'tid',width:80,align:'center',templet:'#tjTpl'}">状态</th>
                    <th lay-data="{align:'center',width:160,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="tjTpl">
    {{#  if(d.yid == 1){ }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon tid" data-id="{{d.id}}" data-tid="0" title="已关闭，点击开启">&#x1006;</div>
    {{#  } else { }}
        <div style="color:#080;cursor: pointer;" class="layui-icon tid" data-id="{{d.id}}" data-tid="1" title="已开启，点击关闭">&#xe605;</div>
    {{#  } }}
</script>
<script type="text/html" id="typeTpl">
    {{#  if(d.type == 'app'){ }}
        <span style="color:#080;">App内置播放器</span>
    {{#  } else { }}
        <span style="color:#1E9FFF;">Web外部播放器</span>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('播放器编辑','<?=links('player/edit')?>/{{d.id}}',600,460)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('player/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
$(function(){
    $(document).on('click','.tid',function(){
        var _this = $(this);
        var tid = $(this).attr('data-tid');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('player/init')?>', {id:id,tid:tid}, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                if(tid == 1){
                    _this.html('&#x1006;').attr('data-tid','0').css('color','#f30').attr('title','已关闭，点击开启');
                }else{
                    _this.html('&#xe605;').attr('data-tid','1').css('color','#080').attr('title','已开启，点击关闭');
                }
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    })
});
</script>
</body>
</html>