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

class Sys extends My_Controller {
	
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

			//查询条件
		    $where = $like = array();
	        //总数量
		    $total = $this->mydb->get_nums('admin',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('admin',$where,'*','id desc',$limit,$like);
	        foreach ($list as $k => $v) {
	        	if(empty($v['qx'])) $list[$k]['qx'] = '超极管理员';
		    	$list[$k]['logtime'] = $v['logtime'] > 0 ? date('Y-m-d H:i:s',$v['logtime']) : '-----------';
		    	if(date('Y-m-d',$v['logtime']) == date('Y-m-d')) $list[$k]['logtime'] = '<font color=red>'.$list[$k]['logtime'].'</font>';
	        }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('sys/index.tpl');
		}
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'name' => '','qx'=>'');
		}else{
			$data = $this->mydb->get_row('admin',array('id'=>$id));
			if(!$data) error('管理员不存在');
		}
		$admin_nav = require_once FCPATH.'yhcms/config/admin_nav.php';
		$nav = array();
		foreach ($admin_nav as $k => $v) {
			$nav[$k]['title'] = $v['name'];
			$children = array();
			foreach ($v['list'] as $kk => $vv) {
				$children[$kk]['title'] = $vv['name'];
				$children[$kk]['id'] = $vv['url'];
				$children[$kk]['checked'] = strpos($data['qx'],$vv['url']) !== false;
			}
			$nav[$k]['children'] = $children;
		}
		$data['nav'] = $nav;
		//输出
		$this->load->view('sys/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$pass = get_post('pass',true);
		$edit = array(
			'name' => get_post('name',true),
			'qx' => get_post('qx',true)
		);
		if(empty($edit['name'])) get_json('账号不能为空',0);
		if(!empty($pass)) $edit['pass'] = md5($pass);
		//判断新增
		if($id == 0){
			if(empty($edit['pass'])) get_json('密码不能为空',0);
			$res = $this->mydb->get_insert('admin',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('admin',$edit,$id);
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
	    if(empty($ids)) get_json('请选择要修改的数据',0);
		foreach ($ids as $_id) {
			if($_id > 0){
			    if(get_cookie('admin_token') == $_id) get_json('不能删除自己',0);
				$this->mydb->get_del('admin',$_id);
			}
		}
		get_json('删除成功');
	}
}