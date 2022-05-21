<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>代理修改</title>
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
.layui-form-pane .layui-input-block span{
    padding-left: 10px;
    line-height: 36px;
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
    <form class="layui-form layui-form-pane" action="<?=links('agent/withdrawal_save')?>">
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">代理ID</label>
                <div class="layui-input-block">
                    <span><?=$aid?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现余额</label>
                <div class="layui-input-block">
                    <span><?=$rmb?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现单号</label>
                <div class="layui-input-block">
                    <span><?=$dd?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现方式</label>
                <div class="layui-input-block">
                    <span><?=$pay_bank?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现账号</label>
                <div class="layui-input-block">
                    <span><?=$pay_card?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">收款人名字</label>
                <div class="layui-input-block">
                    <span><?=$pay_name?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">开户行地址</label>
                <div class="layui-input-block">
                    <span><?=$pay_bank_city?></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">打款状态</label>
                <div class="layui-input-block">
                    <select name="pid" lay-filter="pid">
                        <option value="0">待打款</option>
                        <option value="1"<?php if($pid == 1) echo 'selected';?>>已打款</option>
                        <option value="2"<?php if($pid == 2) echo 'selected';?>>打款失败</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item" id="pid"<?php if($pid<2) echo ' style="display:none;"';?>>
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">失败原因</label>
                <div class="layui-input-block">
                    <input type="text" name="msg" class="layui-input" value="<?=$msg?>" placeholder="请输入失败原因">
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
    form.on('select(pid)', function(r){
        if(r.value == 2){
            $('#pid').show();
        }else{
            $('#pid').hide();
        }
    });
});
</script>
</body>
</html>