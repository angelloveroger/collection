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
		//判断是否登陆
		get_admin_islog();
	}

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
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'uid' || $zd == 'aid'){
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
			get_json($data,0);
		}else{
			$this->load->view('pay/index.tpl');
		}
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('user_order',$id);
		get_json('删除成功');
	}

	//金币记录
	public function cion($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $cid = (int)get_post('cid');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
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
	        if($cid > 0) $where['cid'] = $cid;

	        //总数量
		    $total = $this->mydb->get_nums('user_cion_list',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('user_cion_list',$where,'*','addtime desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('pay/cion.tpl');
		}
	}

	//金币记录删除
	public function cion_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('user_cion_list',$id);
		get_json('删除成功');
	}

	//卡密列表
	public function card($op=''){
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
			get_json($data,0);
		}else{
			$this->load->view('pay/card.tpl');
		}
	}

	//修改
	public function card_add() {
		//输出
		$this->load->view('pay/card_add.tpl');
	}

	//入库
	public function card_save() {
		$this->load->helper('string');
		$type = (int)get_post('type',true);
		$day = (int)get_post('day',true);
		$aid = (int)get_post('aid',true);
		$cion = (int)get_post('cion',true);
		$nums = (int)get_post('nums',true);
		$rmb = (float)get_post('rmb',true);
		$endtime = strtotime(get_post('endtime',true));
		if(empty($endtime)) $endtime = 0;

		if($nums == 0) get_json('请输入卡密数量~！',0);
		if($nums > 5000) get_json('单次数量不能超过5000',0);
		if($type == 0 && $cion == 0) get_json('金币数量不能为空~！',0);
		if($type == 1 && $day == 0) get_json('VIP天数不能为空~！',0);
		for($i=0; $i < $nums; $i++) { 
			$add['type'] = $type;
			$add['rmb'] = $rmb;
			$add['aid'] = $aid;
			$add['nums'] = $type == 1 ? $day : $cion;
			$add['pass'] = random_string('alnum',30);
			$add['endtime'] = $endtime;
			$this->mydb->get_insert('user_card',$add);
		}
		$arr['msg'] = '恭喜您，成功添加'.$nums.'张卡密~!';
		$arr['parent'] = 1;
		get_json($arr,1);
	}

	//删除
	public function card_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('user_card',$id);
		get_json('删除成功');
	}

	//导出卡密
	public function card_daochu(){
		$id = get_post('id',true);
		if(empty($id)) exit('请选择要导出的卡密');
		$ids = explode(',',$id);
		$text = '';
		foreach ($ids as $k=>$_id) {
			$_id = (int)$_id;
			if($_id > 0){
				if($k == 0){
					$text .= getzd('user_card','pass',$_id);
				}else{
					$text .= "\r\n".getzd('user_card','pass',$_id);
				}
			}
		}
		$this->load->helper('download');
		$name = 'Yhcms-card-'.time().'.txt';
		force_download($name, $text);
	}
}