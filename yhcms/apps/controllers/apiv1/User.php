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

class User extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//用户信息
	public function index() {
		$user = get_islog();//判断登录
		if($user){
			$user['is_pass'] = empty($user['pass']) ? 0 : 1;
			unset($user['pass'],$user['channel'],$user['deviceid'],$user['addtime'],$user['logtime'],$user['qdnum'],$user['qdznum'],$user['qddate']);
			//观看历史
			if(get_post('version') < '1.2.1'){
				$watch = $this->mydb->get_select('watch',array('uid'=>$this->uid),'vid,jid','addtime DESC',20);
				foreach ($watch as $k => $v) {
					$rowv = $this->mydb->get_row('vod',array('id'=>$v['vid']),'name,pic');
					$watch[$k]['name'] = $rowv ? $rowv['name'] : '视频已下架';
					$watch[$k]['pic'] = $rowv ? $rowv['pic'] : '';
					$watch[$k]['jname'] = getzd('vod_ji','name',$v['jid']);
					unset($watch[$k]['jid']);
				}
			}else{
				$watch = array();
			}
			$user['watch'] = $watch;
			$user['tel'] = get_sub($user['tel']);
			$user['fans_nums'] = $this->mydb->get_nums('user_fans',array('uid'=>$this->uid));
			$user['funco_nums'] = $this->mydb->get_nums('user_fans',array('fuid'=>$this->uid));
			$user['bbs_nums'] = $this->mydb->get_nums('bbs',array('uid'=>$this->uid));
			$user['message_nums'] = $this->mydb->get_nums('user_message',array('uid'=>$this->uid,'look'=>0));
		}else{
			$user = array('id'=>0,'tel'=>'','nickname'=>'登录后获得更多权益','pic'=>getpic('','user'),'vip'=>0,'viptime'=>'未开通','cion'=>0,'qdnum'=>0,'qdznum'=>0,'qddate'=>0,'watch'=>array(),'fans_nums'=>0,'funco_nums'=>0,'bbs_nums'=>0,'message_nums'=>0);
		}
		get_json($user);
	}

    //PC扫码登录
    public function qrcode_init() {
        $token = get_post('token');
        $id = (int)sys_auth($token,1);
	    if($id > 0){
	    	$row = $this->mydb->get_row('qrcode_log',array('id'=>$id));
	    	if($row){
	    		$time = sys_auth($row['token'],1);
    			$this->mydb->get_update('qrcode_log',array('init'=>1),$id);
    			get_json('扫码成功',1);
	    	}
	    }
	    get_json('token无效',0);
    }

    //PC扫码登录确定
    public function qrcode_log() {
    	$user = get_islog();//判断登录
    	if(!$user) get_json('未登录',-1);
        $token = get_post('token');
        $id = (int)sys_auth($token,1);
	    if($id == 0) get_json('非法请求',0);
	    $row = $this->mydb->get_row('qrcode_log',array('id'=>$id));
	    if(!$row) get_json('非法请求',0);
	    
	    $time = sys_auth($row['token'],1);
	    if(!$time || $time < time()-180) get_json('二维码已失效',0);
	    //设置登录状态
	    $this->mydb->get_update('qrcode_log',array('uid'=>$this->uid),$id);
	    get_json('登录成功',1);
    }

    //PC扫码取消
    public function qrcode_del() {
        $token = get_post('token');
        $id = (int)sys_auth($token,1);
	    if($id > 0){
	    	$row = $this->mydb->get_row('qrcode_log',array('id'=>$id));
	    	if($row){
	    		$this->mydb->get_del('qrcode_log',$id);
    			get_json('操作成功',1);
	    	}
	    }
    }

	//关联上级
	public function invitatione(){
		$fid = (int)get_post('fid');
		$aid = (int)get_post('aid');
		$facility = get_post('facility',true);
		$deviceid = get_post('deviceid',true);
		if($facility != 'android') $facility = 'ios';
		if($fid > 0 || $aid > 0){
			$row = $this->mydb->get_row('user_'.$facility,array('deviceid'=>$deviceid));
			if($row){
				$edit = array();
				if($row['fid'] == 0 && $fid > 0 && $fid != $this->uid){
					$this->mydb->get_update('user_'.$facility,array('fid'=>$fid),$row['id']);
					if($this->uid > 0) $edit['fid'] = $fid;
				}
				if($this->uid > 0 && $aid > 0){
					$yaid = (int)getzd('user','aid',$this->uid);
					if($yaid == 0) $edit['aid'] = $aid;
				}
				if($this->uid > 0 && !empty($edit)) $this->mydb->get_update('user',$edit,$this->uid);
			}
		}
		get_json('ok',1);
	}

	//手机验证码登录
	public function codelog(){
		$tel = get_post('tel',true);
		$aid = (int)get_post('aid');
		$code = (int)get_post('code');
		$facility = get_post('facility',true);
		$deviceid = get_post('deviceid',true);
		if($facility != 'android') $facility = 'ios';
		if(!is_tel($tel)) get_json('手机号码格式错误',0);
		if($code == 0) get_json('验证码不能为空',0);
		$share = 0;
		//判断验证码是否正确
		$rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
		if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
		if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
		//删除验证码
		$this->mydb->get_del('user_code',$rowt['id']);
		//设备信息
		$row1 = $this->mydb->get_row('user_'.$facility,array('deviceid'=>$deviceid));
		//判断手机号码是否存在
		$row = $this->mydb->get_row('user',array('tel'=>$tel),'id,fid,aid');
		if($row){
			$edit = array();
			if($row['fid'] == 0 && $row1['fid'] > 0 && $row1['fid'] != $row['id']){
				$share = 1;
				$edit['fid'] = $row1['fid'];
			}
			if($row['aid'] == 0 && $aid > 0) $edit['aid'] = $aid;
			if(!empty($edit)) $this->mydb->get_update('user',$edit,$row['id']);
			$uid = $row['id'];
		}else{
			$vip = $viptime = 0;
			if($this->myconfig['user']['reg_vip'] > 0){
				$vip = 1;
				$viptime = time()+$this->myconfig['user']['reg_vip']*86400;
			}
			if($row1['fid'] > 0) $share = 1;
			$uid = $this->mydb->get_insert('user',array(
				'tel' => $tel,
				'fid' => $row1['fid'],
				'aid' => $aid,
				'nickname' => '网友_'.time(),
				'facility' => get_post('facility',true),
				'deviceid' => get_post('deviceid',true),
				'vip' => $vip,
				'viptime' => $viptime,
				'cion' => $this->myconfig['user']['reg_cion'],
				'logtime' => time(),
				'addtime' => time()
			));
		}
        //奖励邀请人
        if($share == 1){
	        if($this->myconfig['user']['share_vip']){
	            $rowf = $this->mydb->get_row('user',array('id'=>$row1['fid']),'id,viptime');
	            if($rowf){
	                $daytime = $this->myconfig['user']['share_vip']*86400;
	                $viptime = $rowf['viptime'] > time() ? $rowf['viptime']+$daytime : time()+$daytime;
	                $this->mydb->get_update('user',array('vip'=>1,'viptime'=>$viptime),$row1['fid']);
	            }
	        }
    	}
		//输出
		$data['token'] = sys_auth($uid);
		get_json($data);
	}

	//密码登录
	public function passlog(){
		$aid = (int)get_post('aid');
		$tel = get_post('tel',true);
		$pass = get_post('pass',true);
		$facility = get_post('facility',true);
		$deviceid = get_post('deviceid',true);
		if($facility != 'android') $facility = 'ios';
		if(!is_tel($tel)) get_json('手机号码格式错误',0);
		if(empty($pass)) get_json('登录密码不能为空',0);
		//判断手机号码是否存在
		$row = $this->mydb->get_row('user',array('tel'=>$tel),'id,pass,fid,aid');
		if(!$row || $row['pass'] != md5($pass)) get_json('手机或者密码不正确',0);
		//设备信息
		$row1 = $this->mydb->get_row('user_'.$facility,array('deviceid'=>$deviceid));
		$edit = array();
		if($row['fid'] == 0 && $row1['fid'] > 0 && $row1['fid'] != $row['id']){
			$share = 1;
			$edit['fid'] = $row1['fid'];
		}
		if($row['aid'] == 0 && $aid > 0) $edit['aid'] = $aid;
		if(!empty($edit)) $this->mydb->get_update('user',$edit,$row['id']);
		//输出
		$data['token'] = sys_auth($row['id']);
		get_json($data);
	}

	//注册登录
	public function reg(){
		$aid = (int)get_post('aid');
		$tel = get_post('tel',true);
		$pass = get_post('pass',true);
		$facility = get_post('facility',true);
		$deviceid = get_post('deviceid',true);
		if($facility != 'android') $facility = 'ios';
		if(!is_tel($tel)) get_json('手机号码格式错误',0);
		if(empty($pass)) get_json('登录密码不能为空',0);
		//判断手机号码是否存在
		$row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
		if($row) get_json('手机已注册',0);
		//设备信息
		$row1 = $this->mydb->get_row('user_'.$facility,array('deviceid'=>$deviceid));
		//新用户赠送
		$vip = $viptime = 0;
		if($this->myconfig['user']['reg_vip'] > 0){
			$vip = 1;
			$viptime = time()+$this->myconfig['user']['reg_vip']*86400;
		}
		//注册入库
		$uid = $this->mydb->get_insert('user',array(
			'tel' => $tel,
			'fid' => $row1['fid'],
			'aid' => $aid,
			'pass' => md5($pass),
			'nickname' => '网友_'.time(),
			'facility' => $facility,
			'deviceid' => $deviceid,
			'vip' => $vip,
			'viptime' => $viptime,
			'cion' => $this->myconfig['user']['reg_cion'],
			'logtime' => time(),
			'addtime' => time()
		));
		if(!$uid) get_json('注册失败',0);
		//输出
		$data['token'] = sys_auth($uid);
		get_json($data);
	}

	//发送手机验证码
	public function telcode(){
		$type = get_post('type',true);
		$tel = get_post('tel',true);
		if($type == 'tel'){
			$user = get_islog('*',1);//判断登录
			$tel = $user['tel'];
		}
		if(!is_tel($tel)) get_json('手机号码格式错误',0);
		$code = rand(111111,999999);
		//判断手机号码是否存在
		$row = $this->mydb->get_row('user_code',array('tel'=>$tel),'id,addtime');
		if($row && $row['addtime']+60 > time()) get_json('发送太频繁，扫后再试',0);
		//发送手机验证码
		$this->load->library('sms');
		$res = $this->sms->send($tel,$code);
		if(!$res) get_json('验证码发送失败',0);
		//记录数据库
		if(!$row){
			$res = $this->mydb->get_insert('user_code',array(
				'tel' => $tel,
				'code' => $code,
				'addtime' => time()
			));
		}else{
			$res = $this->mydb->get_update('user_code',array('code'=>$code,'addtime'=>time()),$row['id']);
		}
		//删除已过期验证码记录
		$this->db->query('delete from user_code where addtime<'.(time()-3600));
		if(!$res) get_json('验证码发送失败',0);
		get_json('发送成功',1);
	}

	//验证原手机验证码
	public function verifytel(){
		$pass = get_post('pass',true);
		$code = (int)get_post('code');
		$user = get_islog('*',1);//判断登录
		//判断验证码是否正确
		if($code == 0){
			if(empty($pass)) get_json('请输入登录密码',0);
			if(md5($pass) != $user['pass']) get_json('登录密码错误',0);
		}else{
			$rowt = $this->mydb->get_row('user_code',array('tel'=>$user['tel']));
			if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
			if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
			//删除验证码
			$this->mydb->get_del('user_code',$rowt['id']);
		}
		//输出
		$data = array('msg'=>'验证成功','ckey'=>sys_auth($user['tel']));
		get_json($data);
	}

	//修改手机
	public function edittel(){
		$tel = get_post('tel',true);
		$code = (int)get_post('code');
		$user = get_islog('*',1);//判断登录
		if(!is_tel($tel)) get_json('手机号码格式错误',0);
		if($code == 0) get_json('请输入验证码',0);
		//判断ckey
		$ytel = sys_auth(get_post('ckey'),1);
		if($ytel != $user['tel']) get_json('非法ckey',0);
		//判断新手机是否存在
		$row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
		if($row) get_json('该手机已存在',0);
		//判断验证码是否正确
		$rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
		if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
		if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
		//修改手机
		$this->mydb->get_update('user',array('tel'=>$tel),$this->uid);
		//删除验证码
		$this->mydb->get_del('user_code',$rowt['id']);
		//输出
		$data = array('msg'=>'修改成功','tel'=>get_sub($tel));
		get_json($data);
	}

	//修改头像
	public function uppic(){
		$user = get_islog('*',1);//判断登录
		$pic = get_uppic('user');
		$this->mydb->get_update('user',array('pic'=>$pic),$this->uid);
		if(file_exists(FCPATH.$user['pic'])) unlink(FCPATH.$user['pic']);
		//输出
		$data = array('msg'=>'上传成功','pic'=>$pic);
		get_json($data);
	}

	//修改昵称
	public function edit($zd='nickname'){
		if($zd != 'sex') $zd = 'nickname';
		$user = get_islog('*',1);//判断登录
		$val = get_post($zd,true);
		if(empty($val)) get_json('数据不能为空',0);
		$this->mydb->get_update('user',array($zd=>$val),$this->uid);
		get_json('修改成功');
	}

	//修改密码
	public function editpass(){
		$pass = get_post('pass',true);
		$code = (int)get_post('code');
		if($code == 0) get_json('验证码不能为空',0);
		if(empty($pass)) get_json('新密码不能为空',0);
		$user = get_islog('*',1);//判断登录
		//判断验证码是否正确
		$rowt = $this->mydb->get_row('user_code',array('tel'=>$user['tel']));
		if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
		if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
		//修改密码
		$this->mydb->get_update('user',array('pass'=>md5($pass)),$this->uid);
		$this->mydb->get_del('user_code',$rowt['id']);
		get_json('修改成功');
	}

	//注销账号
	public function cancel(){
		$code = (int)get_post('code');
		if($code == 0) get_json('验证码不能为空',0);
		$user = get_islog('*',1);//判断登录
		//判断验证码是否正确
		$rowt = $this->mydb->get_row('user_code',array('tel'=>$user['tel']));
		if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
		//if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
		//删除头像
		if(file_exists(FCPATH.$user['pic'])) unlink(FCPATH.$user['pic']);
		//删除用户信息
		$this->mydb->get_del('user',$this->uid);
		$this->mydb->get_del('user_vod_buy',$this->uid,'uid');
		$this->mydb->get_del('user_task_list',$this->uid,'uid');
		$this->mydb->get_del('comment',$this->uid,'uid');
		$this->mydb->get_del('comment_report',$this->uid,'uid');
		$this->mydb->get_del('comment_zan',$this->uid,'uid');
		$this->mydb->get_del('feedback',$this->uid,'uid');
		$this->mydb->get_del('topic_fav',$this->uid,'uid');
		$this->mydb->get_del('fav',$this->uid,'uid');
		$this->mydb->get_del('down',$this->uid,'uid');
		$this->mydb->get_del('watch',$this->uid,'uid');
		$this->mydb->get_del('user_code',$rowt['id']);
		get_json('注销成功');
	}
}