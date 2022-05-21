<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户修改</title>
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
    <form class="layui-form layui-form-pane" action="<?=links('user/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">用户手机</label>
                <div class="layui-input-block">
                    <input type="text" name="tel" required lay-verify="required" class="layui-input" value="<?=$tel?>" placeholder="请输入用户手机">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">登录密码</label>
                <div class="layui-input-block">
                    <input type="text" name="pass" class="layui-input" value="" placeholder="<?=$id == 0 ? '请输入登录密码' : '登录密码，不修改请留空';?>"<?php if($id==0) echo ' required lay-verify="required"';?>>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">用户昵称</label>
                <div class="layui-input-block">
                    <input type="text" name="nickname" required lay-verify="required" class="layui-input" value="<?=$nickname?>" placeholder="请输入用户昵称">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">用户头像</label>
                <div class="layui-input-block">
                    <input type="text" id="pic" name="pic" class="layui-input" placeholder="请上传用户头像或者输入图片URL" value="<?=$pic?>">
                    <div class="layui-btn layui-btn-normal uppic" style="position: absolute;top: 0px;right: 0;">封面头像</div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">会员级别</label>
                <div class="layui-input-block">
                    <select name="vip" lay-filter="vip">
                        <option value="0">普通会员</option>
                        <option value="1"<?php if($vip == 1) echo 'selected';?>>Vip会员</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item" id="vip"<?php if($vip == 0) echo ' style="display:none;"';?>>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">VIP时间</label>
                <div class="layui-input-block">
                    <input type="text" id="time" name="viptime" class="layui-input" value="<?=$viptime > 0 ? date('Y-m-d H:i:s',$viptime) : '';?>" placeholder="请输入VIP到期时间">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">剩余金币</label>
                <div class="layui-input-block">
                    <input type="number" name="cion" class="layui-input" value="<?=$cion?>" placeholder="剩余金币">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">会员性别</label>
                <div class="layui-input-block">
                    <select name="sex">
                        <option value="0">保密</option>
                        <option value="1"<?php if($sex == 1) echo 'selected';?>>先生</option>
                        <option value="2"<?php if($sex == 2) echo 'selected';?>>女士</option>
                    </select>
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