<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>任务修改</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style>
.layui-form-pane .layui-form-label{width: 120px;}
.layui-form-pane .layui-input-block{margin-left: 120px;}
</style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('task/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">任务标题</label>
                <div class="layui-input-block">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入任务标题">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">任务介绍</label>
                <div class="layui-input-block">
                    <input type="text" name="text" required lay-verify="required" class="layui-input" value="<?=$text?>" placeholder="请输入任务介绍">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">任务类型</label>
                <div class="layui-input-block">
                    <select name="type" lay-filter="type">
                        <option value="watch">观看任务</option>
                        <option value="share"<?php if($type == 'share') echo 'selected';?>>分享任务</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item" id="type"<?php if($type != 'watch') echo ' style="display:none;"';?>>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">观看时长</label>
                <div class="layui-input-block">
                    <input type="text" name="duration" class="layui-input" value="<?=$duration?>" placeholder="请输入观看时长，单位：秒">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">奖励金币</label>
                <div class="layui-input-block">
                    <input type="number" name="cion" required lay-verify="required" class="layui-input" value="<?=$cion?>" placeholder="奖励金币">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">每天次数上限</label>
                <div class="layui-input-block">
                    <input type="number" name="day" class="layui-input" value="<?=$day?>" placeholder="每天奖励次数上限，0不限制">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">排序ID</label>
                <div class="layui-input-block">
                    <input type="number" name="xid" class="layui-input" value="<?=$xid?>" placeholder="排序ID，越小越靠前">
                </div>
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
    form.on('select(type)', function(r){
        if(r.value == 'watch'){
            $('#type').show();
        }else{
            $('#type').hide();
        }
    });
});
</script>
</body>
</html>