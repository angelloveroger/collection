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

class Star extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//主页
	public function index() {
	    $size = (int)get_post('size');
	    if($size == 0 || $size > 99) $size = 12;
	    $list = array();
		$list[] = array(
		    'id' => 0,
		    'name' => '热门明星',
		    'star'=> $this->mydb->get_select('star','','id,name,pic','hits DESC',$size)
		);
		$class = $this->mydb->get_select('star_class','','id,name','xid ASC',6);
		foreach ($class as $k=>$row){
		    $list[] = array(
    		    'id' => $row['id'],
    		    'name' => '最新'.$row['name'],
    		    'star'=> $this->mydb->get_select('star',array('cid'=>$row['id']),'id,name,pic','id DESC',$size)
    		);
		}
        //记录数组
		$data['list'] = $list;
		get_json($data);
	}
	
	//自定义获取
	public function data() {
		$cid = (int)get_post('cid');
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		$sort = get_post('sort',true); //排序方式
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		$sarr = array('id','hits');
		if(!in_array($sort, $sarr)) $sort = 'id';
		//查询条件
		$where = array();
		if($cid > 0) $where['cid'] = $cid;
		//总数量
	    $nums = $this->mydb->get_nums('star',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
		//输出
		$data['nums'] = $nums;
		$data['page'] = $page;
		$data['pagejs'] = $pagejs;
		$data['list'] = $this->mydb->get_select('star',$where,'id,name,pic,hits',$sort.' DESC',$limit);
		get_json($data);
	}
	
	//演员资料
	public function info(){
		$id = (int)get_post('id');
		$row = $this->mydb->get_row('star',array('id'=>$id));
		if(!$row) get_json('演员不存在',0);
		$row['text'] = str_checkhtml($row['text']);
		//分享地址
		$row['share_text'] = $this->myconfig['sharetxt'];
		$row['share_url'] = get_share_url($this->uid);
		//增加人气
		$this->mydb->get_update('star',array('hits'=>$row['hits']+1),$row['id']);
		get_json($row);
	}

	//演员视频
	public function vod(){
		$actor = get_post('actor',true);
		$cid = (int)get_post('cid');
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		if(empty($actor)) get_json('演员不能为空',0);
		
		//查询条件
		$where = $like = array();
		$like['actor'] = $actor;
		if($cid > 0) $where['cid'] = get_cid($cid);
		//总数量
	    $nums = $this->mydb->get_nums('vod',$where,$like);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('vod',$where,'id,name,pic,actor,year,state,text,pay','rhits DESC',$limit,$like);
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}
}