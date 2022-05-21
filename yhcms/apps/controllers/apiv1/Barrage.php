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

class Barrage extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//弹幕记录
	public function index() {
		$yhuid = get_post('yhuid');
		$vid = (int)get_post('vid');
		$zid = (int)get_post('zid');
		$jid = (int)get_post('jid');
		if($vid == 0 || $zid == 0 || $jid == 0) get_json('参数不完整',0);
		//查询条件
		$where = array('vid'=>$vid,'zid'=>$zid,'jid'=>$jid);
	    $list = $this->mydb->get_select('vod_barrage',$where,'text,duration time,color','id ASC',10000);
	    foreach ($list as $k => $v) {
	    	$list[$k]['text'] = emoji_replace($v['text'],1);
	    	if(empty($v['color'])) $list[$k]['color'] = '#ffffff';
	    }
	    //云端弹幕
	    $name = getzd('vod','name',$vid);
	    $jid = getzd('vod_ji','xid',$jid);
	    if(empty($yhuid)) $yhuid = md5($name.$jid);
	    $arr = json_decode(geturl('http:'.base64decode(APIURL).'barrage',array('yhuid'=>$yhuid,'name'=>$name,'jid'=>$jid)),1);
	    if($arr['code'] == 1){
		    foreach ($arr['data']['list'] as $k2 => $v) {
		    	$v['text'] = emoji_replace($v['text'],1);
		    	if(empty($v['color'])) $v['color'] = '#ffffff';
		    	if(!$this->get_repeat($list,$v['text'])){
		    		$list[] = $v;
		    	}
		    }
		}
		$data['list'] = $list;
		get_json($data);
	}

	//写入弹幕
	public function send(){
		$yhuid = get_post('yhuid');
		$vid = (int)get_post('vid');
		$zid = (int)get_post('zid');
		$jid = (int)get_post('jid');
		$duration = round(get_post('duration'));
		$text = get_post('text');
		$color = '#ffffff';
		if($vid == 0 || $zid == 0 || $jid == 0) get_json('参数不完整',0);
		if(empty($text))  get_json('弹幕内容为空',0);
		//判断灌水
		$row = $this->mydb->get_row('vod_barrage',array('uid'=>$this->uid),'addtime','addtime desc');
		if($row && $row['addtime']+10 > time()) get_json('请勿灌水',0);
		$name = getzd('vod','name',$vid);
	    $xid = getzd('vod_ji','xid',$jid);
	    $yhuid = md5($name.$xid);
	    if(empty($yhuid)) $yhuid = md5($name.$xid);
        $res = geturl('http://api.barrage.yhcms.cc:2121/?type=send&color='.urlencode($color).'&content='.urlencode($text).'&uid='.$yhuid);
        if($res == 'offline') get_json('不在线',0);
        if($res == 'fail') get_json('发送失败',0);
		//入库
		$this->mydb->get_insert('vod_barrage',array(
			'uid' => $this->uid,
			'vid' => $vid,
			'zid' => $zid,
			'jid' => $jid,
			'text' => emoji_replace($text),
			'duration' => $duration,
			'addtime' => time()
		));
		geturl('http:'.base64decode(APIURL).'barrage/index/send',array('yhuid'=>$yhuid,'name'=>$name,'jid'=>$xid,'time'=>$duration,'text'=>emoji_replace($text)));
		get_json('发送成功');
	}

	//去除相同记录
	private function get_repeat($arr,$row){
		foreach ($arr as $v) {
			if($v['text'] == $row['text'] && $v['time'] == $row['time']) return true;
		}
		return flase;
	}
}