<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户列表</title>
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
        <a><cite>用户列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('user/del')?>','user')"><i class="layui-icon">&#xe640;</i>删除</button>
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增用户','<?=links('user/edit')?>',600,520);"><i class="layui-icon">&#xe624;</i>新增用户</button>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="tel">用户手机</option>
                                <option value="nickname">用户昵称</option>
                                <option value="id">用户ID</option>
                                <option value="aid">代理ID</option>
                                <option value="fid">上级ID</option>
                                <option value="deviceid">设备ID</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="">
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="vip">
                                <option value="">vip</option>
                                <option value="2">是</option>
                                <option value="1">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="facility">
                                <option value="">渠道来源</option>
                                <option value="ios">IOS</option>
                                <option value="android">安卓</option>
                                <option value="pc">PC</option>
                                <option value="h5">H5</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="sex">
                                <option value="">性别</option>
                                <option value="1">保密</option>
                                <option value="2">先生</option>
                                <option value="3">女士</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="order">
                                <option value="">排序方式</option>
                                <option value="id">加入时间</option>
                                <option value="logtime">活跃时间</option>
                                <option value="cion">剩余金币</option>
                                <option value="qdznum">签到天数</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="user" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('user/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'user'}" lay-filter="user">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'tel',align:'center'}">手机号</th>
                    <th lay-data="{field:'nickname'}">昵称</th>
                    <th lay-data="{field:'cion',align:'center'}">金币</th>
                    <th lay-data="{align:'center',width:200,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">用户ID</th>
                    <th lay-data="{field:'pic',width:60,align:'center',templet:'#picTpl'}">头像</th>
                    <th lay-data="{field:'tel',width:120,align:'center'}">手机号</th>
                    <th lay-data="{field:'nickname'}">昵称</th>
                    <th lay-data="{field:'aid',width:70,align:'center'}">代理ID</th>
                    <th lay-data="{field:'fid',width:70,align:'center'}">上级ID</th>
                    <th lay-data="{field:'cion',width:80,align:'center'}">金币</th>
                    <th lay-data="{field:'qdnum',width:80,align:'center'}">签到天数</th>
                    <th lay-data="{field:'vip',width:80,align:'center',templet:'#vipTpl'}">会员级别</th>
                    <th lay-data="{field:'viptime',align:'center',width:160,sort: true}">Vip到期时间</th>
                    <th lay-data="{field:'facility',width:80,align:'center'}">来源渠道</th>
                    <th lay-data="{field:'logtime',align:'center',width:160,sort: true}">活跃时间</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">加入时间</th>
                    <th lay-data="{align:'center',width:200,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="picTpl">
    <div onclick="show_img(this)"><img src="{{d.pic}}" style="height: 30px;"></div>
</script>
<script type="text/html" id="vipTpl">
    {{#  if(d.vip == 1){ }}
        <span style="color:#f30;">Vip会员</span>
    {{#  } else { }}
        <span>普通会员</span>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('用户编辑','<?=links('user/edit')?>/{{d.id}}',600,520)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('user/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
function show_img(t) {
    var t = $(t).find("img");
    //页面层
    layer.open({
        type: 1,
        skin: 'none', //加上边框
        area: ['45%', '65%'], //宽高
        shadeClose: true, //开启遮罩关闭
        end: function (index, layero) {
            return false;
        },
        content: '<div style="text-align:center"><img src="' + $(t).attr('src') + '" /></div>'
    });
}
</script>
</body>
</html>