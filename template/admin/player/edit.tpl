<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>播放器修改</title>
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
    <form class="layui-form layui-form-pane" action="<?=links('player/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-block">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入名称">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md6">
                <label class="layui-form-label">介绍</label>
                <div class="layui-input-block">
                    <input type="text" name="text" class="layui-input" value="<?=$text?>" placeholder="请输入简单介绍">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">播放器类型</label>
                <div class="layui-input-block">
                    <select name="type" lay-filter="type">
                        <option value="app">App内置播放器（支持M3U8/mp4）</option>
                        <option value="web"<?php if($type == 'web') echo 'selected';?>>H5外部播放器（需要用到解析地址）</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md6">
                <label class="layui-form-label">唯一标识</label>
                <div class="layui-input-block">
                    <input type="text" name="alias" required lay-verify="alias" class="layui-input" placeholder="请填写唯一标识，字母或者数字且字母开头" value="<?=$alias?>">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">排序编号</label>
                <div class="layui-input-block">
                    <input type="number" name="xid" class="layui-input" value="<?=$xid?>" placeholder="排序编号，越小越靠前">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">是否显示</label>
                <div class="layui-input-block">
                    <select name="yid">
                        <option value="0">显示</option>
                        <option value="1"<?php if($yid == 1) echo 'selected';?>>关闭</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item" id="type"<?php if($type == 'app') echo ' style="display:none;"';?>>
            <label class="layui-form-label">解析地址</label>
            <div class="layui-input-block">
                <input type="text" name="jxurl" class="layui-input" placeholder="解析地址，留空则使用全局解析地址" value="<?=$jxurl?>">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <input type="hidden" name="id" value="<?=$id?>">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['form'], function(){
    var form = layui.form;
    form.verify({
        alias: [/^[a-zA-Z]{1}[a-zA-Z0-9]{1,20}$/,'只能是2-20位字母或者数字，且字母开头']
    });
    form.on('select(type)', function(r){
        if(r.value == 'app'){
            $('#type').hide();
        }else{
            $('#type').show();
        }
    });
});
</script>
</body>
</html>