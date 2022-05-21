<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>公众号配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <style type="text/css">
    .layui-table tr,.layui-table td,.layui-table td input{text-align: center;}
    </style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>系统配置</a>
        <a><cite>公众号配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/mp_save')?>">
            <div class="layui-card-body">
                <div class="layui-tab layui-tab-brief" lay-filter="setting">
                    <ul class="layui-tab-title">
                        <li class="layui-this">基础配置</li>
                        <li>回复文本</li>
                        <li>关键字回复</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">对接状态:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="open" value="1" title="开启"<?php if($mp['open'] == 1) echo ' checked';?>>
                                        <input type="radio" name="open" value="0" title="关闭"<?php if($mp['open'] == 0) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">访问域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="url" placeholder="访问域名，绑定到主域名一起即可，留空则用主域名" value="<?=$mp['url']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">令牌(Token):</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="token" placeholder="令牌(Token)，必须和公众号后台填写的一致" value="<?=$mp['token']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">返回页面:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="url_type" value="1" title="详情页"<?php if($mp['url_type'] == 1) echo ' checked';?>>
                                        <input type="radio" name="url_type" value="2" title="播放页"<?php if($mp['url_type'] == 2) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">返回类型:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="msg_type" value="1" title="文字类型"<?php if($mp['msg_type'] == 1) echo ' checked';?>>
                                        <input type="radio" name="msg_type" value="2" title="图文类型"<?php if($mp['msg_type'] == 2) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-filter="*" lay-submit>
                                            更新配置信息
                                        </button>
                                    </div>
                                </div>
                                <blockquote class="layui-elem-quote layui-quote-nm">
                                    提示信息：<br>
                                    令牌(Token)获取方式：登录微信公众平台-->设置与开发-->基本配置-->服务器配置，点击开启<br>
                                    服务器地址(URL)：http://<?=WEBURL?>/index.php/wxmp
                                </blockquote>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">关注回复内容:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:100px;" name="focus_msg" placeholder="用户关注后回复的文本内容" class="layui-textarea"><?=$mp['focus_msg']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">没有资源内容:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:100px;" name="empty_msg" placeholder="用户搜索未找到资源，回复的文本内容" class="layui-textarea"><?=$mp['empty_msg']?></textarea>
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
                        <div class="layui-tab-item">
                            <div class="layui-text">
                                <div class="layui-form-item">
                                    <table class="layui-table" style="margin-bottom:20px;">
                                        <tbody id="vip-box">
                                            <tr>
                                                <td>关键字</td>
                                                <td>标题</td>
                                                <td>图片地址</td>
                                                <td>链接地址</td>
                                                <td class="vip-add" style="cursor: pointer;" title="增加一个"><i style="font-size:20px;" class="layui-icon layui-icon-add-1"></i></td>
                                            </tr>
                                            <?php
                                            $kk = 0;
                                            foreach($mp['msg_key'] as $kk=>$row){
                                                echo '<tr id="vip-td-'.$kk.'"><td><input type="text" name="msg_key['.$kk.'][key]" placeholder="关键字" value="'.$row['key'].'" class="layui-input"/></td><td><input type="text" name="msg_key['.$kk.'][name]" placeholder="回复标题" value="'.$row['name'].'" class="layui-input"/></td><td><input type="text" name="msg_key['.$kk.'][pic]" placeholder="回复图片地址" value="'.$row['pic'].'" class="layui-input"/></td><td><input type="text" name="msg_key['.$kk.'][url]" placeholder="回复链接地址" value="'.$row['url'].'" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'vip-td-'.$kk.'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
                                            }
                                            ?>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-filter="*" lay-submit>
                                            更新配置信息
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
var vip_k = <?=$kk?>;
layui.use(['layer','form'], function () {
    var layer = layui.layer.
    form = layui.form;
    $('.vip-add').click(function(){
        vip_k++;
        var html = '<tr id="vip-td-'+vip_k+'"><td><input type="text" name="msg_key['+vip_k+'][key]" placeholder="关键字" class="layui-input"/></td><td><input type="text" name="msg_key['+vip_k+'][name]" placeholder="回复标题" class="layui-input"/></td><td><input type="text" name="msg_key['+vip_k+'][pic]" placeholder="回复图片地址" class="layui-input"/></td><td><input type="text" name="msg_key['+vip_k+'][url]" placeholder="回复链接地址" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'vip-td-'+vip_k+'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
        $('#vip-box').append(html);
    });
});
function get_del(_id){
    $('#'+_id).remove();
}
</script>
</body>
</html>