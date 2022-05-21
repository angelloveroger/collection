<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改分类</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('bbs/lists_save')?>">
        <div class="layui-form-item">
            <label class="layui-form-label">分类名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" required lay-verify="required" autocomplete="off" class="layui-input" value="<?=$name?>" placeholder="请输入分类名称">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">分类图片</label>
            <div class="layui-input-block">
                <input type="text" name="pic" id="pic" autocomplete="off" class="layui-input" value="<?=$pic?>" placeholder="请上传分类图片">
                <div class="layui-btn layui-btn-normal uppic" style="position: absolute;top: 0px;right: 0;">上传图片</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">排序编号</label>
            <div class="layui-input-block">
                <input type="number" name="xid" required lay-verify="required" autocomplete="off" class="layui-input" value="<?=$xid?>" placeholder="请输入排序编号，越小越靠前">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否显示</label>
            <div class="layui-input-block">
                <select name="yid">
                    <option value="1">否</option>
                    <option value="0"<?php if($yid == 0) echo 'selected';?>>是</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <input type="hidden" name="id" value="<?=$id?>">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['upload'], function(){
    var upload = layui.upload;
    upload.render({
        elem: '.uppic',
        url: '<?=links('ajax/uppic/bbs')?>',
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
});
</script>
</body>
</html>