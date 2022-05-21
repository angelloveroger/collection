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

class Task extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('qdznum,qdnum,qddate,cion,duration',1);//判断登录
	}

	//任务首页
	public function index() {
		//当日是否签到
		$is_sign = $this->user['qddate'] == date('Ymd') ? 1 : 0;
		//任务列表
		$signin[] = array('id'=>0,'name'=>'每日签到送金币','text'=>'奖励'.$this->myconfig['signin'][0].'-'.end($this->myconfig['signin']).'金币','type'=>'signin');
		$task = $this->mydb->get_select('user_task','','id,name,text,type,day,cion','xid ASC',50);
		//合并
		$list = array_merge($signin,$task);
		foreach ($list as $k => $v) {
			if($v['id'] == 0){
				$list[$k]['state'] = $this->user['qddate'] == date('Ymd') ? 1 : 0;
			}else{
				$wh = array('uid'=>$this->uid,'did'=>$v['id']);
				if($v['type'] == 'watch'){
					$list[$k]['state'] = $this->user['duration'] < $v['type'] ? 0 : 1;
				}else{
					if($v['day'] > 0) $wh['addtime>'] = strtotime(date('Y-m-d 0:0:0'))-1;
					$nums = $this->mydb->get_nums('user_task_list',$wh);
					$list[$k]['state'] = $nums < $v['day'] ? 0 : 1;
				}
				unset($list[$k]['day']);
			}
		}
		unset($this->user['qdznum'],$this->user['qddate'],$this->user['duration']);
		$data = $this->user;
		$jtime = strtotime(date('Y-m-d 0:0:0'))-1;
		$data['day_cion'] = $this->mydb->get_sum('user_cion_list','cion',array('uid'=>$this->uid,'cid'=>1,'addtime>'=>$jtime));
		$data['is_sign'] = $is_sign;
		$data['signin'] = $this->myconfig['signin'];
		$data['list'] = $list;
		get_json($data);
	}


	//领取任务
	public function send() {
		$tid = (int)get_post('tid');
		$type = get_post('type');
		$time = get_post('time',true);
		if($time+60 < time()) get_json('非法请求',0);
		if($type == 'signin'){
			//判断当日是否签到
			if($this->user['qddate'] == date('Ymd')) get_json('今日已签到',0);
			$qdnum = ($this->user['qdnum'] == 7 || $this->user['qddate'] != date('Ymd',time()-86400)) ? 1 : $this->user['qdnum']+1;
			//获取奖励金币
			$cion = $this->myconfig['signin'][$qdnum-1];
			//记录任务
			$this->mydb->get_insert('user_task_list',array(
				'uid' => $this->uid,
				'did' => 0,
				'cion' => $cion,
				'addtime' => time()
			));
			//增加奖励
			$this->mydb->get_update('user',array(
				'cion'=>$this->user['cion']+$cion,
				'qdznum'=>$this->user['qdznum']+1,
				'qdnum'=>$qdnum,
				'qddate'=>date('Ymd')
			),$this->uid);
			//写入金币记录
			$this->mydb->get_insert('user_cion_list',array(
				'cid' => 1,
				'uid' => $this->uid,
				'cion' => $cion,
				'text' => '每日签到送金币',
				'addtime' => time()
			));
		}else{
			if($type == 'watch'){
				$row = $this->mydb->get_row('user_task',array('id'=>$tid));
			}else{
				$row = $this->mydb->get_row('user_task',array('type'=>$type));
			}
			//判断任务是否存在
			if(!$row) get_json('任务不存在',0);
			$tid = $row['id'];
			//判断观看任务
			if($row['type'] == 'watch' && $this->user['duration'] < $row['duration']){
				get_json('任务未完成',0);
			}
			$daynum = $this->mydb->get_nums('user_task_list',array('did'=>$tid,'uid'=>$this->uid,'addtime>'=>strtotime(date('Y-m-d 0:0:0'))-1));
			if($row['day'] == 0 || $daynum < $row['day']){
				//记录任务
				$this->mydb->get_insert('user_task_list',array(
					'uid' => $this->uid,
					'did' => $tid,
					'cion' => $row['cion'],
					'addtime' => time()
				));
				//增加奖励
				$this->mydb->get_update('user',array('cion'=>$this->user['cion']+$row['cion']),$this->uid);
				//写入金币记录
				$this->mydb->get_insert('user_cion_list',array(
					'cid' => 1,
					'uid' => $this->uid,
					'cion' => $row['cion'],
					'text' => $row['name'],
					'addtime' => time()
				));
			}else{
				get_json('任务当日已上限',1);
			}
			$cion = $row['cion'];
		}
		get_json(array('msg'=>'领取成功','cion'=>$cion),1);
	}
}