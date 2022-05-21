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

class Topic extends My_Controller {

	public function __construct(){
		parent::__construct();
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//专题列表
	public function index() {
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		//总数量
	    $nums = $this->mydb->get_nums('topic');
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $this->mydb->get_select('topic','','id,name,pic','id DESC',$limit);
		get_json($data);
	}

	//专题详情
	public function info(){
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		$id = (int)get_post('id');
		$row = $this->mydb->get_row('topic',array('id'=>$id));
		if(!$row) get_json('合集不存在',0);
		//判断合集是否收藏
		$row['fav'] = 0;
		if($this->uid > 0){
			$rowf = $this->mydb->get_row('topic_fav',array('tid'=>$id,'uid'=>$this->uid));
			if($rowf) $row['fav'] = 1;
		}
		//总数量
	    $nums = $this->mydb->get_nums('vod',array('ztid'=>$id));
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('vod',array('ztid'=>$id),'id,name,pic,actor,year,state,text,pay','rhits DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$rowf = $this->uid == 0 ? false : $this->mydb->get_row('fav',array('vid'=>$v['id'],'uid'=>$this->uid));
	    	$list[$k]['fav'] = $rowf ? 1 : 0;
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['info'] = $row;
		$data['list'] = $list;
		//增加人气
		$this->mydb->get_update('topic',array('hits'=>$row['hits']+1),$row['id']);
		get_json($data);
	}
}
