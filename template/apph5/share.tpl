<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
    <meta name="format-detection" content="telephone=no, email=no">
    <title>下载<?=$name?></title>
    <style>
    html,body{width:100%;height:100%;background: #f5f5f5;}
    *{margin:0;padding:0;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;font-family: Avenir,Helvetica,Arial,sans-serif;-moz-user-select: none;-webkit-user-select: none;-ms-user-select: none;-khtml-user-select: none;user-select: none;}
    .box{width: 100%;margin:0 auto;text-align: center;max-width: 500px;background: #fff;height:100%;}
    .box .content{position: fixed;top: 50%;width: 100%;height:410px;margin-top: -205px;max-width: 500px;}
    .box .logo{width: 137px;border-radius: 20px;}
    .box h3{padding: 10px 0;}
    .box p{margin-bottom:100px;color:#666;padding-top:10px;}
    .box .downBtn{width: 60%;height: 40px;line-height: 40px;margin: 40px auto;background: #3986ff;font-size: 14px;border-radius: 20px;color: #fff;font-weight: 700;display: flex;align-content: center;justify-content: center;box-shadow: 5px #eee;}
    .box .downBtn img{width: 25px;height: 25px;width: 25px;height: 25px;margin-top: 7px;margin-right: 20px;}
    .wxbg{width: 100%;height: 100%;position: fixed;top:0;left:0;background: rgba(0, 0, 0, 0.8);z-index:999;}
    .wxbg p{text-align: center;margin-top: 10%;padding: 0 5%;}
    .wxbg p img{max-width: 100%;height: auto;}
    </style>
</head>
<body>
<?php if($is_wxqq == 2) echo '<div class="wxbg"><p><img src="/packs/images/tip.png"></p></div>';?>
<div class="box">
    <div class="content">
        <img class="logo" src="/packs/images/logo_icon.png">
        <h3><?=$name?></h3>
        <p>电影、电视剧、综艺、动漫一网打尽<br>VIP视频、超前点播永久免费</p>
        <?php if($ios){ ?>
        <div data-clipboard-text='{"type":"share","aid":<?=$aid?>,"uid":<?=$uid?>,"vid":0}' class="downBtn ios"><img src="data:image/png;base64,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" alt="ios"><span>IOS下载</span></div>
        <?php }else{ ?>
        <div data-clipboard-text='{"type":"share","aid":<?=$aid?>,"uid":<?=$uid?>,"vid":0}' class="downBtn android"><img src="data:image/png;base64,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" alt="android"><span>安卓下载</span></div>
        <?php } ?>
    </div>
    <div id="down-box" style="position: fixed; width: 100%; height: 100%; top: 0px; left: 0px; background: rgba(0, 0, 0, 0.2); font-size: 14px; z-index: 2147483647;display:none;"><div style="box-sizing:border-box;text-align:left;position:absolute;top:0;bottom:0;left:0;right:0;margin:auto;width:80%;max-width:500px;height:130px;padding:20px;background:#fff;color:#666;"><div onclick="$('#down-box').hide();" style="position:absolute;top:5px;right:5px;font-size:20px;width:20px;text-align:center;color:#999;">×</div>    如未正常唤起，请点击下面按钮下载APP，或在浏览器中打开重试。<div id="appDown" style="width:30%;height:30px;line-height:30px;margin:20px auto 0;text-align:center;color:#fff;background:#3b82fe;">点击下载</div></div></div>
</div>
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/jquery/clipboard.min.js"></script>
<script>
    var ios = navigator.userAgent.match(/iPhone|iPod/i) != null,iosUrl = '<?=$ios_downurl?>',androidUrl = '<?=$android_downurl?>';
    var clipboard = new Clipboard('.downBtn');
    clipboard.on('success',function(e) {
        e.clearSelection();
    });
    $('.ios').click(function(){
        var iosurl = window.atob(iosUrl);
        setTimeout(function() {
            if(iosurl.indexOf('mobileconfig') > -1){
                window.location.href = '<?=links('share/ios')?>';
            }else if(iosurl != ''){
                window.location.href = iosurl;
            }else{
                alert('IOS版本，后续开放');
            }
        },500);
    });
    $('.android').click(function(){
        setTimeout(function() {
            window.location.href = window.atob(androidUrl);
        },500);
    });
</script>
</body>
</html>