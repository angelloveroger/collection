<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网站配置</title>
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
        <a><cite>基础配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/save')?>">
            <div class="layui-card-body">
                <div class="layui-tab layui-tab-brief" lay-filter="setting">
                    <ul class="layui-tab-title">
                        <li class="layui-this">基础配置</li>
                        <li>试看配置</li>
                        <li>评论配置</li>
                        <li>分享配置</li>
                        <li>用户相关</li>
                        <li>签到配置</li>
                        <li>短信配置</li>
                        <li>联系方式</li>
                        <li>举报/反馈类型</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">网站名称:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="name" placeholder="网站名称" value="<?=$sys['name']?>" class="layui-input" lay-verify="required" required/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">H5支付域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="payurl" placeholder="H5支付域名，留空则使用网站域名" value="<?=$sys['payurl']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">后台认证码:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="admin_code" placeholder="后台登录认证码" value="<?=$sys['admin_code']?>" class="layui-input" lay-verify="required" required/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">视频解析地址:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="jxurl" placeholder="视频解析地址" value="<?=$sys['jxurl']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">官采解析秘钥:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="jxtoken" placeholder="官采解析秘钥，获取地址：vipm3u8.com" value="<?=$sys['jxtoken']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">滚动公告:</label>
                                    <div class="layui-input-block">
                                        <textarea name="notice" placeholder="滚动公告" class="layui-textarea"><?=$sys['notice']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">弹窗公告:</label>
                                    <div class="layui-input-block">
                                        <textarea name="notice2" placeholder="弹窗公告" class="layui-textarea"><?=$sys['notice2']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">视频地区:</label>
                                    <div class="layui-input-block">
                                        <textarea name="area" placeholder="视频地区，多个用 | 分割" class="layui-textarea"><?=implode('|',$sys['area'])?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">视频语言:</label>
                                    <div class="layui-input-block">
                                        <textarea name="lang" placeholder="视频语言，多个用 | 分割" class="layui-textarea"><?=implode('|',$sys['lang'])?></textarea>
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
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">试看开关:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" lay-filter="proved" name="proved[init]" value="0" title="关闭"<?php if($sys['proved']['init']==0) echo ' checked';?>>
                                        <input type="radio" lay-filter="proved" name="proved[init]" value="1" title="按时长"<?php if($sys['proved']['init']==1) echo ' checked';?>>
                                        <input type="radio" lay-filter="proved" name="proved[init]" value="2" title="按部数"<?php if($sys['proved']['init']==2) echo ' checked';?>>
                                    </div>
                                </div>
                                <div id="proved1" class="layui-form-item w120"<?php if($sys['proved']['init'] != 1) echo ' style="display:none;"';?>>
                                    <label class="layui-form-label">试看时长:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="proved[time]" placeholder="每部影片试看时长，单位秒" value="<?=$sys['proved']['time']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div id="proved2" class="layui-form-item w120"<?php if($sys['proved']['init'] != 2) echo ' style="display:none;"';?>>
                                    <label class="layui-form-label">试看数量:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="proved[nums]" placeholder="每人每天可以免费观看多少部影视" value="<?=$sys['proved']['nums']?>" class="layui-input"/>
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
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">评论审核开关:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" name="comment[audit]" value="0" title="关闭"<?php if($sys['comment']['audit']==0) echo ' checked';?>>
                                        <input type="radio" name="comment[audit]" value="1" title="开启"<?php if($sys['comment']['audit']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">每天数量上限:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="comment[day_num]" placeholder="每人每天允许发布评论数量" value="<?=$sys['comment']['day_num']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">关键词过滤:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:100px;" name="comment[ban_txt]" placeholder="评论关键词过滤，多个用 | 开分割" class="layui-textarea"><?=$sys['comment']['ban_txt']?></textarea>
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
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">分享防封域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="ffurl" placeholder="分享防封域名，该域名不要填写到分享域名池里面，留空则为网站地址" value="<?=$sys['ffurl']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">分享域名池:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:100px;" name="shareurl" placeholder="分享域名池，也就是落地页域名，一行一个，留空则使用网站域名，*代表随机字符" class="layui-textarea"><?=implode("\n",$sys['shareurl'])?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">QQ微信提示:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" name="sharewxqq" value="0" title="关闭"<?php if($sys['sharewxqq']==0) echo ' checked';?>>
                                        <input type="radio" name="sharewxqq" value="1" title="开启"<?php if($sys['sharewxqq']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">分享文本:</label>
                                    <div class="layui-input-block">
                                        <textarea name="sharetxt" placeholder="分享文本内容" class="layui-textarea"><?=$sys['sharetxt']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">邀请规则:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:150px;" name="sharerules" placeholder="邀请规则" class="layui-textarea"><?=$sys['sharerules']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">分享图片文案:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="share_pngtxt" placeholder="分享二维码图片文案，最多15个字" value="<?=isset($sys['share_pngtxt'])?$sys['share_pngtxt']:'邀请你的好友一起来看电影吧'?>" class="layui-input"/>
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
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">APP代理显示:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" name="user[agent]" value="0" title="关闭"<?php if($sys['user']['agent']==0) echo ' checked';?>>
                                        <input type="radio" name="user[agent]" value="1" title="开启"<?php if(!isset($sys['user']['agent']) || $sys['user']['agent']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">注册短信验证:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" name="user[reg_code]" value="0" title="关闭"<?php if($sys['user']['reg_code']==0) echo ' checked';?>>
                                        <input type="radio" name="user[reg_code]" value="1" title="开启"<?php if(!isset($sys['user']['reg_code']) || $sys['user']['reg_code']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">新用户赠送金币:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="user[reg_cion]" placeholder="新用户赠送金币数量，0为不赠送" value="<?=$sys['user']['reg_cion']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">新用户赠送VIP:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="user[reg_vip]" placeholder="新用户赠送VIP天数，0为不赠送" value="<?=$sys['user']['reg_vip']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">邀请赠送VIP:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="user[share_vip]" placeholder="每邀请1人，赠送VIP天数" value="<?=$sys['user']['share_vip']?>" class="layui-input"/>
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
                            <div class="layui-text" style="max-width: 500px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">签到福利机制:</label>
                                    <div class="layui-input-block">
                                        <table class="layui-table">
                                            <tbody>
                                                <tr>
                                                    <th style="text-align:center;">连续签到天数</th>
                                                    <td style="text-align:center;">赠送金币数量</td>
                                                </tr>
                                                <?php
                                                foreach($sys['signin'] as $k=>$cion){
                                                    echo '<tr><td><input style="text-align:center;cursor: no-drop;" type="text" name="qd" placeholder="连续签到天数" value="'.($k+1).'天" class="layui-input" disabled/></td><td><input style="text-align:center;" type="text" name="signin[]" placeholder="赠送金币数量" value="'.$cion.'" class="layui-input"/></td></tr>';
                                                }
                                                ?>
                                            </tbody>
                                        </table>
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
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">短信服务商:</label>
                                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                        <input type="radio" lay-filter="sms" name="sms[type]" value="vaptcha" title="Vaptcha"<?php if($sys['sms']['type']=='vaptcha') echo ' checked';?>>
                                        <input type="radio" lay-filter="sms" name="sms[type]" value="aliyun" title="阿里云短信"<?php if($sys['sms']['type']=='aliyun') echo ' checked';?>>
                                        <input type="radio" lay-filter="sms" name="sms[type]" value="tencent" title="腾讯云短信"<?php if($sys['sms']['type']=='tencent') echo ' checked';?>>
                                    </div>
                                </div>
                                <div id="vaptcha"<?php if($sys['sms']['type'] != 'vaptcha') echo ' style="display:none;"';?>>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">SMSID:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[vaptcha][appid]" placeholder="SMSID" value="<?=$sys['sms']['vaptcha']['appid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">SMSKEY:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[vaptcha][appkey]" placeholder="SMSKEY" value="<?=$sys['sms']['vaptcha']['appkey']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">模版ID:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[vaptcha][tplid]" placeholder="模板ID需要在服务商短信控制台中申请" value="<?=$sys['sms']['vaptcha']['tplid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                                <div id="aliyun"<?php if($sys['sms']['type'] != 'aliyun') echo ' style="display:none;"';?>>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">阿里云AppKey:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[aliyun][appid]" placeholder="阿里云AppKey" value="<?=$sys['sms']['aliyun']['appid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">阿里云AppSecret:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[aliyun][appkey]" placeholder="阿里云AppSecret" value="<?=$sys['sms']['aliyun']['appkey']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">短信签名:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[aliyun][sign]" placeholder="阿里云短信签名，如：视频APP" value="<?=$sys['sms']['aliyun']['sign']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">模版ID:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[aliyun][tplid]" placeholder="模板ID需要在服务商短信控制台中申请" value="<?=$sys['sms']['aliyun']['tplid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                                <div id="tencent"<?php if($sys['sms']['type'] != 'tencent') echo ' style="display:none;"';?>>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">腾讯云AppKey:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[tencent][appid]" placeholder="腾讯云AppKey" value="<?=$sys['sms']['tencent']['appid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">腾讯云AppSecret:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[tencent][appkey]" placeholder="腾讯云AppSecret" value="<?=$sys['sms']['tencent']['appkey']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">短信签名:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[tencent][sign]" placeholder="腾讯云短信签名，如：视频APP" value="<?=$sys['sms']['tencent']['sign']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item w150">
                                        <label class="layui-form-label layui-form-required">模版ID:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="sms[tencent][tplid]" placeholder="模板ID需要在服务商短信控制台中申请" value="<?=$sys['sms']['tencent']['tplid']?>" class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-left:180px;">
                                    提示信息：<br>
                                    请务必按照短信接口服务商的要求做好短信签名和短信内容的设置。<br>
                                    Vaptcha短信申请地址：<a href="https://user.vaptcha.com/sms" target="_blank">https://user.vaptcha.com/sms</a><br>
                                    腾讯云短信申请地址：<a href="https://cloud.tencent.com/product/sms" target="_blank">https://cloud.tencent.com/product/sms</a><br>
                                    阿里云短信申请地址：<a href="https://www.aliyun.com/product/sms" target="_blank">https://www.aliyun.com/product/sms</a>
                                </blockquote>
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
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">客服QQ:</label>
                                    <div class="layui-input-block">
                                        <input type="number" name="qq" placeholder="客服QQ" value="<?=$sys['qq']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">客服邮箱:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="email" placeholder="客服邮箱" value="<?=$sys['email']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">客服电报:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="telegram" placeholder="客服电报（飞机）" value="<?=$sys['telegram']?>" class="layui-input"/>
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
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">举报类型:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:120px;" name="report" placeholder="举报类型，多个用 | 分割" class="layui-textarea"><?=implode('|',$sys['report'])?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">反馈类型:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:120px;" name="feedback" placeholder="反馈类型，多个用 | 分割" class="layui-textarea"><?=implode('|',$sys['feedback'])?></textarea>
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
    form.on('radio(sms)', function (d) {
        if(d.value == 'aliyun'){
            $('#vaptcha').hide();
            $('#tencent').hide();
            $('#aliyun').show();
        }else if(d.value == 'tencent'){
            $('#tencent').show();
            $('#vaptcha').hide();
            $('#aliyun').hide();
        }else{
            $('#tencent').hide();
            $('#vaptcha').show();
            $('#aliyun').hide();
        }
    });
    form.on('radio(proved)', function (d) {
        if(d.value == 2){
            $('#proved1').hide();
            $('#proved2').show();
        }else if(d.value == 1){
            $('#proved1').show();
            $('#proved2').hide();
        }else{
            $('#proved1').hide();
            $('#proved2').hide();
        }
    });
});
</script>
</body>
</html>