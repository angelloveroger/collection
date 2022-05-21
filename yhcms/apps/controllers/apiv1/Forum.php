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

class Forum extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//获取豆瓣视频
	public function search() {
		$key = get_post('key',true);
		if(empty($key)) get_json('参数不完整',0);
        $url = 'https://movie.douban.com/j/subject_suggest?q='.$key;
        $json = geturl($url);
        $arr = json_decode($json,1);
        if(!empty($arr)){
            $data['code'] = 1;
            $data['list'] = $arr;
        }else{
            $data['code'] = 0;
            $data['msg'] = '未获取到相关影片信息';
            $data['list'] = array();
        }
		get_json($data);
	}

	//求片提交
	public function send(){
		$id = (int)get_post('id');
		$url = 'https://movie.douban.com/subject/'.$id.'/';
        $header = array('User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36');
        $html = geturl($url,$header);
        $json = trim(str_substr('<script type="application/ld+json">','</script>',$html));
        $json = str_replace(array("\r","\n"),"",$json);
        $arrs = json_decode($json,1);
        if(!empty($arrs['name'])){
            $data['name'] = current(explode(' ',$arrs['name']));
            $data['year'] = (int)$arrs['datePublished'];
            $data['pic'] = str_replace('https://','http://',$arrs['image']);
            $data['pic'] = str_replace('photo/s_ratio_poster','movie_poster_cover/lpst',$data['pic']);
            $data['area'] = str_replace(' / ',',',str_substr('<span class="pl">制片国家/地区:</span> ','<br/>',$html));
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
            $data['lang'] = str_replace(' / ',',',str_substr('<span class="pl">语言:</span> ','<br/>',$html));
            $res = geturl('http:'.base64decode(APIURL).'forum',array('token'=>_SYSKEY_,'data'=>sys_auth($data)));
            $d['code'] = 1;
            $d['msg'] = '求片成功';
            $d['data'] = (object)array();
        }else{
            $d['code'] = 0;
            $d['msg'] = '获取影片数据失败';
            $d['data'] = (object)array();
        }
        get_json($d);
	}
}