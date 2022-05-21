<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
    <link rel="icon" href="/packs/images/logo_icon.png" type="image/x-icon">
    <title><?=$vod['name']?> <?=$ji[0]['name']?></title>
    <style>
    *{padding: 0;margin: 0;}
    html,body{width:100%;height:100%;background: #fff;max-width: 500px;margin: 0 auto;}
    img{object-fit: cover;}
    .head{width: 100%;height: 55px;line-height: 55px;}
    .head div{display: inline-block;}
    .head .logo{width: 120px;height: 100%;text-align: center;}
    .head .logo img{width: 98px;height: 35px;margin-top:10px;}
    .head .down-btn{float: right;width: 85px;height: 26px;text-align: center;line-height: 26px;background: #f7b403;color: #333;border-radius: 13px;font-size: 14px;margin-top: 15px;margin-right: 12px;}
    .player{width: 100%;height: 230px;background: #000000;position: relative;}
    .player img{width: 100%;height: 100%;}
    .player .play{position: absolute;top: 50%;left: 50%;-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%);width: 55px;height: 55px;}
    .box{padding: 10px;margin-top:10px;padding-bottom: 50px;}
    .state{padding-top:10px;}
    .state.auto{max-height: 70px;overflow: hidden;}
    .state p{font-size: 14px;font-weight: 400;color: #666;line-height: 1.77;text-indent: 2em;}
    .h3{font-size: 18px;color: #333333;line-height: 25px;position: relative;width: 100%;margin-top:20px;font-weight: bold;}
    .h3-txt{font-size: 13px;font-weight: 400;color: #999999;}
    .h3-you{position:absolute;top:0px;right:13px;}
    .jilist{width: 100%;height: 50px;overflow-x:auto;white-space:nowrap;}
    .jilist::-webkit-scrollbar{display: none;}
    .jilist span{display: inline-block;border-radius: 2px;background: #F6F7F8;padding: 7px 10px;color:#333;margin-right: 15px;margin-top:15px;}
    .jilist span.on{background: #F7B403;}
    .love{width: 100%;margin-top: 15px;}
    .vlist{margin-bottom: 15px;margin-right: 4%;display: inline-block;width: 30.66666666%;}
    .vlist:nth-child(3n){margin-right: 0;}
    .vlist-box{height: 150px;position: relative;border-radius: 4px;overflow: hidden;}
    .vlist-state {width: 100%;height: 20px;line-height: 20px;position: absolute;left: 0;bottom: 0;z-index: 1;background: rgba(0, 0, 0, 0.5);padding: 0 5px;padding-top:3px;overflow: hidden;}
    .vlist-img {width: 100%;}
    .vlist-name {margin-top: 8px;height: 18px;overflow: hidden;font-size: 14px;}
    .vlist-txt{font-size: 15px;}
    .down-button{width: 100%;height: 32px;background: #f7b403;color: #333;border-radius: 16px;text-align: center;line-height: 32px;font-size: 16px;}
    .wxbg{width: 100%;height: 100%;position: fixed;top:0;left:0;background: rgba(0, 0, 0, 0.8);z-index:999;}
    .wxbg p{text-align: center;margin-top: 10%;padding: 0 5%;}
    .wxbg p img{max-width: 100%;height: auto;}
    </style>
</head>
<body data-clipboard-text='{"type":"share","aid":<?=$aid?>,"uid":<?=$uid?>,"vid":<?=$vid?>}'>
<?php if($is_wxqq == 2) echo '<div class="wxbg"><p><img src="/packs/images/tip.png"></p></div>';?>
<div class="down-box">
    <div class="head">
        <div class="logo"><img src="/packs/images/logo.png"></div>
        <div class="down-btn">打开APP</div>
    </div>
    <div class="player">
        <img src="<?=$vod['pic']?>">
        <img class="play" src="/packs/images/player.png">
    </div>
    <div class="box">
        <div class="h3" style="margin-top:0px;">
            <span><?=$vod['name']?></span>
            <div class="h3-you"><span class="h3-txt"><?=$vod['score']?>分</span></div>
        </div>
        <div class="state auto">
            <p><?=$vod['text']?></p>
        </div>
        <div class="h3">
            <span>选集</span>
            <div class="h3-you"><span class="h3-txt"><?=$vod['state']?></span></div>
        </div>
        <div class="jilist">
            <?php
            foreach($ji as $k=>$row){
                $cls = $k == 0 ? 'on' : '';
                echo '<span class="'.$cls.'">'.$row['name'].'</span>';
            }
            ?>
        </div>
        <div class="h3">
            <span>猜你喜欢</span>
        </div>
        <div class="love">
        <?php
        foreach($love as $row){
            echo '<div class="vlist"><div class="vlist-box"><img class="vlist-img" src="'.$row['pic'].'"><div class="vlist-state"><span style="font-size: 12px;color: #FFFFFF;">'.$row['state'].'</span></div></div><div class="vlist-name"><span class="vlist-txt">'.$row['name'].'</span></div></div>';
        }
        ?>
        </div>
        <div class="down-button">更多热播视频 · 打开APP &gt;&gt;</div>
    </div>
</div>
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/jquery/clipboard.min.js"></script>
<script>
    var ios = navigator.userAgent.match(/iPhone|iPod/i) != null,iosUrl = '<?=$ios_downurl?>',androidUrl = '<?=$android_downurl?>';
    var clipboard = new Clipboard('body');
    clipboard.on('success',function(e) {
        e.clearSelection();
    });
    $('.down-box').click(function(){
        var downurl = ios ? window.atob(iosUrl) : window.atob(androidUrl);
        setTimeout(function() {
            if(downurl.indexOf('mobileconfig') > -1){
                window.location.href = '<?=links('share/ios')?>';
            }else if(downurl != ''){
                window.location.href = downurl;
            }else{
                alert('后续开放');
            }
        },500);
    });
</script>
</body>
</html>