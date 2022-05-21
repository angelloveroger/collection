<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>社区配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <script src="/packs/admin/js/md5.js"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>社区管理</a>
        <a><cite>社区配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('bbs/setting_save')?>">
            <div class="layui-card-body">
                <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">社区发帖权限:</label>
                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                            <input lay-filter="open" type="radio" name="open" value="0" title="关闭"<?php if($bbs['open']==0) echo ' checked';?>>
                            <input lay-filter="open" type="radio" name="open" value="1" title="指定用户"<?php if($bbs['open']==1) echo ' checked';?>>
                            <input lay-filter="open" type="radio" name="open" value="2" title="所有用户"<?php if($bbs['open']==2) echo ' checked';?>>
                        </div>
                    </div>
                    <div class="layui-form-item w120" id="open"<?php if($bbs['open'] !=1 ) echo ' style="display:none;"';?>>
                        <label class="layui-form-label">发帖指定用户:</label>
                        <div class="layui-input-block">
                            <textarea style="min-height:100px;" name="uids" placeholder="发帖指定用户id，多个用 | 开分割，如：8|25|65" class="layui-textarea"><?=implode('|',$bbs['uids'])?></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">发帖审核开关:</label>
                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                            <input type="radio" name="audit" value="0" title="关闭"<?php if($bbs['audit']==0) echo ' checked';?>>
                            <input type="radio" name="audit" value="1" title="开启"<?php if($bbs['audit']==1) echo ' checked';?>>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">每天数量上限:</label>
                        <div class="layui-input-block">
                            <input type="number" name="daynum" placeholder="每人每天允许发帖数量" value="<?=$bbs['daynum']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">发帖奖励金币:</label>
                        <div class="layui-input-block">
                            <input type="number" name="cion" placeholder="每发一篇帖子奖励的金币数量" value="<?=$bbs['cion']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">官方小编ID:</label>
                        <div class="layui-input-block">
                            <input type="number" name="admin" placeholder="官方小编ID" value="<?=$bbs['admin']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-filter="*" lay-submit>
                                更新配置信息
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
layui.use(['form'], function () {
    var form = layui.form;
    //监听
    form.on('radio(open)', function (d) {
        if(d.value == 1){
            $('#open').show();
        }else{
            $('#open').hide();
        }
    });
});
</script>
</body>
</html>