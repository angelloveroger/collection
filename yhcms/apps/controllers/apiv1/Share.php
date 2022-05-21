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

class Share extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//邀请首页
	public function index() {
		//全站邀请记录
		$data['list'] = $this->data_replace($this->mydb->get_select('user',array('fid>'=>0),'fid','fid DESC',50,'','fid'));
		$data['my'] = $this->data_replace($this->mydb->get_select('user',array('fid'=>$this->uid),'nickname','id DESC',50));
		$data['share_rules'] = explode("\n", $this->myconfig['sharerules']);
		//分享内容
		$data['share_text'] = $this->myconfig['sharetxt']."\n".get_share_url($this->uid);
		$data['share_pic'] = 'http://'.$_SERVER['HTTP_HOST'].links('ajax/png/'.$this->uid).'.png?t='.time();
		get_json($data);
	}

	//邀请更多
	public function more() {
		$page = (int)get_post('page');
		if($page < 2) $page = 2;
		$size = 50;
		$limit = array($size,$size*($page-1));
		$data['list'] = $this->data_replace($this->mydb->get_select('user',array('fid'=>$this->uid),'id,nickname','id DESC',$limit));
		if(empty($data['list'])) get_json('没有更多了',0);
		get_json($data);
	}

	//数据替换
	private function data_replace($arr) {
		foreach ($arr as $k => $v) {
			if(isset($v['fid'])){
				$arr[$k]['nickname'] = get_sub(getzd('user','nickname',$v['fid']),1,1,3);
				$arr[$k]['nums'] = (int)$this->mydb->get_nums('user',array('fid'=>$v['fid']));
				$arr[$k]['vipday'] = $arr[$k]['nums']*$this->myconfig['user']['share_vip'];
				unset($arr[$k]['fid']);
			}else{
				$arr[$k]['vipday'] = $this->myconfig['user']['share_vip'];
			}
		}
		return $arr;
	}
}