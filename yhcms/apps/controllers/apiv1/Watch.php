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

class Watch extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//观看记录
	public function index() {
		get_islog('*',1);//判断登录
		$page = (int)get_post('page');
		$size = (int)get_post('size');
		if($page == 0) $page = 1;
		if($size == 0) $size = 50;
		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('watch',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('watch',$where,'vid,jid,duration,addtime','addtime DESC',$limit);
	    $ztime = time()-86400*7;
	    $day = 0;
		foreach ($list as $k => $v) {
			$rowv = $this->mydb->get_row('vod',array('id'=>$v['vid']),'name,pic,pay,state');
			$list[$k]['name'] = $rowv ? $rowv['name'].' '.getzd('vod_ji','name',$v['jid']) : '视频已下架';
			$list[$k]['state'] = $rowv ? $rowv['state'] : '已完结';
			$list[$k]['pic'] = $rowv ? $rowv['pic'] : '';
			$list[$k]['pay'] = $rowv ? $rowv['pay'] : 0;
			$list[$k]['duration'] = '观看到：'.get_time($v['duration']);
			$xday = $ztime < $v['addtime'] ? 7 : 999;
			$list[$k]['type'] = 0;
			if($day != $xday){
				$day = $xday;
				$list[$k]['type'] = $xday;
			}
			unset($list[$k]['jid']);
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//写入阅读记录
	public function send(){
		$vid = (int)get_post('vid');
		$zid = (int)get_post('zid');
		$jid = (int)get_post('jid');
		$duration = (int)get_post('duration');
		$user = get_islog('duration',0);
		if($user && $vid > 0 && $zid > 0 && $jid > 0){
			//判断视频是否存在
			$rowv = $this->mydb->get_row('vod',array('id'=>$vid),'cid');
			if($rowv){
				$row = $this->mydb->get_row('watch',array('vid'=>$vid,'uid'=>$this->uid),'id,duration');
				if(!$row){
					$this->mydb->get_insert('watch',array(
						'cid' => $rowv['cid'],
						'vid' => $vid,
						'zid' => $zid,
						'jid' => $jid,
						'duration' => $duration,
						'uid' => $this->uid,
						'addtime' => time()
					));
				}else{
					$this->mydb->get_update('watch',array(
						'zid' => $zid,
						'jid' => $jid,
						'duration' => $duration,
						'addtime' => time()
					),$row['id']);
					$duration = $duration > $row['duration'] ? $duration-$row['duration'] : $duration;
				}
			}
			//记录用户当日观看时长
			$this->mydb->get_update('user',array('duration'=>$user['duration']+$duration),$this->uid);
		}
		get_json('记录成功');
	}

	//删除观看记录
	public function del(){
		get_islog('*',1);//判断登录
		$vid = get_post('vid',true);
		if(empty($vid)) get_json('视频ID为空',0);
		$vid = explode(',', $vid);
		foreach ($vid as $_vid){
			$this->mydb->get_del('watch',array('vid'=>(int)$_vid,'uid'=>$this->uid));
		}
		get_json('删除成功');
	}
}