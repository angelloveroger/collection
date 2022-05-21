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

class Lists extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index(){
		$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'*','xid asc',50);
		$this->load->view('lists/index.tpl',$data);
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'fid' => 0,'name' => '','xid'=>0);
		}else{
			$data = $this->mydb->get_row('class',array('id'=>$id));
			if(!$data) error('分类不存在');
		}
		$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',50);
		//输出
		$this->load->view('lists/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'fid' => (int)get_post('fid'),
			'xid' => (int)get_post('xid'),
			'name' => get_post('name',true)
		);
		if(empty($edit['name'])) get_json('请填写分类名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('class',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('class',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//批量修改
	public function update() {
		$ids = get_post('ids',true);
		if(empty($ids)) get_json('请选择要修改的数据',0);
		foreach ($ids as $_id) {
			$_id = (int)$_id;
			if($_id > 0){
				$edit = array();
				$edit['name'] = get_post('name_'.$_id,true);
				$edit['xid'] = (int)get_post('xid_'.$_id);
				$this->mydb->get_update('class',$edit,$_id);
			}
		}
		get_json('更新成功',1);
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('class',$id);
		$this->mydb->get_del('class',$id,'fid');
		get_json('删除成功');
	}
}