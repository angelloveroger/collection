<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员列表</title>
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
        <a>管理员管理</a>
        <a><cite>管理员列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增管理员','<?=links('sys/edit')?>',500,500);"><i class="layui-icon">&#xe624;</i>新增</button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('sys/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'links'}" lay-filter="links">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'name'}">账号</th>
                    <th lay-data="{align:'center',width:160,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">ID</th>
                    <th lay-data="{field:'name',width:150,align:'center'}">名称</th>
                    <th lay-data="{field:'lognum',width:100,align:'center'}">登录次数</th>
                    <th lay-data="{field:'lopip',width:160,align:'center'}">最后登录IP</th>
                    <th lay-data="{field:'logtime',width:160,align:'center'}">最后登录时间</th>
                    <th lay-data="{field:'qx',align:'center'}">权限</th>
                    <th lay-data="{align:'center',width:160,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('管理员编辑','<?=links('sys/edit')?>/{{d.id}}',500,500)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('sys/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
</body>
</html>