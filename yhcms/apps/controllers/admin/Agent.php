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

class Agent extends My_Controller {
	
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
 	    	$order = get_post('order',true);
			$sid = (int)get_post('sid');
	        if($page==0) $page=1;
	        $oarr = array('id','logtime','rmb');
	        if(!in_array($order,$oarr)) $order = 'id';
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id'){
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
	        if($sid > 0) $where['sid'] = $sid-1;

	        //总数量
		    $total = $this->mydb->get_nums('agent',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('agent',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	$list[$k]['logtime'] = $v['logtime'] > 0 ? date('Y-m-d H:i:s',$v['logtime']) : '---------';
		    	if(date('Y-m-d',$v['logtime']) == date('Y-m-d')) $list[$k]['logtime'] = '<font color=red>'.$list[$k]['logtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('agent/index.tpl');
		}
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id'=>0,'name'=>'','cfee'=>70,'pay_name'=>'','pay_card'=>'','pay_bank'=>'','pay_bank_city'=>'','rmb'=>'0.00');
		}else{
			$data = $this->mydb->get_row('agent',array('id'=>$id));
			if(!$data) error('代理不存在');
		}
		//输出
		$this->load->view('agent/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$pass = get_post('pass',true);
		$edit = array(
			'name' => get_post('name',true),
			'rmb' => (float)get_post('rmb'),
			'sid' => (int)get_post('sid'),
			'pay_name' => get_post('pay_name',true),
			'pay_card' => get_post('pay_card',true),
			'pay_bank' => get_post('pay_bank',true),
			'pay_bank_city' => get_post('pay_bank_city',true)
		);
		if(!empty($pass)) $edit['pass'] = md5($pass);
		if(!is_tel($edit['name']) && !is_email($edit['name'])) get_json('账号只能是手机或者邮箱',0);
		//判断新增
		if($id == 0){
			if(empty($pass)) get_json('请填写登录密码',0);
			$edit['addtime'] = time();
			$this->mydb->get_insert('agent',$edit);
		}else{
			$this->mydb->get_update('agent',$edit,$id);
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
		$this->mydb->get_del('agent',$id);
		$this->mydb->get_del('agent_withdrawal',$id,'aid');
		get_json('删除成功');
	}

	public function withdrawal($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$pid = (int)get_post('pid');
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id'){
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
	        if($pid > 0) $where['pid'] = 'pid='.($pid-1);

	        //总数量
		    $total = $this->mydb->get_nums('agent_withdrawal',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('agent_withdrawal',$where,'*','id desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	$list[$k]['paytime'] = $v['paytime'] > 0 ? date('Y-m-d H:i:s',$v['paytime']) : '---------';
		    	if(date('Y-m-d',$v['paytime']) == date('Y-m-d')) $list[$k]['paytime'] = '<font color=red>'.$list[$k]['paytime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('agent/withdrawal.tpl');
		}
	}

	//修改
	public function withdrawal_show($id=0) {
		$id = (int)$id;
		$data = $this->mydb->get_row('agent_withdrawal',array('id'=>$id));
		if(!$data) error('数据不存在');
		//输出
		$this->load->view('agent/withdrawal_show.tpl',$data);
	}

	//入库
	public function withdrawal_save() {
		$id = (int)get_post('id');
		$edit = array(
			'msg' => get_post('msg',true),
			'pid' => (int)get_post('pid'),
			'paytime' => time(),
		);
		if($edit['pid'] == 2 && empty($edit['msg'])) get_json('请填写失败原因',0);
		$this->mydb->get_update('agent_withdrawal',$edit,$id);

		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//删除
	public function withdrawal_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('agent_withdrawal',$id);
		get_json('删除成功');
	}
}