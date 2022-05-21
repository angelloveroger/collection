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

class Reg extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		if(get_cookie('user_token')){
			header("location:".links('user'));
			exit;
		}
	}

	public function index(){
		//seo
		$data['title'] = '用户注册 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
        $data['op'] = 'index';

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/reg.tpl');
		$this->load->view('bottom.tpl');
	}
}