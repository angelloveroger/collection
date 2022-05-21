<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>充值订单</title>
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
        <a>财务管理</a>
        <a><cite>充值订单</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('pay/del')?>','pay')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="dd">站内订单号</option>
                                <option value="trade_no">商家订单号</option>
                                <option value="aid">代理ID</option>
                                <option value="uid">用户ID</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="">
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="type">
                                <option value="">充值类型</option>
                                <option value="vip">充值VIP</option>
                                <option value="cion">充值金币</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="paytype">
                                <option value="">付款方式</option>
                                <option value="alipay">支付宝</option>
                                <option value="wxpay">微信支付</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="facility">
                                <option value="">渠道</option>
                                <option value="ios">IOS</option>
                                <option value="android">安卓</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="pid">
                                <option value="">状态</option>
                                <option value="2">成功</option>
                                <option value="1">失败</option>
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
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('pay/index/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'pay'}" lay-filter="pay">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'dd',align:'center'}">站内订单号</th>
                    <th lay-data="{field:'rmb',width:80,align:'center'}">金额</th>
                    <th lay-data="{field:'pid',width:80,align:'center',templet:'#ztTpl'}">状态</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">订单ID</th>
                    <th lay-data="{field:'dd',align:'center'}">站内订单号</th>
                    <th lay-data="{field:'trade_no',align:'center'}">商家订单号</th>
                    <th lay-data="{field:'aid',width:70,align:'center'}">代理ID</th>
                    <th lay-data="{field:'uid',width:70,align:'center'}">用户ID</th>
                    <th lay-data="{field:'type',align:'center',templet:'#typeTpl'}">充值内容</th>
                    <th lay-data="{field:'rmb',width:100,align:'center'}">金额</th>
                    <th lay-data="{field:'pid',width:100,align:'center',templet:'#ztTpl'}">状态</th>
                    <th lay-data="{field:'facility',width:100,align:'center'}">渠道</th>
                    <th lay-data="{field:'paytype',width:100,align:'center'}">付款方式</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">时间</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
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
    {{#  } else { }}
        <div style="color:#f30;">未完成</div>
    {{#  } }}
</script>
<script type="text/html" id="typeTpl">
    {{#  if(d.day > 0){ }}
        <div style="color:#080;">购买{{d.day}}天VIP会员</div>
    {{#  } else { }}
        <div style="color:#1E9FFF;">充值{{d.cion}}个金币</div>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('pay/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
</body>
</html>