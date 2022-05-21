<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>卡密添加</title>
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
    <form class="layui-form" action="<?=links('pay/card_save')?>">
        <div class="layui-form-item">
            <label class="layui-form-label">卡密类型</label>
            <div class="layui-input-block">
                <select name="type" lay-filter="type">
                    <option value="2">金币卡</option>
                    <option value="1">Vip卡</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" id="cion">
            <label class="layui-form-label">金币数量</label>
            <div class="layui-input-block">
                <input type="number" name="cion" autocomplete="off" class="layui-input" value="" placeholder="请输入金币数量">
            </div>
        </div>
        <div class="layui-form-item" id="vip" style='display: none;'>
            <label class="layui-form-label">Vip天数</label>
            <div class="layui-input-block">
                <input type="number" name="day" autocomplete="off" class="layui-input" value="" placeholder="请输入Vip天数">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">卡密数量</label>
            <div class="layui-input-block">
                <input required lay-verify="required" type="number" name="nums" autocomplete="off" class="layui-input" value="" placeholder="请输入卡密数量">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">卡密售价</label>
            <div class="layui-input-block">
                <input required lay-verify="required" type="text" name="rmb" autocomplete="off" class="layui-input" value="" placeholder="请输入卡密售价，人民币">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">代理ID</label>
            <div class="layui-input-block">
                <input type="text" name="aid" autocomplete="off" class="layui-input" value="" placeholder="请输入所属代理ID，留空为全站">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">有效期</label>
            <div class="layui-input-block">
                <input type="text" id="time" name="endtime" autocomplete="off" class="layui-input" value="" placeholder="有效期类使用，留空则永久有效">
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn" lay-filter="*" lay-submit>确定提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['form','laydate'], function(){
    var form = layui.form,
        laydate = layui.laydate;
    form.on('select(type)', function(r){
        if(r.value == 1){
            $('#cion').hide();
            $('#vip').show();
        }else{
            $('#cion').show();
            $('#vip').hide();
        }
    });
    laydate.render({
        elem: '#time',
        type: 'datetime'
    });
})
</script>
</body>
</html>