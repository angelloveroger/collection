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

class Edit extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog(1);
	}

	public function index($type='index'){
		$tarr = array('nickname','tel','pass','cancellation');
		if(!in_array($type,$tarr)) $type = 'index';
        $data = $this->user;
        $data['tel'] = get_sub($data['tel']);
		//seo
		$data['title'] = '修改资料 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
        $data['type'] = $type;

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/edit-'.$type.'.tpl');
		$this->load->view('bottom.tpl');
	}
}