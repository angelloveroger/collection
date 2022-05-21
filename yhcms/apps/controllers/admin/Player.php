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

class Player extends My_Controller {
	
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
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

	        //总数量
		    $total = $this->mydb->get_nums('player');
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('player',array(),'*','xid asc',$limit);
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('player/index.tpl');
		}
	}

	//状态开关
	public function init() {
		$id = get_post('id');
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit['yid'] = $tid;
		$this->mydb->get_update('player',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'yid' => 0,'name' => '','alias'=>'','type'=>'app','text'=>'','jxurl'=>'','xid'=>0);
		}else{
			$data = $this->mydb->get_row('player',array('id'=>$id));
			if(!$data) error('播放器不存在');
		}
		//输出
		$this->load->view('player/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'yid' => (int)get_post('yid'),
			'xid' => (int)get_post('xid'),
			'name' => get_post('name',true),
			'alias' => get_post('alias',true),
			'text' => get_post('text',true),
			'type' => get_post('type',true),
			'jxurl' => get_post('jxurl',true)
		);
		if(empty($edit['name'])) get_json('请填写播放器名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('player',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('player',$edit,$id);
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
		$ids = get_post('id',true);
		foreach($ids as $_id){
			$id = (int)$_id;
			if($id > 5){
				$this->mydb->get_del('player',$id);
				$this->mydb->get_del('vod_zu',$id,'pid');
				$this->mydb->get_del('vod_ji',$id,'pid');
			}else{
				get_json('当前播放器无法删除',0);
			}
		}
		get_json('删除成功');
	}
}