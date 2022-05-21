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

class Share extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
        $this->load->get_templates('apph5');
	}

	public function index(){
		$uid = (int)get_post('uid');
		$vid = (int)get_post('vid');
        $aid = (int)get_post('aid');
        //判断是否为防封域名
        if($_SERVER['HTTP_HOST'] == $this->myconfig['ffurl'] && $this->myconfig['ffurl'] != $this->myconfig['url']){
            header("location:".get_ff_url($uid,$vid,$aid));
            exit;
        }
        if($aid > 0) set_cookie('aid',$aid,86400);
        if(!defined('IS_WAP') && $this->myconfig['web']['open'] == 1){
            $pcurl = $vid > 0 ? links('info/'.$vid) : links('appdown');
            header("location:".$pcurl);
            exit;
        }
        if(isset($this->myconfig['sharewxqq']) && $this->myconfig['sharewxqq'] == 1 && $this->check_browser('wechat') || $this->check_browser('qq')){
            $data['is_wxqq'] = 2;
        }else{
            $data['is_wxqq'] = 1;
        }
		$data['name'] = $this->myconfig['name'];
        $data['ios_downurl'] = base64_encode($this->myconfig['app']['ios_downurl']);
        $data['android_downurl'] = base64_encode($this->myconfig['app']['android_downurl']);
        $data['uid'] = $uid;
        $data['aid'] = $aid;
        $data['vid'] = $vid;
        $data['ios'] = preg_match("/(iPhone|iPad|iPod)/i", strtoupper($_SERVER['HTTP_USER_AGENT']));
		if($vid == 0){
            $this->load->view('share.tpl',$data);
		}else{
            $data['vod'] = $this->mydb->get_row('vod',array('id'=>$vid));
            $data['love'] = $this->mydb->get_select('vod',array('cid'=>$data['vod']['cid']),'id,name,pic,state','rhits desc',6);
            $zid = getzd('vod_zu','id',$vid,'vid');
            $data['ji'] = $this->mydb->get_select('vod_ji',array('zid'=>$zid),'id,name','xid asc',500);
			$this->load->view('vod.tpl',$data);
		}
	}

    public function vod(){
        $uid = (int)get_post('uid');
        $aid = (int)get_post('aid');
        $did = (int)get_post('did');
        $arr = array();
        $arr[] = 'vid='.$did;
        if($uid > 0) $arr[] = 'uid='.$uid;
        if($aid > 0) $arr[] = 'uid='.$aid;
        header("location:".links('share').'?'.implode('&',$arr));
        exit;
    }

    public function myopia(){
        $uid = (int)get_post('uid');
        $aid = (int)get_post('aid');
        $did = (int)get_post('did');
        $arr = array();
        $arr[] = 'did='.$did;
        if($uid > 0) $arr[] = 'uid='.$uid;
        if($aid > 0) $arr[] = 'uid='.$aid;
        header("location:".links('share').'?'.implode('&',$arr));
        exit;
    }

    public function bbs(){
        $id = (int)get_post('did');
        $row = $this->mydb->get_row('bbs',array('id'=>$id));
        if(!$row) error('帖子不存在');
        $row['user'] = $this->mydb->get_row('user',array('id'=>$row['uid']),'nickname,pic,vip');
        $row['comment'] = $this->mydb->get_select('comment',array('bid'=>$id,'fid'=>0),'*','id desc',3);
        $row['pics'] = $this->mydb->get_select('bbs_pic',array('bid'=>$id),'url','id asc',10);
        $data['bbs'] = $row;
        if(isset($this->myconfig['sharewxqq']) && $this->myconfig['sharewxqq'] == 1 && $this->check_browser('wechat') || $this->check_browser('qq')){
            $data['is_wxqq'] = 2;
        }else{
            $data['is_wxqq'] = 1;
        }
        $this->load->view('bbs.tpl',$data);
    }

	public function ios(){
	    $data['is_down'] = 1;
	    if(!$this->check_browser('safari')){
	        if($this->check_browser('wechat') || $this->check_browser('qq')){
	            $data['is_down'] = 2;
	        }else{
	            $data['is_down'] = 3;
	        }
	    }
	    $data['ios_downurl'] = $this->myconfig['app']['ios_downurl'];
	    $this->load->view('down_ios.tpl',$data);
	}

	//判断浏览器
    public function check_browser($name){
        $UserAgent = $_SERVER['HTTP_USER_AGENT'];
        switch ($name) {
            case 'wechat':
                if (strpos($UserAgent, 'MicroMessenger')) {
                    return true;
                }
                break;
            case 'qq':
                if (strpos($UserAgent, 'QQ') && strpos($UserAgent,'_SQ_')) {
                    return true;
                }
                break;
            case 'safari':
                if (strpos($UserAgent, 'Safari') && 
                    strpos($UserAgent, 'Firefox') === false && 
                    strpos($UserAgent, 'MicroMessenger') === false && 
                    strpos($UserAgent, 'QQ') === false && 
                    strpos($UserAgent, 'Chrome') === false && 
                    strpos($UserAgent, 'Opera') === false && 
                    strpos($UserAgent, '360SE') === false
                ) {
                    return true;
                }
                break;
        }
        return false;
    }
}