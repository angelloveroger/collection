<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>广告修改</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style type="text/css">
.layui-form-item .layui-input-inline{
    width: auto;
    margin-left: 5px;
}
.layui-form-radio{
    margin: 0; 
    padding-right: 0;
}
.layui-form-pane .layui-form-checkbox {
    margin: 4px 0 4px 1px;
}
.layui-form-checkbox[lay-skin=primary] span {
    padding-right: 4px;
}
.layui-form-checkbox[lay-skin=primary] i {
    left: 6px;
}
.layui-form-radio>i{margin-right: 3px;font-size: 16px;}
.layui-form-pane .layui-form-radio, .layui-form-pane .layui-form-switch {
    margin-top: 2px;
}
@media screen and (max-width: 990px){
    .layui-form-item .layui-col-xs12:first-child{
        margin-top: 0px;
    }
    .layui-form-item{
        margin-bottom: 10px; 
    }
    .layui-form-item .layui-col-xs12{
        margin-top: 10px;
    }
}
</style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('tpl/save/'.$type.'/'.$op)?>">
        <div class="layui-form-item">
            <textarea style="min-height:150px;" name="jshtml" placeholder="广告代码" class="layui-textarea"><?=$jshtml?></textarea>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <input type="hidden" name="dir" value="<?=$dir?>">
            <input type="hidden" name="js" value="<?=$js?>">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['form','upload','laydate'], function(){
    var upload = layui.upload,
        form = layui.form,
        laydate = layui.laydate;
    upload.render({
        elem: '.uppic',
        url: '<?=links('ajax/uppic/user')?>',
        accept: 'file',
        acceptMime: 'image/*',
        exts: 'jpg|png|gif|bmp|jpeg',
        done: function(res){
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                $('#pic').val(res.url);
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        }
    });
    //VIP
    form.on('select(vip)', function(r){
        if(r.value == 1){
            $('#vip').show();
        }else{
            $('#vip').hide();
        }
    });
    laydate.render({
        elem: '#time',
        type: 'datetime'
    });
});
</script>
</body>
</html>