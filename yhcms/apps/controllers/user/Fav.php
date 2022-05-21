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

class Fav extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog(1);
	}

	public function index(){
		//seo
        $data = $this->user;
		$data['title'] = '我的收藏 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//查询条件
		$where = array('uid'=>$this->user['id']);
	    $list = $this->mydb->get_select('fav',$where,'vid','id DESC',15);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('vod',array('id'=>$v['vid']),'id vid,name,pic,state');
		}
		$data['fav'] = $list;
	    $list = $this->mydb->get_select('topic_fav',$where,'tid','id DESC',10);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('topic',array('id'=>$v['tid']),'id tid,name,pic');
		}
		$data['topic'] = $list;
        $data['op'] = 'fav';

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/top.tpl');
		$this->load->view('user/fav.tpl');
		$this->load->view('bottom.tpl');
	}

	//视频
	public function vod($page=1){
		$page = (int)$page;
		if($page == 0) $page = 1;
		$size = 20;
        $data = $this->user;
		//seo
		$data['title'] = '我收藏的视频 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//查询条件
		$where = array('uid'=>$this->user['id']);
		//总数量
	    $nums = $this->mydb->get_nums('fav',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($pagejs == 0) $pagejs = 1;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('fav',$where,'vid','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('vod',array('id'=>$v['vid']),'id vid,name,pic,state');
		    $list[$k]['pic'] = getpic($list[$k]['pic']);
		    $list[$k]['link'] = links('play',$list[$k]['vid'],0);
		}
		$data['fav'] = $list;
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
        $data['op'] = 'fav';
        if(defined('IS_WAP')) get_json($data,1);

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/top.tpl');
		$this->load->view('user/fav-vod.tpl');
		$this->load->view('bottom.tpl');
	}

	//专题
	public function topic($page=1){
		$page = (int)$page;
		if($page == 0) $page = 1;
		$size = 20;
		//seo
        $data = $this->user;
		$data['title'] = '我收藏的专辑 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//查询条件
		$where = array('uid'=>$this->user['id']);
		//总数量
	    $nums = $this->mydb->get_nums('topic_fav',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($pagejs == 0) $pagejs = 1;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('topic_fav',$where,'tid','id DESC',$limit);
		foreach ($list as $k => $v) {
		    $list[$k] = $this->mydb->get_row('topic',array('id'=>$v['tid']),'id tid,name,pic');
		    $list[$k]['pic'] = getpic($list[$k]['pic']);
		    $list[$k]['link'] = links('topicinfo',$list[$k]['tid']);
		}
		$data['topic'] = $list;
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
        $data['op'] = 'fav';
        if(defined('IS_WAP')) get_json($data,1);
		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/top.tpl');
		$this->load->view('user/fav-topic.tpl');
		$this->load->view('bottom.tpl');
	}
}