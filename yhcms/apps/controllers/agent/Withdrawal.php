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

class Withdrawal extends My_Controller {
	
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
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    $where['aid'] = $this->agent['id'];
		    if(!empty($zd) && !empty($key)){
		    	$like[$zd] = $key;
		    }
	        if(!empty($kstime)){
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if($pid > 0) $where['pid'] = $pid-1;

	        //总数量
		    $total = $this->mydb->get_nums('agent_withdrawal',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('agent_withdrawal',$where,'*','addtime desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['pay_name'] = get_sub($v['pay_name'],1,1,1);
		    	$list[$k]['pay_card'] = get_sub($v['pay_card'],4,4,8);
		    	if(empty($v['pay_bank_city'])) $list[$k]['pay_bank_city'] = '-------------';
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
	        $data['code'] = 0;
	        echo json_encode($data);exit;
		}else{
			$this->load->view('withdrawal/index.tpl');
		}
	}

	//设置提现信息
	public function info(){
		$data['agent'] = $this->agent;
		$this->load->view('withdrawal/info.tpl',$data);
	}

	//保存提现信息
	public function save(){
		$edit = array(
			'pay_name' => get_post('pay_name',true),
			'pay_card' => get_post('pay_card',true),
			'pay_bank' => get_post('pay_bank',true),
			'pay_bank_city' => get_post('pay_bank_city',true),
		);
		if(empty($edit['pay_name'])) get_json('收款人不能为空',0);
		if(empty($edit['pay_card'])) get_json('收款账号不能为空',0);
		if(empty($edit['pay_bank'])) get_json('收款方式不能为空',0);
		$this->mydb->get_update('agent',$edit,$this->agent['id']);

		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		echo json_encode($d);
	}

	//提现申请
	public function send(){
		if(empty($this->agent['pay_name'])) get_json('请先完善收款信息',0);
		$rmb = (float)get_post('rmb');
		if($rmb == 0) get_json('请填写提现金额',0);
		if($rmb > $this->agent['rmb']) get_json('余额不足',0);
		//减去余额
		$res = $this->mydb->get_update('agent',array('rmb'=>$this->agent['rmb']-$rmb),$this->agent['id']);
		if(!$res) get_json('网络错误，请稍后',0);
		//记录订单
		$add = array(
			'dd' => date('YmdHis').rand(1111,9999),
			'rmb' => $rmb,
			'aid' => $this->agent['id'],
			'pay_name' => $this->agent['pay_name'],
			'pay_card' => $this->agent['pay_card'],
			'pay_bank' => $this->agent['pay_bank'],
			'pay_bank_city' => $this->agent['pay_bank_city'],
			'addtime' => time()
		);
		$this->mydb->get_insert('agent_withdrawal',$add);
		$d['code'] = 1;
		$d['rmb'] = number_format($this->agent['rmb']-$rmb,2);
		$d['msg'] = '操作成功';
		get_json($d);
	}
}