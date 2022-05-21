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

class Caiji extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->collect = require_once FCPATH.'yhcms/config/collect.php';
		//判断是否登陆
		get_admin_islog();
	}

	//采集配置
	public function index(){
		$data = $this->collect['config'];
		if(!isset($data['ruku_size'])) $data['ruku_size'] = 20;
		$this->load->view('caiji/setting.tpl',$data);
	}

	//配置保存
	public function setting(){
		$config = get_post();
		$upzd = array();
		foreach ($config['upzd'] as $k => $v) $upzd[] = $k;
		$config['upzd'] = $upzd;
		$inspect = array();
		foreach ($config['inspect'] as $k => $v) $inspect[] = $k;
		$config['inspect'] = $inspect;
		$replace_name = array();
		if(!empty($config['replace_name'])){
			$arr = explode("\n", $config['replace_name']);
			foreach ($arr as $v){
				$vv = explode("->", $v);
				$replace_name[$vv[0]] = $vv[1];
			}
		}
		$config['replace_name'] = $replace_name;
		$config['filter_name'] = !empty($config['filter_name']) ? explode("\n", $config['filter_name']) : array();
		$this->collect['config'] = $config;
		//保存
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('文件写入失败，请检查collect.php权限',0);
		//输出
		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('caiji/index');
		get_json($d,1);
	}

	//资源库列表
	public function zyk($type=''){
		if($type == 'json'){
			$zyk = json_decode(geturl(base64decode(ZYKURL)),1);
			$arr = array();
			foreach ($zyk as $i=>$v) {
				$id = $i+1;
				$arr[$i] = array(
					'id' => $id< 10 ? '0'.$id : $id,
					'name' => '<a onclick="layer.load();" href="'.links('caiji/show').'?ly='.$v['ac'].'&type='.$v['form'].'&apiurl='.urlencode($v['url']).'">'.$v['name'].'</a>',
					'text' => '<a onclick="layer.load();" href="'.links('caiji/show').'?ly='.$v['ac'].'&type='.$v['form'].'&apiurl='.urlencode($v['url']).'">'.$v['text'].'</a>',
					'day' => '<a onclick="layer.load();" href="'.links('caiji/ruku').'?ly='.$v['ac'].'&type='.$v['form'].'&apiurl='.urlencode($v['url']).'&day=1">采集当天</a>',
					'week'=> '<a onclick="layer.load();" href="'.links('caiji/ruku').'?ly='.$v['ac'].'&type='.$v['form'].'&apiurl='.urlencode($v['url']).'&day=7">采集本周</a>',
					'all' => '<a onclick="layer.load();" href="'.links('caiji/ruku').'?ly='.$v['ac'].'&type='.$v['form'].'&apiurl='.urlencode($v['url']).'">采集所有</a>',
					'cmd' => '<a class="layui-btn layui-btn-normal layui-btn-xs" onclick="Admin.open(\'入库配置\',\''.links('caiji/set').'?ly='.$v['ac'].'\',800,240);">入库配置</a>'
				);
				$i++;
			}
			$data['data'] = $arr;
			get_json($data,0);
		}else{
			//上次采集路径
			$data['last_url'] = sys_auth(file_get_contents('./caches/caiji.txt'),1);
			$this->load->view('caiji/zyk.tpl',$data);
		}
	}

	//资源库浏览
	public function show(){
		$apiurl = get_post('apiurl',true);
		$ly = get_post('ly',true);
		$key = get_post('key',true);
		$type = get_post('type',true);
		$cid = (int)get_post('cid');
		$page = (int)get_post('page');
		if($page == 0) $page = 1;
		//资源库地址
		$zyurl = $apiurl.'?ac=list&t='.$cid.'&h=0&wd='.$key.'&ids=&pg='.$page;
		//加载采集模型
		$this->load->model('collects');
		if($type == 'json'){
			$data = $this->collects->vodjsonlist($zyurl);
		}else{
			$data = $this->collects->vodlist($zyurl);
		}
		$data['cid'] = $cid;
		$data['ly'] = $ly;
		$data['key'] = $key;
		$data['type'] = $type;
		$data['page'] = $page;
		$data['apiurl'] = $apiurl;
		//站内分类
		$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',100);
		$data['bind'] = isset($this->collect['bind'][$ly]) ? $this->collect['bind'][$ly] : array();
		$this->load->view('caiji/show.tpl',$data);
	}

	//入库配置
	public function set(){
		$ly = get_post('ly',true);
		$data['ly'] = $ly;
		$data['pay'] = isset($this->collect['pay'][$ly]) ? $this->collect['pay'][$ly] : array('pay'=>0,'cion'=>0);
		$this->load->view('caiji/set.tpl',$data);
	}

	//入库配置
	public function set_save(){
		$ly = get_post('ly',true);
		if(empty($ly)) get_json('资源站标示错误',0);
		$this->collect['pay'][$ly]['pay'] = (int)get_post('pay');
		$this->collect['pay'][$ly]['cion'] = (int)get_post('cion');
		if($this->collect['pay'][$ly]['pay'] == 2){
			if($this->collect['pay'][$ly]['cion'] == 0) get_json('请输入点播金币数量',0);
		}else{
			$this->collect['pay'][$ly]['cion'] = 0;
		}
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('修改失败，请重试!');
		get_json(array('msg'=>'修改成功','parent'=>1),1);
	}

	//资源分类绑定
	public function bind(){
		$op = get_post('op',true);
		$ly = get_post('ly',true);
		$cid = (int)get_post('cid');
		$zycid = (int)get_post('zycid');
		if($op == 'delall'){
			$this->collect['bind'][$ly] = array();
		}elseif($cid == 0){
			unset($this->collect['bind'][$ly][$zycid]);
		}else{
			$this->collect['bind'][$ly][$zycid] = $cid;
		}
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('绑定失败，请重试!');
		get_json('分类绑定成功',1);
	}

	//定时任务
	public function timing(){
		$data['timing'] = $this->collect['ting'];
		$this->load->view('caiji/timing.tpl',$data);
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
		if(!empty($ly) && isset($this->collect['ting'][$ly])){
			$data = $this->collect['ting'][$ly];
		}
		$data['ly'] = $ly;
		$data['zyk'] = json_decode(geturl(base64decode(ZYKURL)),1);
		$this->load->view('caiji/timing_edit.tpl',$data);
	}

	//定时任务修改入库
	public function timing_save(){
		$ly = get_post('ly',true);
		$name = get_post('name',true);
		$pass = get_post('pass',true);
		$i = (int)get_post('i');
		$day = (int)get_post('day');
		if(empty($ly)) get_json('请选择任务资源');
		if(empty($name)) get_json('任务名称不能为空');
		if(empty($pass)) get_json('任务密码不能为空');
		$zyk = json_decode(geturl(base64decode(ZYKURL)),1);
		$url = '';
		foreach($zyk as $row){
			if($row['ac'] == $ly){
				$url = $row['url'];
				break;
			}
		}
		//入库
		$this->collect['ting'][$ly] = array(
			'name' => $name,
			'url' => $url,
			'time' => !isset($this->collect['ting'][$ly]) ? '未执行' : $this->collect['ting'][$ly]['time'],
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
		$ly = get_post('ly',true);
		if(empty($ly)) get_json('参数错误!');
		unset($this->collect['ting'][$ly]);
		$res = arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
		if(!$res) get_json('删除失败，请重试!');
		get_json('任务删除成功',1);
	}

	//任务地址
	public function timing_url($ly=''){
		$data['winurl'] = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/ting/win/'.$ly.'?pass='.$this->collect['ting'][$ly]['pass'];
		$data['osurl'] = 'http://'.$_SERVER['HTTP_HOST'].'/index.php/ting/os/'.$ly.'?pass='.$this->collect['ting'][$ly]['pass'];
		$this->load->view('caiji/timing_url.tpl',$data);
	}

	//资源入库
	public function ruku(){
		set_time_limit(0); //不超时
		$apiurl = get_post('apiurl',true);
		$ly = get_post('ly',true);
		$ids = get_post('ids');
		$type = get_post('type');
		$page = (int)get_post('page');
		$cid = (int)get_post('cid');
		$day = (int)get_post('day');
		if($page == 0) $page = 1;
		$h = $day*24;
		$zyurl = $apiurl.'?ac=videolist&t='.$cid.'&h='.$h.'&ids='.$ids.'&pg='.$page.'&size='.$this->collect['config']['ruku_size'];
		//播放器ID
		$pid = (int)getzd('player','id',$ly,'alias');
		//加载采集模型
		$this->load->model('collects');
		if($type == 'json'){
			$data = $this->collects->vodjsonlist($zyurl,'ruku',$pid);
		}else{
			$data = $this->collects->vodlist($zyurl,'ruku',$pid);
		}
		//循环入库
		$msg = array();
		foreach ($data['vod'] as $k => $v) {
			$v = str_checkhtml($v);
			//标题替换
			$v['name'] = $this->collects->get_name_replace($v['name']);
			$msgstr = '第'.($k+1).'条数据《'.$v['name'].'》更新至'.$v['state'].' ';
			//判断采集内容
			if(empty($v['name'])){
				$msgstr .= '<font color=#ff6600>未获取到标题，跳过</font>';
			}elseif(!isset($this->collect['bind'][$ly][$v['cid']])){ //未绑定
				$msgstr .= '<font color=red>未绑定分类，跳过</font>';
			}else{
				$msgstr .= $this->collects->get_send($v,$ly);//更新入库
			}
			$msg[$k]['str'] = $msgstr;
		}
		$data['msg'] = $msg;
		$data['finish'] = 0; //是否全部采集完成
		//下一页地址
		$data['next_link'] = links('caiji/ruku').'?apiurl='.urlencode($apiurl).'&ly='.$ly.'&type='.$type.'&day='.$day.'&ids='.$ids.'&cid='.$cid.'&page='.($page+1);
		//判断采集页数
		if($page >= $data['pagejs']){
			$data['next_link'] = links('caiji/show').'?apiurl='.urlencode($apiurl).'&ly='.$ly.'&type='.$type.'&day='.$day.'&cid='.$cid;
			$data['finish'] = 1;
			file_put_contents('./caches/caiji.txt','');
		}else{
			if(empty($ids)){
				file_put_contents('./caches/caiji.txt',sys_auth($data['next_link']));
			}
		}
		$this->load->view('caiji/ruku.tpl',$data);
	}
}