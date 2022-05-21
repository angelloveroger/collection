<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>支付中...</title>
</head>
<body>
<center id="text">
    <br><br><br><font style="font-size:18px;color:#333;"><?=$text?></font>
    <?=$pic?>
</center>
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
    var is_ios = navigator.userAgent.match(/iPad|iPhone|iPod/i) !== null;
    <?php if(!empty($payurl)){ ?>
    window.setTimeout(function (){
        window.location.href = "<?=$payurl?>";
    },500);
    <?php }elseif(!empty($mpjson)){ ?>
    function jsApiCall(){
        WeixinJSBridge.invoke(
            'getBrandWCPayRequest',
            <?=$mpjson?>,
            function(res){
                if(res.err_msg == "get_brand_wcpay_request：fail" ) {
                    alert('订单支付失败~');
                }
            }
        );
    }
    function callpay(){
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', jsApiCall); 
                document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
            }
        }else{
            jsApiCall();
        }
    }
    callpay();
    <?php } ?>
    var t1 = window.setInterval(function (){
        $.post("<?=links('h5pay/init')?>", {id:<?=$row['id']?>}, function(res) {
            if(res.code == 1){
                $("#text").html("<br><br><br><font style='font-size:20px;color:#080;''>支付成功</font>");
                window.clearInterval(t1);
                $('#back').show();
            }
        },'json');
    },3000);
</script>
</body>
</html>