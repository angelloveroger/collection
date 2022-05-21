<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');
require_once FCPATH.'yhcms/config/ver.php';
$site = require_once FCPATH.'yhcms/config/site.php';
$sys = require_once FCPATH.'yhcms/config/config.php';
//手机客户端访问标示
if(preg_match("/(iPhone|iPad|iPod|Android|Linux)/i", strtoupper($_SERVER['HTTP_USER_AGENT']))){
    define('IS_WAP', true);
	if(strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false){
    	define('IS_WX', true);
    }
}
get_yhcms_site($site);
define('_SITE_', json_encode($site));
define('_SYSJSON_', json_encode($sys));
define('_SYSKEY_', $sys['sys_key']);
define('URLEXT', $sys['web']['uri']['ext']);
define('WEBWAPURL', $sys['wapurl']);
define('_REGCODE_', $sys['user']['reg_code']);
define('_DBPREFIX_', $sys['db']['dbprefix']);
define('_PL_', $sys['web']['comment']);
if(!defined('WEBNAME')) define('WEBNAME', $sys['name']);
if(!defined('WEBURL')) define('WEBURL', $sys['url']);
if(!defined('_STAT_')) define('_STAT_', $sys['web']['stat']);
//模板目录
if(!defined('_tpldir_')){
	if(defined('IS_WAP')){
		define('_tpldir_', '/template/wap/'.$sys['web']['wap_tpl'].'/');
		define('WEBTPL', $sys['web']['wap_tpl']);
	}else{
		define('_tpldir_', '/template/pc/'.$sys['web']['pc_tpl'].'/');
		define('WEBTPL', $sys['web']['pc_tpl']);
	}
}
//判断模板目录
function get_yhcms_site($site){
	foreach ($site as $k=>$v) {
		if($v['host'] == $_SERVER['HTTP_HOST']){
			define('SITEINDEX', $k);
			if(defined('IS_WAP')){
				if(!empty($v['wap_tpl'])){
					define('_tpldir_', '/template/wap/'.$v['wap_tpl'].'/');
					define('WEBTPL', $v['wap_tpl']);
				}
			}else{
				if(!empty($v['pc_tpl'])){
					define('_tpldir_', '/template/pc/'.$v['pc_tpl'].'/');
					define('WEBTPL', $v['pc_tpl']);
				}
			}
			define('WEBNAME', $v['name']);
			define('WEBURL', $v['host']);
			if(!empty($v['stat'])) define('_STAT_', $v['stat']);
			break;
		}
	}
}