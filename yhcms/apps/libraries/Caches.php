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

class Caches {

    function __construct (){
		log_message('debug', "Native Cache Class Initialized");
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->ci = &get_instance();
		$this->_id = false;
		$this->_time = $this->myconfig['caches']['time']['index'];
		if($this->myconfig['caches']['type'] == 3){
			$this->_adapter = 'redis';
		}elseif($this->myconfig['caches']['type'] == 2){
			$this->_adapter = 'memcached';
		}else{
			$this->_adapter = 'file';
		}
		$this->ci->load->driver('cache',array('adapter'=>$this->_adapter,'backup'=>'file','key_prefix'=>$this->myconfig['caches']['rand']));
	}

    //读取缓存
	function get($cacheid){
        if(defined('IS_WAP')) $cacheid.='_wap';
        if(defined('SITEINDEX')) $cacheid.='_'.SITEINDEX;
		$this->_id = md5($cacheid);
		return $this->ci->cache->get($this->_id);
	}

    //写入缓存
	function save($data){
		//写缓存
		return $this->ci->cache->save($this->_id, $data, $this->_time);
	}

    //获取缓存
	function start($id,$time=0){
		//关闭缓存
		if($this->myconfig['caches']['type'] == 0 || defined('IS_ADMIN')) return false;
		if($time > 0) $this->_time = $time;
		$data = $this->get($id);
		if($data !== false  && !empty($data)){
			exit($data);
			return true;
		}else{
			ob_start();
			ob_implicit_flush(true);
			return false;
		}
	}

	function end($data = ''){
		if($this->myconfig['caches']['type'] > 0 && !defined('IS_ADMIN')){
		    $data = ob_get_contents();
		    ob_end_flush();
			$this->save($data);
		}
	}

    //删除缓存
	function del($cacheid){
        if(defined('IS_WAP')) $cacheid.='_wap';
		$this->_id = md5($cacheid);
		return $this->ci->cache->delete($this->_id);
	}

    //清空整个缓存
	function clean(){
		return $this->ci->cache->clean();
	}
}