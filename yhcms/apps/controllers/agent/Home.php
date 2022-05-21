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
		//模板目录
		$this->load->get_templates('agent');
		//判断是否登陆
		$this->agent = get_agent_islog();
	}

	public function index(){
		$data['title'] = '代理管理中心 - '.$this->myconfig['name'];
		$data['agent'] = $this->agent;
		$this->load->view('home/index.tpl',$data);
	}

	public function main(){
		$jtime = strtotime(date('Y-m-d 0:0:0'))-1;
		$ztime = strtotime(date('Y-m-d 0:0:0'))*7-1;
		$ytime = strtotime(date('Y-m-01 0:0:0'))-1;
		//统计
		$data = array(
			'user' => array(
				'nums' => $this->mydb->get_nums('user',array('aid'=>$this->agent['id'])),
				'day' => $this->mydb->get_nums('user',array('aid'=>$this->agent['id'],'addtime>'=>$jtime)),
			),
			'rmb' => array(
				'nums' => ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0))),
				'day' => ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>$jtime))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>$jtime))),
				'zhou' => ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>$ztime))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>$ztime))),
				'yue' => ($this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>$ytime))+$this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>$ytime))),
			),
		);
		$data['agent'] = $this->agent;
		$this->load->view('home/main.tpl',$data);
	}
}