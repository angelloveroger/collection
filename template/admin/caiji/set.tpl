<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采集入库配置</title>
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
    <form class="layui-form" action="<?=links('caiji/set_save')?>?ly=<?=$ly?>">
        <div class="layui-form-item w120">
            <label class="layui-form-label layui-form-required">是否收费</label>
            <div class="layui-input-block">
                <input type="radio" name="pay" value="0" title="免费播放"<?php if($pay['pay'] == 0) echo 'checked';?>>
                <input type="radio" name="pay" value="1" title="VIP播放"<?php if($pay['pay'] == 1) echo 'checked';?>>
                <input type="radio" name="pay" value="2" title="点播播放"<?php if($pay['pay'] == 2) echo 'checked';?>>
            </div>
        </div>
        <div class="layui-form-item w120">
            <label class="layui-form-label">点播所需金币</label>
            <div class="layui-input-block">
                <input type="number" name="cion" required lay-verify="required" autocomplete="off" class="layui-input" value="<?=$pay['cion']?>" placeholder="点播单集所需金币">
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
</body>
</html>