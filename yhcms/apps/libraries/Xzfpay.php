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
Class Xzfpay{
 
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
        $this->notify_url = 'http://'.$payurl.'/index.php/h5pay/notify_url/xzfpay';
        //实际支付金额
        $this->rmb = 0;
    }

    //h5支付
    public function h5($dingdan,$total_fee,$body='会员在线充值',$type='alipay'){
        //提交支付
        $params = array(
            "appid"   => $this->appid,
            "type"  => $type,
            "dd" => $dingdan,
            "rmb" => $total_fee,
            "return_url" => $this->return_url.'/'.$dingdan,
            "notify_url" => $this->notify_url,
            "body" => '商品交易'
        );
        $params['sign'] = $this->sign($params);
        $url = $this->payurl.'?'.http_build_query($params);
        return $url;
    }

    //生成RSA2签名
    public function sign($para) {
        $para_filter = array();
        foreach($para as $key=>$val){
            if($key == "sign" || $val == "") continue;
            $para_filter[$key] = $para[$key];
        }
        ksort($para_filter);
        $prestr = http_build_query($para_filter).$this->appkey;
        return strtoupper(md5($prestr));
    }

    //验证签名
    public function is_sign(){
        //数组转字符串
        $para = isset($_POST['sign']) ? $_POST : $_GET;
        //file_put_contents('./1.txt',json_encode($para));
        $sign = $para['sign'];
        $mysgin = $this->sign($para);
        if($mysgin == $sign) {
            if($para['state'] == 1){
                $this->rmb = $para['rmb'];
                return array('dd'=>$arr['dd'],'trade_no'=>$arr['trade_no']);
            }
        }
        return false;
    }
    
    //实际支付金额
    public function get_rmb(){
       return $this->rmb;
    }
}