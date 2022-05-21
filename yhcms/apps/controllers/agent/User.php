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

class User extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//模板目录
		$this->load->get_templates('agent');
		//判断是否登陆
		$this->agent = get_agent_islog();
	}

	public function index($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $vip = (int)get_post('vip');
	 	    $sex = (int)get_post('sex');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
 	    	$facility = get_post('facility',true);
 	    	$order = get_post('order',true);
	        if($page==0) $page=1;
	        $oarr = array('id','logtime','cion','qdznum');
	        if(!in_array($order,$oarr)) $order = 'id';
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    $where['aid'] = $this->agent['id'];
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id' || $zd == 'fid'){
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
	        if($vip > 0) $where['vip'] = $vip-1;
	        if(!empty($facility)) $where['facility'] = $facility;
	        if($sex > 0) $where['sex'] = $sex-1;

	        //总数量
		    $total = $this->mydb->get_nums('user',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['tel'] = get_sub($v['tel']);
		    	$list[$k]['pic'] = getpic($v['pic'],'user');
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	$list[$k]['logtime'] = $v['logtime'] > 0 ? date('Y-m-d H:i:s',$v['logtime']) : '---------';
		    	if(date('Y-m-d',$v['logtime']) == date('Y-m-d')) $list[$k]['logtime'] = '<font color=red>'.$list[$k]['logtime'].'</font>';
		    	$list[$k]['viptime'] = $v['viptime'] > 0 ? date('Y-m-d H:i:s',$v['viptime']) : '----------';
		    	if(date('Y-m-d',$v['viptime']) == date('Y-m-d')) $list[$k]['viptime'] = '<font color=red>'.$list[$k]['viptime'].'</font>';
		    	if(empty($v['facility'])) $list[$k]['facility'] = 'PC';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
	        $data['code'] = 0;
	        echo json_encode($data);exit;
		}else{
			$this->load->view('user/index.tpl');
		}
	}
}