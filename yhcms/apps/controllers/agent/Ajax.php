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

class Ajax extends My_Controller {

	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
        //判断是否登陆
        $this->agent = get_agent_islog();
	}

    //趋势图统计
    public function echat(){
        $type = get_post('type',true);
        $day = 6;$data = array();
        $jtime = strtotime(date('Y-m-d 0:0:0'));
        if($type == 'user_card'){ //卡密充值
            for ($i=$day; $i >= 0; $i--) { 
                $kstime = $jtime-86400*$i;
                $data['week'][] = date('Y-m-d',$kstime);
                $data['pay']['count'][] = $this->mydb->get_nums('user_card',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>($kstime-1),'paytime<'=>($kstime+86402)));
                $rmb = $this->mydb->get_sum('user_card','rmb',array('aid'=>$this->agent['id'],'uid>'=>0,'paytime>'=>($kstime-1),'paytime<'=>($kstime+86402)));
                if(!$rmb) $rmb = '0.00';
                $data['pay']['rmb'][] = $rmb;
            }
        }elseif($type == 'user_order'){ //充值统计
            for ($i=$day; $i >= 0; $i--) { 
                $kstime = $jtime-86400*$i;
                $data['week'][] = date('Y-m-d',$kstime);
                $data['pay']['count'][] = $this->mydb->get_nums('user_order',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>($kstime-1),'addtime<'=>($kstime+86402)));
                $rmb = $this->mydb->get_sum('user_order','rmb',array('aid'=>$this->agent['id'],'pid'=>1,'addtime>'=>($kstime-1),'addtime<'=>($kstime+86402)));
                if(!$rmb) $rmb = '0.00';
                $data['pay']['rmb'][] = $rmb;
            }
        }
        get_json($data,1);
    }
}