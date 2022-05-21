<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Sms{

    function __construct (){
        log_message('debug', "Native Sms Class Initialized");
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

    //发送入口
	public function send($tel,$code){
		$mode = $this->myconfig['sms']['type'];
		return $this->$mode($tel,$code);
	}

	//极限验证发送
	public function vaptcha($tel,$code){
		$post = array(
	        'smsid'   => $this->myconfig['sms']['vaptcha']['appid'],
	        'smskey'    => $this->myconfig['sms']['vaptcha']['appkey'],
	        'token'   => '',
	        'templateid' => $this->myconfig['sms']['vaptcha']['tplid'],
	        'phone' => $tel,
	        'data' => $code
	    );
	    $res = geturl('http://sms.vaptcha.com/send',$post);
	    if($res == 200) return true;
	    return false;
	}

	//腾讯云发送
	public function tencent($tel,$code){
		// 发送短信 单发指定模板
        $random = rand(1111,9999);
        $time = time();
        //请求地址
        $apiurl = 'https://yun.tim.qq.com/v5/tlssmssvr/sendsms?sdkappid='.$this->myconfig['sms']['tencent']['appid'].'&random='.$random;
        //请求参数
        $params = array();
        $params["params"] = array($code);
        $params["sig"] = hash("sha256", "appkey=".$this->myconfig['sms']['tencent']['appkey']."&random=".$random."&time=".$time."&mobile=".$tel);
        $params["sign"] = $this->myconfig['sms']['tencent']['sign'];
        $params['tel'] = array('mobile'=>$tel,'nationcode'=>'86');
        $params['time'] = $time;
        $params['tpl_id'] = $this->myconfig['sms']['tencent']['tplid'];
        $json = $this->sendCurlPost($apiurl,$params);
        $arr = json_decode($json,1);
        if(isset($arr['result']) && $arr['result'] == 0){
        	return true;
        }else{
            if(!isset($arr['errmsg'])) $arr['errmsg'] = $arr['ErrorInfo'];
        	//echo $arr['errmsg'];
        	return false;
        }
	}

	//阿里云发送
	public function alyun($tel,$code){
		$params = array ();
	    $params["PhoneNumbers"] = $tel;
	    $params["SignName"] = $this->myconfig['sms']['alyun']['sign'];
	    $params["TemplateCode"] = $code;
	    $params['TemplateParam'] = $this->myconfig['sms']['alyun']['tplid'];
	    $content = $this->request($this->myconfig['sms']['alyun']['appid'],$this->myconfig['sms']['alyun']['appkey'],'dysmsapi.aliyuncs.com',array_merge($params, array("RegionId" => "cn-hangzhou","Action" => "SendSms","Version" => "2017-05-25")));
        if($content->Code == 'OK'){
            return true;
        }
	    return false;
    }

    private function request($accessKeyId, $accessKeySecret, $domain, $params, $security=false) {
        $apiParams = array_merge(array (
            "SignatureMethod" => "HMAC-SHA1",
            "SignatureNonce" => uniqid(mt_rand(0,0xffff), true),
            "SignatureVersion" => "1.0",
            "AccessKeyId" => $accessKeyId,
            "Timestamp" => gmdate("Y-m-d\TH:i:s\Z"),
            "Format" => "JSON",
        ), $params);
        ksort($apiParams);
        $sortedQueryStringTmp = "";
        foreach ($apiParams as $key => $value) {
            $sortedQueryStringTmp .= "&" . $this->encode($key) . "=" . $this->encode($value);
        }
        $stringToSign = "GET&%2F&" . $this->encode(substr($sortedQueryStringTmp, 1));
        $sign = base64_encode(hash_hmac("sha1", $stringToSign, $accessKeySecret . "&",true));
        $signature = $this->encode($sign);
        $url = ($security ? 'https' : 'http')."://{$domain}/?Signature={$signature}{$sortedQueryStringTmp}";
        try {
            $content = $this->fetchContent($url);
            return json_decode($content);
        } catch( \Exception $e) {
            return false;
        }
    }

    private function encode($str){
        $res = urlencode($str);
        $res = preg_replace("/\+/", "%20", $res);
        $res = preg_replace("/\*/", "%2A", $res);
        $res = preg_replace("/%7E/", "~", $res);
        return $res;
    }

    private function fetchContent($url) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "x-sdk-client" => "php/2.0.0"
        ));
        if(substr($url, 0,5) == 'https') {
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        }
        $rtn = curl_exec($ch);
        if($rtn === false) {
            trigger_error("[CURL_" . curl_errno($ch) . "]: " . curl_error($ch), E_USER_ERROR);
        }
        curl_close($ch);
        return $rtn;
    }

    private function sendCurlPost($url, $dataObj){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 60);
        curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($dataObj));
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
        $result = curl_exec($curl);
        curl_close($curl);
        return $result;
    }
}