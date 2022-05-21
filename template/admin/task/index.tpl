<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>任务列表</title>
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
        <a>用户管理</a>
        <a><cite>任务列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('task/del')?>','user')"><i class="layui-icon">&#xe640;</i>删除</button>
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增任务','<?=links('task/edit')?>',600,500);"><i class="layui-icon">&#xe624;</i>新增任务</button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('task/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'user'}" lay-filter="user">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'name'}">任务标题</th>
                    <th lay-data="{field:'day',align:'center'}">奖励VIP</th>
                    <th lay-data="{field:'cion',align:'center'}">奖励金币</th>
                    <th lay-data="{align:'center',width:200,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">任务ID</th>
                    <th lay-data="{field:'name'}">任务标题</th>
                    <th lay-data="{field:'text'}">任务介绍</th>
                    <th lay-data="{field:'type',width:100,align:'center',templet:'#typeTpl'}">类型</th>
                    <th lay-data="{field:'cion',width:100,align:'center'}">奖励金币</th>
                    <th lay-data="{field:'day',width:150,align:'center'}">每天奖励次数上限</th>
                    <th lay-data="{field:'duration',width:100,align:'center'}">观看时长</th>
                    <th lay-data="{align:'center',width:200,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="typeTpl">
    {{#  if(d.type == 'share'){ }}
        <span style="color:#f30;">分享任务</span>
    {{#  } else { }}
        <span style="color:#080;">观看任务</span>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('任务编辑','<?=links('task/edit')?>/{{d.id}}',600,500)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('task/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
</body>
</html>