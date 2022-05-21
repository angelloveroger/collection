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

class Opt extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index($type='agreement'){
		$tarr = array('privacy','agreement');
		if(!in_array($type,$tarr)){
			$pages = isset($this->myconfig['web']['pages']) ? $this->myconfig['web']['pages'] : array(array('title'=>'电视直播','tpl'=>'tv'));
			$tpl = $title = '';
			foreach($pages as $v){
				if($type == $v['tpl']){
					$title = $v['title'];
					$tpl = 'opt-'.$type.'.tpl';
					break;
				}
			}
			if(empty($tpl)) show_404();
		}else{
			if($type == 'privacy'){
				$title = '隐私政策';
				$tpl = 'opt-index.tpl';
			}else{
				$title = '用户协议';
				$tpl = 'opt-index.tpl';
			}
			//获取内容
			$txt = file_get_contents('./caches/txt/'.$type.'.txt');
			$txt = str_replace('[appname]', $this->myconfig['name'], $txt);
			$txt = str_replace('[qq]', $this->myconfig['qq'], $txt);
			$txt = str_replace('[email]', $this->myconfig['email'], $txt);
			$data['content'] = $txt;
		}
		//seo
		$data['title'] = $title.' - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
		$data['name'] = $title;

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view($tpl);
		$this->load->view('bottom.tpl');
	}
}