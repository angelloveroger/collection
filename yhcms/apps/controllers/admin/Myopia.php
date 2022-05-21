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

class Myopia extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->collect = require_once FCPATH.'yhcms/config/collect.php';
		//判断是否登陆
		get_admin_islog();
	}

	public function index($yid=1,$op=''){
		$yid = (int)$yid;
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $cid = (int)get_post('cid');
	 	    $pay = (int)get_post('pay');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$tid = (int)get_post('tid',true);
 	    	$order = get_post('order',true);
	        if($page==0) $page=1;
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;
		    $sarr = array('hits','zan','share','id');
		    if(!in_array($order, $sarr)) $order = 'id';

			//查询条件
		    $where = $like = array();
		    $where['yid'] = (int)($yid-1);
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'uid' || $zd == 'id'){
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
	        if($tid > 0) $where['tid'] = ($tid-1);
	        if($pay > 0) $where['pay'] = ($pay-1);

	        //总数量
		    $total = $this->mydb->get_nums('myopia',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('myopia',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['pic'] = getpic($v['pic']);
		    	$list[$k]['cname'] = getzd('myopia_class','name',$v['cid']);
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['class'] = $this->mydb->get_select('myopia_class','','*','xid asc',100);
			$data['yid'] = $yid;
			$this->load->view('myopia/index.tpl',$data);
		}
	}

	//状态
	public function init() {
		$id = get_post('id',true);
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit['tid'] = $tid;
		$this->mydb->get_update('myopia',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit() {
		$id = (int)get_post('id');
		$myopia = $this->mydb->get_row('myopia',array('id'=>$id));
		if(!$myopia) error('短视不存在');
		$myopia['class'] = $this->mydb->get_select('myopia_class',array(),'id,name','xid asc',50);
		//输出
		$this->load->view('myopia/edit.tpl',$myopia);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$edit = array(
			'pic' => get_post('pic',true),
			'text' => get_post('text',true),
			'upic' => get_post('upic',true),
			'nickname' => get_post('nickname',true),
			'cid' => (int)get_post('cid'),
			'uid' => (int)get_post('uid'),
			'tid' => (int)get_post('tid'),
			'yid' => (int)get_post('yid'),
			'hits' => (int)get_post('hits'),
			'zan' => (int)get_post('zan'),
			'share' => (int)get_post('share'),
		);
		if($id == 0) get_json('ID不能为空',0);
		$this->mydb->get_update('myopia',$edit,$id);
		//输出
		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//批量审核
	public function audit(){
		$ids = get_post('id',true);
		if(empty($ids)) get_json('请选择短视',0);
		if(is_array($ids)) $ids = implode(',',$ids);
		$this->mydb->get_update('myopia',array('yid'=>0),$ids);
		get_json('操作成功',1);
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('myopia',$id);
		$this->mydb->get_del('myopia_pic',$id,'bid');
		$this->mydb->get_del('myopia_zan',$id,'did');
		$this->mydb->get_del('comment',$id,'bid');
		get_json('删除成功');
	}

	//短视图片
	public function pic($op=''){
		$bid = (int)get_post('bid');
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
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
	        if($bid > 0) $where['bid'] = $bid;

	        //总数量
		    $total = $this->mydb->get_nums('myopia_pic',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('myopia_pic',$where,'*','id desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['url'] = getpic($v['url']);
		    	$list[$k]['bname'] = getzd('myopia','name',$v['bid']);
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['bid'] = $bid;
			$this->load->view('myopia/pic.tpl',$data);
		}
	}

	//图片删除
	public function pic_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('myopia_pic',$id);
		get_json('删除成功');
	}


	public function lists(){
		$data['class'] = $this->mydb->get_select('myopia_class',array(),'*','xid asc',100);
		$this->load->view('myopia/lists.tpl',$data);
	}

	//修改
	public function lists_edit($id = 0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'name' => '','xid'=>0,'yid'=>0);
		}else{
			$data = $this->mydb->get_row('myopia_class',array('id'=>$id));
			if(!$data) error('分类不存在');
		}
		//输出
		$this->load->view('myopia/lists_edit.tpl',$data);
	}

	//入库
	public function lists_save() {
		$id = (int)get_post('id');
		$edit = array(
			'yid' => (int)get_post('yid'),
			'xid' => (int)get_post('xid'),
			'name' => get_post('name',true)
		);
		if(empty($edit['name'])) get_json('请填写分类名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('myopia_class',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('myopia_class',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//删除
	public function lists_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('myopia_class',$id);
		get_json('删除成功');
	}

	//资源库列表
	public function caiji($type=''){
		if($type == 'json'){
			$zyk = json_decode(geturl('http:'.base64decode(APIURL).'myopia'),1);
			$arr = array();
			foreach ($zyk as $i=>$v) {
				$id = $i+1;
				$arr[$i] = array(
					'id' => $id< 10 ? '0'.$id : $id,
					'name' => '<a onclick="layer.load();" href="'.links('myopia/zyshow').'?ly='.$v['ac'].'&apiurl='.urlencode($v['url']).'">'.$v['name'].'</a>',
					'text' => '<a onclick="layer.load();" href="'.links('myopia/zyshow').'?ly='.$v['ac'].'&apiurl='.urlencode($v['url']).'">'.$v['text'].'</a>',
					'day' => '<a onclick="layer.load();" href="'.links('myopia/ruku').'?ly='.$v['ac'].'&apiurl='.urlencode($v['url']).'&day=1">采集当天</a>',
					'week'=> '<a onclick="layer.load();" href="'.links('myopia/ruku').'?ly='.$v['ac'].'&apiurl='.urlencode($v['url']).'&day=7">采集本周</a>',
					'all' => '<a onclick="layer.load();" href="'.links('myopia/ruku').'?ly='.$v['ac'].'&apiurl='.urlencode($v['url']).'">采集所有</a>'
				);
				$i++;
			}
			$data['data'] = $arr;
			get_json($data,0);
		}else{
			//上次采集路径
			$data['last_url'] = sys_auth(file_get_contents('./caches/caiji_myopia.txt'),1);
			$this->load->view('myopia/zyk.tpl',$data);
		}
	}

	//资源库浏览
	public function zyshow(){
		$apiurl = get_post('apiurl',true);
		$ly = get_post('ly',true);
		$key = get_post('key',true);
		$cid = (int)get_post('cid');
		$page = (int)get_post('page');
		if($page == 0) $page = 1;
		//资源库地址
		$zyurl = $apiurl.'?ac=show&cid='.$cid.'&day=0&key='.$key.'&ids=&page='.$page;
		$json = geturl($zyurl);
		$data = json_decode($json,1);
		$data['cid'] = $cid;
		$data['ly'] = $ly;
		$data['key'] = $key;
		$data['page'] = $page;
		$data['apiurl'] = $apiurl;
		//站内分类
		$data['myopia_class'] = $this->mydb->get_select('myopia_class',array(),'id,name','xid asc',100);
		$data['bind'] = isset($this->collect['myopia']['bind'][$ly]) ? $this->collect['myopia']['bind'][$ly] : array();
		$this->load->view('myopia/show.tpl',$data);
	}

	//资源分类绑定
	public function bind(){
		$op = get_post('op',true);
		$ly = get_post('ly',true);
		$cid = (int)get_post('cid');
		$zycid = (int)get_post('zycid');
		if($op == 'delall'){
			$this->collect['myopia']['bind'][$ly] = array();
		}elseif($cid == 0){
			unset($this->collect['myopia']['bind'][$ly][$zycid]);
		}else{
			$this->collect['myopia']['bind'][$ly][$zycid] = $cid;
		}
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('绑定失败，请重试!');
		get_json('分类绑定成功',1);
	}


	//定时任务
	public function timing(){
		$data['timing'] = $this->collect['myopia']['ting'];
		$this->load->view('myopia/timing.tpl',$data);
	}

	//定时修改
	public function timing_edit($ly = ''){
		$this->load->helper('string');
		$data = array(
			'name' => '',
			'day' => 1,
			'i' => 180,
			'pass' => random_string('alnum',16)
		);
		if(!empty($ly) && isset($this->collect['myopia']['ting'][$ly])){
			$data = $this->collect['myopia']['ting'][$ly];
		}
		$data['ly'] = $ly;
		$data['zyk'] = json_decode(geturl('http:'.base64decode(APIURL).'myopia'),1);
		$this->load->view('myopia/timing_edit.tpl',$data);
	}

	//定时任务修改入库
	public function timing_save(){
		$ly = $this->input->get_post('ly',true);
		$name = $this->input->get_post('name',true);
		$pass = $this->input->get_post('pass',true);
		$i = (int)$this->input->get_post('i');
		$day = (int)$this->input->get_post('day');
		if(empty($ly)) get_json('请选择任务资源');
		if(empty($name)) get_json('任务名称不能为空');
		if(empty($pass)) get_json('任务密码不能为空');
		$zyk = json_decode(geturl('http:'.base64decode(APIURL).'myopia'),1);
		$url = '';
		foreach($zyk as $row){
			if($row['ac'] == $ly){
				$url = $row['url'];
				break;
			}
		}
		//入库
		$this->collect['myopia']['ting'][$ly] = array(
			'name' => $name,
			'url' => $url,
			'time' => !isset($this->collect['myopia']['ting'][$ly]) ? '未执行' : $this->collect['myopia']['ting'][$ly]['time'],
		    'day' => $day,
		    'i' => $i,
		    'pass' => $pass
		);
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('操作失败，请重试!');
		get_json(array('msg'=>'任务操作成功','parent'=>1),1);
	}

	//定时任务删除
	public function timing_del(){
		$ly = $this->input->get_post('ly',true);
		if(empty($ly)) get_json('参数错误!');
		unset($this->collect['myopia']['ting'][$ly]);
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('删除失败，请重试!');
		get_json('任务删除成功',1);
	}

	//任务地址
	public function timing_url($ly=''){
		$data['winurl'] = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/myopiating/win/'.$ly.'?pass='.$this->collect['myopia']['ting'][$ly]['pass'];
		$data['osurl'] = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/myopiating/os/'.$ly.'?pass='.$this->collect['myopia']['ting'][$ly]['pass'];
		$this->load->view('myopia/timing_url.tpl',$data);
	}

	//资源入库
	public function ruku(){
		set_time_limit(0); //不超时
		$apiurl = $this->input->get_post('apiurl',true);
		$ly = $this->input->get_post('ly',true);
		$ids = $this->input->get_post('ids');
		$page = (int)$this->input->get_post('page');
		$cid = (int)$this->input->get_post('cid');
		$day = (int)$this->input->get_post('day');
		if($page == 0) $page = 1;
		$zyurl = $apiurl.'?ac=ruku&cid='.$cid.'&day='.$day.'&ids='.$ids.'&page='.$page;
		$json = geturl($zyurl);
		$arr = json_decode($json,1);
		//print_r($arr);exit;
		//循环入库
		$msg = array();
		if(!empty($arr['vod'])){
			foreach ($arr['vod'] as $k => $v) {
				$msgstr = '第'.($k+1).'条数据《'.$v['text'].'》';
				//未绑定分类
				if(!isset($this->collect['myopia']['bind'][$ly][$v['cid']])){
					$msgstr .= '<font color=#00f>未绑定分类，跳过</font>';
				}else{
					//下载图片到本地
					$pic = $this->down_pic($v['pic'],$v['id']);
					if(!$pic){
						$msgstr .= '<font color=#f90>封面图片下载失败，跳过</font>';
					}else{
						$add = array(
							'cid' => $this->collect['myopia']['bind'][$ly][$v['cid']],
							'md5' => md5($v['id']),
							'text' => $v['text'],
							'playurl' => $v['playurl'],
							'pic' => $pic,
							'type' => 1,
							'upic' => $v['author']['pic'],
							'nickname' => $v['author']['nickname'],
							'addtime' => time()
						);
						$add = str_checkhtml($add);
						//print_r($add);exit;
						//判断是否存在
						$row = $this->mydb->get_row('myopia',array('md5'=>$add['md5']),'id');
						if($row){
							$msgstr .= '<font color=red>已存在，跳过</font>';
						}else{
							$res = $this->mydb->get_insert('myopia',$add);
							if($res){
								$msgstr .= '<font color=#080>入库成功~</font>';
							}else{
								$msgstr .= '<font color=#f30>入库失败~</font>';
							}
						}
					}
				}
				$msg[$k]['str'] = $msgstr;
			}
		}else{
			$msg[] = '<font color=red>获取数据失败</font>';
		}
		$data['page'] = (int)$arr['page'];
		$data['pagejs'] = (int)$arr['pagejs'];
		$data['nums'] = (int)$arr['nums'];
		$data['size'] = (int)$arr['size'];
		$data['msg'] = $msg;
		$data['finish'] = 0; //是否全部采集完成
		//下一页地址
		$data['next_link'] = links('myopia/ruku').'?apiurl='.urlencode($apiurl).'&ly='.$ly.'&day='.$day.'&ids='.$ids.'&cid='.$cid.'&page='.($page+1);
		//判断采集页数
		if($page >= $data['pagejs']){
			$data['next_link'] = links('myopia/zyshow').'?apiurl='.urlencode($apiurl).'&ly='.$ly.'&day='.$day.'&cid='.$cid;
			$data['finish'] = 1;
			file_put_contents('./caches/caiji_myopia.txt','');
		}else{
			if(empty($ids)){
				file_put_contents('./caches/caiji_myopia.txt',sys_auth($data['next_link']));
			}
		}
		$this->load->view('myopia/ruku.tpl',$data);
	}

	//下载图片到本地
	private function down_pic($pic,$vid){
		$picdir = FCPATH.'annex/myopia/'.date('Y').'/'.date('m').'/'.date('d').'/';
		$picfile = $picdir.md5($vid).'.jpeg';
		if(file_exists($picfile)) return str_replace(FCPATH,'/',$picfile);
		//获取文件头信息
		$arr = get_headers($pic,true);
		//print_r($arr);exit;
		if(!empty($arr['location'])){
			$data = geturl($arr['location']);
			if(!empty($data)){
				mkdirss($picdir); //创建文件夹
				file_put_contents($picfile,$data);
				return str_replace(FCPATH,'/',$picfile);
			}
		}
		return false;
	}
}