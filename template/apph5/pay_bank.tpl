<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>支付返回中...</title>
</head>
<body>
<?php if($pid == 1){ ?>
<center><br><br><br><font style="font-size:18px;color:#080;">订单支付成功~!</font></center>
<?php }else{ ?>
<center id="text"><br><br><br><font style="font-size:18px;color:red;">订单处理中，请稍后...</font></center>
<?php } ?>
<center id="back" style="display:none;background: #ff6600;padding: 5px 12px;color: #fff;border-radius: 5px;margin: 0 auto;width: 50%;text-align: center;margin-top: 20px;">
    立即返回
</center>
<script type="text/javascript" src="https://js.cdn.aliyun.dcloud.net.cn/dev/uni-app/uni.webview.1.5.2.js"></script>
<script src="//apps.bdimg.com/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">
document.addEventListener('UniAppJSBridgeReady', function() {
    document.getElementById('back').addEventListener('click', function() {
        uni.postMessage({
            data: {msg:'ok'}
        });
    })
});
<?php if($pid == 1){ ?>
$('#back').show().click();
<?php }else{ ?>
var t1 = window.setInterval(function (){
    $.post("<?=links('h5pay/init')?>", {id:<?=$id?>}, function(res) {
        if(res.code == 1){
            $("#text").html("<br><br><br><font style='font-size:20px;color:#080;''>订单支付成功~!</font>");
            window.clearInterval(t1);
            $('#back').show().click();
        }
    },'json');
},3000);
<?php } ?>
</script>
</body>
</html>