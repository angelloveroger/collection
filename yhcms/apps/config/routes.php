<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$route['default_controller'] = defined('IS_INSTALL')? 'install' : 'home';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
$route['user/edit/(.+)'] = 'user/edit/index/$1';
$route['rss/(.+)'] = 'rss/index/$1';
$route['vod/cid/(.+)'] = 'vod/index/cid/$1';
$route['opt/index/(.+)'] = 'opt/index/$1';
$route['opt/(.+)'] = 'opt/index/$1';

//加载自定义路由
$site = json_decode(_SITE_,1);
if(defined('SITEINDEX') && !empty($site[SITEINDEX]['route'])){
	$route = array_merge($route,$site[SITEINDEX]['route']);
}else{
	require FCPATH.'yhcms/config/uri.php';
}