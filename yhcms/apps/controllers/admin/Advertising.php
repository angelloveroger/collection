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

class Advertising extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
		//请求头
		$this->header = array(
			'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36'
		);
	}

	public function index(){
		$data['open'] = !empty($this->myconfig['union']['username']) ? 1 : 0;
		$this->load->view('advertising/index.tpl',$data);
	}

	public function api($type = 'open'){
		//开通
		if($type == 'open'){
			//注册
			$post = array('username'=>WEBURL,'password'=>md5(_SYSKEY_),'password1'=>md5(_SYSKEY_));
			$json = geturl(base64decode(UNIONURL).'user/register',$post);
			$data = json_decode($json, 1);
			if(empty($data) || $data['code'] == 0){
				$msg = empty($data)?'开通失败':$data['msg'];
				if($msg == '用户名已存在'){
					$json = geturl(base64decode(UNIONURL).'user/resetpwd/username/'.WEBURL);
					$data = json_decode($json, 1);
					if($data['code'] == 0){
						get_json('开通失败:'.$data['msg'],0);
					}
				}else{
					get_json($msg,0);
				}
			}
			$this->myconfig['union']['username'] = WEBURL;
			$this->myconfig['union']['password'] = $data['password'];
			$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
			//获取媒体ID
			$post = $this->myconfig['union'];
			$json = geturl(base64decode(UNIONURL).'media/index',$post);
			$arr = json_decode($json,1);
			$this->myconfig['union']['media_id'] = $arr['list'][0]['id'];
			$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
			if(!$res) get_json('文件写入失败，请检查config.php权限',0);
			get_json('开通成功',1);
		}elseif($type == 'index'){
			//广告收益
			$post = array_merge($this->myconfig['union'],array('start'=>date('Y-m-d', strtotime('-7 day')),'end'=>date('Y-m-d')));
			$json = geturl(base64decode(UNIONURL).'index',$post);
			echo $json;exit;
		}elseif($type == 'adunit'){
			//广告列表
			$post = $this->myconfig['union'];
			$json = geturl(base64decode(UNIONURL).'adunit/index',$post);
			exit($json);
			$arr = json_decode($json,1);
			if(isset($arr['list'])) $arr['code'] = 1;
			echo json_encode($arr);exit;
		}elseif($type == 'adunitadd'){
			$post = $this->myconfig['union'];
			$json = geturl(base64decode(UNIONURL).'adunit/insert?'.http_build_query($post));
			echo $json;exit;
		}elseif($type == 'adunitcode'){
			$post = $this->myconfig['union'];
			$post['id'] = (int)get_post('id');
			$json = geturl(base64decode(UNIONURL).'adunit/code?'.http_build_query($post));
			$arr = json_decode($json,1);
			$code = array();
			foreach ($arr['list'] as $key => $value){
				$code[] = array('name'=>$value['name'],'code'=>$value['code']);
			}
			get_json(array('list'=>$code),1);
		}elseif($type == 'adunitsave'){
			$post = array_merge($this->myconfig['union'],array(
				'name' => get_post('name',true),
				'bidding_method' => get_post('bidding_method',true),
				'creative_tpl_id' => get_post('creative_tpl_id',true),
				'show' => get_post('show',true),
			));
			$json = geturl(base64decode(UNIONURL).'adunit/insert',$post);
			echo $json;exit;
		}elseif($type == 'info'){
			$post = $this->myconfig['union'];
			$json = geturl(base64decode(UNIONURL).'user/index?'.http_build_query($post));
			echo $json;exit;
		}elseif($type == 'infosave'){
			$post = array_merge($this->myconfig['union'],array(
				'qq' => get_post('qq',true),
				'mobile' => get_post('mobile',true),
				'description' => get_post('description',true),
				'bank_name' => get_post('bank_name',true),
				'bank_account' => get_post('bank_account',true),
				'bank_branch' => get_post('bank_branch',true),
				'bank' => get_post('bank',true)
			));
			//print_r($post);exit;
			$json = geturl(base64decode(UNIONURL).'user/index',$post);
			echo $json;exit;
		}else{
			$post = $this->myconfig['union'];
			$json = geturl(base64decode(UNIONURL).'pay/index?'.http_build_query($post));
			echo $json;exit;
		}
	}
}