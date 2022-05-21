<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('FCPATH')) exit('No direct script access allowed');
//错误提示
function error($text='抱歉，页面不存在!',$msg='错误提示'){
    echo '<!DOCTYPE html><html lang="en"><head><meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" /><meta charset="utf-8"><title>404 Page Not Found</title><style type="text/css">::selection{background-color:#f07746;color:#fff;}::-moz-selection{background-color:#f07746;color:#fff;}body{background-color:#fff;margin:40px auto;max-width:1024px;font:16px/24px normal "Helvetica Neue",Helvetica,Arial,sans-serif;color:#808080;}a{color:#dd4814;background-color:transparent;font-weight:normal;text-decoration:none;}a:hover{color:#97310e;}h1{color:#fff;background-color:#dd4814;border-bottom:1px solid #d0d0d0;font-size:22px;font-weight:bold;margin:0 0 14px 0;padding:5px 15px;line-height:40px;}#container{margin:10px;border:1px solid #d0d0d0;box-shadow:0 0 8px #d0d0d0;border-radius:4px;}p{margin:0 0 10px;padding:0;}#body{margin:0 15px 0 15px;min-height:96px;color:#333;}</style></head><body><div id="container"><h1>'.$msg.'</h1><div id="body"><p>'.$text.'</p><br><p style="font-size:12px;">您可以 <a href="javascript:history.back();">返回上一页</a> 或者 <a href="/">返回首页</a></p></div></div></body></html>';
	exit;
}
//删除空格
function trimall($str){
    $qian=array(" ","　","\t","\n","\r");
	$hou=array("","","","","");
    return str_replace($qian,$hou,$str);    
}
//判断email格式是否正确
function is_email($email) {
	return strlen($email) > 6 && preg_match("/^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/", $email);
}
//判断手机号码格式是否正确
function is_tel($tel) {
	return preg_match("/^1[3456789]\d{9}$/", $tel);
}
//获取IP
function getip(){ 
    $ip = false;
    if(!empty($_SERVER["HTTP_CLIENT_IP"])) $ip = $_SERVER["HTTP_CLIENT_IP"];
    if(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
        $ips = explode (", ", $_SERVER['HTTP_X_FORWARDED_FOR']);
        if ($ip){
            array_unshift($ips, $ip);
            $ip = FALSE;
        }
        for ($i = 0; $i < count($ips); $i++){
            if(!preg_match('%^127\.|10\.|192\.168|172\.(1[6-9]|2|3[01])%',$ips[$i])){
                $ip = $ips[$i];
                break;
            }
        }
    }
    $ip = ($ip ? $ip : $_SERVER['REMOTE_ADDR']);
    if(!preg_match("/^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$/", $ip)){
       	return '';
    }
	return $ip;
}
//获取任意字段
function getzd($table,$zd,$id,$cha='id',$order='id desc'){
	$ci = &get_instance();
	$str = "";
	if($table && $zd && $id){
		if(is_array($id)){
			foreach ($id as $k => $v) {
				$ci->db->where($k,$v);
			}
		}else{
			$ci->db->where($cha,$id);
		}
		$row = $ci->db->select($zd)->order_by($order)->get($table)->row_array();
		if($row) $str = $row[$zd];
		if($zd == 'pic' || $zd == 'picx') $str = getpic($str);
	}
	return $str;
}
//链接地址
function links($path='',$id='0',$page=1,$admin=0){
	$config = json_decode(_SYSJSON_,1);
	$site = json_decode(_SITE_,1);
	//判断路由
	$uri = $path;
	if(defined('SITEINDEX') && !empty($site[SITEINDEX]['uri'][$path])){
		$uri = $site[SITEINDEX]['uri'][$path];
	}elseif(!empty($config['web']['uri'][$path])){
		$uri = $config['web']['uri'][$path];
	}
    $url = '/'.SELF;
    if($admin == 1) $url = '/index.php';
	if(!empty($path)) $url.= '/'.$uri;
	//替换
	$a1 = array('[id]','[type]','[jid]','[page]');
	$a2 = array($id,$id,$page,$page);
	$url = str_replace($a1,$a2,$url);
	if($path == 'play' && strstr($url,'/'.$id.'/0')){
		$url = str_replace('/'.$id.'/0','/'.$id,$url);
	}
	if(($path == 'rss' || $path == 'hot') && strstr($url,'/0')){
		$url = str_replace('/0','',$url);
	}
	//伪静态去掉index.php
	if($config['web']['uri']['delindex'] == 1) $url = str_replace('index.php/','',$url);
	if(($admin == 1 || !defined('IS_ADMIN')) && !empty($config['web']['uri']['ext'])) $url .= $config['web']['uri']['ext'];
	return $url;
}
//SQL过滤
function safe_replace($string){
	if(is_array($string)) {
        foreach($string as $k => $v) {
			$string[$k] = safe_replace($v); 
		}
	}else{
		if(!is_numeric($string)){
	        $string = str_replace('%20','',$string);
	        $string = str_replace('%27','',$string);
	        $string = str_replace('%2527','',$string);
			$string = str_replace("'",'&#039;',$string);
	        $string = str_replace('"','&quot;',$string);
	        $string = str_replace('*','',$string);
	        $string = str_replace(';','',$string);
	        $string = str_replace('<','&lt;',$string);
	        $string = str_replace('>','&gt;',$string);
	        $string = str_replace('\\','',$string);
	        $string = str_replace('%','\%',$string);
		}
	}
	return $string;
}
//获取远程内容
function geturl($url,$post='',$header='',$ip=''){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    //curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
    curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_ENCODING, "gzip");
    if(!empty($header)){
    	curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
    }
    if(!empty($post) && $post != 'source'){
    	curl_setopt($ch, CURLOPT_POST, 1);
    	curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
    }
    if(!empty($ip)){
    	curl_setopt($ch, CURLOPT_PROXY, $ip);
    }
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);//获取跳转后的
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}
// 字符串截取函数
function str_substr($start, $end, $str){ 
    $temp = explode($start, $str, 2);      
    $content = explode($end, $temp[1], 2);      
    return $content[0];      
}
//屏蔽所有html
function str_checkhtml($str) {
	if(is_array($str)) {
		foreach($str as $k => $v) {
			$str[$k] = str_checkhtml($v); 
		}
	}else{
		$str = htmlspecialchars_decode($str);
		$str = strip_tags($str);
		//$str = preg_replace("/\s+/"," ", $str);
		//$str = str_replace(chr(13),"",$str);
		//$str = str_replace(chr(10),"",$str);
		//$str = str_replace(chr(9),"",$str);
		$str = preg_replace("/&nbsp;/","",$str);
		$str = str_replace("<","&lt;",$str);
		$str = str_replace(">","&gt;",$str);
		$str = str_replace("\"","&quot;",$str);
		$str = str_replace("'",'&#039;',$str);
		$str = str_replace('{','',$str);
		$str = str_replace('readx();','',$str);
		$str = current(explode('varosoafig=',$str));
	}
	return $str;
}
//编码转换
function strtoutf8($str){
    $encode = mb_detect_encoding($str, array("ASCII",'UTF-8',"GB2312","GBK",'BIG5'));
    if($encode == 'UTF-8'){
        return $str;
    }else{
        return mb_convert_encoding($str, 'UTF-8', $encode);
    }
}
//获取GET、POST
function get_post($key='',$sql=false){
	$ci = &get_instance();
	if(empty($key)){
		$var = $ci->input->post();
		if(empty($var)) $var = $ci->input->get();
	}else{
		$var = $ci->input->post($key);
		if(!$var) $var  = $ci->input->get($key);
		if($sql) $var = safe_replace($var);
	}
	return $var;
}
//JSON输出
function get_json($data,$code=1){
	$facility = get_post('facility');
	$arr = array();
	if(defined('IS_ADMIN')){
		if(is_array($data)){
			$arr = $data;
		}else{
			$arr['msg'] = $data;
		}
		if(!isset($arr['code'])) $arr['code'] = $code;
		if(!isset($arr['msg'])) $arr['msg'] = '获取成功';
	}else{
		if(!is_array($data)){
			$arr['code'] = $code;
			$arr['msg'] = $data;
		}else{
			if(!isset($data['data'])){
				$arr['data'] = $data;
				if(isset($arr['data']['msg'])) $arr['msg'] = $arr['data']['msg'];
				unset($arr['data']['msg']);
			}
			if(isset($arr['data']['code'])){
				$arr['code'] = $arr['data']['code'];
				unset($arr['data']['code']);
			}
			$arr['data'] = get_app_replace($arr['data']);
			if(!isset($arr['code'])) $arr['code'] = $code;
			if(!isset($arr['msg'])) $arr['msg'] = '获取成功';
			if(!empty($facility) && isset($arr['data'])){
		    	$config = json_decode(_SYSJSON_,1);
		    	$appkey = $config['app']['appkey'];
		    	$iv = substr($appkey,0,8);
		    	//加密
				$arr['data'] = base64_encode(openssl_encrypt(json_encode($arr['data']),'DES-CBC',$appkey,1,$iv));
			}
		}
	}
	//强制编码
	header("Access-Control-Allow-Origin: *");
	header('Content-Type:application/json;Charset=utf-8');
	$callback = get_post('callback');
    if(!empty($callback)){
		echo $callback.'('.json_encode($arr).');';
    }else{
		echo json_encode($arr);
    }
	exit;
}
//APP返回数据转换
function get_app_replace($arr){
	$harr = array('hits','rhits','zhits','yhits','dhits','shits','sohits','zan');
	foreach ($arr as $k => $v) {
		if(is_array($v)){
			$arr[$k] = get_app_replace($v);
		}elseif(!is_numeric($k)){
			if(is_numeric($v) && $v < 2147483647 && !strstr($v,'.')) $arr[$k] = (int)$v;
			if($k == 'addtime' && is_numeric($v)) $arr[$k] = date('Y-m-d H:i:s',$v);
			if($k == 'viptime' && is_numeric($v)) $arr[$k] = $v == 0 ? '未开通' : date('Y-m-d H:i:s',$v);
			if($k == 'pic' || $k == 'picx') $arr[$k] = getpic($v);
			if($k == 'picx' && empty($v) && isset($arr['pic'])) $arr[$k] = $arr['pic'];
			if($k == 'actor') $arr[$k] = str_replace('/',',',$v);
			if($k == 'tags') $arr[$k] = !empty($v) ? explode('/',$v) : array();
			if($k == 'score') $arr[$k] = strstr($v,'.') ? $v : $v.'.0';
			if($k == 'nickname') $arr[$k] = sub_str($v,8);
			if(in_array($k,$harr) && is_numeric($v)) $arr[$k] = get_wan($arr[$k]);
			if(($k == 'size' || $k == 'down_size') && is_numeric($v)) $arr[$k] = formatsize($arr[$k]);
		}
	}
	return $arr;
}
//Base64加密
function base64encode($string) {
    $data = base64_encode($string);
    $data = str_replace(array('+', '/', '='), array('-', '_', ''), $data);
    return $data;
}
//Base64解密
function base64decode($string) {
    $data = str_replace(array('-', '_'), array('+', '/'), $string);
    $mod4 = strlen($data) % 4;
    if ($mod4) {
        $data.= substr('====', $mod4);
    }
    return base64_decode($data);
}
//字符加密、解密
function sys_auth($string, $type = 0, $expiry = 0, $key='') {
	if(is_array($string)) $string = json_encode($string);
	if($type == 1) $string = str_replace('-','+',$string);
	$ckey_length = 4;
	if($key == '') $key = _SYSKEY_;
	$key = md5(_SYSKEY_);
	$keya = md5(substr($key, 0, 16));
	$keyb = md5(substr($key, 16, 16));
	$keyc = $ckey_length ? ($type == 1 ? substr($string, 0, $ckey_length): substr(md5(microtime()), -$ckey_length)) : '';
	$cryptkey = $keya.md5($keya.$keyc);
	$key_length = strlen($cryptkey);
	$string = $type == 1 ? base64_decode(substr($string, $ckey_length)) :  sprintf('%010d', $expiry ? $expiry + time() : 0).substr(md5($string.$keyb), 0, 16).$string;
	$string_length = strlen($string);
	$result = '';
	$box = range(0, 255);
	$rndkey = array();
	for($i = 0; $i <= 255; $i++) {
		$rndkey[$i] = ord($cryptkey[$i % $key_length]);
	}
	for($j = $i = 0; $i < 256; $i++) {
		$j = ($j + $box[$i] + $rndkey[$i]) % 256;
		$tmp = $box[$i];
		$box[$i] = $box[$j];
		$box[$j] = $tmp;
	}
	for($a = $j = $i = 0; $i < $string_length; $i++) {
		$a = ($a + 1) % 256;
		$j = ($j + $box[$a]) % 256;
		$tmp = $box[$a];
		$box[$a] = $box[$j];
		$box[$j] = $tmp;
		$result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
	} 
	if($type == 1) {
		if((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16)) {
			$result = substr($result, 26);
			$json = json_decode($result,1);
			if(!is_numeric($result) && $json){
				return $json;
			}else{
				return $result;
			}
		}
		return '';
	}
	return str_replace('+', '-', $keyc.str_replace('=', '', base64_encode($result)));
}
//截取字符串的函数
function sub_str($str, $length, $start=0, $suffix="...", $charset="utf-8"){
	$str = str_checkhtml($str);
	if(($length+2) >= strlen($str)) return $str;
	if(function_exists("mb_substr")){
		$xstr = mb_substr($str, $start, $length, $charset);
		if(strlen($str) != strlen($xstr)) $xstr .= $suffix;
		return $xstr;
	}elseif(function_exists('iconv_substr')){
		$xstr = iconv_substr($str,$start,$length,$charset);
		if(strlen($str) != strlen($xstr)) $xstr .= $suffix;
		return $xstr;
	}
	$re['utf-8']  = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
	$re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
	$re['gbk']    = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
	$re['big5']   = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
	preg_match_all($re[$charset], $str, $match);
	$slice = join("",array_slice($match[0], $start, $length));
	if(strlen($str) != strlen($slice)) $slice .= $suffix;
	return $slice;
}
//以万为单位格式化
function get_wan($hits = 0){
	$hits = round($hits,1);
    if($hits > 99999999){
    	return round($hits/100000000,1)." 亿";
    }elseif($hits > 999999){
    	return round($hits/10000)." 万";
    }elseif($hits > 9999){
    	return round($hits/10000,1)." 万";
    }elseif($hits > 999){
    	return round($hits);
    }else{
    	return number_format($hits);
    }
}
//字符隐藏
function get_sub($str,$z=3,$y=4,$x=4){
	if(empty($str)) return '';
	$xh = '';
	for($i=0;$i<$x;$i++) $xh.='*';
	return mb_substr($str,0,$z).$xh.mb_substr($str,-$y);
}
//图片转换
function getpic($pic='',$op=''){
	if(is_array($pic)){
		foreach ($pic as $k => $v) {
			$pic[$k] = getpic($v);
		}
	}
	//没有图片
	if(empty($pic)) $pic = 'http://'.$_SERVER['HTTP_HOST'].'/packs/images/'.($op == 'user' ? 'user' : 'empty').'.png';
	//判断存储方式
	if(!strstr($pic,'://') && substr($pic,0,2) != '//'){
		$config = json_decode(_SYSJSON_,1);
		if($config['annex']['type'] == 'oss'){
			$pic = $config['annex']['oss']['picurl'].$pic;
		}elseif($config['annex']['type'] == 'ftp'){
			$pic = $config['annex']['ftp']['picurl'].$pic;
		}else{
			$pic = $config['annex']['picurl'] != '' ? $config['annex']['picurl'].$pic : 'http://'.$config['url'].'/'.$pic;
		}
	}
	return $pic;
}
//写入或者删除COOKIE
function set_cookie($zd,$var='',$time=86400,$jm=1){
	if(empty($var)){
		setcookie($zd,'',time()-3600,'/');
	}else{
		if($jm == 1) $var = sys_auth($var);
		setcookie($zd,$var,time()+$time,'/');
	}
}
//读取COOKIE
function get_cookie($zd){
	if(!isset($_COOKIE[$zd])) return null;
	return sys_auth($_COOKIE[$zd],1);
}
//判断后台登陆
function get_admin_islog($link = 1){
	$aid = (int)get_cookie('admin_token');
	if($aid == 0) $aid = (int)sys_auth(get_post('admin_token'),1);
	if($aid > 0){
		$ci = &get_instance();
		$row = $ci->mydb->get_row('admin',array('id'=>$aid));
		if($row){
			//判断权限
			$uri = $ci->uri->uri_string();
			get_admin_qx($row['qx'],$uri,$link);
			return $row;
		}
	}
	set_cookie('admin_token');
	if($link == 1){
		exit("<script language='javascript'>top.location='".links('login')."';</script>");
	}else{
		return false;
	}
}
//判断后台路径访问权限
function get_admin_qx($qx,$uri,$link){
	$uri = preg_replace("/\/([0-9]+)/","",$uri);
	$uri = preg_replace("/\/([0-9]+)\/json/","",$uri);
	$uri = str_replace('admin/','',$uri);
	$uri = str_replace('/json','',$uri);
	if(empty($qx) || empty($uri)) return true;
	//不需要判断路径
	$arr = array('/','home','home/main','home/echat');
	if(in_array($uri,$arr) || substr($uri,0,5) == 'ajax/') return true;
	$arr = explode(',',$qx);
	$ok = 0;
	foreach ($arr as $v) {
		if($uri == $v){
			$ok = 1;
			break;
		}
	}
	if($ok == 0){
		if($link == 0 || strpos($_SERVER['HTTP_ACCEPT'],'application/json') !== false){
			get_json('您没有操作权限',0);
		}else{
			error('您没有权限访问该页面');
		}
	}
}
//判断代理登陆
function get_agent_islog($link = 1){
	$aid = (int)get_cookie('agent_token');
	if($aid == 0) $aid = (int)sys_auth(get_post('agent_token'),1);
	if($aid > 0){
		$ci = &get_instance();
		$row = $ci->mydb->get_row('agent',array('id'=>$aid));
		if($row) return $row;
	}
	set_cookie('agent_token');
	if($link == 1){
		exit("<script language='javascript'>top.location='".links('agent/login')."';</script>");
	}else{
		return false;
	}
}
//判断登录并返回用户信息
function get_web_islog($link = 0){
	$uid = (int)get_cookie('user_token');
	if($uid > 0){
		$ci = &get_instance();
		$row = $ci->mydb->get_row('user',array('id'=>$uid));
		if($row){
			$edit = array();
			if(date('Y-m-d',$row['logtime']) != date('Y-m-d')) $edit['duration'] = 0;
			//修改活跃时间
			if($row['logtime'] < (time()-1800)) $edit['logtime'] = time();
			if($row['vip'] > 0 && $row['viptime'] < time()){
				$edit['vip'] = 0;
				$row['vip'] = 0;
			}
			if(!empty($edit)) $ci->mydb->get_update('user',$edit,$uid);
			unset($row['pass']);
			return $row;
		}
	}
	set_cookie('user_token');
	if($link == 1){
		if(strpos($_SERVER['HTTP_ACCEPT'],'application/json') !== false){
			get_json('未登录',-1);
		}else{
			header("location:".links('user/login'));
			exit;
		}
	}else{
		return false;
	}
}
//判断登录并返回用户信息
function get_islog($field='*',$link = 0){
	$uid = (int)sys_auth(get_post('user_token'),1);
	if($uid > 0){
		$ci = &get_instance();
		$row = $ci->mydb->get_row('user',array('id'=>$uid));
		if($row){
			$edit = array();
			if(date('Y-m-d',$row['logtime']) != date('Y-m-d')) $edit['duration'] = 0;
			//修改活跃时间
			if($row['logtime'] < (time()-1800)) $edit['logtime'] = time();
			if($row['vip'] > 0 && $row['viptime'] < time()){
				$edit['vip'] = 0;
				$row['vip'] = 0;
			}
			if(!empty($edit)) $ci->mydb->get_update('user',$edit,$uid);
			if($field != '*'){
				$arr = explode(',',$field);
				foreach ($row as $k => $v) {
					if(!strstr($field,$k)) unset($row[$k]);
				}
			}
			unset($row['pass']);
			return $row;
		}
	}
	if($link == 1){
		get_json('未登录',-1);
	}else{
		return false;
	}
}
//递归创建文件夹
function mkdirss($dir) {
    if(!$dir) return FALSE;
    if(!is_dir($dir)) {
        mkdirss(dirname($dir));
        if(!file_exists($dir)){
            mkdir($dir, 0777);
        }
    }
    return true;
}
//上传图片
function get_uppic($dir,$name='file',$ext='jpg|png|jpeg|gif'){
	$myconfig = json_decode(_SYSJSON_,1);
	if($myconfig['annex']['type'] == 'sys'){
		$cof['upload_path'] = FCPATH.'annex/'.$dir.'/'.date('Y-m').'/'.date('d').'/';
	}else{
		$cof['upload_path'] = FCPATH.'annex/'.$dir.'/';
	}
	$ci = &get_instance();
	mkdirss($cof['upload_path']); //创建文件夹
	$cof['allowed_types'] = $ext;
	$cof['file_name'] = md5(date('YmdHis').rand(1111,9999)._SYSKEY_);
	$cof['file_ext_tolower'] = true;
	$cof['overwrite'] = true;
	$ci->load->library('upload');
	$ci->upload->initialize($cof);
	if(!$ci->upload->do_upload($name)){
		$msg = $ci->upload->display_errors();
		get_json($msg,0);
	}else{
		$arr = $ci->upload->data();
		if(checkPicHex($arr['full_path']) == 1){
			get_json('不支持的文件类型',0);
		}
		//判断同步
		if($myconfig['annex']['type'] != 'sys'){
			$file_path = get_tongbu($myconfig,$arr['full_path'],$ci);
			if(!$file_path){
				if($myconfig['annex']['type'] == 'oss'){
					get_json('同步到阿里云OSS失败',0);
				}else{
					get_json('同步到FTP失败',0);
				}
			}
			return $file_path;
		}else{
			return str_replace(str_replace("\\",'/',FCPATH),'/',$arr['full_path']);
		}
	}
}
//同步附件到OSS或者FTP
function get_tongbu($myconfig,$file_path,$ci){
	$dir = str_substr('/annex/','/',$file_path);
	if($myconfig['annex']['type'] == 'oss'){
		$ci->load->library('oss');
		$file_path = $ci->oss->upload($file_path,str_replace('/'.$dir.'/','/'.$dir.'/'.date('Y-m').'/'.date('d').'/',$file_path));
		if(!$file_path) return false;
	}elseif($myconfig['annex']['type'] == 'ftp'){
		$ci->load->library('ftp');
		$myconfig['annex']['ftp']['passive'] = $myconfig['annex']['ftp']['passive'] == 1 ? TRUE : FALSE;
		$ci->ftp->connect($myconfig['annex']['ftp']);
		$ftp_path = str_replace(FCPATH.'annex/'.$dir.'/',$dir.'/'.date('Y-m').'/'.date('d').'/',$file_path);
		//创建FTP目录
        $dir = '/'.dirname($ftp_path).'/';
        $dir = str_replace('//', '/',$dir);
        $darr = explode('/',$dir);
        $dir2 = '';
        foreach ($darr as $v) {
            if(!empty($v)) $dir2 .= '/'.$v;
            $res = $ci->ftp->changedir($dir2,true);
            if(!$res) $ci->ftp->mkdir($dir2);
        }
        $ci->ftp->changedir($dir,true);
        $ftp_file = end(explode('/',$ftp_path));
        $res = $ci->ftp->upload($file_path,'./'.$ftp_file);
        $ci->ftp->close();
        unlink($file_path);
        if(!$res) return false;
        $file_path = $ftp_path;
	}
	return str_replace(FCPATH,'/',$file_path);
}
//生成随机字符串
function rand_str($num=15,$addtime=1,$number=1){
	if($number == 1) {
		$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHJKLMNPQEST123456789';
	}else{
		$chars = 'abcdefghijklmnopqrstuvwxyz';
	}
	$len = strlen($chars);
	$randStr = '';
	for ($i = 0; $i < $num; $i++) {
		$randStr .= $chars[mt_rand(0, $len - 1)];
	}
	//是否加上当前时间
	if($addtime) $randStr .= time();
	return $randStr;
}
//删除图片、文件
function get_del_file($file=''){
	if(!empty($file)){
		if(strpos($file,'://') === false){
			unlink('.'.$file);
		}
	}
}
//时间格式转换
function datetime($TimeTime){
	$limit = time() < $TimeTime ? $TimeTime-time() : time()-$TimeTime;
	$txt = time() < $TimeTime ? '后' : '前';
	if ($limit <5) {$show_t = '刚刚';}
	if ($limit >= 5 and $limit <60) {$show_t = $limit.'秒'.$txt;}
	if ($limit >= 60 and $limit <3600) {$show_t = sprintf("%01.0f",$limit/60).'分钟'.$txt;}
	if ($limit >= 3600 and $limit <86400) {$show_t = sprintf("%01.0f",$limit/3600).'小时'.$txt;}
	if ($limit >= 86400 and $limit <2592000) {$show_t = sprintf("%01.0f",$limit/86400).'天'.$txt;}
	if ($limit >= 2592000 and $limit <31104000) {$show_t = sprintf("%01.0f",$limit/2592000).'个月'.$txt;}
	if ($limit >= 31104000) {$show_t = '1年以'.$txt;}
	return $show_t;
}
//大小转换
function formatsize($size, $dec=2){
	$a = array("B", "KB", "MB", "GB", "TB", "PB");
	$pos = 0;
	while ($size >= 1024) {
		$size /= 1024;
		$pos++;
	}
	return round($size,$dec)." ".$a[$pos];
}
//将秒数转换成时分秒
function get_time($seconds){
    if ($seconds > 3600) {
        $hours = intval($seconds / 3600);
        $time = $hours . ":" . gmstrftime('%M:%S', $seconds);
    } else {
        $time = gmstrftime('%H:%M:%S', $seconds);
    }
    return $time;
}
//解析多个分类ID  如 cid=1,2,3,4,5,6
function get_cid($fid,$table='class',$zd='fid'){
	$fid = (int)$fid;
	$ci = &get_instance();
	$cids = array();
	if($fid > 0){
		$result = $ci->db->where($zd,$fid)->select('id')->get($table)->result_array();
		foreach ($result as $row) {
			$cids[] = $row['id'];
		}
	}
	$cids[] = $fid;
	return implode(',',$cids);
}
//获取301分享地址
function get_share_url($uid=0,$did=0,$type=''){
	$uid = (int)$uid;
	$did = (int)$did;
	$config = json_decode(_SYSJSON_,1);
	$share_url = $config['ffurl'];
	if(empty($share_url)) $share_url = $config['url'];
	if(!strstr($share_url,'://')) $share_url =  'http://'.$share_url;
	if(substr($share_url,0,1) == '/') $share_url = substr($share_url,0,-1);
	if(empty($type) && $did > 0) $type = 'vod';
	$share_url .= !empty($type) ? links('share/'.$type) : links('share');
	$arr = array();
	if($uid > 0) $arr[] = 'uid='.$uid;
	if($did > 0) $arr[] = 'did='.$did;
	if(!empty($arr)) $share_url .= '?'.implode('&',$arr);
	return $share_url;
}
//获取分享地址
function get_ff_url($uid=0,$vid=0,$aid=0){
	$uid = (int)$uid;
	$vid = (int)$vid;
	$aid = (int)$aid;
	$config = json_decode(_SYSJSON_,1);
	$share_url = $config['url'];
	if(!empty($config['shareurl'])){
		$r = rand(0,count($config['shareurl'])-1);
		$share_url = $config['shareurl'][$r];
	}
	if(!strstr($share_url,'://')) $share_url =  'http://'.$share_url;
	$share_url = str_replace('*',rand_str(),$share_url);
	if(substr($share_url,0,1) == '/') $share_url = substr($share_url,0,-1);
	$share_url .= links('share');
	$arr = array();
	if($uid > 0) $arr[] = 'uid='.$uid;
	if($vid > 0) $arr[] = 'vid='.$vid;
	if($aid > 0) $arr[] = 'aid='.$aid;
	if(!empty($arr)) $share_url .= '?'.implode('&',$arr);
	return $share_url;
}
//播放地址转换
function get_player_url($arr,$type,$jxurl,$user,$app=0){
	foreach ($arr as $k => $v) {
		//判断需要解析否
		if($type == 'web' && !strstr($v['playurl'],'.mp4') && !strstr($v['playurl'],'.m3u8')){
			if($app == 0) $arr[$k]['playurl'] = $jxurl.urlencode($v['playurl']);
		}
		$arr[$k]['is_buy'] = 0;
		if($v['pay'] == 2){
			$buy = getzd('user_vod_buy','id',array('jid'=>$v['id'],'uid'=>$user['id']));
			if($buy) $arr[$k]['is_buy'] = 1;
		}
	}
	return $arr;
}
//获取终端名字
function get_facility($facility){
	$arr = array(
		'ios' => 'iOS',
		'android' => 'Android'
	);
	if(isset($arr[$facility])) return $arr[$facility];
	return '未知';
}
//写入新数组到文件
function arr_file_edit($arr,$file=''){
	if(empty($file)) return false;
	if(is_array($arr)){
	    $con = var_export($arr,true);
	} else{
	    $con = $arr;
	}
	$strs="<?php if (!defined('FCPATH')) exit('No direct script access allowed');".PHP_EOL;
	$strs.="return $con;";
	return file_put_contents($file, $strs);
}
//emoji表情处理
function emoji_replace($str,$type = 0){
	if($type == 1){
	    //转义表情
		preg_match_all('/emoji\[([^\s]+?)\]/',$str,$face);
        if(!empty($face[1])){
			for($j = 0;$j < count($face[1]);$j++){
				$str = str_replace($face[0][$j],base64_decode($face[1][$j]),$str);
           	}
		}
	}else{
	    $str = preg_replace_callback(
	        '/./u',
	        function (array $match) {
	            return strlen($match[0]) >= 4 ? 'emoji['.base64_encode($match[0]).']' : $match[0];
	        },
	    $str);	
	}
    return $str;
}
//seo替换
function get_seo($ac,$op,$arr=array()){
	$config = json_decode(_SYSJSON_,1);
	$site = json_decode(_SITE_,1);
	if(defined('SITEINDEX') && !empty($site[SITEINDEX]['seo'][$ac][$op])){
		$str = $site[SITEINDEX]['seo'][$ac][$op];
	}else{
		$str = $config['web']['seo'][$ac][$op];
	}
	foreach ($arr as $k => $v) {
		if($k == 'text') $v = sub_str($v,80);
		$str = str_replace('['.$k.']',$v,$str);
	}
	$str = str_replace('[webname]',$config['name'],$str);
	$str = str_replace('[weburl]',$config['url'],$str);
    return $str;
}
//手机PC域名相互替换
function get_replace_url(){
	if(defined('IS_WAP')){
		return '//'.WEBURL.'/'.uri_string();
	}else{
		$url = WEBWAPURL == '' ? WEBURL : WEBWAPURL;
		return '//'.$url.'/'.uri_string();
	}
}
//分类类型检索链接
function get_vod_url($retval=array()){
	$config = json_decode(_SYSJSON_,1);
	$ci = &get_instance();
    $uri = $ci->uri->uri_string();
    $yarr = array();
    if(strpos($uri,'vod') !== false){
	    $n = strpos($uri,'/index') !== false ? 3 : 2;
	    $yarr = $ci->uri->uri_to_assoc($n);
    }
    foreach ($retval as $key => $value) {
    	if(empty($value)){
    		unset($yarr[$key]);
    	}else{
    		$yarr[$key] = $value;
    	}
    }
    if(isset($yarr['page']) && $yarr['page'] != '{page}') unset($yarr['page']);
    //去除所有空值数组
    $uarr = array();
    foreach ($yarr as $key => $value) {
    	if(!empty($value)){
    		$uarr['['.$key.']'] = $value;
    	}
    }
    $link = '/index.php/vod/cid/[cid]/area/[area]/lang/[lang]/year/[year]/sort/[sort]/page/[page]';
    foreach ($uarr as $k => $v) {
    	$link = str_replace($k,$v,$link);
    }
    $link = str_replace('/cid/[cid]','',$link);
    $link = str_replace('/area/[area]','',$link);
    $link = str_replace('/lang/[lang]','',$link);
    $link = str_replace('/year/[year]','',$link);
    $link = str_replace('/sort/[sort]','',$link);
    $link = str_replace('/page/[page]','',$link);
	//伪静态去掉index.php
	if($config['web']['uri']['delindex'] == 1) $link = str_replace('index.php/','',$link);
	if(!empty($config['web']['uri']['ext'])) $link .= $config['web']['uri']['ext'];

	return $link;
}
//图片转base64
function imgToBase64($img_file) {
    $img_base64 = '';
    if(file_exists($img_file)) {
        $app_img_file = $img_file; // 图片路径
        $img_info = getimagesize($app_img_file); // 取得图片的大小，类型等
        $fp = fopen($app_img_file, "r"); // 图片是否可读权限
        if ($fp) {
            $filesize = filesize($app_img_file);
            $content = fread($fp, $filesize);
            $file_content = chunk_split(base64_encode($content)); // base64编码
            switch ($img_info[2]) {           //判读图片类型
                case 1: $img_type = "gif";
                    break;
                case 2: $img_type = "jpg";
                    break;
                case 3: $img_type = "png";
                    break;
            }
            $img_base64 = 'data:image/' . $img_type . ';base64,' . $file_content;//合成图片的base64编码
        }
        fclose($fp);
    	unlink($img_file);
    }
    return $img_base64;
}
//检查上传图片是否包含木马
function checkPicHex($file) {
    if(file_exists($file)) {
        $resource = fopen($file,'rb');
        $fileSize = filesize($file);
        fseek($resource, 0);//把文件指针移到文件的开头
        if($fileSize > 512){ // 若文件大于521B文件取头和尾
            $hexCode = bin2hex(fread($resource, 512));
            fseek($resource, $fileSize - 512);//把文件指针移到文件尾部
            $hexCode .= bin2hex(fread($resource,512));
        } else { // 取全部
            $hexCode = bin2hex(fread($resource, $fileSize));
        }
        fclose($resource);
        if(preg_match("/(3c25.*?28.*?29.*?253e)|(3c3f.*?28.*?29.*?3f3e)|(3C534352495054)|(2F5343524950543E)|(3C736372697074)|(2F7363726970743E)/is",$hexCode)){
        	//删除文件
        	unlink($file);
            return 1;
        }else{
            return 0;
        }
    } else {
        return -1;
    }
}
//HTML转JS  
function htmltojs($str){
	$re='';
	$str=str_replace('\\','\\\\',$str);
	$str=str_replace("'","\'",$str);
	$str=str_replace('"','\"',$str);
	$str=str_replace("\t",'',$str);
	$str=str_replace("\r",'',$str);
	$str= explode("\n",$str);
	for($i=0;$i<count($str);$i++){
		$re.="document.writeln(\"".$str[$i]."\");\r\n";
	}
	return $re;
}
//删除目录和文件
function deldir($dir,$sid='no') {
	//目录不存在
	if(!is_dir($dir)) return true;
	//先删除目录下的文件
	$ci = &get_instance();
	$ci->load->helper('file');
	$res = delete_files($dir, TRUE);
	//删除当前文件夹：
	if($sid=='ok'){
		if(!rmdir($dir)) return false;
	}
	return true;
}