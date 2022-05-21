<?php if (!defined('FCPATH')) exit('No direct script access allowed');
return array (
  'dir' => 'default',
  'name' => '英皇默认模板',
  'pic' => '',
  'ads' => 
  array (
    'comment' => 
    array (
      'name' => '全局广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '全站顶部漂浮',
          'init' => 1,
          'jspath' => 'top.js',
          'jshtml' => '',
        ),
        1 => 
        array (
          'name' => '全站底部漂浮',
          'init' => 1,
          'jspath' => 'bottom.js',
          'jshtml' => '',
        ),
      ),
    ),
    'index' => 
    array (
      'name' => '主页广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '主页头部',
          'init' => 1,
          'jspath' => 'index1.js',
          'jshtml' => NULL,
        ),
        1 => 
        array (
          'name' => '主页中间横幅',
          'init' => 1,
          'jspath' => 'index2.js',
          'jshtml' => '',
        ),
        2 => 
        array (
          'name' => '主页底部横幅',
          'init' => 1,
          'jspath' => 'index3.js',
          'jshtml' => '',
        ),
      ),
    ),
    'list' => 
    array (
      'name' => '分类页广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '分类页横幅1',
          'init' => 1,
          'jspath' => 'list1.js',
          'jshtml' => '',
        ),
        1 => 
        array (
          'name' => '分类页横幅2',
          'init' => 1,
          'jspath' => 'list2.js',
          'jshtml' => NULL,
        ),
        2 => 
        array (
          'name' => '分类页横幅3',
          'init' => 1,
          'jspath' => 'list3.js',
          'jshtml' => '',
        ),
      ),
    ),
    'vod' => 
    array (
      'name' => '筛选页广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '筛选页横幅1',
          'init' => 1,
          'jspath' => 'vod1.js',
          'jshtml' => '',
        ),
        1 => 
        array (
          'name' => '筛选页横幅2',
          'init' => 1,
          'jspath' => 'vod2.js',
          'jshtml' => '',
        ),
        2 => 
        array (
          'name' => '筛选页横幅3',
          'init' => 1,
          'jspath' => 'vod3.js',
          'jshtml' => '',
        ),
      ),
    ),
    'info' => 
    array (
      'name' => '详情页广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '详情页横幅',
          'init' => 1,
          'jspath' => 'info.js',
          'jshtml' => NULL,
        ),
      ),
    ),
    'play' => 
    array (
      'name' => '播放页广告',
      'list' => 
      array (
        0 => 
        array (
          'name' => '播放页横幅',
          'init' => 1,
          'jspath' => 'play.js',
          'jshtml' => NULL,
        ),
      ),
    ),
  ),
);