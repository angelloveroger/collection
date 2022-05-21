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

class Read extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog(1);
	}

	public function index(){
		$page = (int)get_post('page');;
		if($page == 0) $page = 1;

		$size = 15;
		//查询条件
		$where = array('uid'=>$this->user['id']);
		//总数量
	    $nums = $this->mydb->get_nums('watch',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('watch',$where,'vid,jid,duration,addtime','addtime DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$rowv = $this->mydb->get_row('vod',array('id'=>$v['vid']),'name,pic');
			$list[$k]['name'] = $rowv ? $rowv['name'].' '.getzd('vod_ji','name',$v['jid']) : '视频已下架';
			$list[$k]['pic'] = $rowv ? getpic($rowv['pic']) : '';
			$list[$k]['duration'] = '观看到：'.get_time($v['duration']);
			$list[$k]['link'] = links('play',$v['vid'],$v['jid']);
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		if($page > 1) get_json($data);

		//seo
		$data['title'] = '观看记录 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/read.tpl');
		$this->load->view('bottom.tpl');
	}
}