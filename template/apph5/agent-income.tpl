<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title><?=$title?></title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0"/>
        <link rel="stylesheet" type="text/css" href="/packs/images/agent/style.css"/>
    </head>
    <body style="padding:0 10px;">
    <div class="container">
        <div class="user_box">
            <div class="center">
                <div class="user_name">
                    <h5>代理账号：<?=get_sub($agent['name'])?></h5>
                </div>
            </div>
        </div>
        <div class="plate">
            <div class="title">
                <p></p>
                <h4>推广收益</h4>
            </div>
            <div class="center_box" style="height: 130px">
                <div class="frame_1">
                    <div class="list">
                        <h4>9.00</h4>
                        <p>昨日收益（元）</p>
                    </div>
                    <div class="list">
                        <h4>50.00</h4>
                        <p>今日收益（元）</p>
                    </div>
                    <div class="list">
                        <h4>100.00</h4>
                        <p>总收益（元）</p>
                    </div>
                </div>
                <div>
                    <a href="<?=links('agent')?>"><div class="button">提现</div></a>
                </div>
            </div>
        </div>
        <div class="plate">
            <div class="title">
                <p></p>
                <h4>推广数据</h4>
            </div>
            <div class="center_box" style="height: 130px">
                <div class="frame_1 w25">
                    <div class="list">
                        <h4><?=get_wan($pc_num)?></h4>
                        <p>PC用户</p>
                    </div>
                    <div class="list">
                        <h4><?=get_wan($h5_num)?></h4>
                        <p>H5用户</p>
                    </div>
                    <div class="list">
                        <h4>5<?=get_wan($android_num)?>0</h4>
                        <p>安卓用户</p>
                    </div>
                    <div class="list">
                        <h4><?=get_wan($ios_num)?></h4>
                        <p>IOS用户</p>
                    </div>
                </div>
                <div>
                    <a href="<?=links('agent')?>"><div class="button">推广记录</div></a>
                </div>
            </div>
        </div>
        <div class="block">
            <div class="title">
                <p></p>
                <h4>代理优势</h4>
            </div>
            <div class="center_box" style="height: 220px;">
                <div style="height: 210px;">
                    <div class="list">
                        <img src="/packs/images/agent/agent_prefor_advan_1.png">
                        <p>免费加盟</p>
                    </div>
                    <div class="list">
                        <img src="/packs/images/agent/agent_prefor_advan_2.png">
                        <p>傻瓜式推广</p>
                    </div>
                    <div class="list">
                        <img src="/packs/images/agent/agent_prefor_advan_3.png">
                        <p>高额返利</p>
                    </div>
                    <div class="list">
                        <img src="/packs/images/agent/agent_prefor_advan_4.png">
                        <p>提现秒达</p>
                    </div>
                    <div class="list">
                        <img src="/packs/images/agent/agent_prefor_advan_5.png">
                        <p>财务透明</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>