<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');
$route['vod/opt/([a-zA-Z0-9\-\_]+)'] = 'vod/opt/$1';
$route['vod/opt'] = 'vod/opt';
$route['vod/hot/([a-zA-Z0-9\-\_]+)'] = 'vod/hot/$1';
$route['vod/hot'] = 'vod/hot';
$route['vod/cid/(\d+)/area/(.+)/year/([a-zA-Z0-9\-\_]+)/sort/([a-zA-Z0-9\-\_]+)'] = 'vod/index/cid/$1/area/$2/year/$3/sort/$4';
$route['topic/info/(\d+)'] = 'topic/info/$1';
$route['topic/(\d+)'] = 'topic/index/$1';
$route['star/lists/(\d+)/(\d+)'] = 'star/lists/$1/$2';
$route['star/lists/(\d+)'] = 'star/lists/$1';
$route['star/info/(\d+)'] = 'star/info/$1';
$route['star/hot'] = 'star/hot';
$route['star'] = 'star';
$route['rss/([a-zA-Z0-9\-\_]+)'] = 'rss/index/$1';
$route['rss'] = 'rss/index';
$route['play/(\d+)/(\d+)'] = 'play/index/$1/$2';
$route['play/(\d+)'] = 'play/index/$1';
$route['lists/(\d+)/(\d+)'] = 'lists/index/$1/$2';
$route['lists/(\d+)'] = 'lists/index/$1';
$route['info/(\d+)'] = 'info/index/$1';