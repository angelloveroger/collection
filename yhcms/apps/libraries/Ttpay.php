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
Class Ttpay{
 
    public function __construct(){
        $this->myconfig = json_decode(_SYSJSON_,1);
        //应用APPID
        $this->appid = $this->myconfig['pay']['xzfpay']['appid'];
        //支付宝公钥
        $this->appkey = $this->myconfig['pay']['xzfpay']['appkey'];
        //支付地址
        $this->payurl = $this->myconfig['pay']['xzfpay']['appurl'];
        //支付域名
        $payurl = $this->myconfig['payurl'] == '' ? $this->myconfig['url'] : $this->myconfig['payurl'];
        //同步地址
        $this->return_url = 'http://'.$payurl.'/index.php/h5pay/return_url';
        //异步地址
        $this->notify_url = 'http://'.$payurl.'/index.php/h5pay/notify_url/ttpay';
        //实际支付金额
        $this->rmb = 0;
    }

    //h5支付
    public function h5($dingdan,$total_fee,$body='会员在线充值',$type='alipay'){
        //提交支付
        $params = array(
            "mchId" => $this->appid, //商户ID
            "productId" => $type == 'alipay' ? '8007' : '8003',  //支付产品:ID8003微信小额话费,8007支付宝小额话费
            "mchOrderNo" => $dingdan,  // 商户订单号
            "currency" => 'cny',  //币种
            "amount" => $total_fee*100, // 支付金额
            "returnUrl" => $this->return_url.'/'.$dingdan,     //支付结果前端跳转URL
            "notifyUrl" => $this->notify_url,    //支付结果后台回调URL
            "subject" => '网络购物',     //商品主题
            "body" => '网络购物',    //商品描述信息
            "param1" => 'ios',  //扩展参数1
            "extra" =>  '{"deviceType":"ios"}',  //附加参数
            "reqTime" => date("YmdHis"),     //请求时间, 格式yyyyMMddHHmmss
            "version" => '1.0'   //版本号, 固定参数1.0
        );
        $params["sign"] = $this->get_sign($params);  //签名
        //print_r($params);
        //请求
        $header = array(
            "cache-control: no-cache",
            "content-type: application/x-www-form-urlencoded"
        );
        $res = $this->geturl($this->payurl."/api/pay/create_order",$params,$header);
        $arr = json_decode($res,1);
        //print_r($arr);exit;
        if($arr['retCode'] != 0) exit($arr['retMsg']);
        header("location:".$arr['payJumpUrl']);exit;
        //return $arr['payJumpUrl'];
    }

    //生成签名
    public function get_sign($paramArray) {
        ksort($paramArray);  //字典排序
        reset($paramArray);
        $md5str = "";
        foreach ($paramArray as $key => $val) {
            if($key != 'sign' &&  strlen($key)  && strlen($val) ){
                $md5str = $md5str . $key . "=" . $val . "&";
            }
        }
        $sign = strtoupper(md5($md5str . "key=" . $this->appkey));  //签名
        return $sign;
    }

    //验证签名
    public function is_sign(){
        //数组转字符串
        $para = isset($_POST['sign']) ? $_POST : $_GET;
        //file_put_contents('./1.txt',json_encode($para));
        $sign = $para['sign'];
        $mysgin = $this->get_sign($para);
        if($mysgin == $sign) {
            $this->rmb = $para['amount']/100;
            return array('dd'=>$para['mchOrderNo'],'trade_no'=>$para['channelOrderNo']);
        }
        return false;
    }
    
    //实际支付金额
    public function get_rmb(){
       return $this->rmb;
    }

    //获取远程内容
    public function geturl($url,$post='',$header=''){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        //curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_ENCODING, "gzip");
        if(!empty($header)){
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        }
        if(!empty($post)){
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
        }
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);//获取跳转后的
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }
}