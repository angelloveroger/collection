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

class Fav extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//视频收藏
	public function vod() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		if($page == 0) $page = 1;
		if($size == 0) $size = 15;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('fav',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('fav',$where,'vid','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('vod',array('id'=>$v['vid']),'id vid,name,pic,state');
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//专题收藏
	public function topic() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		if($page == 0) $page = 1;
		if($size == 0) $size = 15;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('topic_fav',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('topic_fav',$where,'tid','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('topic',array('id'=>$v['tid']),'id tid,name,pic');
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//短视收藏
	public function myopia() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		if($page == 0) $page = 1;
		if($size == 0) $size = 15;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('myopia_zan',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('myopia_zan',$where,'did','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('myopia',array('id'=>$v['did']),'id,pic,text,hits,zan');
			$list[$k]['is_zan'] = 1;
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//帖子收藏
	public function bbs() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		if($page == 0) $page = 1;
		if($size == 0) $size = 15;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('bbs_zan',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('bbs_zan',$where,'did','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('bbs',array('id'=>$v['did']),'id,uid,cid,ding,name,text,zan,addtime');
			$list[$k]['label'] = $this->mydb->get_row('bbs_class',array('id'=>$list[$k]['cid']),'id,name,pic');
		    $list[$k]['comment_num'] = $this->mydb->get_nums('comment',array('bid'=>$list[$k]['id'],'yid'=>0));
		    $list[$k]['user'] = $this->mydb->get_row('user',array('id'=>$list[$k]['uid']),'id,nickname,pic,vip');
		    $pislist = $this->mydb->get_select('bbs_pic',array('bid'=>$list[$k]['id']),'url','id ASC',10);
		    $pics = array();
		    foreach ($pislist as $v2) $pics[] = getpic($v2['url']);
			$list[$k]['pics'] = $pics;
			//是否赞过
			$list[$k]['is_zan'] = 1;
			$list[$k]['is_funco'] = 0;
			$rowz = $this->mydb->get_row('user_fans',array('uid'=>$list[$k]['uid'],'fuid'=>$this->uid),'id');
			if($rowz) $list[$k]['is_funco'] = 1;
			$list[$k]['is_admin'] = $list[$k]['uid'] == $this->myconfig['bbs']['admin'] ? 1 : 0;
			$list[$k]['share_url'] = $list[$k]['name']."\r\n".get_share_url($this->uid,$list[$k]['id'],'bbs');
			unset($list[$k]['cid']);
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//提交收藏
	public function add(){
		$did = (int)get_post('did');
		$type = get_post('type',true);
		if($did == 0) get_json('数据ID为空',0);
		$tarr = array('vod','topic','myopia','bbs');
		if(!in_array($type, $tarr)) get_json('type error',0);
		//判断数据是否存在
		$vzd = '';
		$txt = '收藏';
		if($type == 'topic'){
			$zd = 'tid';
			$table = 'topic_fav';
		}elseif($type == 'myopia'){
			$vzd = 'zan';
			$zd = 'did';
			$table = 'myopia_zan';
			$txt = '点赞';
		}elseif($type == 'bbs'){
			$vzd = 'zan';
			$zd = 'did';
			$table = 'bbs_zan';
			$txt = '点赞';
		}else{
			$vzd = 'shits';
			$zd = 'vid';
			$table = 'fav';
		}
		$fzd = $vzd ? 'id,'.$vzd : 'id';
		$rowv = $this->mydb->get_row($type,array('id'=>$did),$fzd);
		if(!$rowv) get_json('数据不存在',0);
		//判断是否收藏
		$row = $this->mydb->get_row($table,array($zd=>$did,'uid'=>$this->uid),'id');
		if($row){
		    $this->mydb->get_del($table,$row['id']);
		    if($vzd) $this->mydb->get_update($type,array($vzd=>$rowv[$vzd]-1),$did);
		    get_json('已取消'.$txt);
		}else{
    		//记录收藏
    		$this->mydb->get_insert($table,array(
    			$zd => $did,
    			'uid' => $this->uid,
    			'addtime' => time()
    		));
    		if($vzd) $this->mydb->get_update($type,array($vzd=>$rowv[$vzd]+1),$did);
    		get_json($txt.'成功');
		}
	}

	//删除收藏
	public function del(){
		$did = get_post('did',true);
		$type = get_post('type',true);
		if(empty($did)) get_json('数据ID为空',0);
		$tarr = array('vod','topic','myopia','bbs');
		if(!in_array($type, $tarr)) get_json('type error',0);
		$vzd = '';
		//数据表
		if($type == 'topic'){
			$zd = 'tid';
			$table = 'topic_fav';
		}elseif($type == 'myopia'){
			$vzd = 'zan';
			$zd = 'did';
			$table = 'myopia_zan';
		}elseif($type == 'bbs'){
			$vzd = 'zan';
			$zd = 'did';
			$table = 'bbs_zan';
		}else{
			$vzd = 'shits';
			$zd = 'vid';
			$table = 'fav';
		}
		if(is_numeric($did)){
			$row = $this->mydb->get_row($table,array($zd=>(int)$did,'uid'=>$this->uid),'id');
			if(!$row) get_json('数据不存在',0);
			if($vzd) $this->db->query('update '._DBPREFIX_.$type.' set '.$vzd.'='.$vzd.'-1 where id='.(int)$did);
			$this->mydb->get_del($table,array($zd=>(int)$did,'uid'=>$this->uid));
		}else{
			$did = explode(',', $did);
			foreach ($did as $_did){
				$this->mydb->get_del($table,array($zd=>(int)$_did,'uid'=>$this->uid));
			}
		}
		get_json('操作成功');
	}
}