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

	public function __construct(){
		parent::__construct();
        $this->myconfig = json_decode(_SYSJSON_,1);
        $this->uid = (int)get_cookie('user_token');
	}

    //二维码图片
    public function qrcode() {
        header("Content-Type:image/png");
        //手机APP下载二维码
        $str = sys_auth(get_post('str'),1);
        if(empty($str)){
            $uid = (int)get_cookie('user_token');
            $str = get_share_url($uid);
        }
        //生成二维码
        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
        //QRcode::png($str,NULL,'L',9,2);
        $qrcode_path = FCPATH.'caches/qrcode/0.png';
        QRcode::png($str,$qrcode_path,'L',9,2);
        //合并二维码
        $logo = imagecreatefrompng('./packs/images/logo_icon.png');
        $QR = imagecreatefrompng($qrcode_path);
        //重新组合图片并调整大小
        $QR_width = imagesx($QR);//二维码图片宽度 
        $QR_height = imagesy($QR);//二维码图片高度 
        $logo_width = imagesx($logo);//logo图片宽度 
        $logo_height = imagesy($logo);//logo图片高度 
        $logo_qr_width = $QR_width / 8; 
        $scale = $logo_width/$logo_qr_width; 
        $logo_qr_height = $logo_height/$scale; 
        $from_width = ($QR_width - $logo_qr_width) / 2; 
        //重新组合图片并调整大小 
        imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width, $logo_qr_height, $logo_width, $logo_height); 
        imagepng($QR);
        imagedestroy($QR);
    }

    //生成分享图片
    public function png($uid=''){
        $uid = (int)$uid;
        if($uid == '') exit('uid为空');
        $img = imagecreatefrompng('./caches/qrcode/share.png');
        $color = imagecolorallocate($img, 51, 51, 51);
        //字体路径
        $sizefile = FCPATH.'caches/qrcode/simhei.ttf';
        $txt = isset($this->myconfig['share_pngtxt']) ? $this->myconfig['share_pngtxt'] : '邀请你的好友一起来看电影吧';
        if(mb_strlen($txt) > 6){
            $text = sub_str($txt,6,0,'');
            $size = imagettfbbox(28,0,$sizefile,$text);
            imagettftext($img,28,0,ceil((633 - $size[2]) / 2),800,$color,$sizefile,$text);
            $text = sub_str($txt,9,6,'');
            $size = imagettfbbox(28,0,$sizefile,$text);
            imagettftext($img,28,0,ceil((633 - $size[2]) / 2),860,$color,$sizefile,$text);
        }else{
            $size = imagettfbbox(28,0,$sizefile,$txt);
            imagettftext($img,28,0,ceil((633 - $size[2]) / 2),850,$color,$sizefile,$txt);
        }
        //域名
        $text = '官网：'.$this->myconfig['url'];
        $size = imagettfbbox(18,0,$sizefile,$text);
        imagettftext($img,18,0,ceil((633 - $size[2]) / 2),700,$color,$sizefile,$text);
        //合并二维码
        $qr = $this->rcode($uid);
        $qr_width = imagesx($qr);//图片宽度
        $qr_height = imagesy($qr);//图片高度
        //重新组合图片并调整大小
        imagecopyresampled($img,$qr,200,375,0,0,255,255,$qr_width,$qr_height);
        unlink('./caches/qrcode/'.$uid.'.png');
        //输出
        Header("Content-type:image/png");
        imagepng($img);
    }

    //生成二维码加LOGO
    private function rcode($uid){
        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
        //生成二维码图片
        $share_url = get_share_url($uid);
        $qrcode_path = './caches/qrcode/'.$uid.'.png';
        QRcode::png($share_url,$qrcode_path,'L',9,1);
        //合并LOGO
        $QR = imagecreatefromstring(file_get_contents($qrcode_path));   
        $logo = imagecreatefrompng('./packs/images/logo_icon.png');  
        $QR_width = imagesx($QR);//二维码图片宽度   
        $QR_height = imagesy($QR);//二维码图片高度   
        $logo_width = imagesx($logo);//logo图片宽度   
        $logo_height = imagesy($logo);//logo图片高度   
        $logo_qr_width = $QR_width / 8; 
        $scale = $logo_width/$logo_qr_width; 
        $logo_qr_height = $logo_height/$scale; 
        $from_width = ($QR_width - $logo_qr_width) / 2; 
        //重新组合图片并调整大小
        imagecopyresampled($QR,$logo,$from_width,$from_width,0,0,$logo_qr_width,$logo_qr_height,$logo_width,$logo_height);
        return $QR;
    }

    //二维码登录
    public function qrlogin() {
        $ip = getip();
        $token = sys_auth(time());
        $row = $this->mydb->get_row('qrcode_log',array('ip'=>$ip));
        if($row){
            $this->mydb->get_update('qrcode_log',array('token'=>$token,'init'=>0),$row['id']);
            $id = $row['id'];
        }else{
            $id = $this->mydb->get_insert('qrcode_log',array('token'=>$token,'ip'=>$ip));
        }
        //手机APP登录二维码
        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
        $qrcode_path = FCPATH.'caches/qrcode/'.$id.'.png';
        $str = 'yhcmslog-'.sys_auth($id);
        QRcode::png($str,$qrcode_path,'L',9,2);
        //输出
        $data['qrcode'] = imgToBase64($qrcode_path);
        $data['qid'] = $id;
        $data['token'] = $token;
        get_json($data,1);
    }

    //二维码登录验证
    public function qrcode_init(){
        $id = (int)get_post('qid');
        $token = get_post('token');
        $time = sys_auth($token,1);
        if(!$time || $time < time()-180) get_json('二维码已失效',2);
        if($id > 0){
            $row = $this->mydb->get_row('qrcode_log',array('id'=>$id));
            if($row && $row['token'] == $token){
                if($row['uid'] > 0){
                    set_cookie('user_token',$row['uid']);
                    //删除扫码记录
                    $this->mydb->get_del('qrcode_log',$id);
                    get_json('登录成功',1);
                }elseif($row['init'] > 0){
                    get_json('已扫码',3);
                }else{
                    get_json('APP未扫码',0);
                }
            }else{
                get_json('二维码已失效',2);
            }
        }
        get_json('二维码已失效',2);
    }

    //用户信息
    public function user() {
        //判断是否登录
        $user = get_web_islog();
        if(!$user) get_json('请先登录',0);
        if(!empty($user['tel'])) $user['name'] = get_sub($user['tel']);
        $user['ulink'] = links('user');
        unset($user['pass'],$user['ypass'],$user['tel'],$user['token'],$user['deviceid']);
        get_json($user);
    }

    //注册
    public function reg(){
        $tel = get_post('tel',true);
        $pass = get_post('pass',true);
        $code = (int)get_post('tcode');
        if(!is_tel($tel)) get_json('手机号码格式错误',0);
        if(empty($pass)) get_json('请填写登录密码',0);
        //判断验证码是否正确
        if(_REGCODE_ == 1){
            if($code == 0) get_json('请填写手机验证码',0);
            $rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
            if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
            if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
            $this->mydb->get_del('user_code',$rowt['id']);
        }else{
            $this->load->library('pcode');
            $res = $this->pcode->check();
            if(!$res) get_json('图片文字验证失败',0);
        }
        //判断手机号码是否存在
        $row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
        if($row){
            if($row['pass'] != md5($pass)) get_json('手机号已注册',0);
            $uid = $row['id'];
        }else{
            $vip = $viptime = 0;
            if($this->myconfig['user']['reg_vip'] > 0){
                $vip = 1;
                $viptime = time()+$this->myconfig['user']['reg_vip']*86400;
            }
            $uid = $this->mydb->get_insert('user',array(
                'tel' => $tel,
                'nickname' => '网友_'.time(),
                'facility' => defined('IS_WAP') ? 'h5' : 'pc',
                'deviceid' => getip(),
                'pass' => md5($pass),
                'vip' => $vip,
                'viptime' => $viptime,
                'cion' => $this->myconfig['user']['reg_cion'],
                'logtime' => time(),
                'addtime' => time()
            ));
        }
        //输出
        set_cookie('user_token',$uid);
        get_json('注册成功',1);
    }

    //登录
    public function login(){
        $tel = get_post('tel',true);
        $pass = get_post('pass',true);
        if(!is_tel($tel)) get_json('手机号码格式错误',0);
        if(empty($pass)) get_json('登录密码不能为空',0);
        //判断手机号码是否存在
        $row = $this->mydb->get_row('user',array('tel'=>$tel),'id,pass');
        if(!$row || $row['pass'] != md5($pass)) get_json('手机或者密码不正确',0);
        //输出
        set_cookie('user_token',$row['id']);
        get_json('登录成功',1);
    }

    //验证码登录
    public function codelog(){
        $tel = get_post('tel');
        $code = (int)get_post('code');
        if(!is_tel($tel)) get_json('手机号码格式错误',0);
        if($code == 0) get_json('验证码不能为空',0);
        $share = 0;
        //判断验证码是否正确
        $rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
        if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
        if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
        //删除验证码
        $this->mydb->get_del('user_code',$rowt['id']);
        //判断手机号码是否存在
        $row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
        if($row){
            $uid = $row['id'];
        }else{
            $vip = $viptime = 0;
            if($this->myconfig['user']['reg_vip'] > 0){
                $vip = 1;
                $viptime = time()+$this->myconfig['user']['reg_vip']*86400;
            }
            $uid = $this->mydb->get_insert('user',array(
                'tel' => $tel,
                'nickname' => '网友_'.time(),
                'facility' => defined('IS_WAP') ? 'h5' : 'pc',
                'deviceid' => getip(),
                'pass' => md5(time()),
                'vip' => $vip,
                'viptime' => $viptime,
                'cion' => $this->myconfig['user']['reg_cion'],
                'logtime' => time(),
                'addtime' => time()
            ));
        }
        //输出
        set_cookie('user_token',$uid);
        get_json('登录成功',1);
    }

    //修改密码
    public function pass(){
        $tel = get_post('tel',true);
        $code = (int)get_post('code');
        $pass = get_post('pass',true);
        if(!is_tel($tel)) get_json('手机号码格式错误',0);
        if($code == 0) get_json('请填写手机验证码',0);
        if(empty($pass)) get_json('请填写新密码',0);
        //判断验证码是否正确
        $rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
        if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
        if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
        //判断手机号码是否存在
        $row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
        if(!$row) get_json('手机号未注册',0);
        //修改密码
        $this->mydb->get_update('user',array('pass'=>md5($pass)),$row['id']);
        $this->mydb->get_del('user_code',$rowt['id']);
        //输出
        get_json('密码修改成功',1);
    }

    //退出登录
    public function logout() {
        set_cookie('user_token');
        get_json('退出成功');
    }

    //生成图形验证码
    public function piccode() {
        $this->load->library('pcode');
        $this->pcode->entry();
    }

    //发送手机验证码
    public function telcode($type){
        $this->load->library('pcode');
        $res = $this->pcode->check();
        if(!$res) get_json('图片文字验证失败',0);
        $tel = get_post('tel',true);
        if($type == 'tel'){
            $user = get_web_islog();//判断登录
            if(!$user) get_json('请先登录',-1);
            $tel = $user['tel'];
        }else{
            if(!is_tel($tel)) get_json('请填写正确的手机号码',0);
            $row = $this->mydb->get_row('user',array('tel'=>$tel),'id');
            if($type == 'pass'){
                if(!$row)  get_json('手机号码未注册',0);
            }elseif($type == 'reg'){
                if($row)  get_json('手机号码已存在',0);
            }
        }
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

    //修改手机号码
    public function teledit() {
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $tel = get_post('tel',true);
        $code = (int)get_post('code');
        $tkey = get_post('tkey');
        if($code == 0) get_json('请填写手机验证码',0);
        if(empty($tel)){
            //判断验证码是否正确
            $rowt = $this->mydb->get_row('user_code',array('tel'=>$user['tel']));
            if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
            if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
            $data['tkey'] = sys_auth($user['tel']);
            get_json($data);
        }else{
            if(!is_tel($tel)) get_json('手机号码格式错误',0);
            if(empty($tkey)) get_json('非法请求',0);
            if(sys_auth($tkey,1) != $user['tel']) get_json('非法请求',0);
            //判断验证码是否正确
            $rowt = $this->mydb->get_row('user_code',array('tel'=>$tel));
            if(!$rowt || $rowt['code'] != $code) get_json('验证码错误',0);
            if($rowt['addtime']+300 < time()) get_json('验证码已过期',0);
            //修改
            $this->mydb->get_update('user',array('tel'=>$tel),$user['id']);
            $this->mydb->get_del('user_code',$rowt['id']);
            //输出
            get_json('修改成功',1);
        }
    }

    //修改密码
    public function passedit() {
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $pass = get_post('pass',true);
        $pass1 = get_post('pass1',true);
        $pass2 = get_post('pass2',true);
        if(empty($pass)) get_json('请填写原密码',0);
        if(empty($pass1)) get_json('请填写新密码',0);
        if($pass1 != $pass2) get_json('两次密码不一致',0);
        if(md5($pass) != $user['pass']) get_json('原密码不正确',0);
        //修改
        $this->mydb->get_update('user',array('pass'=>md5($pass1)),$user['id']);
        //输出
        get_json('修改成功',1); 
    }

    public function nicknameedit(){
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $nickname = get_post('nickname',true);
        if(empty($nickname)) get_json('请填写昵称',0);
        //修改
        $this->mydb->get_update('user',array('nickname'=>$nickname),$user['id']);
        //输出
        get_json('修改成功',1); 
    }

    public function sexedit(){
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $sex = (int)get_post('sex',true);
        if(empty($sex)) get_json('请选择性别',0);
        //修改
        $this->mydb->get_update('user',array('sex'=>$sex),$user['id']);
        //输出
        get_json('修改成功',1); 
    }

    //获取VIP列表
    public function viplist(){
        //判断是否登录
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $data['nickname'] = $user['nickname'];
        $data['rmbtocion'] = $this->myconfig['pay']['rmbtocion'];
        $data['list'] = $this->myconfig['pay']['vip'];
        $data['cionlist'] = $this->myconfig['pay']['cion'];
        $data['alipay'] = $this->myconfig['pay']['alipay']['open'];
        $data['wxpay'] = $this->myconfig['pay']['wxpay']['open'];
        get_json($data);
    }

    //支付订单
    public function pay(){
        //判断是否登录
        $user = get_web_islog();
        if(!$user) get_json('请先登录',-1);
        $type = get_post('type'); //vip,cion,card
        $day = (int)get_post('day');
        $rmb = (int)get_post('cion');
        $paytype = get_post('paytype');
        $card = get_post('card',true);
        //卡密充值
        if($type == 'card'){
            if(empty($card)) get_json('请填写点卡卡密',0);
            $row = $this->mydb->get_row('user_card',array('pass'=>$card));
            if(!$row || $row['uid'] > 0) get_json('卡密不存在',0);
            if($row['endtime'] > 0 && $row['endtime'] < time()) get_json('卡密已到期',0);
            if($row['type'] == 1){ //vip
                $viptime = $user['viptime'] > time() ? $user['viptime']+$row['nums']*86400 : time()+$row['nums']*86400;
                $this->mydb->get_update('user',array('vip'=>1,'viptime'=>$viptime),$user['id']);
            }else{
                $this->mydb->get_update('user',array('cion'=>$user['cion']+$row['nums']),$user['id']);
            }
            $this->mydb->get_update('user_card',array('uid'=>$user['id'],'paytime'=>time()),$row['id']);
            //代理分成
            if($row['aid'] > 0){
                $rowa = $this->mydb->get_row('agent',array('id'=>$row['aid']));
                if($rowa){
                    $rmb = round($row['rmb']*($rowa['cfee']/100));
                    $this->mydb->get_update('agent',array('rmb'=>$rowa['rmb']+$rmb),$rowa['id']);
                }
            }
            get_json('卡密兑换成功',1);
        }
        if($paytype != 'wxpay') $paytype = 'alipay';
        $ptitle = array('alipay'=>'支付宝','wxpay'=>'微信');
        if($this->myconfig['pay'][$paytype]['open'] == 0) get_json($ptitle[$paytype].'支付暂时关闭，请用其他方式付款',0);

        //获取金额
        if($type == 'cion'){ //金币
            if($rmb == 0) get_json('请选择套餐',0);
            if($rmb > 10000) get_json('金币数量不能超过1W',0);
            //获取金额
            $cion = $rmb*$this->myconfig['pay']['rmbtocion'];
            $cions = $this->myconfig['pay']['cion'];
            foreach ($cions as $k => $v) {
                if($rmb == $v['rmb']){
                    $cion = $v['cion'];
                    break;
                }
            }
        }else{
            if($day == 0) get_json('请选择套餐',0);
            $rmb = 0;
            $vips = $this->myconfig['pay']['vip'];
            foreach ($vips as $k => $v) {
                if($day == $v['day']){
                    $rmb = $v['rmb'];
                    break;
                }
            }
            if($rmb == 0) get_json('套餐不存在',0);
        }
        /*
        //记录订单
        $pid = $this->mydb->get_insert('user_order',array(
            'aid' => $user['aid'],
            'uid' => $user['id'],
            'dd' => date('YmdHis').rand(1111,9999),
            'rmb' => $rmb,
            'day' => $type == 'vip' ? $day : 0,
            'cion' => $type == 'vip' ? 0 : $cion,
            'paytype' => $paytype,
            'facility' => defined('IS_WAP') ? 'wap' : 'pc',
            'addtime' => time()
        ));
        if(!$pid) get_json('记录订单失败',0);
        //输出
        if($this->myconfig['payurl'] == ''){
            $payurl = 'http://'.$_SERVER['HTTP_HOST'].links('h5pay/index/'.$pid);
        }else{
            $payurl = 'http://'.$this->myconfig['payurl'].links('h5pay/index/'.$pid);
        }
        */
        $paytoken = sys_auth(array(
            'aid' => $user['aid'],
            'uid' => $user['id'],
            'dd' => date('YmdHis').rand(1111,9999),
            'rmb' => $rmb,
            'day' => $type == 'vip' ? $day : 0,
            'cion' => $type == 'vip' ? 0 : $cion,
            'paytype' => $paytype,
            'facility' => defined('IS_WAP') ? 'wap' : 'pc',
            'addtime' => time()
        ));
        if($this->myconfig['payurl'] == ''){
            $payurl = 'http://'.$_SERVER['HTTP_HOST'].links('h5pay/qrcode/');
        }else{
            $payurl = 'http://'.$this->myconfig['payurl'].links('h5pay/qrcode/');
        }
        $payurl .= '?paytoken='.urlencode($paytoken);
        //生成二维码
        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
        $qrcode_path = FCPATH.'caches/qrcode/0.png';
        QRcode::png($payurl,$qrcode_path,'L',9,2);
        $data['img'] = imgToBase64($qrcode_path);
        get_json($data);
    }

    //观看记录
    public function my_watch(){
        //判断是否登录
        $user = get_web_islog();
        if(!$user){
            $list = array();
            if(!empty($_COOKIE['read'])){
                $arr = explode('|',$_COOKIE['read']);
                $i = 0;
                foreach ($arr as $k => $v) {
                    $jid = (int)$v;
                    if($jid > 0){
                        $row = $this->mydb->get_row('vod_ji',array('id'=>$jid),'id,name,zid,vid');
                        if($row){
                            //数据
                            $rowb = $this->mydb->get_row('vod',array('id'=>$row['vid']),'name,pic,state');
                            $list[$i]['name'] = $rowb['name'];
                            $list[$i]['pic'] = $rowb['pic'];
                            $list[$i]['url'] = links('info',$row['vid']);
                            $list[$i]['news_chapter_name'] =$rowb['state'];
                            $list[$i]['read_chapter_id'] = $row['zid'];
                            $list[$i]['read_url'] = links('play',$row['vid'],$row['id']);
                            $list[$i]['read_chapter_name'] = $row['name'];
                            $i++;
                        }
                    }
                }
            }
        }else{
            //列表
            $list = $this->mydb->get_select('watch',array('uid'=>$user['id']),'vid,jid','addtime DESC',10);
            foreach($list as $k=>$row){
                //数据
                $rowb = $this->mydb->get_row('vod',array('id'=>$row['vid']),'name,pic,state');
                $list[$k]['name'] = $rowb['name'];
                $list[$k]['pic'] = $rowb['pic'];
                $list[$k]['url'] = links('info',$row['vid']);
                $list[$k]['news_chapter_name'] =$rowb['state'];
                $list[$k]['read_chapter_id'] = $row['zid'];
                $list[$k]['read_url'] = links('play',$row['vid'],$row['jid']);
                $list[$k]['read_chapter_name'] = getzd('vod_ji','name',$row['jid']);
            }
        }
        $data['list'] = $list;
        get_json($data,1);
    }

    //收藏记录
    public function my_fav(){
        //判断是否登录
        $user = get_web_islog();
        if(!$user) get_json('请先登录',0);
        //列表
        $list = $this->mydb->get_select('fav',array('uid'=>$user['id']),'vid','id DESC',10);
        foreach($list as $k=>$row){
            //数据
            $rowb = $this->mydb->get_row('vod',array('id'=>$row['vid']),'name,pic,state');
            $list[$k]['name'] = $rowb['name'];
            $list[$k]['pic'] = $rowb['pic'];
            $list[$k]['url'] = links('info',$row['vid']);
            $list[$k]['news_chapter_name'] = $rowb['state'];
            //阅读记录
            $row2 = $this->mydb->get_row('watch',array('vid'=>$row['vid'],'uid'=>$user['id']),'jid');
            if($row2){
                $list[$k]['read_chapter_id'] = $row2['jid'];
                $list[$k]['read_url'] = links('play',$row['vid'],$row2['jid']);
                $list[$k]['read_chapter_name'] = getzd('vod_ji','name',$row2['jid']);
            }else{
                $list[$k]['read_chapter_id'] = 0;
                $list[$k]['read_url'] = links('play',$row['vid']);
                $list[$k]['read_chapter_name'] = '未观看';
            }
        }
        $data['list'] = $list;
        get_json($data,1);
    }

    //收藏
    public function fav() {
        get_web_islog(1);
        $did = (int)get_post('vid');
        $type = get_post('type',true);
        if($did == 0) get_json('数据ID为空',0);
        if($type != 'topic') $type = 'vod';
        //判断数据是否存在
        $vzd = 'id';
        if($type == 'vod') $vzd.=',shits';
        $rowv = $this->mydb->get_row($type,array('id'=>$did),$vzd);
        if(!$rowv) get_json('数据不存在',0);
        //判断是否收藏
        $table = $type != 'topic' ? 'fav' : 'topic_fav';
        $zd = $type != 'topic' ? 'vid' : 'tid';
        $row = $this->mydb->get_row($table,array($zd=>$did,'uid'=>$this->uid),'id');
        if($row){
            $this->mydb->get_del($table,$row['id']);
            if($type == 'vod') $this->mydb->get_update('vod',array('shits'=>$rowv['shits']-1),$did);
            get_json('已取消收藏');
        }else{
            //记录收藏
            $this->mydb->get_insert($table,array(
                $zd => $did,
                'uid' =>$this->uid,
                'addtime' => time()
            ));
            if($type == 'vod') $this->mydb->get_update('vod',array('shits'=>$rowv['shits']+1),$did);
            get_json('收藏成功');
        }
    }

    //更多评论
    public function comment() {
        $vid = (int)get_post('vid');
        $size = (int)get_post('size');
        $page = (int)get_post('page');
        if($size == 0) $size = 15;
        if($page == 0) $page = 1;
        if($vid == 0) get_json('视频ID错误',0);

        //查询条件
        $where = array('vid'=>$vid,'yid'=>0,'fid'=>0);
        //总数量
        $nums = $this->mydb->get_nums('comment',$where);
        //总页数
        $pagejs = ceil($nums / $size);
        if($page > $pagejs) get_json('没有更多了',2);
        $limit = array($size,$size*($page-1));
        $list = $this->mydb->get_select('comment',$where,'id,uid,text,zan,addtime','id DESC',$limit);
        $list = $this->data_replace($list);
        $html = '';
        foreach ($list as $k => $v) {
            $del = $v['is_del'] ? '<span data-id="'.$v['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
            $html .= '<li>'.$del.'<div class="pic"><img src="'.getpic($v['upic']).'"></div><div class="info"><div class="nickname">'.$v['nickname'].'<span>'.datetime($v['addtime']).'</span></div><div class="text">'.$v['text'].'</div><div class="cmd" data-zan="'.($v['is_zan']?1:0).'" data-id="'.$v['id'].'" data-nickname="'.$v['nickname'].'"><span class="zan"><img src="'._tpldir_.'images/'.($v['is_zan']?'zan_on':'zan').'.png"><font>'.$v['zan'].'</font></span><span class="reply one"><img src="'._tpldir_.'images/reply.png">回复</span></div><div class="box"><textarea data-fid="'.$v['id'].'" data-vid="'.$vid.'" data-nickname="'.$v['nickname'].'" name="text" placeholder="回复：'.$v['nickname'].'"></textarea><div class="num"><span>0</span>/200</div><div class="btn">发布</div></div>';
            $reply_num = $this->mydb->get_nums('comment',array('fid'=>$v['id'],'yid'=>0));
            if($reply_num > 0){
                $html .= '<ul class="reply-list" id="reply-list-'.$v['id'].'">';
                $reply = $this->data_replace($this->mydb->get_select('comment',array('fid'=>$v['id'],'yid'=>0),'id,uid,text,zan,addtime','id desc',3));
                foreach($reply as $row2){
                    $del2 = $row2['is_del'] ? '<span data-id="'.$row2['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
                    $html .= '<li>'.$del2.'<div class="pic"><img src="'.getpic($row2['upic']).'"></div><div class="info"><div class="nickname">'.$row2['nickname'].'<span>'.datetime($row2['addtime']).'</span></div><div class="text">'.$row2['text'].'</div><div class="cmd" data-zan="'.($row2['is_zan']?1:0).'" data-id="'.$row2['id'].'" data-nickname=""><span class="zan"><img src="'._tpldir_.'images/'.($row2['is_zan']?'zan_on':'zan').'.png"><font>'.$row2['zan'].'</font></span><span class="reply"><img src="'._tpldir_.'images/reply.png">回复</span></div></li>';
                }
                $html .= '</ul>';
                if($reply_num > 3) $html .= '<div data-id="'.$v['id'].'" class="reply-more">查看全部'.$reply_num.'条回复<i class="layui-icon layui-icon-down"></i></div>';
            }
            $html .= '</div></li>';
        }
        //记录数组
        $data['html'] = $html;
        get_json($data);
    }

    //更多回复
    public function comment_reply(){
        $fid = (int)get_post('fid');
        $size = (int)get_post('size');
        if($size > 100) $size = 100;
        $limit = $size == 0 ? array(100,3) : $size;
        $list = $this->mydb->get_select('comment',array('fid'=>$fid),'id,uid,text,zan,addtime','id DESC',$limit);
        $list = $this->data_replace($list);
        $html = '';
        foreach ($list as $k => $row2) {
            $del2 = $row2['is_del'] ? '<span data-id="'.$row2['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
            $html .= '<li>'.$del2.'<div class="pic"><img src="'.getpic($row2['upic']).'"></div><div class="info"><div class="nickname">'.$row2['nickname'].'<span>'.datetime($row2['addtime']).'</span></div><div class="text">'.$row2['text'].'</div><div class="cmd" data-zan="'.($row2['is_zan']?1:0).'" data-id="'.$row2['id'].'" data-nickname=""><span class="zan"><img src="'._tpldir_.'images/'.($row2['is_zan']?'zan_on':'zan').'.png"><font>'.$row2['zan'].'</font></span><span class="reply"><img src="'._tpldir_.'images/reply.png">回复</span></div></li>';
        }
        //记录数组
        $data['html'] = $html;
        get_json($data);
    }

    //新增评论
    public function comment_add() {
        if(_PL_ == 0) get_json('评论已关闭',0);
        get_web_islog(1);
        $vid = (int)get_post('vid');
        $fid = (int)get_post('fid');
        $text = get_post('text',true);
        if($vid == 0) get_json('视频ID不能为空',0);
        if(empty($text)) get_json('评论内容不能为空',0);
        if(strlen($text) > 200) get_json('评论内容最多只能200字',0);
        //控制每人每天发表数量
        if($this->myconfig['comment']['day_num'] > 0){
            $jtime = strtotime(date('Y-m-d 0:0:0'))-1;
            $pcount = $this->mydb->get_nums('comment',array('uid'=>$this->uid,'addtime>'=>$jtime));
            if($pcount >= $this->myconfig['comment']['day_num'])  get_json('当日评论数量已上限',0);
        }
        //判断评论间隔时长
        $row = $this->mydb->get_row('comment',array('uid'=>$this->uid),'addtime','addtime desc');
        if($row && $row['addtime']+30 > time()) get_json('休息一下吧',0);
        //入库
        $this->mydb->get_insert('comment',array(
            'uid' => $this->uid,
            'vid' => $vid,
            'text' => emoji_replace($text),
            'fid' => $fid,
            'yid' => $this->myconfig['comment']['audit'],
            'addtime' => time()
        ));
        get_json('评论成功',1);
    }

    //评论点赞
    public function comment_zan() {
        if(_PL_ == 0) get_json('评论已关闭',0);
        get_web_islog(1);
        $id = (int)get_post('id');
        if($id == 0) get_json('ID不能为空',0);
        $row1 = $this->mydb->get_row('comment',array('id'=>$id));
        if(!$row1) get_json('评论不存在',0);
        $row = $this->mydb->get_row('comment_zan',array('did'=>$id,'uid'=>$this->uid));
        if($row){
            $this->mydb->get_del('comment_zan',$row['id']);
            //减去点赞次数
            if($row1['zan'] > 0) $this->mydb->get_update('comment',array('zan'=>$row1['zan']-1),$id);
            get_json('取消点赞成功',1);
        }else{
            $this->mydb->get_insert('comment_zan',array('did'=>$id,'uid'=>$this->uid));
            //增加点赞次数
            $this->mydb->get_update('comment',array('zan'=>$row1['zan']+1),$id);
            get_json('点赞成功',1);
        }
    }

    //删除评论
    public function comment_del() {
        if(_PL_ == 0) get_json('评论已关闭',0);
        get_web_islog(1);
        $id = (int)get_post('id');
        if($id == 0) get_json('ID不能为空',0);
        $row = $this->mydb->get_row('comment',array('id'=>$id),'uid');
        if(!$row || $row['uid'] !=$this->uid) get_json('评论不存在',0);
        $this->mydb->get_del('comment',$id);
        get_json('删除成功',1);
    }

    //获取播放集数地址
    public function vodurl(){
        $jid = (int)get_post('jid');
        $row = $this->mydb->get_row('vod_ji',array('id'=>$jid));
        if(!$row) get_json('视频集数不存在',0);
        $rowz = $this->mydb->get_row('player',array('id'=>$row['pid']));
        if(empty($rowz['jxurl'])) $rowz['jxurl'] = $this->myconfig['jxurl'];
        //判断需要解析否
        if($rowz['type'] == 'web'){
            $row['playurl'] = $rowz['jxurl'].urlencode($row['playurl']).'&token='.$this->myconfig['jxtoken'];
        }
        $data = $row;
        $data['type'] = $rowz['type'];
        //按断收费视频
        $data['pay'] = array('time'=>0,'nums'=>0,'cion'=>$row['cion'],'msg'=>'','btntxt'=>'');
        $init = 0;
        $user = get_web_islog();
        if($row['pay'] > 0){
            if($user){
                if($row['pay'] == 1 && $user['vip'] == 0){
                    $init = 2;
                    $data['pay']['msg'] = '试看已结束，成为VIP后可观看完整视频哟~';
                    $data['pay']['btntxt'] = '立即升级';
                }
                if($row['pay'] == 2){
                    $buy = getzd('user_vod_buy','id',array('jid'=>$row['id'],'uid'=>$user['id']));
                    if(!$buy){
                        $init = 3;
                        $data['pay']['msg'] = '收费视频，继续观看需要扣除 '.$row['cion'].' 金币';
                        $data['pay']['btntxt'] = '购买观看';
                        if($user['cion'] < $row['cion']){
                            $init = 4;
                            $data['pay']['btntxt'] = '金币不足，去充值';
                        }
                    }
                }
            }else{
                $init = 1;
                $data['pay']['msg'] = '收费视频，请登录后观看';
                $data['pay']['btntxt'] = '立即登录';
            }
        }
        $data['pay']['init'] = $init;
        //收费
        if($init > 0){
            //试看判断
            $data['pay']['time'] = 0;
            $data['pay']['nums'] = 0;
            if($this->myconfig['proved']['init'] == 1){
                $data['pay']['time'] = $this->myconfig['proved']['time'];
            }elseif($this->myconfig['proved']['init'] == 2){
                $watch = get_cookie('watch');
                if(!empty($watch)){
                    $arr = explode(',',$watch);
                    if(count($arr) <= $this->myconfig['proved']['nums']){
                        if(!in_array($jid,$arr)) $arr[] = $jid;
                        $data['pay']['nums'] = $this->myconfig['proved']['nums'] - count($arr);
                        set_cookie('watch',implode(',',$arr));
                    }else{
                        $data['pay']['nums'] = -1;
                    }
                }else{
                    $data['pay']['nums'] = $this->myconfig['proved']['nums'];
                    set_cookie('watch',$jid);
                }
            }else{
                $data['pay']['nums'] = -1;
            }
        }
        //判断网页端不给播放
        if($this->db->field_exists('app','vod') && getzd('vod','app',$row['vid']) == 1){
            $data['pay']['init'] = 5;
            $data['pay']['msg'] = '网页端不支持观看，请下载APP观看';
            $data['pay']['btntxt'] = '立即下载APP';
        }
        //播放前广告
        $data['ads'] = array();
        $data['uvip'] = $user ? $user['vip'] : -1;
        if(!$user || $user['vip'] == 0){
            $ads = $this->myconfig['ads']['info']['player'];
            if(!empty($ads)){
                $r = rand(0,count($ads)-1);
                $data['ads'] = $this->myconfig['ads']['info']['player'][$r];
            }
        }
        //增加人气
        $rowv = $this->mydb->get_row('vod',array('id'=>$row['vid']),'hits,rhits,zhits,yhits');
        $this->mydb->get_update('vod',array('hits'=>$rowv['hits']+1,'rhits'=>$rowv['rhits']+1,'zhits'=>$rowv['zhits']+1,'yhits'=>$rowv['yhits']+1),$row['vid']);
        //下一集地址
        $rowx = $this->mydb->get_row('vod_ji',array('zid'=>$row['zid'],'xid>'=>$row['xid']),'id','xid asc');
        $data['nexturl'] = $rowx ? '//'.$_SERVER['HTTP_HOST'].links('play',$row['vid'],$rowx['id']) : '';
        $data['vname'] = getzd('vod','name',$row['vid']);
        get_json($data);
    }

    //购买点播视频
    public function buy(){
        $user = get_web_islog();
        if(!$user) get_json('未登录',0);
        $id = (int)get_post('jid');
        if($id == 0) get_json('集数ID为空',0);
        $row = $this->mydb->get_row('vod_ji',array('id'=>$id));
        if(!$row) get_json('集数不存在',0);
        //判断是否购买
        $rowp = $this->mydb->get_row('user_vod_buy',array('jid'=>$id,'uid'=>$user['id']));
        if($rowp) get_json('已购买');
        //判断金币数量
        if($user['cion'] < $row['cion']) get_json('金币不足',0);
        //扣除金币
        $this->mydb->get_update('user',array('cion'=>$user['cion']-$row['cion']),$this->uid);
        //写入购买记录
        $this->mydb->get_insert('user_vod_buy',array(
            'vid' => $row['vid'],
            'zid' => $row['zid'],
            'jid' => $row['id'],
            'uid' => $user['id'],
            'cion' => $row['cion'],
            'addtime' => time()
        ));
        //写入兑换记录
        $this->mydb->get_insert('user_cion_list',array(
            'cid' => 2,
            'uid' => $user['id'],
            'cion' => $row['cion'],
            'text' => '购买视频《'.getzd('vod','name',$row['vid']).'》-'.$row['name'],
            'addtime' => time()
        ));
        get_json('购买成功');
    }

    //增加观看记录
    public function watch() {
        $user = get_web_islog();
        if(!$user) get_json('未登录',0);
        $jid = (int)get_post('jid');
        $duration = (int)get_post('time');
        $row = $this->mydb->get_row('vod_ji',array('id'=>$jid));
        if(!$row) get_json('视频集数不存在',0);
        $row2 = $this->mydb->get_row('watch',array('vid'=>$row['vid'],'uid'=>$this->uid),'id,duration');
        if(!$row2){
            $this->mydb->get_insert('watch',array(
                'cid' => getzd('vod','cid',$row['vid']),
                'vid' => $row['vid'],
                'zid' => $row['zid'],
                'jid' => $jid,
                'duration' => $duration,
                'uid' => $this->uid,
                'addtime' => time()
            ));
        }else{
            $this->mydb->get_update('watch',array(
                'zid' => $row['zid'],
                'jid' => $jid,
                'duration' => $duration,
                'addtime' => time()
            ),$row2['id']);
            $duration = $duration > $row2['duration'] ? $duration-$row2['duration'] : $duration;
        }
        //记录用户当日观看时长
        $this->mydb->get_update('user',array('duration'=>$user['duration']+$duration),$this->uid);
        get_json('记录成功',0);
    }

    //删除观看记录
    public function delwatch(){
        $user = get_web_islog();
        if(!$user) get_json('登录超时',-1);
        $vid = get_post('ids',true);
        if(empty($vid)) get_json('视频ID为空',0);
        $vid = explode(',', $vid);
        foreach ($vid as $_vid){
            $this->mydb->get_del('watch',array('vid'=>(int)$_vid,'uid'=>$user['id']));
        }
        get_json('删除成功');
    }

    //删除收藏
    public function delfav(){
        $user = get_web_islog();
        if(!$user) get_json('登录超时',-1);
        $did = get_post('ids',true);
        $type = get_post('type',true);
        if(empty($did)) get_json('数据ID为空',0);
        //数据表
        $table = $type != 'topic' ? 'fav' : 'topic_fav';
        $zd = $type != 'topic' ? 'vid' : 'tid';
        $did = explode(',', $did);
        foreach ($did as $_did){
            $this->mydb->get_del($table,array($zd=>(int)$_did,'uid'=>$user['id']));
        }
        get_json('删除成功');
    }

    //上传头像
    public function uppic(){
        $user = get_web_islog();
        if(!$user) get_json('登录超时',-1);
        $data['url'] = get_uppic('user');
        $data['msg'] = '上传成功';
        //删除原图片
        get_del_file($user['pic']);
        //保存新图片
        $this->mydb->get_update('user',array('pic'=>$data['url']),$user['id']);
        $data['url'] = getpic($data['url']);
        get_json($data,1);
    }

    //自定义获取视频
    public function vod(){
        $hot = (int)get_post('hot');
        $cid = (int)get_post('cid'); //分类ID
        $tid = (int)get_post('tid'); //是否推荐，1是
        $year = (int)get_post('year'); //年份
        $area = safe_replace(get_post('area')); //地区
        $lang = safe_replace(get_post('lang')); //语言
        $key = safe_replace(get_post('key',true)); //搜索关键词
        $zm = get_post('zm',true); //字母
        $sort = get_post('sort',true); //排序方式
        $size = (int)get_post('size'); //每页数量
        $page = (int)get_post('page'); //当前页数
        if($size == 0 || $size > 100) $size = 48;
        if($page == 0) $page = 1;
        $sarr = array('addtime','hits','yhits','zhits','rhits','dhits','shits','score');
        if(!in_array($sort, $sarr)) $sort = 'addtime';
        $zmarr = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

        $wh = array();
        if($cid > 0){
            $cids = get_cid($cid);
            $wh[] = is_numeric($cids) ? 'cid='.$cids : 'cid in('.$cids.')';
        }
        if($tid > 0) $wh[] = 'tid=1';
        if($year > 0) $wh[] = 'year='.$year;
        if(!empty($lang)) $wh[] = "lang='".$lang."'";
        if(!empty($area)) $wh[] = "area='".$area."'";
        if(!empty($key)) $wh[] = "(name like '%".$key."%' or actor like '%".$key."%' or director like '%".$key."%')";
        if(!empty($zm)){
            $zimu_arr1 = array(-20319,-20283,-19775,-19218,-18710,-18526,-18239,-17922,-1,-17417,-16474,-16212,-15640,-15165,-14922,-14914,-14630,-14149,-14090,-13318,-1,-1,-12838,-12556,-11847,-11055);
            $zimu_arr2 = array(-20284,-19776,-19219,-18711  ,-18527,-18240,-17923,-17418,-1,-16475,-16213,-15641,-15166,-14923,-14915,-14631,-14150,-14091,-13319,-12839,-1,-1,-12557,-11848,-11056,-2050);
            if(!in_array(strtoupper($zm),$zmarr)){
                 $wh[] = "substring(name,1,1) NOT REGEXP '^[a-zA-Z]' and substring(name,1,1) REGEXP '^[u4e00-u9fa5]'";
            }else{
                 $index = array_keys($zmarr,strtoupper($zm))[0];
                 $wh[] = "(((ord(substring(convert(name USING gbk),1,1))-65536>=".($zimu_arr1[$index])." and  ord( substring(convert(name USING gbk),1,1))-65536<=".($zimu_arr2[$index]).")) or UPPER(substring(convert(name USING gbk),1,1))='".$zimu_arr[$index]."')";
            }
        }
        //组装SQL
        $sql = 'SELECT id,name,pic,actor,year,state,score,hits,`text`,pay FROM '._DBPREFIX_.'vod';
        if(!empty($wh)) $sql .= ' WHERE '.implode(' and ', $wh);
        //总数量
        $nums = $this->mydb->get_sql_nums($sql);
        //总页数
        $pagejs = ceil($nums / $size);
        if($pagejs == 0) $pagejs = 1;
        //偏移量
        $limit = $size*($page-1).','.$size;
        $sql .= ' ORDER BY '.$sort.' DESC LIMIT '.$limit;
        $vod = $this->mydb->get_sql($sql);
        $uid = (int)get_cookie('user_token');
        foreach ($vod as $k => $v) {
            if($hot == 1){
                $is_fav = $uid > 0 ? $this->mydb->get_row('fav',array('vid'=>$row['id'],'uid'=>$uid),'id') : false;
                $vod[$k]['fav'] = $is_fav ? 1 : 0;
            }
            $vod[$k]['hits'] = get_wan($v['hits']);
            $vod[$k]['text'] = sub_str($v['text'],50);
            $vod[$k]['pic'] = getpic($v['pic']);
            $vod[$k]['info_url'] = links('info',$v['id']);
            $vod[$k]['play_url'] = links('play',$v['id']);
        }
        //输出
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
        $data['list'] = $vod;
        get_json($data);
    }

    //自定义获取明星
    public function star(){
        $cid = (int)get_post('cid'); //分类ID
        $tid = (int)get_post('tid'); //是否推荐，1是
        $sort = get_post('sort',true); //排序方式
        $size = (int)get_post('size'); //每页数量
        $page = (int)get_post('page'); //当前页数
        if($size == 0 || $size > 100) $size = 48;
        if($page == 0) $page = 1;
        $sarr = array('addtime','hits');
        if(!in_array($sort, $sarr)) $sort = 'addtime';

        $wh = array();
        if($cid > 0) $wh[] = 'cid='.$cid;
        if($tid > 0) $wh[] = 'tid=1';
        //组装SQL
        $sql = 'SELECT id,name,pic FROM '._DBPREFIX_.'star';
        if(!empty($wh)) $sql .= ' WHERE '.implode(' and ', $wh);
        //总数量
        $nums = $this->mydb->get_sql_nums($sql);
        //总页数
        $pagejs = ceil($nums / $size);
        if($pagejs == 0) $pagejs = 1;
        //偏移量
        $limit = $size*($page-1).','.$size;
        $sql .= ' ORDER BY '.$sort.' DESC LIMIT '.$limit;
        $star = $this->mydb->get_sql($sql);
        foreach ($star as $k => $v) {
            $star[$k]['pic'] = getpic($v['pic']);
            $star[$k]['url'] = links('starinfo',$v['id']);
        }
        //输出
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
        $data['list'] = $star;
        get_json($data);
    }

    //求片
    public function forum($type = 'search'){
        $id = (int)get_post('id');
        $name = get_post('name');
        if($type == 'info'){
            $url = 'https://movie.douban.com/subject/'.$id.'/';
            $header = array('User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36');
            $html = geturl($url,$header);
            $json = trim(str_substr('<script type="application/ld+json">','</script>',$html));
            $json = str_replace(array("\r","\n"),"",$json);
            $arrs = json_decode($json,1);
            if(!empty($arrs['name'])){
                $data['name'] = current(explode(' ',$arrs['name']));
                $data['year'] = (int)$arrs['datePublished'];
                $data['pic'] = str_replace('https://','http://',$arrs['image']);
                $data['pic'] = str_replace('photo/s_ratio_poster','movie_poster_cover/lpst',$data['pic']);
                $data['area'] = str_replace(' / ',',',str_substr('<span class="pl">制片国家/地区:</span> ','<br/>',$html));
                $dy = array();
                for($i=0;$i<count($arrs['director']);$i++){
                    $director = current(explode(' ',$arrs['director'][$i]['name']));
                    if(!empty($director)) $dy[] = $director;
                }
                $data['director'] = implode(',',$dy);
                $zy = array();
                for($i=0;$i<count($arrs['actor']);$i++){
                    $actor = current(explode(' ',$arrs['actor'][$i]['name']));
                    if(!empty($actor)) $zy[] = $actor;
                }
                $data['actor'] = implode(',',$zy);
                $data['text'] = $arrs['description'];
                $data['lang'] = str_replace(' / ',',',str_substr('<span class="pl">语言:</span> ','<br/>',$html));
                $res = geturl('http:'.base64decode(APIURL).'forum',array('token'=>_SYSKEY_,'data'=>sys_auth($data)));
                $d['code'] = 1;
                $d['msg'] = '求片成功';
            }else{
                $d['code'] = 0;
                $d['msg'] = '获取失败';
            }
            get_json($d);
        }else{
            $url = 'https://movie.douban.com/j/subject_suggest?q='.$name;
            $json = geturl($url);
            $arr = json_decode($json,1);
            if(count($arr) > 0){
                $option = '<option value="0">共获取到 '.count($arr).' 部影片，请选择</option>';
                for($i=0;$i<count($arr);$i++){
                    $option.='<option value="'.$arr[$i]['id'].'">'.$arr[$i]['title'].'</option>';
                }
                $data['code'] = 1;
                $data['html'] = '<div style="background:#fff;padding:20px;"><select style="height: 35px;width:100%;" name="douban" id="douban">'.$option.'</select></div>';
            }else{
                $data['code'] = 0;
                $data['msg'] = '未获取到相关影片信息';
            }
            get_json($data);
        }
    }

    //写入弹幕
    public function barrage_send(){
        $user = get_web_islog();
        if(!$user) get_json('登录超时',-1);
        $yhuid = get_post('yhuid',true);
        $vid = (int)get_post('vid');
        $zid = (int)get_post('zid');
        $jid = (int)get_post('jid');
        $xid = (int)get_post('xid');
        $duration = (int)get_post('duration');
        $text = get_post('text',true);
        $color = get_post('color',true);
        if($vid == 0 || $zid == 0 || $jid == 0 || empty($yhuid)) get_json('参数不完整',0);
        if(empty($text))  get_json('弹幕内容为空',0);
        if(empty($color)) $color = '#ffffff';
        //判断灌水
        $row = $this->mydb->get_row('vod_barrage',array('uid'=>$this->uid),'addtime','addtime desc');
        if($row && $row['addtime']+10 > time()) get_json('请勿灌水',0);
        $res = geturl('http://api.barrage.yhcms.cc:2121/?type=send&color='.urlencode($color).'&content='.urlencode($text).'&uid='.$yhuid);
        if($res == 'offline') get_json('不在线',0);
        if($res == 'fail') get_json('发送失败',0);
        //入库
        $this->mydb->get_insert('vod_barrage',array(
            'uid' => $this->uid,
            'vid' => $vid,
            'zid' => $zid,
            'jid' => $jid,
            'color' => $color,
            'text' => emoji_replace($text),
            'duration' => $duration,
            'addtime' => time()
        ));
        $name = getzd('vod','name',$vid);
        geturl('http:'.base64decode(APIURL).'barrage/index/send',array('name'=>$name,'color'=>$color,'jid'=>$xid,'time'=>$duration,'text'=>emoji_replace($text)));
        get_json('发送成功',1);
    }

    //数据替换
    private function data_replace($arr) {
        foreach ($arr as $k => $v) {
            $arr[$k]['text'] = emoji_replace($v['text'],1);
            $arr[$k]['addtime'] = datetime($v['addtime']);
            $row = $this->mydb->get_row('user',array('id'=>$v['uid']),'nickname,pic');
            $arr[$k]['nickname'] = $row ? $row['nickname'] : '佚名';
            $arr[$k]['upic'] = $row ? getpic($row['pic'],'user') : getpic('','user');
            //检测是否赞过
            $arr[$k]['is_zan'] = 0;
            //判断删除权限
            $arr[$k]['is_del'] = 0;
            if($this->uid > 0){
                if($this->uid == $v['uid']) $arr[$k]['is_del'] = 1;
                $rowz = $this->mydb->get_row('comment_zan',array('did'=>$v['id'],'uid'=>$this->uid),'id');
                if($rowz) $arr[$k]['is_zan'] = 1;
            }
        }
        return $arr;
    }
}