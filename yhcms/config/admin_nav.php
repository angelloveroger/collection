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
return array (
    array (
        'name'=>'系统配置',
        'icon'=>'&#xe653;',
        'file'=>'setting/,site/',
        'list' => 
        array (
            array('name'=>'基础配置','url'=>'setting/index','init' => 1),
            array('name'=>'基础修改','url'=>'setting/save','init' => 0),
            array('name'=>'网站配置','url'=>'setting/web','init' => 1),
            array('name'=>'网站修改','url'=>'setting/pc_save','init' => 0),
            array('name'=>'站群管理','url'=>'site/index','init' => 1),
            array('name'=>'站群修改','url'=>'site/edit,site/save,site/del','init' => 0),
            array('name'=>'模板管理','url'=>'tpl/index','init' => 1),
            array('name'=>'模板修改','url'=>'tpl/ads,tpl/init,tpl/edit,tpl/save,tpl/del','init' => 0),
            array('name'=>'APP配置','url'=>'setting/app','init' => 1),
            array('name'=>'APP修改','url'=>'setting/app_save','init' => 0),
            array('name'=>'存储配置','url'=>'setting/annex','init' => 1),
            array('name'=>'存储修改','url'=>'setting/annex_save','init' => 0),
            array('name'=>'财务配置','url'=>'setting/pay','init' => 1),
            array('name'=>'财务修改','url'=>'setting/pay_save','init' => 0),
            array('name'=>'缓存配置','url'=>'setting/caches','init' => 1),
            array('name'=>'缓存修改','url'=>'setting/caches_save','init' => 0),
            array('name'=>'公众号配置','url'=>'setting/mp','init' => 1),
            array('name'=>'公众号修改','url'=>'setting/mp_save','init' => 0),
            array('name'=>'文本配置','url'=>'setting/txt','init' => 1),
            array('name'=>'文本修改','url'=>'setting/txt_save','init' => 0),
        ),
    ),
    array (
        'name'=>'视频管理',
        'icon'=>'&#xe6ed;',
        'file'=>'vod/,lists/,topic/,player/,buy/',
        'list' => 
        array (
            array('name'=>'视频列表','url'=>'vod/index','init' => 1),
            array('name'=>'视频操作','url'=>'vod/edit,vod/save,vod/init,vod/del','init' => 0),
            array('name'=>'分类列表','url'=>'lists/index','init' => 1),
            array('name'=>'分类操作','url'=>'lists/edit,lists/save,lists/update,lists/del','init' => 0),
            array('name'=>'专题列表','url'=>'topic/index','init' => 1),
            array('name'=>'专题操作','url'=>'topic/edit,topic/save,topic/del','init' => 0),
            array('name'=>'播放器列表','url'=>'player/index','init' => 1),
            array('name'=>'播放器操作','url'=>'player/edit,player/save,player/del','init' => 0),
            array('name'=>'视频点播记录','url'=>'buy/index','init' => 1),
            array('name'=>'点播记录删除','url'=>'buy/del','init' => 0),
            array('name'=>'视频批量操作','url'=>'vod/batch','init' => 1),
            array('name'=>'批量操作视频','url'=>'vod/batch_save','init' => 0),
            array('name'=>'重复视频列表','url'=>'vod/repeat','init' => 1),
        ),
    ),
    array(
        'name'=>'社区管理',
        'icon'=>'&#xe756;',
        'file'=>'bbs/',
        'list'=>array(
            array('name'=>'社区配置','url'=>'bbs/setting','init' => 1),
            array('name'=>'配置保存','url'=>'bbs/setting_save','init' => 0),
            array('name'=>'帖子列表','url'=>'bbs/index','init' => 1),
            array('name'=>'帖子操作','url'=>'bbs/init,bbs/edit,bbs/save,bbs/del,bbs/audit','init' => 0),
            array('name'=>'帖子图片','url'=>'bbs/pic','init' => 1),
            array('name'=>'图片删除','url'=>'bbs/del','init' => 0),
            array('name'=>'帖子标签','url'=>'bbs/lists','init' => 1),
            array('name'=>'标签操作','url'=>'bbs/lists_edit,bbs/lists_save,bbs/lists_del','init' => 0),
        ),
    ),
    array(
        'name'=>'短视管理',
        'icon'=>'&#xe652;',
        'file'=>'myopia/',
        'list'=>array(
            array('name'=>'短视列表','url'=>'myopia/index','init' => 1),
            array('name'=>'短视操作','url'=>'myopia/init,myopia/edit,myopia/save,myopia/del','init' => 0),
            array('name'=>'短视分类','url'=>'myopia/lists','init' => 1),
            array('name'=>'分类操作','url'=>'myopia/lists_edit,myopia/lists_save,myopia/lists_del','init' => 0),
            array('name'=>'短视采集','url'=>'myopia/caiji','init' => 1),
        ),
    ),
    array (
        'name'=>'演员管理',
        'icon'=>'&#xe66c;',
        'file'=>'star/',
        'list' => 
        array (
            array('name'=>'演员列表','url'=>'star/index','init' => 1),
            array('name'=>'演员操作','url'=>'star/edit,star/save,star/init,star/del','init' => 0),
            array('name'=>'演员分类','url'=>'star/lists','init' => 1),
            array('name'=>'演员分类操作','url'=>'star/lists_edit,star/lists_save,star/lists_del','init' => 0),
        ),
    ),
    array (
        'name'=>'采集管理',
        'icon'=>'&#xe609;',
        'file'=>'caiji/',
        'list' => 
        array (
            array('name'=>'采集配置','url'=>'caiji/index','init' => 1),
            array('name'=>'采集配置保存','url'=>'caiji/setting','init' => 0),
            array('name'=>'资源库列表','url'=>'caiji/zyk','init' => 1),
            array('name'=>'资源库操作','url'=>'caiji/edit,caiji/save,caiji/del,caiji/init','init' => 0),
            array('name'=>'资源库采集','url'=>'caiji/show,caiji/ruku','init' => 0),
            array('name'=>'定时任务','url'=>'caiji/timing','init' => 1),
            array('name'=>'定时任务操作','url'=>'caiji/timing_edit,caiji/timing_save,caiji/timing_del,caiji/timing_show','init' => 0),
        ),
    ),
    array (
        'name'=>'财务管理',
        'icon'=>'&#xe65e;',
        'file'=>'pay/',
        'list' => 
        array (
            array('name'=>'充值订单','url'=>'pay/index','init' => 1),
            array('name'=>'充值订单删除','url'=>'pay/del','init' => 0),
            array('name'=>'金币记录','url'=>'pay/cion','init' => 1),
            array('name'=>'金币记录删除','url'=>'pay/cion_del','init' => 0),
            array('name'=>'卡密管理','url'=>'pay/card','init' => 1),
            array('name'=>'卡密操作','url'=>'pay/card_edit,pay/card_save,pay/card_del','init' => 0),
        ),
    ),
    array (
        'name'=>'用户管理',
        'icon'=>'&#xe770;',
        'file'=>'user/,task/,comment/',
        'list' => 
        array (
            array('name'=>'用户列表','url'=>'user/index','init' => 1),
            array('name'=>'用户操作','url'=>'user/edit,user/save,user/del','init' => 0),
            array('name'=>'任务列表','url'=>'task/index','init' => 1),
            array('name'=>'任务操作','url'=>'task/edit,task/save,task/del','init' => 0),
            array('name'=>'评论列表','url'=>'comment/index','init' => 1),
            array('name'=>'评论操作','url'=>'comment/init,comment/del','init' => 0),
            array('name'=>'消息列表','url'=>'message/index','init' => 1),
            array('name'=>'消息删除','url'=>'message/del','init' => 0),
        ),
    ),
    array (
        'name'=>'运营管理',
        'icon'=>'&#xe7ae;',
        'file'=>'advertising/,ads/,report/,feedback/,device/,barrage/',
        'list' => 
        array (
            array('name'=>'设备统计','url'=>'device/index','init' => 1),
            array('name'=>'网页广告变现','url'=>'advertising/index','init' => 1),
            array('name'=>'广告变现操作','url'=>'advertising/edit,ads/save,ads/del','init' => 0),
            array('name'=>'App广告变现','url'=>'ads/index','init' => 1),
            array('name'=>'App广告操作','url'=>'ads/edit,ads/save,ads/del','init' => 0),
            array('name'=>'举报列表','url'=>'report/index','init' => 1),
            array('name'=>'举报删除','url'=>'report/del','init' => 0),
            array('name'=>'反馈列表','url'=>'feedback/index','init' => 1),
            array('name'=>'反馈操作','url'=>'feedback/edit,feedback/save,feedback/del','init' => 0),
            array('name'=>'弹幕管理','url'=>'barrage/index','init' => 1),
            array('name'=>'弹幕删除','url'=>'barrage/del','init' => 0),
            array('name'=>'友情链接','url'=>'links/index','init' => 1),
            array('name'=>'友情链接操作','url'=>'links/edit,links/save,links/del','init' => 0),
        ),
    ),
    array (
        'name'=>'代理管理',
        'icon'=>'&#xe735;',
        'file'=>'agent/',
        'list' => 
        array (
            array('name'=>'代理列表','url'=>'agent/index','init' => 1),
            array('name'=>'代理操作','url'=>'agent/edit,agent/save,agent/del','init' => 0),
            array('name'=>'提现管理','url'=>'agent/withdrawal','init' => 1),
            array('name'=>'提现操作','url'=>'agent/withdrawal_show,agent/withdrawal_save,agent/withdrawal_del','init' => 0),
        ),
    ),
    array (
        'name'=>'管理员管理',
        'icon'=>'&#xe66f;',
        'file'=>'sys/',
        'list' => 
        array (
            array('name'=>'管理员列表','url'=>'sys/index','init' => 1),
            array('name'=>'管理员修改','url'=>'sys/edit,sys/save','init' => 0),
            array('name'=>'管理员删除','url'=>'sys/del','init' => 0),
        ),
    )
);