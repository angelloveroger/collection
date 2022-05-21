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

class Pay extends My_Controller {
	
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
	 	    $pid = (int)get_post('pid');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$type = get_post('type',true);
			$paytype = get_post('paytype',true);
			$facility = get_post('facility',true);
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
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if($pid > 0) $where['pid'] = $pid-1;
	        if($type == 'vip') $where['day>'] = 0;
	        if($type == 'cion') $where['cion>'] = 0;
	        if(!empty($paytype)) $where['paytype'] = $paytype;
	        if(!empty($facility)) $where['facility'] = $facility;

	        //总数量
		    $total = $this->mydb->get_nums('user_order',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user_order',$where,'*','addtime desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	if(empty($list[$k]['trade_no'])) $list[$k]['trade_no'] = '---------';
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
	        $data['code'] = 0;
	        echo json_encode($data);exit;
		}else{
			$this->load->view('pay/index.tpl');
		}
	}
}