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
    <form class="layui-form layui-form-pane" action="<?=links('agent/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">代理账号</label>
                <div class="layui-input-block">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入手机或者邮箱">
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
                <label class="layui-form-label">分成比列</label>
                <div class="layui-input-block">
                    <input type="text" name="cfee" required lay-verify="required" class="layui-input" value="<?=$cfee?>" placeholder="请输入分成比列,百分比">
                    <div class="layui-btn layui-btn-normal uppic" style="position: absolute;top: 0px;right: 0;">%</div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">余额</label>
                <div class="layui-input-block">
                    <input type="text" name="rmb" class="layui-input" placeholder="余额" value="<?=$rmb?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现方式</label>
                <div class="layui-input-block">
                    <input type="text" name="pay_bank" class="layui-input" placeholder="提现方式，如：支付宝" value="<?=$pay_bank?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现账号</label>
                <div class="layui-input-block">
                    <input type="text" name="pay_card" class="layui-input" placeholder="提现账号" value="<?=$pay_card?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">收款人名字</label>
                <div class="layui-input-block">
                    <input type="text" name="pay_name" class="layui-input" placeholder="收款人名字" value="<?=$pay_name?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">开户行地址</label>
                <div class="layui-input-block">
                    <input type="text" name="pay_bank_city" class="layui-input" placeholder="银行开户行地址，可留空" value="<?=$pay_bank_city?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">代理状态</label>
                <div class="layui-input-block">
                    <select name="sid">
                        <option value="0">正常</option>
                        <option value="1"<?php if($sid == 1) echo 'selected';?>>已锁定</option>
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
</body>
</html>