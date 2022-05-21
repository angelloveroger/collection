<!doctype html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0">
    <title>《<?=WEBNAME?>APP - iOS安装指导</title>
    <style>
    <?php if($is_down == 1){ ?>
    *{margin:0;padding:0;font-family: Microsoft Yahei,sans-serif; list-style: none; font-style: normal; text-decoration: none; border: none; -webkit-tap-highlight-color: transparent; -webkit-font-smoothing: antialiased;} html,body{width: 100%;} a{color: #333;text-decoration: none;} h3{font-size: 20px;} h4{font-size: 18px;padding-bottom: 10px;} p{font-size: 14px;} p a span{color: red;} .box{float: left;padding: 16px 4%;width: 92%;} .box .icon{float: left;width: 30%;} .box .icon img{width: 100%;} .box .text{float: left;width: 70%;position: relative;} .box .text h3{padding: 5px 10px;} .box .text p{padding: 0px 5px 10px 10px;color:#999;}.box .text .down{background:#0477f9;padding:3px 15px;border-radius:15px;font-size:12px;color:#fff;margin-left:10px}.box .text .arouse{position:absolute;right:5px;bottom:-6px;height:30px;line-height:30px;border-radius:15px;text-align:center;font-size:12px;color:rgba(6,122,254,1);display:inline-block}.box .text .arouse b{display:inline-block;vertical-align:middle;width:20px;height:20px;line-height:20px;margin:-2px 5px 0 0;text-align:center;background:rgba(6,122,254,1);color:#fff;border-radius:100%}.picbox{display:flex;overflow-x:auto;justify-content:space-between;align-items:center}.picbox::-webkit-scrollbar{display:none;width:0!important}.picbox li{margin-right:20px;margin-bottom:15px;text-align:center;width:80%}.picbox li img{width:100%}.rate-info{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:horizontal;-webkit-box-direction:normal;-ms-flex-direction:row;flex-direction:row;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}.rate-info .rate>strong{font-size:1rem;font-weight:700;color:#888}.rate-info .rate>img{width:5rem;margin-left:5px}.rate-info .rate>p{color:#d8d8d8;font-size:.75rem}.rate-info .classification>strong{color:#8e8f92;font-size:1rem}.rate-info .classification>p{color:#d8d8d8;font-size:.75rem}.pics{display:none}.line{float: left;height: 1px;width: 100%;background: rgb(238, 238, 238);} .row{padding: 10px 0;} .row .title h3,.row .title img{display: inline-block;vertical-align: middle;} .row .title img{width: 32px;} .row p{padding-left: 40px;padding-top:8px;} .row a{border-radius: 25px;font-size: 16px;position: relative;width: 80%;display: block;margin: 20px auto 10px;height: 50px;line-height: 50px;text-align: center;background-color: #409eff;color: #fff;box-shadow: 0 5px 10px -5px #409eff;} .row a img{height: 42px;position: absolute;top: 50%;transform: translateY(-21px);left: 10%;} .row span{font-size: 16px;text-align: center;display: block;} .comment-info .comment-info-title{margin-bottom: 10px; font-size: 20px; font-weight: 700;} .comment-info .comment-info-content{display: -webkit-box; display: -ms-flexbox; display: flex; -webkit-box-orient: horizontal; -webkit-box-direction: normal; -ms-flex-direction: row; flex-direction: row;} .comment-info .comment-info-content .comment-info-l>strong{font-size: 58px; line-height: 60px; color: #4a4a4e; font-weight: 700;} .comment-info .comment-info-content .comment-info-l>p{width: 100px; text-align: center; color: #7b7b7b; margin-top: 10px;} .comment-info .comment-info-content .comment-info-r{margin-left: 20px; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1;} .comment-info .comment-info-content .comment-info-r .comment-star-list{margin-top: 10px; width: 90%;} .comment-info .comment-info-content .comment-info-r .comment-star-list>li:first-child{margin-top: 0;} .comment-info .comment-info-content .comment-info-r .comment-star-list>li{margin-top: 6px; line-height: 0; display: -webkit-box; display: -ms-flexbox; display: flex; -webkit-box-orient: horizontal; -webkit-box-direction: normal; -ms-flex-direction: row; flex-direction: row; -webkit-box-align: center; -ms-flex-align: center; align-items: center;} .comment-info .comment-info-content .comment-info-r .comment-star-list .comment-star{position: relative; width: 46px; height: 7px;} .comment-info .comment-info-content .comment-info-r .comment-star-list .comment-star>img{display: block; width: 100%; height: 100%;} .comment-info .comment-info-content .comment-info-r .comment-star-list .comment-star>div{position: absolute; left: 0; top: 0; height: 100%; background: #fff;} .comment-info .comment-info-content .comment-info-r .comment-star-list .comment-progress{position: relative; margin-left: 5px; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1; height: 2px; width: 80%; background: #e9e9ec; border-radius: 2px;} .comment-info .comment-info-content .comment-info-r .comment-star-list .comment-progress>div{position: absolute; left: 0; width: 0; height: 2px; background: #4a4a4e; border-radius: 2px; width: 90%;} .box .app-title{margin-bottom: 5px; font-size: 20px;} .box .information-list{padding: 0 16px;} .box .information-list>li{font-size: 12px; display: -webkit-box; display: -ms-flexbox; display: flex; -webkit-box-orient: horizontal; -webkit-box-direction: normal; -ms-flex-direction: row; flex-direction: row; -webkit-box-align: center; -ms-flex-align: center; align-items: center; line-height: 3.5; border-bottom: 1px solid #f2f2f2;} .box .information-list>li .l{color: #737379;} .box .information-list>li .r{margin-left: 15px; -webkit-box-flex: 1; -ms-flex: 1; flex: 1; text-align: right; line-height: 10px;} .bottom{background-color: rgb(250, 250, 250);color:#666;} .bottom p{font-size: 12px;}
    }
    <?php }else{ ?>
        body{height:100%;color:#777;font-weight:400;font-size:18px;line-height:1.5;font-family:Helvetica Neue,Helvetica,Roboto,Segoe UI,Arial,sans-serif}*,:after,:before{box-sizing:inherit}a{color:inherit;text-decoration:none;outline:0}.OpenGuideWechatAplan-options{background-image:url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik01LDE0IEMzLjg5NTQzMDUsMTQgMywxMy4xMDQ1Njk1IDMsMTIgQzMsMTAuODk1NDMwNSAzLjg5NTQzMDUsMTAgNSwxMCBDNi4xMDQ1Njk1LDEwIDcsMTAuODk1NDMwNSA3LDEyIEM3LDEzLjEwNDU2OTUgNi4xMDQ1Njk1LDE0IDUsMTQgWiBNMTIsMTQgQzEwLjg5NTQzMDUsMTQgMTAsMTMuMTA0NTY5NSAxMCwxMiBDMTAsMTAuODk1NDMwNSAxMC44OTU0MzA1LDEwIDEyLDEwIEMxMy4xMDQ1Njk1LDEwIDE0LDEwLjg5NTQzMDUgMTQsMTIgQzE0LDEzLjEwNDU2OTUgMTMuMTA0NTY5NSwxNCAxMiwxNCBaIE0xOSwxNCBDMTcuODk1NDMwNSwxNCAxNywxMy4xMDQ1Njk1IDE3LDEyIEMxNywxMC44OTU0MzA1IDE3Ljg5NTQzMDUsMTAgMTksMTAgQzIwLjEwNDU2OTUsMTAgMjEsMTAuODk1NDMwNSAyMSwxMiBDMjEsMTMuMTA0NTY5NSAyMC4xMDQ1Njk1LDE0IDE5LDE0IFoiLz4KPC9zdmc+Cg==);background-position:center;background-repeat:no-repeat;background-size:cover;width:36px;height:14px;display:inline-block;margin:0 6px}.OpenGuideWechatAplan-wrapper{min-height:100%;}.OpenGuideWechatAplan-arrow{position:absolute;z-index:1;top:16px;right:26px;width:52px;height:136px;background-size:contain;background-repeat:no-repeat;background-image:url(https://p0.pstatp.com/origin/pgc-image/7d8ed30770bc4f41be60c80a8cb0f534)}.OpenGuideWechatAplan-content{position:relative;max-width:calc(100% - 10px);margin:auto auto 20px}.OpenGuideWechatAplan-hit{background:#fff;width:200px;padding:80px 0 8px;margin:auto;box-shadow:0 0 32px 16px #fff;color:#444;font-size:20px;line-height:1.8}.OpenGuideWechatAplan-img{max-width:100%}.OpenGuideWechatAplan-browser{position:absolute;top:160px;left:60%;z-index:2;width:25%;padding-top:25%;box-shadow:-1px -1px 20.5px 0 #dff0fc;border:solid 1px #ebebeb;border-radius:50%;background-color:#fff;background-size:65% 65%;background-position:center;background-image:url(/packs/images/ios.png);background-repeat:no-repeat}
    <?php } ?>
    </style>
</head>
<body>
<?php if($is_down == 1){ ?>
    <div class="box" style="padding-bottom: 0;">
        <div class="icon"><img src="/packs/images/logo_icon.png"></div>
        <div class="text">
            <h3><?=WEBNAME?></h3>
            <p>VIP视频、超前点播永久免费</p>
            <a class="down" href="<?=$ios_downurl?>">获取</a>
            <a class="arouse"><b>?</b>安装教程</a>
        </div>
    </div>
    <div class="box">
        <div class="rate-info">
            <div class="rate"><strong>4.9</strong><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMsAAAAgCAYAAAC8eIxyAAADiElEQVR4nNXcvascVRgH4GfXWySKFoIouYJ2gogS1ELFr4hJlPgdP1CihWBhYaOd/4CNEcTSKsZCESxMo3axsBAEtRVUgogfGFEsDFxiMRtyWbI7s3Nmzt3fr9ndmT3vPFu8s+ycszM5+tbbBsh+fDZEoQpJsSY4E4wM5JwOALkXn+KmAWqNnRRrgjPByIDOIZrl9dnjkQFqjZ0Ua4IzwciAztJmuQ77Zs+fw0ZhvTGTYk1wJhgZ2FnaLC9iMnt+Fe4vrDdmUqwJzgQjAztLmmWKZ+e2PV9Qb8ykWBOcCUZGcJY0yz5szm17BJcV1BwrKdYEZ4KREZwlzXKhH0y78VRBzbGSYk1wJhgZwdm3WS7GYwv2rdvVkRRrgjPByEjOVa8O7MYuzZWFSxe8507ciFML9m/h7xWP2ycp1gRngpGRnRu4At/hyiLm+UzwTY9xR3C85T0p1gRngpE1ck7xO04MBOmTs3hNe6OQY01wJhhZI+e53ywv45MdgJzRnFneXGFMijXBmWBkTZzTbRsP46OKkH9wCO+vOC7FmuBMMLImzu1Xw87gGbxbAfIT7sDnPcenWBOcCUbWwHnRgYMPbH99VvN1959mUmdi+HyJ+/BDYZ0Ua4IzwcgOOxfNs7yh+dr7d2DIMc2S6d8GrJliTXAmGNkh57JJyY9xO74fALGFV/GC5qwwdFKsCc4EIzvgbJvB/xa3Krt0dxoP4mhBjS5JsSY4E4xUdnZZ7vIXHsZXPTHvqffX0xRrgjPBSEVn17Vhu3B9T8wTKxxniKRYE5wJRio5u36Y/bikJ2YTt/Uc2ycp1gRngpFKzq7NsmgFZ9ccLhy/SlKsCc4EI5WcXZplAw+VWTxaOL5rUqwJzgQjFZ1dmuUuXL5k/xZOttS4Fnu7gAqTYk1wJhip6OzSLMu+4n7UTOLcrenuX5e8t8ZZJsWa4EwwUtHZ1iyTJUWOaW5c9sXs9QncYPFit0NtmMKkWBOcCUYqO9ua5RZcPbftTzytme2c/0fZH3hSs6z59Ny+vdjTBipIijXBmWCksrOtWea79gNNd37YMu64pqu3r9qc4GDLuJKkWBOcCUYqO9ua5fHZ40nco1ki/UvLmHM5hQN4STPLyvm7A46RFGuCM8FIZedkyV30p3hlBvm6I2BR9uAd3IxrCmtdKCnWBGeCkR1wLmuWMbKJn2sesCAp1gRngpEW5//kXI9EZibN2wAAAABJRU5ErkJggg==" alt="">
                <p>10000+个评分</p>
            </div>
            <div class="classification"><strong>4+</strong>
                <p>年龄</p>
            </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="box">
        <div class="comment-info">
            <h2 class="comment-info-title">评分及评论</h2>
            <div class="comment-info-content">
                <div class="comment-info-l">
                    <strong>4.9</strong> 
                    <p>满分 5 分</p>
                </div>
                <div class="comment-info-r">
                    <ul class="comment-star-list">
                        <li>
                            <div class="comment-star">
                                <img src="/packs/images/ios/5x.png" alt="">
                                <div></div>
                            </div>
                            <div class="comment-progress">
                                <div style="width: 90%;"></div>
                            </div>
                        </li>
                        <li>
                            <div class="comment-star">
                                <img src="/packs/images/ios/4x.png" alt="">
                                <div style="width: 20%;"></div>
                            </div>
                            <div class="comment-progress">
                                <div style="width: 15%;"></div>
                            </div>
                        </li>
                        <li>
                            <div class="comment-star">
                                <img src="/packs/images/ios/3x.png" alt="">
                                <div style="width: 40%;"></div>
                            </div>
                            <div class="comment-progress">
                                <div style="width: 5%;"></div>
                            </div>
                        </li>
                        <li>
                            <div class="comment-star">
                                <img src="/packs/images/ios/2x.png" alt="">
                                <div style="width: 60%;"></div>
                            </div>
                            <div class="comment-progress">
                                <div style="width: 3%;"></div>
                            </div>
                        </li>
                        <li>
                            <div class="comment-star">
                                <img src="/packs/images/ios/1x.png" alt="">
                                <div style="width: 80%;"></div>
                            </div>
                            <div class="comment-progress">
                                <div style="width: 1%;"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="box">
        <h2 class="app-title">信息</h2>
        <ul class="information-list">
            <li><span class="l">销售商</span> <div class="r"><?=WEBNAME?></div></li>
            <li><span class="l">语言</span> <div class="r">简体中文</div></li>
            <li><span class="l">大小</span> <div class="r">14.2MB</div></li>
            <li><span class="l">更新时间</span> <div class="r"><?=date('Y-m-d')?></div></li>
        </ul>
    </div>
    <div class="box bottom">
        <p>免责声明：</p> 
        <p>
            本网站仅提供下载托管，App内容相关事项由开发者负责，与本网站无关。
        </p>
    </div>
    <div class="pics">
        <img alt="第1步" layer-src="/packs/images/ios/1.png" src="/packs/images/ios/1.png">
        <img alt="第2步" layer-src="/packs/images/ios/2.png" src="/packs/images/ios/2.png">
        <img alt="第3步" layer-src="/packs/images/ios/3.png" src="/packs/images/ios/3.png">
        <img alt="第4步" layer-src="/packs/images/ios/4.png" src="/packs/images/ios/4.png">
        <img alt="第5步" layer-src="/packs/images/ios/5.png" src="/packs/images/ios/5.png">
        <img alt="第6步" layer-src="/packs/images/ios/6.png" src="/packs/images/ios/6.png">
    </div>
    <script src="/packs/layui/layui.js"></script>
    <script>
        layui.use(['layer','jquery'], function(){
            var layer = layui.layer,$ = layui.jquery;
            layer.photos({
                photos: '.pics',
                anim: 5
            });
            $('.arouse').click(function(){
                $('.pics img').eq(0).click();
            });
        });
    </script>
<?php }else{ ?>
    <?php if($is_down == 2){ ?>
        <div id="hd" class="OpenGuideWechatAplan-wrapper">
            <div class="OpenGuideWechatAplan-arrow"></div>
            <div class="OpenGuideWechatAplan-content">
                <div class="OpenGuideWechatAplan-hit">
                    <div>点击右上角 <span class="OpenGuideWechatAplan-options"></span></div>
                    <div>选择在 <span class="OpenGuideWechatAplan-browsertext">Safari浏览器</span> 中打开</div>
                </div>
                <div class="OpenGuideWechatAplan-browser"></div>
            </div>
        </div>
    <?php }else{ ?>
        <div id="hd" class="OpenGuideWechatAplan-wrapper">
            <div class="OpenGuideWechatAplan-content">
                <div class="OpenGuideWechatAplan-browser" style="top: 90px;left: 37%;"></div>
                <div class="OpenGuideWechatAplan-hit" style="width: 315px;padding-top:205px;font-size: 16px;">
                    <div>请复制地址到苹果自带 <span class="OpenGuideWechatAplan-browsertext">Safari浏览器</span> 中打开</div>
                </div>
                
            </div>
        </div>
    <?php } ?>
<?php } ?>
</body>
</html>