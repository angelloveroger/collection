<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>提现列表</title>
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
        <a>代理管理</a>
        <a><cite>提现列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('agent/withdrawal_del')?>','user')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="dd">提现单号</option>
                                <option value="aid">代理ID</option>
                                <option value="pay_name">提现名字</option>
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
                            <select name="pid">
                                <option value="">状态</option>
                                <option value="1">待打款</option>
                                <option value="2">已完成</option>
                                <option value="3">已失败</option>
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
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('agent/withdrawal/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'user'}" lay-filter="user">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'dd',align:'center'}">单号</th>
                    <th lay-data="{field:'rmb',align:'center'}">金额</th>
                    <th lay-data="{field:'aid',align:'center'}">代理ID</th>
                    <th lay-data="{field:'pid',align:'center',templet:'#pidTpl'}">状态</th>
                    <th lay-data="{align:'center',width:130,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'aid',width:70,align:'center'}">代理ID</th>
                    <th lay-data="{field:'dd',align:'center'}">单号</th>
                    <th lay-data="{field:'rmb',width:100,align:'center'}">金额</th>
                    <th lay-data="{field:'pid',align:'center',templet:'#sidTpl'}">状态</th>
                    <th lay-data="{field:'pay_bank',align:'center'}">提现方式</th>
                    <th lay-data="{field:'pay_name',align:'center'}">提现名字</th>
                    <th lay-data="{field:'pay_card',align:'center'}">提现账号</th>
                    <th lay-data="{field:'paytime',align:'center',sort: true}">操作时间</th>
                    <th lay-data="{field:'addtime',align:'center',sort: true}">加入时间</th>
                    <th lay-data="{align:'center',width:130,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="sidTpl">
    {{#  if(d.pid == 2){ }}
        <span style="color:#f30;">已失败，{{d.msg}}</span>
    {{#  } else if(d.pid == 1){ }}
        <span style="color:#080;">已完成</span>
    {{#  } else { }}
        <span style="color:#f90;">待打款</span>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="详情" class="layui-btn layui-btn-xs" onclick="Admin.open('提现详情','<?=links('agent/withdrawal_show')?>/{{d.id}}',400,550)"><i class="layui-icon">&#xe615;</i>详情</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('agent/withdrawal_del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
</body>
</html>