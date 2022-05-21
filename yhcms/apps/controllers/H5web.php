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

class H5web extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->load->get_templates('apph5');
	}

	//文本输出
	public function index($type='agreement') {
		if($type == 'privacy'){
		    $title = '隐私政策';
		}else{
		    $type = 'agreement';
		    $title = '用户协议';
		}
		//获取内容
		$txt = file_get_contents('./caches/txt/'.$type.'.txt');
		$txt = str_replace('[appname]', $this->myconfig['name'], $txt);
		$txt = str_replace('[qq]', $this->myconfig['qq'], $txt);
		$txt = str_replace('[email]', $this->myconfig['email'], $txt);

		echo '<!doctype html><html><head><title>'.$title.'</title><meta charset="utf-8"><meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover"><style>body{padding:0 10px}</style><body>'.$txt.'</body></html>';
	}

	public function agent(){
		//判断是否登陆
		$this->agent = get_agent_islog(0);
		if(!$this->agent){
			$data['title'] = '加入代理';
			$this->load->view('agent.tpl',$data);
		}else{
			$data['title'] = '代理收益';
			$data['agent'] = $this->agent;
			$jtime = strtotime(date('Y-m-d 0:0:0'))-1;
			$ztime = strtotime(date('Y-m-d 0:0:0'))-86401;
			//昨日收益
			$data['rmb1'] = ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>$ztime,'addtime<'=>$jtime))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>$ztime,'paytime<'=>$jtime)));
			//今日收益
			$data['rmb2'] = ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>$jtime))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>$jtime)));
			//总收益
			$data['rmb3'] = ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0)));
			$data['pc_num'] = $this->mydb->get_nums('user',array('aid'=>$this->agent['id'],'facility'=>'pc'));
			$data['h5_num'] = $this->mydb->get_nums('user',array('aid'=>$this->agent['id'],'facility'=>'h5'));
			$data['android_num'] = $this->mydb->get_nums('user',array('aid'=>$this->agent['id'],'facility'=>'android'));
			$data['ios_num'] = $this->mydb->get_nums('user',array('aid'=>$this->agent['id'],'facility'=>'ios'));
			$this->load->view('agent-income.tpl',$data);
		}
	}
}
