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

class Feedback extends My_Controller {
	
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
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$type = get_post('type',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 100) $per_page = 100;
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
	        if(!empty($type)) $where['type'] = $type;

	        //总数量
		    $total = $this->mydb->get_nums('feedback',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('feedback',$where,'*','id desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	$list[$k]['reply_time'] = date('Y-m-d H:i:s',$v['reply_time']);
		    	if(date('Y-m-d',$v['reply_time']) == date('Y-m-d')) $list[$k]['reply_time'] = '<font color=red>'.$list[$k]['reply_time'].'</font>';
		    	if($v['reply_time'] == 0) $list[$k]['reply_time'] = '----';
		    	if(empty($v['reply_text'])) $list[$k]['reply_text'] = '----';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['type'] = $this->myconfig['feedback'];
			$this->load->view('feedback/index.tpl',$data);
		}
	}

	//反馈详情
	public function edit($id=0){
		$id = (int)$id;
		$row = $this->mydb->get_row('feedback',array('id'=>$id));
		if(!$row) error('反馈不存在');
		$this->load->view('feedback/edit.tpl',$row);
	}

	//反馈详情
	public function save(){
		$id = (int)get_post('id');
		if($id == 0) get_json('ID不能为空',0);
		$edit['reply_text'] = get_post('reply_text',true);
		if(!empty($edit['reply_text'])){
			$edit['reply_time'] = time();
		}else{
			$edit['reply_time'] = 0;
		}
		$this->mydb->get_update('feedback',$edit,$id);
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
		$this->mydb->get_del('feedback',$id);
		get_json('删除成功');
	}
}