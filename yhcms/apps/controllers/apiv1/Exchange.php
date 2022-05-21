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

class Exchange extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//兑换首页
	public function index() {
		$list = isset($this->myconfig['pay']['exchange']) ? $this->myconfig['pay']['exchange'] : array();
		$user = array('cion'=>$this->user['cion'],'list'=>$list);
		//输出
		get_json($user);
	}

	//兑换
	public function send() {
		$day = (int)get_post('day');
		if($day == 0) get_json('请选择兑换套餐',0);
		$cion = 0;
		foreach ($this->myconfig['pay']['exchange'] as $v) {
			if($v['day'] == $day){
				$cion = $v['cion'];
				break;
			}
		}
		if($cion == 0) get_json('套餐不存在',0);
		//判断金币数量
		if($this->user['cion'] < $cion) get_json('金币不足，去做任务赚取金币吧',0);
		//扣除金币
		$viptime = $this->user['viptime'] > time() ? $this->user['viptime']+$day*86400 :time()+$day*86400;
		$this->mydb->get_update('user',array('cion'=>$this->user['cion']-$cion,'vip'=>1,'viptime'=>$viptime),$this->uid);
		//写入兑换记录
		$this->mydb->get_insert('user_cion_list',array(
			'cid' => 2,
			'uid' => $this->uid,
			'cion' => $cion,
			'text' => '兑换'.$day.'天VIP',
			'addtime' => time()
		));
		get_json('兑换成功');
	}

	//兑换记录
	public function lists(){
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('user_cion_list',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_cion_list',$where,'cid,text,cion,addtime','id DESC',$limit);
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//购买视频
	public function vod(){
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('uid'=>$this->uid);
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_vod_buy',$where,'vid','id DESC',$limit,'','vid');
	    foreach ($list as $k => $v) {
	    	$list[$k] = $this->mydb->get_row('vod',array('id'=>$v['vid']),'id vid,name,pic,state');
	    }
        //记录数组
		$data['list'] = $list;
		get_json($data);
	}
}