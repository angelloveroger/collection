<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>设备统计</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style type="text/css">
.layui-table td, .layui-table th{
    text-align: center;
}
</style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>运营管理</a>
        <a><cite>APP广告变现</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                    <li data-type="index" class="layui-this">收益记录</li>
                    <li data-type="">广告配置</li>
                    <li data-type="info">用户信息</li>
                    <li data-type="settlement">结算记录</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show" style="max-width:800px;">
                    <?php if(!empty($ads['user_token'])){ ?>
                        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
                            <legend>收入概况</legend>
                        </fieldset>
                        <div class="layui-form">
                            <table class="layui-table">
                                <thead>
                                    <tr>
                                        <th>今日累计</th>
                                        <th>昨日</th>
                                        <th>过去七天</th>
                                        <th>本月</th>
                                        <th>余额</th>
                                    </tr> 
                                </thead>
                                <tbody>
                                    <tr id="count">
                                        <td>￥0</td>
                                        <td>￥0</td>
                                        <td>￥0</td>
                                        <td>￥0</td>
                                        <td>￥0</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
                            <legend>数据报表</legend>
                        </fieldset>
                        <div class="layui-form">
                            <table class="layui-table">
                                <thead>
                                    <tr>
                                        <th>日期</th>
                                        <th>APP包名</th>
                                        <th>浏览次数</th>
                                        <th>结算数</th>
                                        <th>媒体收益</th>
                                    </tr> 
                                </thead>
                                <tbody id="daylist">
                                    <tr>
                                        <td align="center" colspan="5">
                                            <div style="width:50px;height:50px;margin:0 auto;line-height: 50px;">
                                                <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:30px;"></i>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    <?php }else{ ?>
                        <div style="width:300px;height:100px;line-height:100px;">
                            <button style="margin: 0 auto;" type="button" class="ads-btn layui-btn layui-btn-normal layui-btn-fluid">一键开通</button>
                        </div>
                    <?php } ?>
                    </div>
                    <div class="layui-tab-item" style="max-width:800px;">
                    <?php if(!empty($ads['user_token'])){ ?>
                        <form class="layui-form" action="<?=links('ads/api/save')?>">
                            <div class="layui-card-body">
                                <div class="layui-text" style="max-width: 400px;padding-top: 25px;">
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">开屏广告:</label>
                                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                            <input type="radio" name="start" value="0" title="关闭"<?php if($ads['start']==0) echo ' checked';?>>
                                            <input type="radio" name="start" value="1" title="开启"<?php if($ads['start']==1) echo ' checked';?>>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">幻灯图广告:</label>
                                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                            <input type="radio" name="banner" value="0" title="关闭"<?php if($ads['banner']==0) echo ' checked';?>>
                                            <input type="radio" name="banner" value="1" title="开启"<?php if($ads['banner']==1) echo ' checked';?>>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">主页横幅数量:</label>
                                        <div class="layui-input-block">
                                            <input type="number" name="heng" placeholder="主页横幅广告数量，0为关闭" value="<?=$ads['heng']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">播放页横幅数量:</label>
                                        <div class="layui-input-block">
                                            <input type="number" name="playheng" placeholder="视频播放页横幅广告数量，0为关闭" value="<?=$ads['playheng']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">社区页横幅数量:</label>
                                        <div class="layui-input-block">
                                            <input type="number" name="bbs" placeholder="社区主页横幅广告数量，0为关闭" value="<?=$ads['bbs']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <label class="layui-form-label">播放前广告:</label>
                                        <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                            <input type="radio" name="player" value="0" title="关闭"<?php if($ads['player']==0) echo ' checked';?>>
                                            <input type="radio" name="player" value="1" title="开启"<?php if($ads['player']==1) echo ' checked';?>>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w120">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-filter="save" lay-submit>
                                                更新配置信息
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    <?php }else{ ?>
                        <div style="width:300px;height:100px;line-height:100px;">
                            <button style="margin: 0 auto;" type="button" class="ads-btn layui-btn layui-btn-normal layui-btn-fluid">一键开通</button>
                        </div>
                    <?php } ?>
                        <div style="margin-top: 15px"></div>
                    </div>
                    <div class="layui-tab-item" style="max-width:800px;">
                    <?php if(!empty($ads['user_token'])){ ?>
                        <form class="layui-form" action="<?=links('ads/api/infosave')?>">
                            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
                                <legend>用户信息</legend>
                            </fieldset>
                            <div class="layui-form-item">
                                <label class="layui-form-label">用户ID：</label>
                                <div class="layui-input-block" id="userid" style="line-height:36px;">0</div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">用户账号：</label>
                                <div class="layui-input-block" id="username" style="line-height:36px;">***</div>
                            </div>
                            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
                                <legend>结算信息</legend>
                            </fieldset>
                            <div class="layui-form-item">
                                <label class="layui-form-label">选择银行：</label>
                                <div class="layui-input-block">
                                    <select name="bank_account_type" id="bank">
                                        <option value=""></option>
                                  </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">开户地址：</label>
                                <div class="layui-input-block">
                                  <input type="text" id="bank_branch" name="bank_branch" lay-reqtext="请认真填写开户行地址" placeholder="请输入开户行地址" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">收款账号：</label>
                                <div class="layui-input-block">
                                  <input type="text" id="bank_account" lay-verify="required" name="bank_account" lay-reqtext="请认真填写账号" placeholder="请输入账号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">收款名称：</label>
                                <div class="layui-input-block">
                                  <input type="text" name="bank_name" id="bank_name" lay-verify="required" lay-reqtext="请认真填收款人真实姓名" placeholder="请输入收款人真实姓名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-btn-container">
                                <button type="submit" lay-submit lay-filter="save" class="layui-btn" style="margin-left: 100px;">保存</button>
                            </div>
                        </form>
                    <?php }else{ ?>
                        <div style="width:300px;height:100px;line-height:100px;">
                            <button style="margin: 0 auto;" type="button" class="ads-btn layui-btn layui-btn-normal layui-btn-fluid">一键开通</button>
                        </div>
                    <?php } ?>
                    </div>
                    <div class="layui-tab-item" style="max-width:800px;">
                    <?php if(!empty($ads['user_token'])){ ?>
                        <fieldset class="layui-elem-field layui-field-title" style="border-width: 0;">
                            <legend style="font-size: 16px;margin: 16px 0px 0px 20px;">
                                <span>总收入：<b id="zrmb" style="color:#1E9FFF">￥0</b></span>
                                <span style="padding-left:20px;">已提现：<b id="txrmb" style="color:#ea0000">￥0</b></span>
                                <span style="padding-left:20px;">余额：<b id="rmb" style="color:#080">￥0</b></span>
                                <p><br>结算方式：满500周结，每周一下午3点结算打款</p>
                                <p>如有疑问，请联系在线客服TG: <a href="https://t.me/yhcmsvip" target="_blank">yhcmsvip</a></p>
                            </legend>
                        </fieldset>
                        <div class="layui-form">
                            <table class="layui-table">
                                <thead>
                                    <tr>
                                        <th>结算日期</th>
                                        <th>结算单号</th>
                                        <th>结算金额</th>
                                        <th>结算状态</th>
                                    </tr> 
                                </thead>
                                <tbody id="paylist">
                                    <tr>
                                        <td align="center" colspan="5">
                                            <div style="width:50px;height:50px;margin:0 auto;line-height: 50px;">
                                                <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:30px;"></i>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    <?php }else{ ?>
                        <div style="width:300px;height:100px;line-height:100px;">
                            <button style="margin: 0 auto;" type="button" class="ads-btn layui-btn layui-btn-normal layui-btn-fluid">一键开通</button>
                        </div>
                    <?php } ?>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
<script type="text/javascript">
layui.use(['jquery','layer','form','element'],function() {
    var $ = layui.jquery,
        layer = layui.layer,
        form = layui.form,
        tindex = null;
    //保存资料
    form.on('submit(save)', function(data){
        var index = layer.load();
        $.post(data.form.action,data.field,function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.close(tindex);
                layer.msg(res.msg);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
        return false;
    });
    $('.ads-btn').click(function(){
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入API秘钥，秘钥在yhcms官网获取',
            area: ['500px', '200px']
        }, function(value, index, elem){
            var tindex = layer.load();
            $.post('<?=links('ads/api/open')?>',{user_token:value},function(res){
                layer.close(tindex);
                if(res.code == 1){
                    layer.close(index);
                    layer.msg('开通成功');
                    setTimeout(function(){
                        Admin.get_load();
                    },1000);
                }else{
                    layer.msg(res.msg,{shift:6});
                }
            },'json');
        });
        
    });
    if($('.ads-btn').length == 0){
        get_type('index');
    }
    $('.layui-tab-title li').click(function(){
        var type = $(this).data('type');
        if(type) get_type(type);
    });
    function get_type(type){
        $.get('<?=links('ads/api')?>/'+type,function(res){
            if(res.code == 1){
                if(type == 'index'){
                    $('#count td').eq(0).html('￥'+res.data.count.today);
                    $('#count td').eq(1).html('￥'+res.data.count.yesterday);
                    $('#count td').eq(2).html('￥'+res.data.count.sevendays);
                    $('#count td').eq(3).html('￥'+res.data.count.month);
                    $('#count td').eq(4).html('￥'+res.data.count.balance);
                    var html = '';
                    for (var i = 0; i < res.data.list.length; i++) {
                        html+='<tr><td>'+res.data.list[i].date+'</td><td>'+res.data.list[i].package+'</td><td>'+res.data.list[i].shits+'</td><td>'+res.data.list[i].click+'</td><td>￥'+res.data.list[i].rmb+'</td></tr>';
                    }
                    if(html == '') html = '<tr><td align="center" colspan="5">暂无数据~!</td></tr>';
                    $('#daylist').html(html);
                }else if(type == 'info'){
                    $('#userid').html(res.data.user.uid);
                    $('#username').html(res.data.user.name);
                    var html ='';
                    for (var i = 0; i < res.data.bank_account_type.length; i++) {
                        var cls = res.data.bank_account_type[i] == res.data.user.bank_account_type ? ' selected' : '';
                        html+='<option value="'+res.data.bank_account_type[i]+'"'+cls+'>'+res.data.bank_account_type[i]+'</option>';
                    }
                    $('#bank').html(html);
                    form.render('select');
                    $('#bank_branch').val(res.data.user.bank_branch);
                    $('#bank_account').val(res.data.user.bank_account);
                    $('#bank_name').val(res.data.user.bank_name);
                }else if(type == 'settlement'){
                    $('#zrmb').html('￥'+res.data.zrmb);
                    $('#txrmb').html('￥'+res.data.txrmb);
                    $('#rmb').html('￥'+res.data.rmb);
                    var html = '';
                    for (var i = 0; i < res.data.list.length; i++) {
                        html+='<tr><td>'+res.data.list[i].addtime+'</td><td>'+res.data.list[i].dd+'</td><td>￥'+res.data.list[i].rmb+'</td><td>'+res.data.list[i].pid+'</td></tr>';
                    }
                    if(html == '') html = '<tr><td align="center" colspan="4">暂无数据~!</td></tr>';
                    $('#paylist').html(html);
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    }
});
</script>
</body>
</html>