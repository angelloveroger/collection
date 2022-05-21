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

class Down extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//下载首页
	public function index() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		$type = (int)get_post('type');
		if($type == 0) $type = 1;
		if($page == 0) $page = 1;
		if($size == 0) $size = 50;
		$limit = $size*($page-1).','.$size;
		$sql = 'select a.vid,count(a.jid) nums,sum(a.size) size,max(a.addtime) addtime,b.name,b.pic from '._DBPREFIX_.'down a left join '._DBPREFIX_.'vod b on a.vid=b.id where a.uid='.$this->uid.' GROUP BY a.vid order by addtime desc limit '.$limit;
		$down = $this->mydb->get_sql($sql);
		$list = array();$i=0;
		foreach ($down as $k => $v) {
			$progress = $this->mydb->get_nums('down',array('uid'=>$this->uid,'vid'=>$v['vid'],'progress<'=>100));
			if(($type == 1 && $progress == 0) || ($type == 2 && $progress > 0)){
				$list[$i] = $v;
				$list[$i]['progress'] = $type == 2 ? round(($v['nums']-$progress)/$v['nums']*100,2) : 100;
				$list[$i]['down_name'] = $type == 2 ? getzd('vod_ji','name',getzd('down','jid',array('vid'=>$v['vid'],'progress<'=>100),'vid','id asc')) : '已完成';
				$i++;
			}
		}
		//输出
		$data['page'] = $page;
		$data['list'] = $list;
		get_json($data);
	}

	//集数列表
	public function info() {
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		$vid = (int)get_post('vid');
		if($vid == 0) get_json('视频ID为空',0);
		if($page == 0) $page = 1;
		if($size == 0) $size = 20;
		$limit = $size*($page-1).','.$size;
		$sql = 'select a.vid,a.zid,a.jid,a.down_size,a.size,a.zt,a.progress,a.addtime,b.name jname,b.playurl from '._DBPREFIX_.'down a left join '._DBPREFIX_.'vod_ji b on a.jid=b.id where a.uid='.$this->uid.' and a.vid='.$vid.' order by a.jid asc limit '.$limit;
		$list = $this->mydb->get_sql($sql);
		foreach ($list as $k => $v) {
			$list[$k]['pic'] = getzd('vod','pic',$v['vid']);
			//观看记录
			$list[$k]['watch'] = '未观看';
			$rowv = $this->mydb->get_row('watch',array('jid'=>$v['jid'],'uid'=>$this->uid),'duration');
			if($rowv) $list[$k]['watch'] = '观看到：'.get_time($rowv['duration']);
		}
		//输出
		$data['vname'] = getzd('vod','name',$vid);
		$data['page'] = $page;
		$data['list'] = $list;
		get_json($data);
	}

	//提交缓存
	public function add(){
		$jid = (int)get_post('jid');
		$zt = (int)get_post('zt');
		$size = (int)get_post('size');
		$down_size = (int)get_post('down_size');
		$progress = (float)get_post('progress');
		if($jid == 0) get_json('集数ID为空',0);
		//判断视频是否存在
		$rowv = $this->mydb->get_row('vod_ji',array('id'=>$jid));
		if(!$rowv) get_json('视频集数不存在',0);
		//判断是否存在
		$row = $this->mydb->get_row('down',array('jid'=>$jid,'uid'=>$this->uid),'id,size');
		if(!$row){
		    //判断收费
		    if($rowv['pay'] == 1 && $this->user['vip'] == 0)  get_json('VIP视频，没有权限',0);
		    if($rowv['pay'] == 2)  get_json('点播视频，不支持下载',0);
			$this->mydb->get_insert('down',array(
				'vid' => $rowv['vid'],
				'zid' => $rowv['zid'],
				'jid' => $jid,
				'size' => 100,
				'down_size' => $down_size,
				'uid' => $this->uid,
				'zt' => $zt,
				'progress' => $progress,
				'addtime' => time()
			));
		}else{
		    $edit = array(
				'down_size' => $down_size,
				'zt' => $zt,
				'progress' => $progress
			);
			$this->mydb->get_update('down',$edit,$row['id']);
		}
		get_json('记录完成');
	}

	//删除缓存
	public function del(){
		$vid = get_post('vid',true);
		$jid = get_post('jid',true);
		if(empty($vid)) get_json('视频ID为空',0);
		if(empty($jid)){
			$vid = explode(',', $vid);
			foreach ($vid as $_vid){
				$this->mydb->get_del('down',array('vid'=>(int)$_vid,'uid'=>$this->uid));
			}
		}else{
			$vid = (int)$vid;
			$jid = explode(',', $jid);
			foreach ($jid as $_jid){
				$this->mydb->get_del('down',array('vid'=>$vid,'jid'=>(int)$_jid,'uid'=>$this->uid));
			}
		}
		get_json('删除成功');
	}
}