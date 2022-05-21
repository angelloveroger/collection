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

class Message extends My_Controller {

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
		$sid = (int)get_post('sid');
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		if($sid != 2) $sid = 1;

		//查询条件
		$where = array('uid'=>$this->uid);
		if($sid == 1){
			$where['sid>'] = 0;
		}else{
			$where['sid'] = 0;
		}
		//总数量
	    $nums = $this->mydb->get_nums('user_message',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_message',$where,'*','id DESC',$limit);
	    foreach ($list as $k => $v) {
	    	if($v['fuid'] == 0){
	    		$list[$k]['user'] = array('id'=>0,'pic'=>'','nickname'=>'系统消息');
	    	}else{
	    		$list[$k]['user'] = $this->mydb->get_row('user',array('id'=>$v['fuid']),'id,pic,nickname');
	    	}
	    	//数据
	    	$list[$k]['data'] = (object)array();
	    	$rowc = false;
	    	if($v['did'] > 0){
	    		if($v['sid'] == 4){
	    			$rowc = $this->mydb->get_row('comment',array('id'=>$v['did']),'id,vid,bid,did,text');
	    			if($rowc){
	    				if($rowc['vid'] > 0){
	    					$list[$k]['data'] = $this->mydb->get_row('vod',array('id'=>$rowc['vid']),'id,name');
	    					$list[$k]['sid'] = 1;
	    				}elseif($rowc['bid'] > 0){
	    					$list[$k]['data'] = $this->mydb->get_row('bbs',array('id'=>$rowc['bid']),'id,name');
	    					$list[$k]['sid'] = 3;
	    				}elseif($rowc['did'] > 0){
	    					$list[$k]['data'] = $this->mydb->get_row('myopia',array('id'=>$rowc['did']),'id,text name');
	    					$list[$k]['sid'] = 2;
	    				}
	    				unset($rowc['vid'],$rowc['bid'],$rowc['did'],$rowc['cid']);
	    			}
	    		}else{
	    			if($v['sid'] == 1){
    					$list[$k]['data'] = $this->mydb->get_row('vod',array('id'=>$v['did']),'id,name');
    				}elseif($v['sid'] == 3){
    					$list[$k]['data'] = $this->mydb->get_row('bbs',array('id'=>$v['did']),'id,name');
    				}elseif($v['sid'] == 2){
    					$list[$k]['data'] = $this->mydb->get_row('myopia',array('id'=>$v['did']),'id,text name');
    				}
	    		}
	    	}
	    	$list[$k]['comment'] = $rowc ? $rowc : (object)array();
	    	$list[$k]['text'] = $rowc ? '回复了你：'.$v['text'] : '评论了你：'.$v['text'];
			//设为已读
			if($v['look'] == 0){
				$this->mydb->get_update('user_message',array('look'=>1),$v['id']);
			}
			unset($list[$k]['look'],$list[$k]['uid'],$list[$k]['fuid'],$list[$k]['did']);
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//删除
	public function del() {
		$id = (int)get_post('id');
		if($id == 0) get_json('id error');
		$this->mydb->get_del('user_message',array('uid'=>$this->uid,'id'=>$id));
		get_json('删除成功',1);
	}
}