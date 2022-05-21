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
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $tid = (int)get_post('tid');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id'){
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
	        if($tid > 0) $where['tid'] = $tid-1;

	        //总数量
		    $total = $this->mydb->get_nums('topic',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('topic',$where,'*','addtime desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
				$list[$k]['pic'] = getpic($v['pic']);
				$list[$k]['hits'] = get_wan($v['hits']);
				$list[$k]['nums'] = $this->mydb->get_nums('vod',array('ztid'=>$v['id']));
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('topic/index.tpl');
		}
	}

	//专题视频
	public function vod($id=0,$op=''){
		$id = (int)$id;
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 100) $per_page = 100;
		    if($per_page == 0) $per_page = 10;

			//查询条件
		    $where = array('ztid'=>$id);
	        //总数量
		    $total = $this->mydb->get_nums('vod',$where);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('vod',$where,'*','addtime desc',$limit);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
				$list[$k]['pic'] = getpic($v['pic']);
				$list[$k]['hits'] = get_wan($v['hits']);
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['tid'] = $id;
			$this->load->view('topic/vod.tpl',$data);
		}
	}

	//推荐
	public function init() {
		$id = get_post('id');
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit['tid'] = $tid;
		$this->mydb->get_update('topic',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'tid' => 0,'name' => '','pic'=>'','text'=>'','hits'=>0);
		}else{
			$data = $this->mydb->get_row('topic',array('id'=>$id));
			if(!$data) error('专题不存在');
		}
		//输出
		$this->load->view('topic/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'tid' => (int)get_post('tid'),
			'hits' => (int)get_post('hits'),
			'name' => get_post('name',true),
			'pic' => get_post('pic',true),
			'text' => get_post('text',true),
			'addtime' => time()
		);
		if(empty($edit['name'])) get_json('请填写专题名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('topic',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('topic',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('topic',$id);
		$this->mydb->get_update('vod',array('ztid'=>0),$id,'ztid');
		get_json('删除成功');
	}

	//取消视频专题
	public function voddel(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_update('vod',array('ztid'=>0),$id);
		get_json('删除成功');
	}
}