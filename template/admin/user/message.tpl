<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>消息列表</title>
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
        <a><cite>消息列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('message/del')?>','vod')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="sid">
                                <option value="">类型</option>
                                <option value="0">系统</option>
                                <option value="1">视频</option>
                                <option value="2">短视</option>
                                <option value="3">帖子</option>
                                <option value="4">评论</option>
                                <option value="5">点赞</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="uid">用户ID</option>
                                <option value="zid">消息内容</option>
                                <option value="did">数据ID</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="">
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="vod" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('message/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'vod'}" lay-filter="vod">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'text'}">消息内容</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'uid',width:100,align:'center'}">用户ID</th>
                    <th lay-data="{field:'sid',width:100,align:'center'}">类型</th>
                    <th lay-data="{field:'text'}">消息内容</th>
                    <th lay-data="{field:'vid',width:100,align:'center'}">数据ID</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">时间</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('message/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
</body>
</html>