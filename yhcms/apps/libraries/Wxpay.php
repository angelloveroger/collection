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
Class Wxpay{
 
    public function __construct(){
        $this->myconfig = json_decode(_SYSJSON_,1);
        //应用APPID
        $this->app_id = $this->myconfig['pay']['wxpay']['appid'];
        //应用appsecret
        $this->app_key = $this->myconfig['pay']['wxpay']['appkey'];
        //商户号
        $this->mch_id = $this->myconfig['pay']['wxpay']['mchid'];
        //商户私钥
        $this->mch_key = $this->myconfig['pay']['wxpay']['mchkey'];
        //支付域名
        $payurl = $this->myconfig['payurl'] == '' ? $this->myconfig['url'] : $this->myconfig['payurl'];
        //同步地址
        $this->return_url = 'http://'.$payurl.'/index.php/h5pay/return_url';
        //异步地址
        $this->notify_url = 'http://'.$payurl.'/index.php/h5pay/notify_url/wxpay';
    }

    //h5支付
    public function h5($dingdan,$total_fee,$body='会员在线充值'){
        $arr['appid'] = $this->app_id;
        $arr['mch_id'] = $this->mch_id;
        $arr['nonce_str'] = $this->getNonceStr();
        $arr['body'] = $body;
        $arr['out_trade_no'] = $dingdan;
        $arr['total_fee'] = $total_fee*100;
        $arr['spbill_create_ip'] = $this->get_ip();
        $arr['notify_url'] = $this->notify_url;
        $arr['trade_type'] = 'MWEB';
        $arr['scene_info'] = '{"h5_info": {"type":"Wap","wap_url": "'.$this->return_url.'/'.$dingdan.'","wap_name": "'.$this->myconfig['name'].'"}}';
        $arr['sign'] = $this->getsign($arr);
        $url = 'https://api.mch.weixin.qq.com/pay/unifiedorder';
        $post_xml = $this->arrtoxml($arr);
        $xml = $this->geturl($url,$post_xml);
        $arr2 = $this->xmltoarr($xml);
        if($arr2['return_code'] != 'SUCCESS' || $arr2['result_code'] != 'SUCCESS'){
            if(!empty($arr2['err_code_des'])) $arr2['return_msg'] = $arr2['err_code_des'];
            error($arr2['return_msg']);
        }else{
            return $arr2['mweb_url'];
        }
    }

    //公众号支付
    public function mp($dingdan,$total_fee,$body='会员在线充值',$openid){
        $arr['appid'] = $this->app_id;
        $arr['mch_id'] = $this->mch_id;
        $arr['nonce_str'] = $this->getNonceStr();
        $arr['body'] = $body;
        $arr['out_trade_no'] = $dingdan;
        $arr['total_fee'] = $total_fee*100;
        $arr['spbill_create_ip'] = $this->get_ip();
        $arr['notify_url'] = $this->notify_url;
        $arr['trade_type'] = 'JSAPI';
        $arr['openid'] = $openid;
        $arr['sign'] = $this->getsign($arr);
        $url = 'https://api.mch.weixin.qq.com/pay/unifiedorder';
        $post_xml = $this->arrtoxml($arr);
        $xml = geturl($url,$post_xml);
        $arr2 = $this->xmltoarr($xml);
        if($arr2['return_code'] != 'SUCCESS' || $arr2['result_code'] != 'SUCCESS'){
            if(!empty($arr2['err_code_des'])) $arr2['return_msg'] = $arr2['err_code_des'];
            error($arr2['return_msg']);
        }else{
            //组装JSAPI
            $arr3['appId'] = $arr2['appid'];
            $arr3['timeStamp'] = time().'';
            $arr3['nonceStr'] = $this->getNonceStr();
            $arr3['package'] = "prepay_id=".$arr2['prepay_id'];
            $arr3['signType'] = 'MD5';
            $arr3['paySign'] = $this->getsign($arr3);
            return $arr3;
        }
    }

    //获取微信openid
    public function openid($url=''){
        //通过code获得openid
        if (!isset($_GET['code'])){
            //触发微信返回code码
            $baseUrl = urlencode($url);
            $url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->app_id."&redirect_uri={$baseUrl}&response_type=code&scope=snsapi_base&state=STATE"."#wechat_redirect";
            Header("Location: $url");
            exit();
        } else {
            $url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$this->app_id."&secret=".$this->app_key."&code={$_GET['code']}&grant_type=authorization_code";
            $json = geturl($url);
            $data = json_decode($json,true);
            return $data;
        }
    }

    //验证签名
    public function is_sign(){
        $xml = file_get_contents("php://input");
        //file_put_contents('./1.txt',$xml);
        $arr = $this->xmltoarr($xml);
        if($arr['return_code'] == 'SUCCESS' && $arr['result_code'] == 'SUCCESS') {
            $sign = $arr['sign'];
            $md5 =  $this->getsign($arr);
            if($sign == $md5){
                return array('dd'=>$arr['out_trade_no'],'trade_no'=>$arr['transaction_id']);
            }
        }
        return false;
    }

    //生成签名，$arr为请求数组，$key为私钥
    public function getsign($arr){
        if(isset($arr['sign'])) unset($arr['sign']);
        ksort($arr);
        $arr['key'] = $this->mch_key;
        $requestString = $this->arrtouri($arr);
        $newSign = md5($requestString);
        return strtoupper($newSign);
    }

    //数组转URI
    public function arrtouri($param){
        $str = '';
        foreach($param as $key => $value) {
            $str .= $key .'=' . $value . '&';
        }
        $str = substr($str,0,-1);
        return $str;
    }

    //获取IP
    public function get_ip(){    
        $ip = '';    
        if(isset($_SERVER['HTTP_X_FORWARDED_FOR'])){        
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];    
        }elseif(isset($_SERVER['HTTP_CLIENT_IP'])){        
            $ip = $_SERVER['HTTP_CLIENT_IP'];    
        }else{        
            $ip = $_SERVER['REMOTE_ADDR'];    
        }
        $ip_arr = explode(',', $ip);
        return $ip_arr[0];
    }

    //数组转XML
    public function arrtoxml($arr){
        $xml = '<xml>';
        foreach($arr as $k=>$v){
            $xml .= '<'.$k.'>'.$v.'</'.$k.'>';
        }
        $xml .= '</xml>';
        return $xml;
    }

    //XML转数组
    public function xmltoarr($xml){ 
        //禁止引用外部xml实体 
        libxml_disable_entity_loader(true); 
        $xmlstring = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA); 
        $val = json_decode(json_encode($xmlstring),true); 
        return $val; 
    }

    //产生随机字符串，不长于32位
    public function getNonceStr($length = 32) 
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";  
        $str ="";
        for ( $i = 0; $i < $length; $i++ )  {  
            $str .= substr($chars, mt_rand(0, strlen($chars)-1), 1);  
        } 
        return $str;
    }
    
    public function geturl($url,$post=''){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        if(!empty($post)){
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        }
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }
}