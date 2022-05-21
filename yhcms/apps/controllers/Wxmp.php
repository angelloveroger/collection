<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
defined('BASEPATH') OR exit('No direct script access allowed');

class Wxmp extends My_Controller {

    public function __construct(){
        parent::__construct();
        $this->myconfig = json_decode(_SYSJSON_,1);
        //判断开关
        if($this->myconfig['mp']['open'] == 0) exit;
        //微信token
        $this->token     =  $this->myconfig['mp']['token'];
        $this->echostr   =  get_post('echostr');
        $this->signature =  get_post('signature');
        $this->timestamp =  get_post('timestamp');
        $this->nonce     =  get_post('nonce');
    }

    public function index() {
        $neir = file_get_contents('php://input');
        //验证微信过来的
        $this->checkSignature();
        $MsgType = 'event';
        $msg = $event ='';
        if(!empty($neir)){
            $xml = @simplexml_load_string($neir);
            $ToUserName = (string) $xml->ToUserName; //开发者微信号ID
            $OpenID = (string) $xml->FromUserName; //发送者账号ID
            $MsgType = (string) $xml->MsgType; //消息类型
            $msg = (string) $xml->Content; //消息内容
            $event = (string) $xml->Event; //关注状态
            $eventkey = (string) $xml->EventKey; //事件key
        }
        //关注状态消息
        if(!empty($event)){
            //默认关注事件
            echo "<xml><ToUserName><![CDATA[".$OpenID."]]></ToUserName><FromUserName><![CDATA[".$ToUserName."]]></FromUserName><CreateTime>".time()."</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[".$this->myconfig['mp']['focus_msg']."]]></Content></xml>";
        }elseif(!empty($msg)){ //用户输入消息
            $msg = safe_replace($msg);
            //判断命中关键词
            $result = $this->checkKeyword($msg);
            if($result){
                $xml = "<item><Title><![CDATA[".$result['name']."]]></Title><Description><![CDATA[".$result['name']."]]></Description><PicUrl><![CDATA[".$result['pic']."]]></PicUrl><Url><![CDATA[".$result['url']."]]></Url></item>";
                $text = '<a href="'.$result['url'].'">'.$result['name'].'</a>' . "\n\n";
                $nums = 1;
            }else{
                $xml = '';
                $result = $this->mydb->get_sql("SELECT id,name,pic,`text` FROM "._DBPREFIX_."vod where LOCATE('".$msg."',name) > 0 or LOCATE('".$msg."',director) > 0 or LOCATE('".$msg."',actor) > 0 ORDER BY rhits DESC LIMIT 5");
                $text = empty($result) ? $this->myconfig['mp']['empty_msg'] : "为您找到以下资源：\n\n\n";
                foreach ($result as $row) {
                    $url = $this->myconfig['mp']['url'];
                    if(empty($url)) $url = WEBURL;
                    $link = "http://".$url.($this->myconfig['mp']['url_type'] == 1 ? links('info',$row['id']) : links('play',$row['id'],0));
                    $xml .= "<item><Title><![CDATA[".$row['name']."]]></Title><Description><![CDATA[".sub_str($row['text'],30)."]]></Description><PicUrl><![CDATA[".getpic($row['pic'])."]]></PicUrl><Url><![CDATA[".$link."]]></Url></item>";
                    $text .= '<a href="'.$link.'">'.$row['name'].'</a>' . "\n\n";
                }
                $nums = count($result);
            }
            if(empty($result) || $this->myconfig['mp']['msg_type'] == 1){
                echo "<xml><ToUserName><![CDATA[".$OpenID."]]></ToUserName><FromUserName><![CDATA[".$ToUserName."]]></FromUserName><CreateTime>".time()."</CreateTime><MsgType><![CDATA[text]]></MsgType><Content><![CDATA[".$text."]]></Content></xml>";
            }else{
                echo "<xml><ToUserName><![CDATA[".$OpenID."]]></ToUserName><FromUserName><![CDATA[".$ToUserName."]]></FromUserName><CreateTime>".time()."</CreateTime><MsgType><![CDATA[news]]></MsgType><ArticleCount>".$nums."</ArticleCount><Articles>".$xml."</Articles></xml>";
            }
        }
        echo $this->echostr;
    }

    //判断是否在关键词
    private function checkKeyword($msg){
        foreach ($this->myconfig['mp']['msg_key'] as $v) {
            if(strstr($v['key'],$msg)) return $v;
        }
        return false;
    }

    //验证微信过来
    private function checkSignature(){
        $tmpArr = array($this->token,$this->timestamp,$this->nonce);
        sort($tmpArr,SORT_STRING);
        $tmpStr = implode($tmpArr);
        $tmpStr = sha1($tmpStr);
        if($tmpStr == $this->signature){
            return true;
        }else{
            exit();
        }
    }
}
