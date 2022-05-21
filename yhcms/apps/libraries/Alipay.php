<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('FCPATH')) exit('No direct script access allowed');
Class Alipay{
 
    public function __construct(){
        $this->myconfig = json_decode(_SYSJSON_,1);
        //应用APPID
        $this->appid = $this->myconfig['pay']['alipay']['appid'];
        //支付宝公钥
        $this->pubkey = $this->myconfig['pay']['alipay']['pubkey'];
        //应用私钥
        $this->prikey = $this->myconfig['pay']['alipay']['prikey'];
        //支付域名
        $payurl = $this->myconfig['payurl'] == '' ? $this->myconfig['url'] : $this->myconfig['payurl'];
        //同步地址
        $this->return_url = 'http://'.$payurl.'/index.php/h5pay/return_url';
        //异步地址
        $this->notify_url = 'http://'.$payurl.'/index.php/h5pay/notify_url/alipay';
    }

    //h5支付
    public function h5($dingdan,$total_fee,$body='会员在线充值'){
        echo '<!DOCTYPE html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"></head><body><center><br><br><br><font id="text" style="font-size:18px;color:#333;">拉起支付中...</font></center>';
        require_once FCPATH.'yhcms/myclass/alipay/AopClient.php';
        require_once FCPATH.'yhcms/myclass/alipay/request/AlipayTradeWapPayRequest.php';
        $aop = new AopClient ();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = $this->appid;
        $aop->rsaPrivateKey = $this->prikey;
        $aop->alipayrsaPublicKey = $this->pubkey;
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset = 'UTF-8';
        $aop->format = 'json';
        $request = new AlipayTradeWapPayRequest();
        $request->setReturnUrl($this->return_url.'/'.$dingdan);
        $request->setNotifyUrl($this->notify_url);
        //请求参数
        $json['subject'] = $body;
        $json['out_trade_no'] = $dingdan;
        $json['total_amount'] = $total_fee;
        $json['quit_url'] = $this->return_url.'/'.$dingdan;
        $json['product_code'] = 'QUICK_WAP_WAY';
        $request->setBizContent(json_encode($json));
        $result = $aop->pageExecute($request);
        if(!is_object($result)) exit($result);
        $responseNode = str_replace(".","_",$request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;
        exit('<center><br><br>错误码：'.$result->$responseNode->sub_code.'，内容：'.$result->$responseNode->sub_msg.'</content></body></html>');
    }

    //验证签名
    public function is_sign(){
        //file_put_contents('./1.txt',json_encode($_POST));
        require_once FCPATH.'yhcms/myclass/alipay/AopClient.php';
        $aop = new AopClient ();
        $aop->alipayrsaPublicKey = $this->pubkey;
        //此处验签方式必须与下单时的签名方式一致
        $flag = $aop->rsaCheckV1($_POST, NULL, "RSA2");
        if($flag){
            if($_POST['trade_status'] == 'TRADE_SUCCESS'){
                return array('dd'=>$_POST['out_trade_no'],'trade_no'=>$_POST['trade_no']);
            }
        }
        return false;
    }
}