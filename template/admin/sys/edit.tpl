<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改管理员</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <style>
        .layui-form-label{padding: 9px 0px;width: 50px;}
        .layui-input-block{margin-left: 60px;}
    </style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form" action="<?=links('sys/save')?>">
        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-block">
                <input type="text" name="name" required lay-verify="required" autocomplete="off" class="layui-input" value="<?=$name?>" placeholder="请输入登录账号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="text" name="pass" autocomplete="off" class="layui-input" value="" placeholder="请输入登录密码<?=$id>0?'，留空为不修改':''?>">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-block">
                <p style="padding:5px;color:#f00;"><b>注意：超极管理员请不要选择权限~!</b></p>
                <div id="quanxuan"></div>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <input type="hidden" name="id" value="<?=$id?>">
            <input type="hidden" id="qx" name="qx" value="<?=$qx?>">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['tree', 'util'], function(){
    var tree = layui.tree
    ,layer = layui.layer
    ,util = layui.util
    ,data = <?=json_encode($nav)?>;
    var qx = [];

    tree.render({
        elem: '#quanxuan',
        data: data,
        showCheckbox: true,
        id: 'demoId',
        oncheck: function(obj){
            get_qx(obj.data,obj.checked);
        }
    });

    function get_qx(d,checked){
        if(d.children == undefined){
            var index = qx.indexOf(d.id);
            if(checked){
                if(index == -1) qx.push(d.id);
            }else{
                if(index > -1) qx.splice(index,1);
            }
        }else{
            for(var k = 0; k < d.children.length; k++){
                var index = qx.indexOf(d.children[k].id);
                if(checked){
                    if(index == -1) qx.push(d.children[k].id);
                }else{
                    if(index > -1) qx.splice(index,1);
                }
            }
        }
        $('#qx').val(qx.join(','));
    }
});
</script>
</body>
</html>