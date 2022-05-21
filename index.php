<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
//默认时区
date_default_timezone_set("Asia/Shanghai");
header('Content-Type: text/html; charset=utf-8');
//判断是否安装
if(!defined('IS_INSTALL') && !file_exists('./caches/install.lock')){
	header("location:/install.php");
    exit;
}
define('ENVIRONMENT', isset($_SERVER['CI_ENV']) ? $_SERVER['CI_ENV'] : 'production');
switch (ENVIRONMENT){
	case 'development':
		error_reporting(-1);
		ini_set('display_errors', 1);
	break;
	case 'testing':
	case 'production':
		ini_set('display_errors', 0);
		if (version_compare(PHP_VERSION, '5.3', '>=')){
			error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT & ~E_USER_NOTICE & ~E_USER_DEPRECATED);
		}else{
			error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_USER_NOTICE);
		}
	break;
	default:
		header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
		echo 'The application environment is not set correctly.';
		exit(1);
}
$system_path = 'yhcms/system';
$application_folder = 'yhcms/apps';
$view_folder = 'template';
if(defined('STDIN')){
	chdir(dirname(__FILE__));
}
if(($_temp = realpath($system_path)) !== FALSE){
	$system_path = $_temp.DIRECTORY_SEPARATOR;
}else{
	$system_path = strtr(
		rtrim($system_path, '/\\'),
		'/\\',
		DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
	).DIRECTORY_SEPARATOR;
}
if(!is_dir($system_path)){
	header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
	echo 'Your system folder path does not appear to be set correctly. Please open the following file and correct this: '.pathinfo(__FILE__, PATHINFO_BASENAME);
	exit(3);
}
if (!defined('SELF')) define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME));
define('BASEPATH', $system_path);
if (!defined('FCPATH')) define('FCPATH', dirname(__FILE__).DIRECTORY_SEPARATOR);
define('SYSDIR', basename(BASEPATH));
if(is_dir($application_folder)){
	if (($_temp = realpath($application_folder)) !== FALSE){
		$application_folder = $_temp;
	}else{
		$application_folder = strtr(
			rtrim($application_folder, '/\\'),
			'/\\',
			DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
		);
	}
}elseif (is_dir(BASEPATH.$application_folder.DIRECTORY_SEPARATOR)){
	$application_folder = BASEPATH.strtr(
		trim($application_folder, '/\\'),
		'/\\',
		DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
	);
}else{
	header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
	echo 'Your application folder path does not appear to be set correctly. Please open the following file and correct this: '.SELF;
	exit(3);
}
define('APPPATH', $application_folder.DIRECTORY_SEPARATOR);
if(!isset($view_folder[0]) && is_dir(APPPATH.'views'.DIRECTORY_SEPARATOR)){
	$view_folder = APPPATH.'views';
}elseif (is_dir($view_folder)){
	if (($_temp = realpath($view_folder)) !== FALSE){
		$view_folder = $_temp;
	}else{
		$view_folder = strtr(
			rtrim($view_folder, '/\\'),
			'/\\',
			DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
		);
	}
}elseif (is_dir(APPPATH.$view_folder.DIRECTORY_SEPARATOR)){
	$view_folder = APPPATH.strtr(
		trim($view_folder, '/\\'),
		'/\\',
		DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
	);
}else{
	header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
	echo 'Your view folder path does not appear to be set correctly. Please open the following file and correct this: '.SELF;
	exit(3);
}
define('VIEWPATH', $view_folder.DIRECTORY_SEPARATOR);
require_once FCPATH.'yhcms/config/cms.php';
require_once BASEPATH.'core/CodeIgniter.php';