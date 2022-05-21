<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>卡密列表</title>
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
        <a><cite>卡密列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('pay/card_del')?>','cion')"><i class="layui-icon">&#xe640;</i>删除</button>
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="get_dc('card');"><i class="layui-icon">&#xe601;</i>导出txt</button>
                        <button class="layui-btn layui-btn-sm" onclick="Admin.open('添加卡密','<?=links('pay/card_add')?>',500,450)"><i class="layui-icon">&#xe654;</i>添加卡密</button>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="tzd">
                                <option value="endtime">到期时间</option>
                                <option value="paytime">使用时间</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="uid">用户ID</option>
                                <option value="aid">代理ID</option>
                                <option value="pass">卡密</option>
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
                                <option value="">类型</option>
                                <option value="1">VIP卡</option>
                                <option value="2">金币卡</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zt">
                                <option value="">状态</option>
                                <option value="1">已使用</option>
                                <option value="2">未使用</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="cion" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('pay/card/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'cion'}" lay-filter="cion">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'pass'}">卡密</th>
                    <th lay-data="{field:'cion',width:150,align:'center',templet:'#rmbTpl'}">数量</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:80,align:'center'}">ID</th>
                    <th lay-data="{field:'pass',align:'center'}">卡密</th>
                    <th lay-data="{field:'cion',width:150,align:'center',templet:'#rmbTpl'}">面额</th>
                    <th lay-data="{field:'aid',width:100,align:'center'}">代理ID</th>
                    <th lay-data="{field:'uid',width:100,align:'center'}">使用用户ID</th>
                    <th lay-data="{field:'paytime',align:'center',width:160,templet:'#payTpl'}">使用时间</th>
                    <th lay-data="{field:'endtime',align:'center',width:160,sort: true}">到期时间</th>
                    <th lay-data="{align:'center',width:120,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="payTpl">
    {{#  if(d.paytime == '------'){ }}
    <span>未使用</span>
    {{#  } else { }}
    {{d.paytime}}
    {{#  } }}
</script>
<script type="text/html" id="rmbTpl">
    {{#  if(d.type == 2){ }}
    <font color=#1E9FFF>{{d.nums}}个金币</font>
    {{#  } else { }}
    <font color=red>{{d.nums}}天Vip</font>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('pay/card_del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
    function get_dc(){
        var ids = [];
        var checkStatus = table.checkStatus('cion');
        checkStatus.data.forEach(function(n,i){
            ids.push(n.id);
        });
        if(ids.length == 0){
            layer.msg('请选择要导出的卡密',{icon: 2});
        }else{
            window.location.href = '<?=links('pay/card_daochu')?>?id='+ids.join(',');
        }
    }
</script>
</body>
</html>