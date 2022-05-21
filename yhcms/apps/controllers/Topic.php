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

class Topic extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index($page=1){
		$page = (int)$page;
		if($page == 0) $page = 1;
        if(!$this->caches->start('topic-'.$page,$this->myconfig['caches']['time']['topic'])){
			//seo
			$data['title'] = get_seo('topic','title');
			$data['keywords'] = get_seo('topic','keywords');
			$data['description'] = get_seo('topic','description');
			//列表
			$data['topic'] = $this->mydb->get_select('topic',array(),'id,name,pic','id desc',100);
			//输出
			$this->load->view('head.tpl',$data);
			$this->load->view('topic.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}

	public function info($id=0){
		$id = (int)$id;
        if($id == 0) error('专题不存在',404);
        if(!$this->caches->start('topic-info-'.$id,$this->myconfig['caches']['time']['topicinfo'])){
	        $row = $this->mydb->get_row('topic',array('id'=>$id));
	        if(!$row) error('专题不存在',404);
	        $data = $row;
			//seo
			$data['title'] = get_seo('topicinfo','title',$row);
			$data['keywords'] = get_seo('topicinfo','keywords',$row);
			$data['description'] = get_seo('topicinfo','description',$row);
			//视频列表
			$data['vodlist'] = $this->mydb->get_select('vod',array('ztid'=>$id),'id,name,pic,actor,state,score,hits,pay,text','id DESC',300);
			//增加人气
			$this->mydb->get_update('topic',array('hits'=>$row['hits']+1),$row['id']);
			//输出
			$this->load->view('head.tpl',$data);
			$this->load->view('topic-info.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}
}