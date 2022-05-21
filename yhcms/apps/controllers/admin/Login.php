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

class Login extends My_Controller {

	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index(){
		$this->load->view('home/login.tpl');
	}

	public function save(){
		$name = get_post('name',true);
		$pass = get_post('pass',true);
		$code = get_post('code',true);
		if(empty($name)) get_json('登录账号不能为空',0);
		if(empty($pass)) get_json('登录密码不能为空',0);
		if(empty($code)) get_json('认证码不能为空',0);
		if($this->myconfig['admin_code'] != $code) get_json('认证码不正确',0);
		$row = $this->mydb->get_row('admin',array('name'=>$name));
		if(!$row || $row['pass'] != md5($pass)) get_json('账号或者密码不正确',0);
		$this->mydb->get_update('admin',array('logip'=>getip(),'lognum'=>$row['lognum']+1,'logtime'=>time()),$row['id']);
		set_cookie('admin_token',$row['id'],86400);
		get_json('登录成功');
	}
	
	//退出
	public function ext(){
		set_cookie('admin_token');
		header("location:".links('login'));
		exit;
	}
}