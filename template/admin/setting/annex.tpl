<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>附件配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>系统配置</a>
        <a><cite>附件配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/annex_save')?>">
            <div class="layui-card-body">
                <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">图片存储方式:</label>
                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                            <input lay-filter="type" type="radio" name="type" value="sys" title="站内"<?php if($annex['type']=='sys') echo ' checked';?>>
                            <input lay-filter="type" type="radio" name="type" value="oss" title="阿里云OSS"<?php if($annex['type']=='oss') echo ' checked';?>>
                            <input lay-filter="type" type="radio" name="type" value="ftp" title="FTP服务器"<?php if($annex['type']=='ftp') echo ' checked';?>>
                        </div>
                    </div>
                    <div id="sys"<?php if($annex['type'] != 'sys') echo ' style="display: none;"';?>>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">图片访问前缀:</label>
                            <div class="layui-input-block">
                                <input type="text" name="picurl" placeholder="图片访问地址，如：http://cdn.xxx.com，留空则使用网站地址" value="<?=$annex['picurl']?>" class="layui-input"/>
                            </div>
                        </div>
                    </div>
                    <div id="oss"<?php if($annex['type'] != 'oss') echo ' style="display: none;"';?>>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">Access_ID:</label>
                            <div class="layui-input-block">
                                <input type="text" name="oss[access_id]" placeholder="阿里云Access_ID" value="<?=$annex['oss']['access_id']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">Access_Key:</label>
                            <div class="layui-input-block">
                                <input type="text" name="oss[access_key]" placeholder="阿里云Access_Key" value="<?=$annex['oss']['access_key']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">end_point:</label>
                            <div class="layui-input-block">
                                <input type="text" name="oss[end_point]" placeholder="end_point" value="<?=$annex['oss']['end_point']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">bucket:</label>
                            <div class="layui-input-block">
                                <input type="text" name="oss[bucket]" placeholder="bucket" value="<?=$annex['oss']['bucket']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">图片访问前缀:</label>
                            <div class="layui-input-block">
                                <input type="text" name="oss[picurl]" placeholder="图片访问前缀地址，如：http://img.cdn.xxx.com" value="<?=$annex['oss']['picurl']?>" class="layui-input"/>
                            </div>
                        </div>
                    </div>
                    <div id="ftp"<?php if($annex['type'] != 'ftp') echo ' style="display: none;"';?>>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">FTP主机:</label>
                            <div class="layui-input-block">
                                <input type="text" name="ftp[hostname]" placeholder="FTP主机IP" value="<?=$annex['ftp']['hostname']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">FTP端口:</label>
                            <div class="layui-input-block">
                                <input type="text" name="ftp[port]" placeholder="FTP端口：一般为21" value="<?=$annex['ftp']['port']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">FTP账号:</label>
                            <div class="layui-input-block">
                                <input type="text" name="ftp[username]" placeholder="FTP账号" value="<?=$annex['ftp']['username']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">FTP密码:</label>
                            <div class="layui-input-block">
                                <input type="text" name="ftp[password]" placeholder="FTP密码" value="<?=$annex['ftp']['password']?>" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">被动模式:</label>
                            <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                <input type="radio" name="ftp[passive]" value="0" title="关闭"<?php if($annex['ftp']['passive']==0) echo ' checked';?>>
                                <input type="radio" name="ftp[passive]" value="1" title="开启"<?php if($annex['ftp']['passive']==1) echo ' checked';?>>
                            </div>
                        </div>
                        <div class="layui-form-item w120">
                            <label class="layui-form-label">链接前缀地址:</label>
                            <div class="layui-input-block">
                                <input type="text" name="ftp[picurl]" placeholder="链接前缀地址，如：http://img.cdn.xxx.com" value="<?=$annex['ftp']['picurl']?>" class="layui-input"/>
                            </div>
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
    form.on('radio(type)', function (r) {
        if(r.value == 'oss'){
            $('#sys').hide();
            $('#oss').show();
            $('#ftp').hide();
        }else if(r.value == 'ftp'){
            $('#sys').hide();
            $('#oss').hide();
            $('#ftp').show();
        }else{
            $('#sys').show();
            $('#oss').hide();
            $('#ftp').hide();
        }
    });
});
</script>
</body>
</html>