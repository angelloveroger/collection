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

class Ads extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index(){
		$data['ads'] = $this->myconfig['ads'];
		if(empty($data['ads']['user_token'])){
			$data['ads'] = array('start'=>0,'banner'=>0,'heng'=>0,'playheng'=>0,'player'=>0,'bbs'=>0,'user_token'=>'');
		}
		$this->load->view('ads/index.tpl',$data);
	}

	public function api($type = 'open'){
		//开通
		if($type == 'open'){
			$post['user_token'] = get_post('user_token');
			$json = geturl('http:'.base64decode(APIURL).'ads/api/open',$post);
			$arr = json_decode($json,1);
			if($arr['code'] == 0) get_json($arr['msg'],0);
			$this->myconfig['ads']['bbs'] = 0;
			$this->myconfig['ads']['user_token'] = $post['user_token'];
			$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
			if(!$res) get_json('文件写入失败，请检查config.php权限',0);
			get_json('开通成功',1);
		}elseif($type == 'save'){
			$post = get_post();
			foreach ($post as $k => $v) {
				$this->myconfig['ads'][$k] = $v;
			}
			//保存
			$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
			if(!$res) get_json('文件写入失败，请检查config.php权限',0);
			get_json('修改成功',1);
		}elseif($type == 'settlement'){
			$post['user_token'] = isset($this->myconfig['ads']['user_token']) ? $this->myconfig['ads']['user_token'] : '';
			$json = geturl('http:'.base64decode(APIURL).'ads/api/settlement',$post);
			echo $json;exit;
		}elseif($type == 'info'){
			$post['user_token'] = isset($this->myconfig['ads']['user_token']) ? $this->myconfig['ads']['user_token'] : '';
			$json = geturl('http:'.base64decode(APIURL).'ads/api/user',$post);
			echo $json;exit;
		}elseif($type == 'infosave'){
			$post = array(
				'user_token' => $this->myconfig['ads']['user_token'],
				'bank_name' => get_post('bank_name',true),
				'bank_account' => get_post('bank_account',true),
				'bank_branch' => get_post('bank_branch',true),
				'bank_account_type' => get_post('bank_account_type',true)
			);
			$json = geturl('http:'.base64decode(APIURL).'ads/api/usersave',$post);
			echo $json;exit;
		}else{
			//广告收益
			$post['user_token'] = isset($this->myconfig['ads']['user_token']) ? $this->myconfig['ads']['user_token'] : '';
			$json = geturl('http:'.base64decode(APIURL).'ads/api/earnings',$post);
			echo $json;exit;
		}
	}
}