<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
define('IS_INSTALL', TRUE); // 安装标识
define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME)); // 文件名
define('FCPATH', str_replace("\\", "/", dirname(__FILE__).'/')); // 网站根目录
require('index.php'); // 引入主文件