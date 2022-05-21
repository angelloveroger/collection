<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改反馈</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <style type="text/css">
    .pic{margin-left:10px;margin-bottom: 10px;cursor: pointer;}
    .you{border: 1px solid #e0e0e0;min-height: 36px;line-height: 36px;padding-left: 10px;}
    </style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('feedback/save')?>">
        <div class="layui-form-item">
            <label class="layui-form-label">反馈用户ID</label>
            <div class="layui-input-block">
                <div class="you"><?=$uid?></div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">反馈类型</label>
            <div class="layui-input-block">
                <div class="you"><?=$type?></div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">反馈内容</label>
            <div class="layui-input-block">
                <div class="you">
                <?=$text?><br>
                <?php 
                if(!empty($pics)){
                    $picarr = json_decode(base64_decode($pics),1);
                    foreach($picarr as $pic){
                        echo '<img class="pic" src="'.getpic($pic).'" style="max-height:100px;">';
                    }
                }
                ?>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">回复内容</label>
            <div class="layui-input-block">
                <textarea name="reply_text" style="min-height:100px;" placeholder="回复内容" class="layui-textarea"><?=$reply_text?></textarea>
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
$('.pic').click(function(){
    //页面层
    layer.open({
        type: 1,
        title: '查看图片',
        area: ['100%', '100%'], //宽高
        content: '<div style="text-align:center"><img src="' + $(this).attr('src') + '" /></div>'
    });
});
</script>
</body>
</html>