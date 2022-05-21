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

class Fans extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//粉丝列表
	public function index() {
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('user_fans',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_fans',$where,'fuid','id DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$user = $this->mydb->get_row('user',array('id'=>$v['fuid']),'id,nickname,pic,vip');
	    	if(!$user) $user = array('id'=>0,'nickname'=>'用户不存在','pic'=>'','vip'=>0);
	    	$list[$k] = $user;
	    	//是否关注
	    	$row = $this->mydb->get_row('user_fans',array('fuid'=>$this->uid,'uid'=>$user['id']),'id');
	    	$list[$k]['is_funco'] = $row ? 1 : 0;
	    	unset($list[$k]['fuid']);
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//关注列表
	public function funco() {
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('fuid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('user_fans',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_fans',$where,'uid','id DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$user = $this->mydb->get_row('user',array('id'=>$v['uid']),'id,nickname,pic,vip');
	    	if(!$user) $user = array('id'=>0,'nickname'=>'用户不存在','pic'=>'','vip'=>0);
	    	$list[$k] = $user;
	    	$list[$k]['is_funco'] = 1;
	    	unset($list[$k]['uid']);
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//关注
	public function send() {
		$uid = (int)get_post('uid');
		if($uid == 0) get_json('uid error');
		if($uid == $this->uid) get_json('不能关注自己',0);
		//判断是否关注
		$row = $this->mydb->get_row('user_fans',array('uid'=>$uid,'fuid'=>$this->uid),'id');
		if($row){
			$this->mydb->get_del('user_fans',$row['id']);
			get_json('已取消关注',1);
		}else{
			$this->mydb->get_insert('user_fans',array('uid'=>$uid,'fuid'=>$this->uid,'addtime' => time()));
			get_json('关注成功',1);
		}
	}
}