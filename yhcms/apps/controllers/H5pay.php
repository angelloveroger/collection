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

class H5pay extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
        $this->load->get_templates('apph5');
	}

    //支付页面
    public function index($id=0) {
        $id = (int)$id;
        $row = $this->mydb->get_row('user_order',array('id'=>$id));
        if(!$row) error('订单不存在~!');
        $data['row'] = $row;
        $data['text'] = '拉起支付中...';
        $data['payurl'] = '';
        $data['pic'] = '';
        $data['mpjson'] = '';
        $text = $row['day'] > 0 ? '购买VIP'.$row['day'].'天' : '购买'.$row['cion'].'个金币';
        //判断订单是否支付
        if($row['pid'] == 0){
            if($this->myconfig['pay']['xzfpay']['open'] == 1){
                $this->load->library('ttpay');
                $this->ttpay->h5($row['dd'],$row['rmb'],$text,$row['paytype']);
            }else{
                //加载支付类
                $type = $row['paytype'];
                $this->load->library($type);
                //支付宝
                if($type == 'alipay'){
                    //微信内不支持宝
                    if(defined('IS_WX')){
                        //生成二维码
                        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
                        $qrcode_path = FCPATH.'annex/pay'.$row['id'].'.png';
                        $payurl = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/h5pay/index/'.$id;
                        QRcode::png($payurl,$qrcode_path,'L',9,1);
                        $data['pic'] = '<br><br><img src="'.imgToBase64($qrcode_path).'" style="width:160px;">';
                        $data['text'] = '微信内不能拉起支付宝<br>请先截屏，然后去支付宝扫码付款';
                    }else{
                        $this->$type->h5($row['dd'],$row['rmb'],$text);
                    }
                }else{
                    //微信内使用公众号支付
                    if(defined('IS_WX')){
                        //获取用户openid
                        $url = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/h5pay/index/'.$id;
                        $odata = $this->$type->openid($url);
                        $openid = $odata['openid'];
                        if(empty($openid)) error('获取openid失败');
                        //请求支付
                        $arr = $this->$type->mp($row['dd'],$row['rmb'],$text,$openid);
                        $data['mpjson'] = json_encode($arr);
                    }else{
                        $data['payurl'] = $this->$type->h5($row['dd'],$row['rmb'],$text);
                    }
                }
            }
        }
        //加载模板
        $this->load->view('pay.tpl',$data);
    }

    //PC扫码请求
    public function qrcode() {
        $paytoken = sys_auth(get_post('paytoken'),1);
        if(empty($paytoken)) error('非法请求');
        //记录订单
        $pid = $this->mydb->get_insert('user_order',$paytoken);
        if(!$pid) error('记录订单失败');
        if($this->myconfig['payurl'] == ''){
            $payurl = 'http://'.$_SERVER['HTTP_HOST'].links('h5pay/index/'.$pid);
        }else{
            $payurl = 'http://'.$this->myconfig['payurl'].links('h5pay/index/'.$pid);
        }
        header("location:".$payurl);
    }

    //支付状态
    public function init() {
        $id = (int)get_post('id');
        if($id == 0) get_json('ID不能为空',0);
        $row = $this->mydb->get_row('user_order',array('id'=>$id));
        if(!$row) get_json('记录不存在!');
        if($row['pid'] == 1){
            get_json('付款成功，3秒后刷新',1);
        }else{
            get_json('未付款!',0);
        }
    }

    //支付同步返回
    public function return_url($dd=''){
        $dd = safe_replace($dd);
        $row = $this->mydb->get_row('user_order',array('dd'=>$dd));
        if(!$row) error('订单不存在!');
        //加载模板
        $this->load->view('pay_bank.tpl',$row);
    }

    //支付异步返回处理
    public function notify_url($type='alipay'){
    	$this->load->library($type);
        //验证签名
        $arr = $this->$type->is_sign();
        if($arr){
            //支付订单号
            $dd = $arr['dd'];
            //商家订单号
            $trade_no = $arr['trade_no'];
            //判断订单是否存在
            $row = $this->mydb->get_row('user_order',array('dd'=>$dd));
            if($row){
                if($row['pid'] == 0){
                    //改变支付状态
                    $this->mydb->get_update('user_order',array('pid'=>1,'trade_no'=>$trade_no),$row['id']);
                    //判断充值类型
                    if($row['day'] > 0){
                        //改变会员VIP状态
                        $edit['vip'] = 1;
                        $viptime = getzd('user','viptime',$row['uid']);
                        if($viptime > time()){
                            $edit['viptime'] = $viptime+86400*$row['day'];
                        }else{
                            $edit['viptime'] = time()+86400*$row['day'];
                        }
                    }else{
                    	$cion = getzd('user','cion',$row['uid']);
                        $edit['cion'] = $cion+$row['cion'];
                        //写入金币记录
                        $this->mydb->get_insert('user_cion_list',array(
                            'cid' => 1,
                            'uid' => $row['uid'],
                            'cion' => $cion,
                            'text' => '在线充值金币',
                            'addtime' => time()
                        ));
                    }
                    $this->mydb->get_update('user',$edit,$row['uid']);
                    //代理分成
                    if($row['aid'] > 0){
                        $rowa = $this->mydb->get_row('agent',array('id'=>$row['aid']));
                        if($rowa){
                            $rmb = round($row['rmb']*($rowa['cfee']/100));
                            $this->mydb->get_update('agent',array('rmb'=>$rowa['rmb']+$rmb),$rowa['id']);
                        }
                    }
                }
            }
            echo 'success';
        }else{
            echo 'fail';
        }
    }
}