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

class Pay extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('cion,vip,viptime',1);//判断登录
	}

	//VIP套餐
	public function index() {
		$data = $this->user;
		$data['list'] = $this->myconfig['pay']['vip'];
		$data['alipay'] = $this->myconfig['pay']['alipay']['open'];
		$data['wxpay'] = $this->myconfig['pay']['wxpay']['open'];
		get_json($data);
	}

	//金币套餐
	public function cion() {
		$data = $this->user;
		$data['rmbtocion'] = $this->myconfig['pay']['rmbtocion'];
		$data['list'] = $this->myconfig['pay']['cion'];
		$data['alipay'] = $this->myconfig['pay']['alipay']['open'];
		$data['wxpay'] = $this->myconfig['pay']['wxpay']['open'];
		get_json($data);
	}

	//记录充值订单
	public function send() {
		$type = get_post('type'); //vip,cion,card
		$day = (int)get_post('day');
		$rmb = (int)get_post('cion');
		$paytype = get_post('paytype');
		if($paytype != 'wxpay') $paytype = 'alipay';
		if($type != 'cion' && $type != 'card') $type = 'vip';
        $card = get_post('card',true);
        //卡密充值
        if($type == 'card'){
            if(empty($card)) get_json('请填写点卡卡密',0);
            $row = $this->mydb->get_row('user_card',array('pass'=>$card));
            if(!$row || $row['uid'] > 0) get_json('卡密不存在',0);
            if($row['endtime'] > 0 && $row['endtime'] < time()) get_json('卡密已到期',0);
            if($row['type'] == 1){ //vip
                $viptime = $this->user['viptime'] > time() ? $this->user['viptime']+$row['nums']*86400 : time()+$row['nums']*86400;
                $this->mydb->get_update('user',array('vip'=>1,'viptime'=>$viptime),$this->uid);
            }else{
                $this->mydb->get_update('user',array('cion'=>$this->user['cion']+$row['nums']),$this->uid);
            }
            $this->mydb->get_update('user_card',array('uid'=>$this->uid,'paytime'=>time()),$row['id']);
            //代理分成
            if($row['aid'] > 0){
                $rowa = $this->mydb->get_row('agent',array('id'=>$row['aid']));
                if($rowa){
                    $rmb = round($row['rmb']*($rowa['cfee']/100));
                    $this->mydb->get_update('agent',array('rmb'=>$rowa['rmb']+$rmb),$rowa['id']);
                }
            }
            get_json('卡密兑换成功',1);
        }
		$ptitle = array('alipay'=>'支付宝','wxpay'=>'微信');
		if($this->myconfig['pay'][$paytype]['open'] == 0) get_json($ptitle[$paytype].'支付暂时关闭，请用其他方式付款',0);

        //获取金额
        if($type == 'cion'){ //金币
        	if($rmb == 0) get_json('请选择套餐',0);
            if($rmb > 10000) get_json('金币数量不能超过1W',0);
			//获取金额
			$cion = $rmb*$this->myconfig['pay']['rmbtocion'];
            $cions = $this->myconfig['pay']['cion'];
            foreach ($cions as $k => $v) {
				if($rmb == $v['rmb']){
					$cion = $v['cion'];
					break;
				}
			}
        }else{
        	$type = 'vip';
			if($day == 0) get_json('请选择套餐',0);
			//获取金额
			$rmb = 0;
			$vips = $this->myconfig['pay']['vip'];
			foreach ($vips as $k => $v) {
				if($day == $v['day']){
					$rmb = $v['rmb'];
					break;
				}
			}
			if($rmb == 0) get_json('套餐不存在',0);
		}
		//记录订单
		$pid = $this->mydb->get_insert('user_order',array(
			'uid' => $this->uid,
			'aid' => $this->user['aid'],
			'dd' => date('YmdHis').rand(1111,9999),
			'rmb' => $rmb,
            'day' => $type == 'vip' ? $day : 0,
            'cion' => $type == 'vip' ? 0 : $cion,
			'paytype' => $paytype,
			'facility' => get_post('facility'),
			'addtime' => time()
		));
		if(!$pid) get_json('记录订单失败',0);
		//输出
		$payurl = $this->myconfig['payurl'] == '' ? $_SERVER['HTTP_HOST'] : $this->myconfig['payurl'];
		$data['payurl'] = 'http://'.$payurl.links('h5pay/index/'.$pid);
		get_json($data);
	}

	//充值记录
	public function lists() {
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('pid'=>1,'uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('user_order',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_order',$where,'day,cion,rmb,addtime','id DESC',$limit);
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//卡密记录
	public function cardlist() {
		$page = (int)get_post('page');
		$size = 15;
		if($page == 0) $page = 1;
		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('user_card',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_card',$where,'type,pass,nums,paytime','id DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$list[$k]['paytime'] = date('Y-m-d H:i:s',$v['paytime']);
	    }
        //记录数组
		$data['list'] = $list;
		get_json($data);
	}
}