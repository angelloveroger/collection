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

class Card extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//模板目录
		$this->load->get_templates('agent');
		//判断是否登陆
		$this->agent = get_agent_islog();
	}

	//卡密列表
	public function index($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $type = (int)get_post('type');
	 	    $zt = (int)get_post('zt');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$tzd = get_post('tzd',true);
			if($tzd != 'endtime') $tzd = 'paytime';
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    $where['aid'] = $this->agent['id'];
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'uid'){
		    		$where[$zd] = (int)$key;
		    	}else{
		    		$like[$zd] = $key;
		    	}
		    }
	        if(!empty($kstime)){
	        	$where[$tzd.'>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where[$tzd.'<'] = strtotime($jstime)+86401;
	        }
	        if($type > 0) $where['type'] = $type;
	        if($zt == 1) $where['uid>'] = 0;
	        if($zt == 2) $where['uid'] = 0;

	        //总数量
		    $total = $this->mydb->get_nums('user_card',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user_card',$where,'*','id desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['paytime'] = $v['paytime'] > 0 ? date('Y-m-d H:i:s',$v['paytime']) : '------';
		    	if(date('Y-m-d',$v['paytime']) == date('Y-m-d')) $list[$k]['paytime'] = '<font color=red>'.$list[$k]['paytime'].'</font>';
		    	$list[$k]['endtime'] = $v['endtime'] > 0 ? date('Y-m-d H:i:s',$v['endtime']) : '永久不过期';
		    	if(date('Y-m-d',$v['endtime']) == date('Y-m-d')) $list[$k]['endtime'] = '<font color=red>'.$list[$k]['endtime'].'</font>';
		    	if($v['uid'] == 0) $list[$k]['uid'] = '---';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
	        $data['code'] = 0;
	        echo json_encode($data);exit;
		}else{
			$this->load->view('card/index.tpl');
		}
	}

	//导出卡密
	public function daochu(){
		$id = get_post('id',true);
		if(empty($id)) exit('请选择要导出的卡密');
		$ids = explode(',',$id);
		$text = '';
		foreach ($ids as $k=>$_id) {
			$_id = (int)$_id;
			if($_id > 0){
				$row = $this->mydb->get_row('user_card',array('id'=>$_id,'aid'=>$this->agent['id']),'pass');
				if($row){
					if($k == 0){
						$text .= $row['pass'];
					}else{
						$text .= "\r\n".$row['pass'];
					}
				}
			}
		}
		$this->load->helper('download');
		$name = 'Yhcms-card-'.time().'.txt';
		force_download($name, $text);
	}
}