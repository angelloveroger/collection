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

class Task extends My_Controller {
	
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
		    $total = $this->mydb->get_nums('user_task',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user_task',$where,'*','xid asc',$limit,$like);
		    foreach($list as $k=>$v){
		    	if($v['duration'] == 0) $list[$k]['duration'] = '--';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('task/index.tpl');
		}
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$row = $this->mydb->get_row('user_task',array(),'xid','xid desc');
			$xid = $row ? $row['xid']+1 : 1;
			$data = array('id'=>0,'type'=>'watch','name'=>'','text'=>'','day'=>1,'cion'=>0,'duration'=>0,'xid'=>$xid);
		}else{
			$data = $this->mydb->get_row('user_task',array('id'=>$id));
			if(!$data) error('用户不存在');
		}
		//输出
		$this->load->view('task/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'type' => get_post('type',true),
			'name' => get_post('name',true),
			'text' => get_post('text',true),
			'cion' => (int)get_post('cion'),
			'day' => (int)get_post('day'),
			'duration' => (int)get_post('duration'),
			'xid' => (int)get_post('xid')
		);
		if(empty($edit['type'])) get_json('请选择任务类型',0);
		if(empty($edit['name'])) get_json('请填写任务标题',0);
		if(empty($edit['text'])) get_json('请填写内容介绍',0);
		if($edit['type'] == 'watch' && empty($edit['duration'])) get_json('请填写观看时间',0);
		if($edit['cion'] == 0) get_json('奖励金币不能为空',0);
		//判断新增
		if($id == 0){
			$this->mydb->get_insert('user_task',$edit);
		}else{
			$this->mydb->get_update('user_task',$edit,$id);
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
		//删除用户信息
		$this->mydb->get_del('user_task',$id);
		$this->mydb->get_del('user_task_list',$id,'tid');
		get_json('删除成功');
	}
}