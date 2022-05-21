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

class Links extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		//判断是否登陆
		get_admin_islog();
	}

	//友情链接列表
	public function index($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
	        if($page==0) $page=1;

	        //总数量
		    $total = $this->mydb->get_nums('links');
			//每页数量
		    if($per_page == 0) $per_page = 20;
		    if($per_page > 100) $per_page = 100;
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($page > $pagejs) $page = $pagejs;
		    if($total < $per_page) $per_page = $total;
		    $limit = array($per_page,$per_page*($page-1));
	        //记录数组
	        $data['count'] = $total;
		    $data['data'] = $this->mydb->get_select('links','','*','id DESC',$limit);
			get_json($data,0);
		}else{
			$this->load->view('links/index.tpl');
		}
	}

	//友情链接增加编辑
	public function edit($id=0){
 	    $id = (int)$id;
	    $data = array();
		if($id==0){
            $data['id'] = 0;
            $data['name'] = '';
            $data['url'] = 'http://';
		}else{
            $data = $this->mydb->get_row("links",array('id'=>$id)); 
		}
        $this->load->view('links/edit.tpl',$data);
	}

	//友情链接修改
	public function save(){
 	    $id = (int)$this->input->post('id',true);
		$data['name'] = $this->input->post('name',true);
		$data['url'] = $this->input->post('url',true);
		if(empty($data['name'])){
            get_json('链接名称不能为空~！');
		}
		if(empty($data['url'])){
            get_json('链接地址不能为空~！');
		}
		if($id==0){
            $this->mydb->get_insert('links',$data);
		}else{
            $this->mydb->get_update('links',$data,$id);
		}
		$arr['msg'] = '恭喜您，操作成功~!';
		$arr['url'] = links('links');
		$arr['parent'] = 1;
		get_json($arr,1);
	}

    //删除友情链接
	public function del($id=0){
 	    $id = (int)$id;
 	    if($id == 0){
 	    	$ids = get_post('id',true);
 	    	$ids = implode(',',$ids);
 	    	if(is_numeric($ids) || preg_match('/^([0-9]+[,]?)+$/', $ids)){
				$id = $ids;
			}
 	    }
 	    if(empty($id)) get_json('ID不能为空~!');
 	    $arr = explode(',', $id);
 	    foreach ($arr as $_id) {
 	    	$this->mydb->get_del('links',$_id);
 	    }
		$arr['msg'] = '恭喜您，删除成功~!';
		$arr['url'] = links('links');
		get_json($arr,1);
	}
}