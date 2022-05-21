<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>帖子修改</title>
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
.layui-ji-box{border: 1px solid #e6e6e6;height: 150px;overflow-y: auto;text-align: center;}
.layui-ji-box .layui-input{text-align: center;margin-left: 0px;padding-left:0;}
.name{height: 30px;line-height: 30px;text-align: center;background: #f1f1f1;border: 1px solid #e0e0e0;}
.zu-box:first-child .layui-zu,.zu-box:nth-child(2) .layui-zu{margin-top: -35px;}
.mglt5{margin-left:10px!important;margin-top:5px!important;}
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
    .name{display: none;}
    .layui-ji-box .layui-input{padding:0 10px;}
    .zu-box .layui-zu{margin-top: 10px;}
    .zu-box:first-child .layui-zu{margin-top: -35px;}
}
</style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('bbs/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md8">
                <label class="layui-form-label">帖子分类</label>
                <div class="layui-input-block">
                    <select name="cid" required lay-verify="required">
                        <option value="">选择分类</option>
                    <?php
                    foreach($class as $row){
                        $sel = $row['id'] == $cid ? ' selected' : '';
                        echo '<option value="'.$row['id'].'"'.$sel.'>'.$row['name'].'</option>';
                    }
                    ?>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">浏览人气</label>
                <div class="layui-input-block">
                    <input type="number" name="hits" class="layui-input" value="<?=$hits?>" placeholder="请输入浏览人气">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md8">
                <label class="layui-form-label">帖子标题</label>
                <div class="layui-input-block" id="vodlist">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入帖子标题">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">点赞数量</label>
                <div class="layui-input-block">
                    <input type="number" name="zan" class="layui-input" value="<?=$zan?>" placeholder="请输入点赞数量">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">是否置顶</label>
                <div class="layui-input-block">
                    <select name="ding">
                        <option value="0">否</option>
                        <option value="1"<?php if($reco == 1) echo 'selected';?>>是</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">是否推荐</label>
                <div class="layui-input-block">
                    <select name="reco">
                        <option value="0">否</option>
                        <option value="1"<?php if($reco == 1) echo 'selected';?>>是</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">是否审核</label>
                <div class="layui-input-block">
                    <select name="yid">
                        <option value="1">否</option>
                        <option value="0"<?php if($yid == 0) echo 'selected';?>>是</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">用户ID</label>
                <div class="layui-input-block">
                    <input type="number" name="uid" class="layui-input" value="<?=$uid?>" placeholder="请输入用户ID">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">帖子内容</label>
            <div class="layui-input-block">
                <textarea id="text" name="text" placeholder="帖子内容" class="layui-textarea" style="min-height:150px;"><?=$text?></textarea>
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

</script>
</body>
</html>