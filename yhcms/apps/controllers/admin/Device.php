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

class Device extends My_Controller {
	
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
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 100) $per_page = 100;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
	        if(!empty($kstime)){
	        	$where['date>'] = date('Ymd',strtotime($kstime)-1);
	        }
	        if(!empty($jstime)){
	        	$where['date<'] = date('Ymd',strtotime($jstime)+86401);
	        }

	        //总数量
		    $total = $this->mydb->get_nums('user_nums',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user_nums',$where,'*','date desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	if(date('Ymd') == $v['date']) $list[$k]['date'] = '<font color=red>'.$list[$k]['date'].'</font>';
		    	$list[$k]['add'] = '<b style="color:#080;">'.($v['android_add']+$v['ios_add']).'</b>';
		    	$list[$k]['num'] = '<b style="color:#f30;">'.($v['android_num']+$v['ios_num']).'</b>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('device/index.tpl');
		}
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('user_nums',$id);
		get_json('删除成功');
	}
}