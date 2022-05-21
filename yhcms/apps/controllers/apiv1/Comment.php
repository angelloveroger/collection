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

class Comment extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//评论列表
	public function index() {
		$vid = (int)get_post('vid');
		$did = (int)get_post('did');
		$bid = (int)get_post('bid');
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;
		if($vid == 0 && $bid == 0 && $did == 0) get_json('数据ID错误',0);

		//查询条件
		$where = array('yid'=>0,'fid'=>0);
		if($vid > 0) $where['vid'] = $vid;
		if($did > 0) $where['did'] = $did;
		if($bid > 0) $where['bid'] = $bid;

		//总数量
	    $nums = $this->mydb->get_nums('comment',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('comment',$where,'id,uid,text,zan,addtime','id DESC',$limit);
		$list = $this->data_replace($list);
		foreach ($list as $k => $v) {
		    $list[$k]['reply_num'] = $this->mydb->get_nums('comment',array('fid'=>$v['id'],'yid'=>0));
			$list[$k]['reply'] = $this->data_replace($this->mydb->get_select('comment',array('fid'=>$v['id']),'id,uid,text,zan,addtime','id desc',3));
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//我的评论列表
	public function my() {
		get_islog('*',1);//判断登录
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('uid'=>$this->uid,'fid'=>0);
		//总数量
	    $nums = $this->mydb->get_nums('comment',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('comment',$where,'id,vid,did,bid,uid,text,zan,addtime','id DESC',$limit);
		$list = $this->data_replace($list);
		foreach ($list as $k => $v) {
		    $list[$k]['reply_num'] = $this->mydb->get_nums('comment',array('fid'=>$v['id'],'yid'=>0));
			$list[$k]['reply'] = $this->data_replace($this->mydb->get_select('comment',array('fid'=>$v['id'],'yid'=>0),'id,uid,text,zan,addtime','id desc',3));
			if($v['vid'] > 0) $list[$k]['vname'] = getzd('vod','name',$v['vid']);
			if($v['bid'] > 0) $list[$k]['vname'] = getzd('bbs','name',$v['bid']);
			if($v['did'] > 0) $list[$k]['vname'] = getzd('myopia','text',$v['did']);
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//评论详情
	public function reply() {
	    $id = (int)get_post('id');
	    $page = (int)get_post('page');
		$size = (int)get_post('size'); //每页数量
		if($size == 0) $size = 10;
		if($page == 0) $page = 1;
		if($id == 0) get_json('评论ID为空',0);
		if($page == 1){
    		$comment = array();
    		$comment[] = $this->mydb->get_row('comment',array('id'=>$id),'id,uid,text,zan,addtime');
    		if(empty($comment[0])) get_json('评论不存在',0);
    		$data['comment'] = $this->data_replace($comment)[0];
		}
		//查询条件
		$where = array('fid'=>$id,'yid'=>0);
		//总数量
		$nums = $this->mydb->get_nums('comment',$where);
		//总页数
		$pagejs = ceil($nums / $size);
		if($pagejs == 0) $pagejs = 1;
		//偏移量
	    $limit = array($size,$size*($page-1));
		$list = $this->mydb->get_select('comment',$where,'id,uid,text,zan,addtime','id desc',$limit);
		//输出
		$data['code'] = 1;
		$data['nums'] = $nums;
		$data['page'] = $page;
		$data['pagejs'] = $pagejs;
		$data['list'] = $this->data_replace($list);
		get_json($data);
	}

	//新增评论
	public function add() {
		get_islog('*',1);//判断登录
		$vid = (int)get_post('vid');
		$did = (int)get_post('did');
		$bid = (int)get_post('bid');
		$fid = (int)get_post('fid');
		$text = get_post('text',true);
		if($vid == 0 && $bid == 0 && $did == 0) get_json('数据ID不能为空',0);
		if(empty($text)) get_json('评论内容不能为空',0);
		if(strlen($text) > 200) get_json('评论内容最多只能200字',0);
		//控制每人每天发表数量
		if($this->myconfig['comment']['day_num'] > 0){
			$jtime = strtotime(date('Y-m-d 0:0:0'))-1;
			$pcount = $this->mydb->get_nums('comment',array('uid'=>$this->uid,'addtime>'=>$jtime));
			if($pcount >= $this->myconfig['comment']['day_num'])  get_json('当日评论数量已上限',0);
		}
		//判断评论间隔时长
		$row = $this->mydb->get_row('comment',array('uid'=>$this->uid),'addtime','addtime desc');
		if($row && $row['addtime']+30 > time()) get_json('休息一下吧',0);
		//入库
		$res = $this->mydb->get_insert('comment',array(
			'uid' => $this->uid,
			'vid' => $vid,
			'did' => $did,
			'bid' => $bid,
			'text' => emoji_replace($text),
			'fid' => $fid,
			'yid' => $this->myconfig['comment']['audit'],
			'addtime' => time()
		));
		if(!$res) get_json('评论失败，稍后再试',0);
		//评论消息
		$uid = 0;
		if($fid > 0){
			$sid = 4;
			$uid = (int)getzd('comment','uid',$fid);
			$did = $fid;
		}elseif($bid > 0){
			$sid = 3;
			$uid = (int)getzd('bbs','uid',$bid);
			$did = $bid;
		}elseif($did > 0){
			$sid = 2;
		}else{
			$sid = 1;
			$did = $vid;
		}
		$this->mydb->get_insert('user_message',array(
			'uid' => $uid,
			'fuid' => $this->uid,
			'did' => $did,
			'sid' => $sid,
			'text' => emoji_replace($text),
			'addtime' => time()
		));
		get_json('评论成功',1);
	}

	//评论点赞
	public function zan() {
		get_islog('*',1);//判断登录
		$id = (int)get_post('id');
		if($id == 0) get_json('ID不能为空',0);
		$row1 = $this->mydb->get_row('comment',array('id'=>$id));
		if(!$row1) get_json('评论不存在',0);
		$row = $this->mydb->get_row('comment_zan',array('did'=>$id,'uid'=>$this->uid));
		if($row){
			$this->mydb->get_del('comment_zan',$row['id']);
			//减去点赞次数
			if($row1['zan'] > 0) $this->mydb->get_update('comment',array('zan'=>$row1['zan']-1),$id);
			get_json('取消点赞成功',1);
		}else{
			$this->mydb->get_insert('comment_zan',array('did'=>$id,'uid'=>$this->uid));
			//增加点赞次数
			$this->mydb->get_update('comment',array('zan'=>$row1['zan']+1),$id);
			get_json('点赞成功',1);
		}
	}

	//评论删除
	public function del() {
		get_islog('*',1);//判断登录
		$id = (int)get_post('id');
		if($id == 0) get_json('ID不能为空',0);
		$row = $this->mydb->get_row('comment',array('id'=>$id),'uid');
		if(!$row || $row['uid'] != $this->uid) get_json('评论不存在',0);
		$this->mydb->get_del('comment',$id);
		//删除消息
		$this->mydb->get_del('user_message',array('sid'=>4,'did'=>$id));
		get_json('删除成功',1);
	}

	//举报类型
	public function report_type(){
		$data['list'] = $this->myconfig['report'];
		get_json($data);
	}

	//举报提交
	public function report(){
		get_islog('*',1);//判断登录
		$id = (int)get_post('id');
		$type = get_post('type',true);
		$text = get_post('text',true);
		if($id == 0) get_json('评论ID不能为空',0);
		if(empty($type)) get_json('请选择举报类型',0);
		$row = $this->mydb->get_row('comment',array('id'=>$id),'uid');
		if(!$row) get_json('评论不存在',0);
		$row = $this->mydb->get_row('comment_report',array('did'=>$id,'uid'=>$this->uid),'id');
		if($row) get_json('您的举报已收到，我们会尽快核实',0);
		//入库
		$this->mydb->get_insert('comment_report',array(
			'uid' => $this->uid,
			'did' => $id,
			'type' => $type,
			'text' => $text,
			'addtime' => time()
		));
		get_json('举报成功',1);
	}
	
	//数据替换
	private function data_replace($arr) {
		foreach ($arr as $k => $v) {
		    $arr[$k]['text'] = emoji_replace($v['text'],1);
			$arr[$k]['addtime'] = datetime($v['addtime']);
			$row = $this->mydb->get_row('user',array('id'=>$v['uid']),'nickname,pic,vip');
			$arr[$k]['nickname'] = $row ? $row['nickname'] : '佚名';
			$arr[$k]['upic'] = $row ? getpic($row['pic'],'user') : getpic('','user');
			$arr[$k]['vip'] = $row ? $row['vip'] : 0;
			//检测是否赞过
			$arr[$k]['is_zan'] = 0;
			//判断删除权限
			$arr[$k]['is_del'] = 0;
			if($this->uid > 0){
				if($this->uid == $v['uid']) $arr[$k]['is_del'] = 1;
			    $rowz = $this->mydb->get_row('comment_zan',array('did'=>$v['id'],'uid'=>$this->uid),'id');
			    if($rowz) $arr[$k]['is_zan'] = 1;
			}
		}
		return $arr;
	}
}
