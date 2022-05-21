<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
defined('BASEPATH') OR exit('No direct script access allowed');

class Ajax extends My_Controller {

	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
        //判断是否登陆
        get_admin_islog();
	}

    //趋势图统计
    public function echat(){
        $type = get_post('type',true);
        $day = (int)get_post('day');
        $date_type = get_post('date_type',true);
        $kstime = get_post('kstime',true);
        $jstime = get_post('jstime',true);
        $jtime = strtotime(date('Y-m-d 0:0:0'));
        if(!empty($kstime) && !empty($jstime)){
            if($date_type == 'month'){
                $date2 = explode('-', $kstime);
                $date1 = explode('-', $jstime);
                $day = abs($date1[0] - $date2[0]) * 12 + ($date1[1] - $date2[1]);
                $jstime = strtotime($jstime);
            }else{
                $kstime = strtotime($kstime);
                $jstime = strtotime($jstime);
                $day = (int)(($jstime - $kstime)/86400)-1;
            }
            $jtime = $jstime;
        }else{
            if($day == 0) $day = 7;
            $day--;
        }
        if($day > 31 && $date_type != 'month') get_json('日期区间不能超过31天',0);
        if($day > 15 && $date_type == 'month') get_json('日期区间不能超过12个月',0);
        $data = array();
        if($type == 'user_nums'){ //活跃用户
            for ($i=$day; $i >= 0; $i--) {
                if($date_type == 'month'){
                    $time = $i > 0 ? strtotime("-".$i." month",$jtime) : $jtime;
                    $ksmonth = date('Ym01',$time);
                    $jsmonth = date('Ymt',$time);
                    $data['week'][] = date('Y-m',$time);
                    $row = $this->mydb->get_row('user_nums',array('date>='=>$ksmonth,'date<='=>$jsmonth),'sum(ios_num) ios_num,sum(android_num) android_num');
                    $data['user']['ios'][] = $row ? (int)$row['ios_num'] : 0;
                    $data['user']['android'][] = $row ? (int)$row['android_num'] : 0;
                }else{
                    $data['week'][] = date('Y-m-d',$jtime-86400*$i);
                    //用户统计
                    $row = $this->mydb->get_row('user_nums',array('date'=>date('Ymd',$jtime-86400*$i)));
                    $data['user']['ios'][] = $row ? (int)$row['ios_num'] : 0;
                    $data['user']['android'][] = $row ? (int)$row['android_num'] : 0;
                }
            }
        }elseif($type == 'user_add'){ //新增用户
            for ($i=$day; $i >= 0; $i--) {
                if($date_type == 'month'){
                    $time = $i > 0 ? strtotime("-".$i." month",$jtime) : $jtime;
                    $ksmonth = date('Ym01',$time);
                    $jsmonth = date('Ymt',$time);
                    $data['week'][] = date('Y-m',$time);
                    $row = $this->mydb->get_row('user_nums',array('date>='=>$ksmonth,'date<='=>$jsmonth),'sum(ios_add) ios_add,sum(android_add) android_add');
                    $data['user']['ios'][] = $row ? (int)$row['ios_add'] : 0;
                    $data['user']['android'][] = $row ? (int)$row['android_add'] : 0;
                }else{
                    $data['week'][] = date('Y-m-d',$jtime-86400*$i);
                    //用户统计
                    $row = $this->mydb->get_row('user_nums',array('date'=>date('Ymd',$jtime-86400*$i)));
                    $data['user']['ios'][] = $row ? (int)$row['ios_add'] : 0;
                    $data['user']['android'][] = $row ? (int)$row['android_add'] : 0;
                }
            }
        }elseif($type == 'user_order'){ //充值统计
            for ($i=$day; $i >= 0; $i--) { 
                if($date_type == 'month'){
                    $time = $i > 0 ? strtotime("-".$i." month",$jtime) : $jtime;
                    $data['week'][] = date('Y-m',$time);
                    $kstime = strtotime(date('Y-m-01 0:0:0',$time))-1;
                    $jstime = strtotime(date('Y-m-t 23:59:59',$time))+1;
                    $data['pay']['count'][] = $this->mydb->get_nums('user_order',array('pid'=>1,'addtime>'=>$kstime,'addtime<'=>$jstime));
                    $rmb = $this->mydb->get_sum('user_order','rmb',array('pid'=>1,'addtime>'=>$kstime,'addtime<'=>$jstime));
                    if(!$rmb) $rmb = '0.00';
                    $data['pay']['rmb'][] = $rmb;
                }else{
                    $kstime = $jtime-86400*$i;
                    $data['week'][] = date('Y-m-d',$kstime);
                    $data['pay']['count'][] = $this->mydb->get_nums('user_order',array('pid'=>1,'addtime>'=>($kstime-1),'addtime<'=>($kstime+86402)));
                    $rmb = $this->mydb->get_sum('user_order','rmb',array('pid'=>1,'addtime>'=>($kstime-1),'addtime<'=>($kstime+86402)));
                    if(!$rmb) $rmb = '0.00';
                    $data['pay']['rmb'][] = $rmb;
                }
            }
        }elseif($type == 'user_facility'){ //终端分布
            $sql = 'select facility,count(id) count from '._DBPREFIX_.'user group by facility';
            $list = $this->mydb->get_sql($sql);
            $facility = array();
            foreach ($list as $k => $v) {
                $facility[$k]['name'] = get_facility($v['facility']);
                $facility[$k]['value'] = $v['count'];
            }
            $data['facility'] = $facility;
        }elseif($type == 'user_vip'){ //VIP分布
            $data['vip'] = array(
            	array('name'=>'VIP用户','value'=>$this->mydb->get_nums('user',array('vip'=>1))),
            	array('name'=>'普通用户','value'=>$this->mydb->get_nums('user',array('vip'=>0)))
            );
        }else{ //顶部统计
            $jtime--;
            //当日统计
            $row = $this->mydb->get_row('user_nums',array('date'=>date('Ymd')));
            //活跃统计
            $data['data']['active_num'] = (int)$this->mydb->get_sum('user_nums','android_num+ios_num');
            $data['data']['active_day'] = (int)$this->mydb->get_sum('user_nums','android_num+ios_num',array('date'=>date('Ymd')));
            //安卓
            $data['data']['android_num'] = $this->mydb->get_nums('user_android');
            $data['data']['android_day'] = (int)$row['android_num'];
            //IOS
            $data['data']['ios_num'] = $this->mydb->get_nums('user_ios');
            $data['data']['ios_day'] = (int)$row['ios_num'];
            //订单
            $data['data']['order_num'] = $this->mydb->get_nums('user_order',array('pid'=>1));
            $data['data']['order_day'] = $this->mydb->get_nums('user_order',array('pid'=>1,'addtime>'=>$jtime));
            //金额
            $data['data']['rmb_num'] = (float)$this->mydb->get_sum('user_order','rmb',array('pid'=>1));
            $data['data']['rmb_day'] = (float)$this->mydb->get_sum('user_order','rmb',array('pid'=>1,'addtime>'=>$jtime));
            //注册用户
            $data['data']['user_num'] = $this->mydb->get_nums('user');
            $data['data']['user_day'] = $this->mydb->get_nums('user',array('addtime>'=>$jtime));
        }
        get_json($data,1);
    }

    //上传图片
    public function uppic($dir=''){
        $darr = array('vod','topic','user','ads','bbs','myopia');
        if(!in_array($dir, $darr)) $dir = 'vod';
        $data['url'] = get_uppic($dir);
        $data['msg'] = '上传成功';
        if($dir == 'ads') $data['url'] = getpic($data['url']);
        get_json($data,1);
    }

    //获取豆瓣视频信息
    public function douban($type='search'){
        $id = (int)get_post('id');
        $name = get_post('name');
        if($type == 'info'){
            $url = 'https://movie.douban.com/subject/'.$id.'/';
            $header = array('User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36');
            $html = geturl($url,$header);
            $json = str_substr('<script type="application/ld+json">','</script>',$html);
            $arrs = json_decode($json,1);
            if(!empty($arrs['name'])){
                $data['name'] = current(explode(' ',$arrs['name']));
                $data['year'] = (int)$arrs['datePublished'];
                $data['pic'] = str_replace('https://','http://',$arrs['image']);
                $data['pic'] = str_replace('photo/s_ratio_poster','movie_poster_cover/lpst',$data['pic']);
                $data['area'] = str_replace(' / ',',',str_substr('<span class="pl">制片国家/地区:</span> ','<br/>',$html));
                $data['tags'] = implode(',',$arrs['genre']);
                $dy = array();
                for($i=0;$i<count($arrs['director']);$i++){
                    $director = current(explode(' ',$arrs['director'][$i]['name']));
                    if(!empty($director)) $dy[] = $director;
                }
                $data['director'] = implode(',',$dy);
                $zy = array();
                for($i=0;$i<count($arrs['actor']);$i++){
                    $actor = current(explode(' ',$arrs['actor'][$i]['name']));
                    if(!empty($actor)) $zy[] = $actor;
                }
                $data['actor'] = implode(',',$zy);
                $data['text'] = $arrs['description'];
                $jinum = (int)str_substr('<span class="pl">集数:</span> ','<br/>',$html);
                $data['state'] = $jinum == 0 ? 'HD' : '共'.$jinum.'集';
                $data['lang'] = str_replace(' / ',',',str_substr('<span class="pl">语言:</span> ','<br/>',$html));
                $d['code'] = 1;
                $d['msg'] = '获取成功';
                $d['data'] = $data;
            }else{
                $d['code'] = 0;
                $d['msg'] = '获取失败';
            }
            get_json($d);
        }else{
            $url = 'https://movie.douban.com/j/subject_suggest?q='.$name;
            $json = geturl($url);
            $arr = json_decode($json,1);
            if(count($arr) > 0){
                $option = '<option value="0">共获取到'.count($arr).'条,请选择</option>';
                for($i=0;$i<count($arr);$i++){
                    $option.='<option value="'.$arr[$i]['id'].'">'.$arr[$i]['title'].'</option>';
                }
                $data['code'] = 1;
                $data['msg'] = '共获取到 '.count($arr).' 条信息';
                $data['html'] = '<div class="select200" style="position: absolute;top: 0px;right: 0;"><select name="douban" lay-filter="douban">'.$option.'</select></div>';
            }else{
                $data['code'] = 0;
                $data['msg'] = '未获取到信息';
            }
            get_json($data);
        }
    }

    //缓存链接测试
    public function caches(){
        $id = (int)$this->input->post('id');
        $ip = $this->input->post('ip',true);
        $port = (int)$this->input->post('port');
        $pass = $this->input->post('pass',true);
        if(empty($ip) || $port==0) get_json('缺少参数',0);
        if($id == 2){
            if(!class_exists('Memcache')) get_json('发生错误，请检查是否开启相应扩展库!',0);
            //创建对象
            $conn = new Memcache;
            $res = $conn->pconnect($ip, $port);
            if(!$res) get_json('链接失败，请检查主机地址或者端口是否有误!',0);
        }else{
            if(!class_exists('Redis')) get_json('发生错误，请检查是否开启相应扩展库!',0);
            //创建对象
            $redis = new Redis();
            $res = $redis->connect($ip,$port);
            if(!$res) get_json('链接失败，请检查主机地址或者端口是否有误!',0);
        }
        get_json('链接成功...',1);
    }

    //清除缓存
    public function delcaches(){
        $res = $this->caches->clean();
        get_json('缓存更新完成...',1);
    }
}