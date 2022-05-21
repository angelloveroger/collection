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
		//判断是否登陆
		get_admin_islog();
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
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id' || $zd == 'fid' || $zd == 'aid'){
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
		    	$list[$k]['pic'] = getpic($v['pic'],'user');
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	$list[$k]['logtime'] = $v['logtime'] > 0 ? date('Y-m-d H:i:s',$v['logtime']) : '---------';
		    	if(date('Y-m-d',$v['logtime']) == date('Y-m-d')) $list[$k]['logtime'] = '<font color=red>'.$list[$k]['logtime'].'</font>';
		    	$list[$k]['viptime'] = $v['viptime'] > 0 ? date('Y-m-d H:i:s',$v['viptime']) : '----------';
		    	if(date('Y-m-d',$v['viptime']) == date('Y-m-d')) $list[$k]['viptime'] = '<font color=red>'.$list[$k]['viptime'].'</font>';
		    	if(empty($v['facility'])) $list[$k]['facility'] = '后台';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('user/index.tpl');
		}
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id'=>0,'tel'=>'','pic'=>'','nickname'=>'','sex'=>0,'vip'=>0,'viptime'=>'','cion'=>0);
		}else{
			$data = $this->mydb->get_row('user',array('id'=>$id));
			if(!$data) error('用户不存在');
		}
		//输出
		$this->load->view('user/edit.tpl',$data);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$pass = get_post('pass',true);
		$edit = array(
			'sex' => (int)get_post('sex'),
			'vip' => (int)get_post('vip'),
			'viptime' => strtotime(get_post('viptime')),
			'cion' => (int)get_post('cion'),
			'nickname' => get_post('nickname',true),
			'pic' => get_post('pic',true),
			'tel' => get_post('tel',true)
		);
		if(!empty($pass)) $edit['pass'] = md5($pass);
		if(!is_tel($edit['tel'])) get_json('请填写正确的手机号码',0);
		if($edit['vip'] == 1 && empty($edit['viptime'])) get_json('请填写VIP到期时间',0);
		if($edit['vip'] == 0) $edit['viptime'] = 0;
		//判断新增
		if($id == 0){
			if(empty($pass)) get_json('请填写登录密码',0);
			$edit['addtime'] = time();
			$this->mydb->get_insert('user',$edit);
		}else{
			$this->mydb->get_update('user',$edit,$id);
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
		$this->mydb->get_del('user',$id);
		$this->mydb->get_del('user_vod_buy',$id,'uid');
		$this->mydb->get_del('user_task_list',$id,'uid');
		$this->mydb->get_del('comment',$id,'uid');
		$this->mydb->get_del('comment_report',$id,'uid');
		$this->mydb->get_del('comment_zan',$id,'uid');
		$this->mydb->get_del('feedback',$id,'uid');
		$this->mydb->get_del('topic_fav',$id,'uid');
		$this->mydb->get_del('fav',$id,'uid');
		$this->mydb->get_del('down',$id,'uid');
		$this->mydb->get_del('watch',$id,'uid');
		get_json('删除成功');
	}
}