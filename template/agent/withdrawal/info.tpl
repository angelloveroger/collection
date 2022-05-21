<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>完善信息</title>
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
    <form class="layui-form layui-form-pane" action="<?=links('agent/withdrawal/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">提现方式</label>
                <div class="layui-input-block">
                    <select name="pay_bank">
                        <?=!empty($pay_bank)?'<option value="'.$pay_bank.'">'.$pay_bank.'</option>':''?>
                        <option value="支付宝">支付宝</option>
                        <option value="USDT-ERC20">USDT-ERC20</option>
                        <option value="USDT-TRC20">USDT-TRC20</option>
                        <option value="兴业银行">兴业银行</option>
                        <option value="上海银行">上海银行</option>
                        <option value="浦发银行">浦发银行</option>
                        <option value="厦门银行">厦门银行</option>
                        <option value="招商银行">招商银行</option>
                        <option value="民生银行">民生银行</option>
                        <option value="中国银行">中国银行</option>
                        <option value="农业银行">农业银行</option>
                        <option value="光大银行">光大银行</option>
                        <option value="工商银行">工商银行</option>
                        <option value="北京银行">北京银行</option>
                        <option value="恒生银行">恒生银行</option>
                        <option value="兴业银行">兴业银行</option>
                        <option value="花旗银行">花旗银行</option>
                        <option value="华夏银行">华夏银行</option>
                        <option value="交通银行">交通银行</option>
                        <option value="网商银行">网商银行</option>
                        <option value="建设银行">建设银行</option>
                        <option value="邮政银行">邮政银行</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md9">
                <label class="layui-form-label">收款账号</label>
                <div class="layui-input-block">
                    <input type="text" name="pay_card" class="layui-input" placeholder="收款账号" value="<?=$pay_card?>">
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
        <div class="layui-form-item" style="text-align: center;">
            <input type="hidden" name="id" value="<?=$id?>">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
</body>
</html>