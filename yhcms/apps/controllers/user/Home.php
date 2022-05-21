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

class Home extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog();
	}

	public function index(){
        $data = $this->user;
        if(empty($data['nickname'])) $data['nickname'] = '游客';
        if(empty($data['viptime'])) $data['viptime'] = 0;
        if(empty($data['id'])) $data['id'] = 0;
        if(empty($data['cion'])) $data['cion'] = 0;
        if(empty($data['pic'])) $data['pic'] = '';
		//seo
		$data['title'] = '用户中心 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
		//观看历史
		if($this->user){
			$size = defined('IS_WAP') ? 10 : 100;
			$list = $this->mydb->get_select('watch',array('uid'=>$data['id']),'vid,jid,duration,addtime','addtime DESC',$size);
			$jtime = strtotime(date('Y-m-d 0:0:0'))-1;
		    $ztime = time()-86400*7;
		    $day = 0;
			foreach ($list as $k => $v) {
				$rowv = $this->mydb->get_row('vod',array('id'=>$v['vid']),'name,pic,pay,state');
				$list[$k]['name'] = $rowv ? $rowv['name'].' '.getzd('vod_ji','name',$v['jid']) : '视频已下架';
				$list[$k]['state'] = $rowv ? $rowv['state'] : '已完结';
				$list[$k]['pic'] = $rowv ? $rowv['pic'] : '';
				$list[$k]['pay'] = $rowv ? $rowv['pay'] : 0;
				$list[$k]['duration'] = '观看到：'.get_time($v['duration']);
				$xday = $jtime < $v['addtime'] ? 1 : ($ztime < $v['addtime'] ? 7 : 999);
				$list[$k]['type'] = 0;
				if($day != $xday){
					$day = $xday;
					$list[$k]['type'] = $xday;
				}
			}
			$data['watch'] = $list;
		}else{
			$data['watch'] = array();
		}
        $data['op'] = 'index';

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/top.tpl');
		$this->load->view('user/index.tpl');
		$this->load->view('bottom.tpl');
	}
}