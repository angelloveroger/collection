<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>挂机定时采集任务</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style type="text/css">
    .layui-form{
        border-width: 0!important;
        margin: 0!important;
    }
    .layui-table-view .layui-table td {
        padding: 2px 0!important;
    }
</style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">
            <b style="padding-left:15px;color:#000;">WIN挂机定时任务采集</b>
        </div>
        <div class="layui-card-body" style="padding:0 15px;">
            <div style="padding: 5px 15px;color:#000;font-weight: bold;" id="collect">
                定时采集任务等侍中...
            </div>
        </div>
    </div>
</div>
<script>
var cjurl = '<?=$cjurl?>';
var i = <?=$i?>;
var n = 0;
setInterval('collect()',1000*60*i);
collect();
function collect(){
    if(n == 0){
        $("#collect").html("<iframe  frameborder='0' width='100%' height='500' src='"+cjurl+"' scrolling='auto'></iframe>");
        n = 1;
    }
}
</script>
</body>
</html>