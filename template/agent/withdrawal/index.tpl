<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>结算记录</title>
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
        <a>代理后台</a>
        <a><cite>结算记录</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="dd">订单号</option>
                                <option value="pay_name">收款人</option>
                                <option value="pay_card">收款账号</option>
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
                                <option value="1">待处理</option>
                                <option value="2">成功</option>
                                <option value="3">失败</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="pay" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('agent/withdrawal/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'pay'}" lay-filter="pay">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'dd',align:'center'}">订单号</th>
                    <th lay-data="{field:'rmb',width:80,align:'center'}">金额</th>
                    <th lay-data="{field:'pay_name',width:100,align:'center'}">收款人</th>
                    <th lay-data="{field:'pid',align:'center',templet:'#ztTpl'}">状态</th>
                <?php }else{ ?>
                    <th lay-data="{field:'dd',align:'center'}">订单号</th>
                    <th lay-data="{field:'rmb',width:100,align:'center'}">金额</th>
                    <th lay-data="{field:'pay_name',align:'center'}">收款人</th>
                    <th lay-data="{field:'pay_card',align:'center'}">收款账号</th>
                    <th lay-data="{field:'pay_bank',align:'center'}">收款银行</th>
                    <th lay-data="{field:'pay_bank_city',align:'center'}">银行地址</th>
                    <th lay-data="{field:'pid',align:'center',templet:'#ztTpl'}">状态</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">时间</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="ztTpl">
    {{#  if(d.pid == 1){ }}
        <div style="color:#080;">已完成</div>
    {{#  } else if(d.pid == 2){ }}
        <div style="color:#f00;">失败，原因：{{d.msg}}</div>
    {{#  } else { }}
        <div style="color:#f90;">待处理</div>
    {{#  } }}
</script>
</body>
</html>