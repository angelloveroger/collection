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

class Bbs extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function setting(){
		if(!isset($this->myconfig['bbs'])){
			$data['bbs'] = array(
			    'open' => 0,
			    'uids' => array(),
			    'daynum' => 0,
			    'audit' => 0,
			    'cion' => 0,
			    'admin' => 0
			);
		}else{
			$data['bbs'] = $this->myconfig['bbs'];
		}
		$this->load->view('bbs/setting.tpl',$data);
	}

	//配置保存
	public function setting_save(){
		$config = $this->myconfig;
		$uids = get_post('uids',true);
		$config['bbs'] = array(
		    'open' => (int)get_post('open'),
		    'uids' => !empty($uids) ? explode('|',$uids) : array(),
			'daynum' => (int)get_post('daynum'),
		    'audit' => (int)get_post('audit'),
		    'cion' => (int)get_post('cion'),
		    'admin' => (int)get_post('admin'),
		);
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('bbs/setting');
		get_json($d,1);
	}

	public function index($yid=1,$op=''){
		$yid = (int)$yid;
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $cid = (int)get_post('cid');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$ding = (int)get_post('ding',true);
			$reco = (int)get_post('reco',true);
 	    	$order = get_post('order',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;
		    $sarr = array('hits','zan','id');
		    if(!in_array($order, $sarr)) $order = 'id';

			//查询条件
		    $where = $like = array();
		    $where['yid'] = (int)($yid-1);
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'uid' || $zd == 'id'){
		    		$where[$zd] = (int)$key;
		    	}else{
		    		$like[$zd] = $key;
		    	}
		    }
	        if(!empty($kstime)){
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if($cid > 0) $where['cid'] = $cid;
	        if($ding > 0) $where['ding'] = ($ding-1);
	        if($reco > 0) $where['reco'] = ($reco-1);

	        //总数量
		    $total = $this->mydb->get_nums('bbs',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('bbs',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$row = $this->mydb->get_row('bbs_pic',array('bid'=>$v['id'],'id'));
		    	$list[$k]['ispic'] = $row ? 1 : 0;
		    	$list[$k]['cname'] = getzd('bbs_class','name',$v['cid']);
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['class'] = $this->mydb->get_select('bbs_class','','*','xid asc',100);
			$data['yid'] = $yid;
			$this->load->view('bbs/index.tpl',$data);
		}
	}

	//状态
	public function init($zd='tid') {
		if($zd != 'reco') $zd = 'ding';
		$id = get_post('id',true);
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit[$zd] = $tid;
		$this->mydb->get_update('bbs',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit() {
		$id = (int)get_post('id');
		$bbs = $this->mydb->get_row('bbs',array('id'=>$id));
		if(!$bbs) error('帖子不存在');
		$bbs['class'] = $this->mydb->get_select('bbs_class',array(),'id,name','xid asc',50);
		//输出
		$this->load->view('bbs/edit.tpl',$bbs);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'name' => get_post('name',true),
			'text' => get_post('text',true),
			'cid' => (int)get_post('cid'),
			'ding' => (int)get_post('ding'),
			'reco' => (int)get_post('reco'),
			'yid' => (int)get_post('yid'),
			'hits' => (int)get_post('hits'),
			'zan' => (int)get_post('zan'),
			'uid' => (int)get_post('uid'),
		);
		if($id == 0) get_json('ID不能为空',0);
		$this->mydb->get_update('bbs',$edit,$id);
		//输出
		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//批量审核
	public function audit(){
		$ids = get_post('id',true);
		if(empty($ids)) get_json('请选择帖子',0);
		if(is_array($ids)) $ids = implode(',',$ids);
		$this->mydb->get_update('bbs',array('yid'=>0),$ids);
		//发送系统消息
		$id2 = !is_array($ids) ? array($ids) : $ids;
		foreach ($id2 as $_id) {
			$row = $this->mydb->get_row('bbs',array('id'=>$_id),'uid,name');
			$this->mydb->get_insert('user_message',array('uid'=>$row['uid'],'did'=>$_id,'text'=>'您的帖子【'.$row['name'].'】已通过审核~','addtime'=>time()));
		}
		get_json('操作成功',1);
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		$ids = !is_array($id) ? array($id) : $id;
		//发送系统消息
		foreach ($ids as $_id) {
			$row = $this->mydb->get_row('bbs',array('id'=>$_id),'uid,yid,name');
			$text = $row['yid'] == 0 ? '已被删除~' : '审核不能通过~';
			$this->mydb->get_insert('user_message',array('uid'=>$row['uid'],'did'=>$_id,'text'=>'您的帖子【'.$row['name'].'】'.$text,'addtime'=>time()));
		}
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('bbs',$id);
		$this->mydb->get_del('bbs_pic',$id,'bid');
		$this->mydb->get_del('bbs_zan',$id,'did');
		$this->mydb->get_del('comment',$id,'bid');
		get_json('删除成功');
	}

	//帖子图片
	public function pic($op=''){
		$bid = (int)get_post('bid');
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'uid'){
		    		$where[$zd] = (int)$key;
		    	}else{
		    		$like[$zd] = $key;
		    	}
		    }
	        if(!empty($kstime)){
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if($bid > 0) $where['bid'] = $bid;

	        //总数量
		    $total = $this->mydb->get_nums('bbs_pic',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('bbs_pic',$where,'*','id desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['url'] = getpic($v['url']);
		    	$list[$k]['bname'] = getzd('bbs','name',$v['bid']);
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['bid'] = $bid;
			$this->load->view('bbs/pic.tpl',$data);
		}
	}

	//图片删除
	public function pic_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('bbs_pic',$id);
		get_json('删除成功');
	}


	public function lists(){
		$data['class'] = $this->mydb->get_select('bbs_class',array(),'*','xid asc',100);
		$this->load->view('bbs/lists.tpl',$data);
	}

	//修改
	public function lists_edit($id = 0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'name' => '','pic' => '','xid'=>0,'yid'=>0);
		}else{
			$data = $this->mydb->get_row('bbs_class',array('id'=>$id));
			if(!$data) error('分类不存在');
		}
		//输出
		$this->load->view('bbs/lists_edit.tpl',$data);
	}

	//入库
	public function lists_save() {
		$id = (int)get_post('id');
		$edit = array(
			'yid' => (int)get_post('yid'),
			'xid' => (int)get_post('xid'),
			'name' => get_post('name',true),
			'pic' => get_post('pic',true)
		);
		if(empty($edit['name'])) get_json('请填写分类名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('bbs_class',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('bbs_class',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//删除
	public function lists_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('bbs_class',$id);
		get_json('删除成功');
	}
}