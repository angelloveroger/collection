<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>充值配置</title>
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
        <a><cite>财务配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/pay_save')?>">
            <div class="layui-card-body">
                <div class="layui-tab layui-tab-brief" lay-filter="setting">
                    <ul class="layui-tab-title">
                        <li class="layui-this">VIP套餐</li>
                        <li>金币套餐</li>
                        <li>兑换套餐</li>
                        <li>支付宝收款</li>
                        <li>微信收款</li>
                        <li>鑫支付收款</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">VIP套餐:</label>
                                    <div class="layui-input-block">
                                        <table class="layui-table" style="margin-bottom:20px;">
                                            <tbody id="vip-box">
                                                <tr>
                                                    <th>标题</th>
                                                    <td>价格（元）</td>
                                                    <td>天数</td>
                                                    <td class="vip-add" style="cursor: pointer;" title="增加一组"><i style="font-size:20px;" class="layui-icon layui-icon-add-1"></i></td>
                                                </tr>
                                                <?php
                                                $kk = 0;
                                                foreach($pay['vip'] as $kk=>$row){
                                                    echo '<tr id="vip-td-'.$kk.'"><td><input type="text" name="vip['.$kk.'][name]" placeholder="标题" value="'.$row['name'].'" class="layui-input"/></td><td><input type="text" name="vip['.$kk.'][rmb]" placeholder="价格" value="'.$row['rmb'].'" class="layui-input"/></td><td><input type="number" name="vip['.$kk.'][day]" placeholder="VIP天数" value="'.$row['day'].'" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'vip-td-'.$kk.'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
                                                }
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
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
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">金币换算:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="rmbtocion" placeholder="1元等于多少金币" value="<?=empty($pay['rmbtocion'])?1:$pay['rmbtocion']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">金币套餐:</label>
                                    <div class="layui-input-block">
                                        <table class="layui-table" style="margin-bottom:20px;">
                                            <tbody id="cion-box">
                                                <tr>
                                                    <td>价格（元）</td>
                                                    <td>金币数量</td>
                                                    <td class="cion-add" style="cursor: pointer;" title="增加一组"><i style="font-size:20px;" class="layui-icon layui-icon-add-1"></i></td>
                                                </tr>
                                                <?php
                                                $kk1 = 0;
                                                if(!isset($pay['cion'])) $pay['cion'] = array();
                                                foreach($pay['cion'] as $kk1=>$row){
                                                    echo '<tr id="cion-td-'.$kk1.'"><td><input type="text" name="cion['.$kk1.'][rmb]" placeholder="价格" value="'.$row['rmb'].'" class="layui-input"/></td><td><input type="number" name="cion['.$kk1.'][cion]" placeholder="金币数量" value="'.$row['cion'].'" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'cion-td-'.$kk1.'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
                                                }
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
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
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">兑换套餐:</label>
                                    <div class="layui-input-block">
                                        <table class="layui-table" style="margin-bottom:20px;">
                                            <tbody id="exchange-box">
                                                <tr>
                                                    <th>标题</th>
                                                    <td>需要金币</td>
                                                    <td>VIP天数</td>
                                                    <td class="exchange-add" style="cursor: pointer;" title="增加一组"><i style="font-size:20px;" class="layui-icon layui-icon-add-1"></i></td>
                                                </tr>
                                                <?php
                                                $kk2 = 0;
                                                foreach($pay['exchange'] as $kk2=>$row){
                                                    echo '<tr id="exchange-td-'.$kk2.'"><td><input type="text" name="exchange['.$kk2.'][name]" placeholder="标题" value="'.$row['name'].'" class="layui-input"/></td><td><input type="number" name="exchange['.$kk2.'][cion]" placeholder="金币数量" value="'.$row['cion'].'" class="layui-input"/></td><td><input type="number" name="exchange['.$kk2.'][day]" placeholder="VIP天数" value="'.$row['day'].'" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'exchange-td-'.$kk2.'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
                                                }
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
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
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">支付宝收款:</label>
                                    <div class="layui-input-block">
                                        <input lay-filter="open" type="radio" name="alipay[open]" value="1" title="开启"<?php if($pay['alipay']['open'] == 1) echo ' checked';?>>
                                        <input lay-filter="open" type="radio" name="alipay[open]" value="0" title="关闭"<?php if($pay['alipay']['open'] == 0) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">支付宝应用ID:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="alipay[appid]" placeholder="支付宝应用ID，APPID" value="<?=$pay['alipay']['appid']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">支付宝公钥:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:150px;" name="alipay[pubkey]" placeholder="支付宝公钥" class="layui-textarea"><?=$pay['alipay']['pubkey']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">商户应用私钥:</label>
                                    <div class="layui-input-block">
                                        <textarea style="min-height:150px;" name="alipay[prikey]" placeholder="商户应用私钥" class="layui-textarea"><?=$pay['alipay']['prikey']?></textarea>
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
                                    1.支付宝支付申请地址：<a href="https://open.alipay.com/" target="_blank">https://open.alipay.com/</a><br>
                                    2.支付宝支付需要申请手机网站收款支付接口
                                </blockquote>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">微信收款:</label>
                                    <div class="layui-input-block">
                                        <input lay-filter="open" type="radio" name="wxpay[open]" value="1" title="开启"<?php if($pay['wxpay']['open'] == 1) echo ' checked';?>>
                                        <input lay-filter="open" type="radio" name="wxpay[open]" value="0" title="关闭"<?php if($pay['wxpay']['open'] == 0) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">微信应用ID:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxpay[appid]" placeholder="微信应用APPID" value="<?=$pay['wxpay']['appid']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">微信应用Secret:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxpay[appkey]" placeholder="微信应用AppSecret，公众号支付必填" value="<?=$pay['wxpay']['appkey']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">微信商户ID:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxpay[mchid]" placeholder="微信支付商户ID" value="<?=$pay['wxpay']['mchid']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">微信商户密钥:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxpay[mchkey]" placeholder="微信支付商户密钥" value="<?=$pay['wxpay']['mchkey']?>" class="layui-input"/>
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
                                    1.微信支付申请地址：<a href="http://pay.weixin.qq.com/" target="_blank">http://pay.weixin.qq.com/</a><br>
                                    2.微信支付需要申请H5接口和JSAPI支付接口
                                </blockquote>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">鑫支付收款:</label>
                                    <div class="layui-input-block">
                                        <input lay-filter="open" type="radio" name="xzfpay[open]" value="1" title="开启"<?php if($pay['xzfpay']['open'] == 1) echo ' checked';?>>
                                        <input lay-filter="open" type="radio" name="xzfpay[open]" value="0" title="关闭"<?php if($pay['xzfpay']['open'] == 0) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">鑫支付APPID:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="xzfpay[appid]" placeholder="鑫支付商户号" value="<?=$pay['xzfpay']['appid']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">鑫支付密钥:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="xzfpay[appkey]" placeholder="鑫支付商户密钥" value="<?=$pay['xzfpay']['appkey']?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">鑫支付API地址:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="xzfpay[appurl]" placeholder="鑫支付API请求地址" value="<?=$pay['xzfpay']['appurl']?>" class="layui-input"/>
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
                                    1.鑫支付申请地址：<a href="http://xzf.la/" target="_blank">http://xzf.la/</a><br>
                                    2.开启鑫支付后默认则使用鑫支付收款
                                </blockquote>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
var vip_k = <?=$kk?>,cion_k = <?=$kk1?>,exchange_k = <?=$kk2?>;
layui.use(['layer','form'], function () {
    var layer = layui.layer.
    form = layui.form;
    $('.vip-add').click(function(){
        vip_k++;
        var html = '<tr id="vip-td-'+vip_k+'"><td><input type="text" name="vip['+vip_k+'][name]" placeholder="标题" value="" class="layui-input"/></td><td><input type="text" name="vip['+vip_k+'][rmb]" placeholder="价格" value="" class="layui-input"/></td><td><input type="number" name="vip['+vip_k+'][day]" placeholder="VIP天数" value="" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'vip-td-'+vip_k+'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
        $('#vip-box').append(html);
    });
    $('.cion-add').click(function(){
        cion_k++;
        var html = '<tr id="cion-td-'+cion_k+'"><td><input type="text" name="cion['+cion_k+'][rmb]" placeholder="价格" value="" class="layui-input"/></td><td><input type="number" name="cion['+cion_k+'][cion]" placeholder="金币数量" value="" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'cion-td-'+cion_k+'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
        $('#cion-box').append(html);
    });
    $('.exchange-add').click(function(){
        exchange_k++;
        var html = '<tr id="exchange-td-'+exchange_k+'"><td><input type="text" name="exchange['+exchange_k+'][name]" placeholder="标题" value="" class="layui-input"/></td><td><input type="number" name="exchange['+exchange_k+'][cion]" placeholder="金币数量" value="" class="layui-input"/></td><td><input type="number" name="exchange['+exchange_k+'][day]" placeholder="VIP天数" value="" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'exchange-td-'+exchange_k+'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
        $('#exchange-box').append(html);
    });
});
function get_del(_id){
    $('#'+_id).remove();
}
</script>
</body>
</html>