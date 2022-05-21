<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title><?=$title?></title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0"/>
        <link rel="stylesheet" type="text/css" href="/packs/images/agent/style.css"/>
    </head>
    <body>
        <div class="container">
            <div class="poster">
                <p>- 加入代理月入过万 -</p>
                <a href="<?=links('agent')?>"><div class="button">我的收益</div></a>
            </div>
            <div class="modular">
                <div class="gd-30">
                    <p class="dot" style="float: left;"></p>
                    <h4>操作简单，无限极返利，最高比例90%</h4>
                </div>
                <p class="describe">在代理后台中，<span>获取到推广链接</span>，<span>「复制推广链接」</span>分享给好友。推广好友注册登录后，代理商即可在代理后台查看到推广成功的所有用户，以及充值记录等信息。获得收益都可以在代理后台只看并提现.</p>
                <div class="exhibition" style="margin-top:10px;padding-bottom:6px;">
                    <img src="/packs/images/agent/purse.png" style="float: left;">
                    <h4>收益来源：</h4>
                    <span>直接收益</span>
                </div>
            </div>
            <div class="modular">
                <div class="gd-30">
                    <p class="dot" style="float: left;"></p>
                    <h4>直接收益</h4>
                </div>
                <p class="describe">您直接推广的所有用户产生的交易，您都将获得直推收益。</p>
            </div>
            <div class="modular" style="border-bottom:0;padding-bottom:30px;">
                <div class="gd-30">
                    <p class="dot" style="float: left;"></p>
                    <h4>联系我们</h4>
                </div>
                <div  class="exhibition">
                    <img src="/packs/images/agent/qq.png" style="float: left;">
                    <p>客服QQ：<span><?=$this->myconfig['qq']?></span></p>
                </div>
                <div  class="exhibition">
                    <img src="/packs/images/agent/tg.png" style="float: left;">
                    <p>客服TG：<span><?=$this->myconfig['telegram']?></span></p>
                </div>
                <div class="exhibition">
                    <img src="/packs/images/agent/gamil.png" style="float: left;">
                    <p>客服邮箱：<span><?=$this->myconfig['email']?></span></p>
                </div>
            </div>
        </div>
    </body>
</html>