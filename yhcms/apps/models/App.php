<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('BASEPATH')) exit('No direct script access allowed');
class App extends CI_Model{

    function __construct (){
		parent:: __construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

    //按断签名是否正确
    function is_sign(){
    	$post = get_post();
    	if(empty($post['facility']) || empty($post['deviceid']) || empty($post['version']) || empty($post['sign'])){
    		get_json('参数不完整',0);
    	}
	    if($post['facility'] != 'ios' && $post['facility'] != 'android'){
	    	get_json('参数facility值不正确',0);
	    }
	    //判断签名
	    $str = array();
	    $sign = $post['sign'];
	    unset($post['sign']);
	    ksort($post);
	    foreach ($post as $k => $v) {
	        if($v !== '') $str[] = $k.'='.$v;
	    }
	    $str = implode('&',$str).$this->myconfig['app']['appkey'];
	    $mysign = strtoupper(md5($str));
	    if($mysign != $sign) get_json('签名不正确',0);
	    $this->set_deviceid($post);
	    return true;
	}

	//记录设备ID
	function set_deviceid($post){
		$uid = !empty($post['user_token']) ? (int)sys_auth($post['user_token'],1) : 0;
		//当日日期
	    $date = date('Ymd');
	    //记录用户
	    $phone_table = 'user_'.$post['facility'];
	    //判断设备是否存在
	    $row1 = $this->mydb->get_row($phone_table,array('deviceid'=>$post['deviceid']));
	    $rh = $new = 0;
	    if(!$row1){
	        $this->mydb->get_insert($phone_table,array('deviceid'=>$post['deviceid'],'date'=>$date,'uid'=>$uid));
	        $rh = 1;
	    }else{
	        $edit = array();
	        //判断每日日活
	        if($row1['date'] != $date){
	            $edit['date'] = $date;
	            $rh = 1;
	        }
	        //判断UID是否录入
	        if($uid > 0 && $row1['uid'] == 0) $edit['uid'] = $uid;
	        if(!empty($edit)) $this->mydb->get_update($phone_table,$edit,$row1['id']);
	    }
	    //新增日活数量
	    $row2 = $this->mydb->get_row('user_nums',array('date'=>$date));
	    if(!$row2){
	        $this->mydb->get_insert('user_nums',array($post['facility'].'_num'=>1,$post['facility'].'_add'=>1,'date'=>$date));
	    }elseif($rh == 1){
	        $edit2[$post['facility'].'_num'] = $row2[$post['facility'].'_num']+1;
	    	if(!$row1) $edit2[$post['facility'].'_add'] = $row2[$post['facility'].'_add']+1;
	        $this->mydb->get_update('user_nums',$edit2,$row2['id']);
	    }
	}
}