<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>资源库</title>
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
        <a>采集管理</a>
        <a><cite>资源库</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <?php 
            if(!empty($last_url)){
                echo '<div class="layui-row"><b style="color:#06f;padding-left:20px;">系统检测到，你上次有未采集完的任务，是否需要继续，<a style="color:red;" href="'.$last_url.'">继续采集</a></b></div>';
            }
            ?>
            <table class="layui-table" lay-data="{url:'<?=links('caiji/zyk/json')?>',page:false}" lay-filter="caiji">
              <thead>
                <tr>
                    <th lay-data="{field:'id',width:80,align:'center',sort: true}">编号</th>
                    <th lay-data="{field:'name'}">资源名称</th>
                    <th lay-data="{field:'text'}">资源简介</th>
                    <th lay-data="{field:'day',width:90,align:'center'}">采集当天</th>
                    <th lay-data="{field:'week',width:90,align:'center'}">采集本周</th>
                    <th lay-data="{field:'all',width:90,align:'center'}">采集所有</th>
                    <th lay-data="{field:'cmd',width:90,align:'center'}">入库配置</th>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script>
function get_del(ly){
    layer.confirm('确定要删除吗', {
        title:'删除提示',
        btn: ['确定', '取消'], //按钮
        shade:0.001
    }, function(index) {
        layer.load();
        $.post('<?=links('caiji/del')?>', {ly:ly}, function(res) {
            if(res.code == 1){
                layer.msg('删除成功...',{icon: 1});
                setTimeout(function() {
                    window.location.reload();
                }, 1000);
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    }, function(index) {
        layer.close(index);
    });
}
</script>
</body>
</html>