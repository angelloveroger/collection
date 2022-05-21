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

class Init extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//初始化
	public function index() {
		$version = get_post('version',true);
		$user_token = get_post('user_token',true);
		$app = array();
		$app['update'] = $this->myconfig['app'];
		$app['update']['is_update'] = $version < $app['update']['version'] ? 1 : 0;
		$app['update']['downurl'] = get_share_url();
		$app['privacy_url'] = 'http://'.$this->myconfig['url'].links('h5web/index/privacy');
		$app['agreement_url'] = 'http://'.$this->myconfig['url'].links('h5web/index/agreement');
		$app['ads'] = array();
		unset($app['update']['appkey'],$app['update']['android_downurl'],$app['update']['ios_downurl']);
		$app['notice'] = $this->myconfig['notice2'];
		$app['agent_url'] = !empty($this->myconfig['user']['agent']) ? 'http://'.WEBURL.links('h5web/agent') : '';
		$app['jxtoken'] = $this->myconfig['jxtoken'];
		//输出
		get_json($app);
	}

	//获取联系信息
	public function about() {
		$data['qq'] = $this->myconfig['qq'];
		$data['email'] = $this->myconfig['email'];
		$data['telegram'] = $this->myconfig['telegram'];
		//输出
		get_json($data);
	}
	
	//获取服务器时间
	public function time() {
		$data['time'] = time();
		//输出
		get_json($data);
	}
	
	//获取注册验证码是否开启
	public function regcode() {
		$data['regcode'] = _REGCODE_;
		//输出
		get_json($data);
	}
}
