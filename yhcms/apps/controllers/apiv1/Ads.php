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
		$type = get_post('type',true);
		$tarr = array('index','start','player','bbs');
		if(!in_array($type,$tarr)) get_json('type err',0);
		$ads = array('start'=>array(),'banner'=>array(),'heng'=>array(),'player'=>array());
		$vip = 0;
		if($this->uid > 0){
			$vip = (int)getzd('user','vip',$this->uid);
		}
		if($vip == 0 && !empty($this->myconfig['ads']['user_token'])){
			$adsarr = json_decode(geturl('http:'.base64decode(APIURL).'ads/api'),1);
			$heng = array();
			if($type == 'index'){
				if($this->myconfig['ads']['banner'] > 0 && !empty($adsarr['data']['banner'])){
					$r = array_rand($adsarr['data']['banner'],1);
					$ads['banner'] = array($adsarr['data']['banner'][$r]);
				}
				for($i=0; $i < $this->myconfig['ads']['heng']; $i++) {
					if(!empty($adsarr['data']['heng'])){
						$r = array_rand($adsarr['data']['heng'],1);
						$heng[] = $adsarr['data']['heng'][$r];
					}
				}
				$ads['heng'] = $heng;
				unset($ads['start'],$ads['player']);
			}elseif($type == 'player'){
				if($this->myconfig['ads']['player'] > 0 && !empty($adsarr['data']['player'])){
					$r = array_rand($adsarr['data']['player'],1);
					$ads['player'] = array($adsarr['data']['player'][$r]);
				}
				for ($i=0; $i < $this->myconfig['ads']['playheng']; $i++) {
					if(!empty($adsarr['data']['heng'])){
						$r = array_rand($adsarr['data']['heng'],1);
						$heng[] = $adsarr['data']['heng'][$r];
					}
				}
				$ads['heng'] = $heng;
				unset($ads['start'],$ads['banner']);
			}elseif($type == 'bbs'){
				$len = isset($this->myconfig['ads']['bbs']) ? $this->myconfig['ads']['bbs'] : 0;
				for ($i=0; $i < $len; $i++) {
					if(!empty($adsarr['data']['heng'])){
						$r = array_rand($adsarr['data']['heng'],1);
						$heng[] = $adsarr['data']['heng'][$r];
					}
				}
				$ads['heng'] = $heng;
				unset($ads['start'],$ads['banner'],$ads['player']);
			}else{
				if($this->myconfig['ads']['start'] > 0 && !empty($adsarr['data']['start'])){
					$r = array_rand($adsarr['data']['start'],1);
					$ads['start'] = array($adsarr['data']['start'][$r]);
				}
				unset($ads['heng'],$ads['banner'],$ads['player']);
			}
		}
		//输出
		get_json($ads);
	}
}