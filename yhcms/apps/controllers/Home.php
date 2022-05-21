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
	}

	public function index(){
        if(!$this->caches->start('home',$this->myconfig['caches']['time']['index'])){
			//seo
			$data['title'] = get_seo('index','title');
			$data['keywords'] = get_seo('index','keywords');
			$data['description'] = get_seo('index','description');
			$this->load->view('head.tpl',$data);
			$this->load->view('index.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}
}
