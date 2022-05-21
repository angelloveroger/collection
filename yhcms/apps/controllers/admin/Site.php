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

class Site extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index(){
		$data['site'] = json_decode(_SITE_,1);
		$this->load->view('site/index.tpl',$data);
	}

	//站群配置保存
	public function edit($k=0){
		$site = json_decode(_SITE_,1);
		$k = (int)$k;
		if($k > 0){
			$kk = $k-1;
			if(!isset($site[$kk])) error('错误提示','该站群不存在');
			$data = $site[$kk];
		}else{
			$data = array(
				'name' => '',
				'host' => '',
				'stat' => '',
				'route' => '',
				'pc_tpl' => '',
			    'wap_tpl' => '',
			    'uri' => $this->myconfig['web']['uri'],
			    'seo' => $this->myconfig['web']['seo'],
			);
		}
		$this->load->helper('directory');
		//获取所有PC模板
		$pcpath = FCPATH.'template/pc/';
		$pcarr = directory_map($pcpath, 1);
		$pcskin = array();
        foreach ($pcarr as $dir) {
			$pcskin[] = str_replace("/","",str_replace("\\","/",$dir));
		}
        $data['pctpl'] = $pcskin;
		//获取所有手机模板
		$wappath = FCPATH.'template/wap/';
		$waparr = directory_map($wappath, 1);
		$wapskin = array();
        foreach ($waparr as $dir) {
			$wapskin[] = str_replace("/","",str_replace("\\","/",$dir));
		}
        $data['waptpl'] = $wapskin;
        $data['kk'] = $k;
		$this->load->view('site/edit.tpl',$data);
	}

	//站群配置保存
	public function save($k=0){
		$site = json_decode(_SITE_,1);
		$k = (int)$k;
		$config = get_post();
		//配置保存路由
 		$config['route'] = $this->route_file($config['uri']);
 		//修改
		if($k > 0){
			$k--;
			if(!isset($site[$k])) get_json('该站群不存在',0);
			$site[$k] = $config;
		}else{
			$site[] = $config;
		}
		$res = arr_file_edit($site,FCPATH.'yhcms/config/site.php');
		if(!$res) get_json('文件写入失败，请检查site.php权限',0);

		$arr['msg'] = '恭喜您，操作成功~!';
		$arr['url'] = links('site');
		$arr['parent'] = 1;
		get_json($arr,1);
	}

	//站群删除
	public function del(){
		$site = json_decode(_SITE_,1);
		$k = (int)get_post('id');
		$kk = $k-1;
		unset($site[$kk]);
		$site = array_values($site);
		$res = arr_file_edit($site,FCPATH.'yhcms/config/site.php');
		if(!$res) get_json('文件写入失败，请检查site.php权限',0);

		$arr['msg'] = '恭喜您，删除成功~!';
		$arr['url'] = links('site');
		get_json($arr,1);
	}

	//将路由规则生成至文件
	private function route_file($uri) {
        $yuri = array(
			'lists' => 'lists/index/[id]/[page]',
			'vod' => 'vod/index/cid/[cid]/area/[area]/year/[year]/sort/[sort]',
			'info'  => 'info/index/[id]',
			'play'   => 'play/index/[id]/[jid]',
			'topic' => 'topic/index/[page]',
			'topicinfo'  => 'topic/info/[id]',
			'star'   => 'star',
			'starlists'   => 'star/lists/[id]/[page]',
			'starinfo'   => 'star/info/[id]',
			'hot'   => 'vod/hot/[type]',
			'opt'   => 'vod/opt/[type]',
			'starhot'   => 'star/hot',
			'rss'   => 'rss/index/[type]',
	    );
	    $back_arr = array();
		if($uri) {
			arsort($uri);
			foreach ($uri as $key => $val1) {
				if(substr($val1,0,1) === '/') $val1 = substr($val1,1);
				$var0 = $val1;
				$val2 = $yuri[$key];
				if($key == 'lists'){
					$val1 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[page]'),array('$1','$2'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[page]','',$var0);
					$val3 = str_replace('/[page]','',$yuri[$key]);
					$var0 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$var0);
					$val3 = str_replace(array('[id]','[page]'),array('$1','$2'),$val3);
				    $back_arr[$var0] = $val3;
				}elseif($key == 'info'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
				}elseif($key == 'play'){
					$val1 = str_replace(array('[id]','[jid]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[jid]'),array('$1','$2'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[jid]','',$var0);
					$val3 = str_replace('/[jid]','',$yuri[$key]);
					$var0 = str_replace(array('[id]'),array('(\d+)'),$var0);
					$val3 = str_replace(array('[id]'),array('$1'),$val3);
				    $back_arr[$var0] = $val3;
				}elseif($key == 'topic'){
					$val1 = str_replace(array('[page]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[page]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
				}elseif($key == 'topicinfo'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
				}elseif($key == 'star' ){
				    $back_arr[$val1] = $val2;
				}elseif($key == 'starhot' ){
				    $back_arr[$val1] = $val2;
				}elseif($key == 'starlists'){
					$val1 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[page]'),array('$1','$2'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[page]','',$var0);
					$val3 = str_replace('/[page]','',$yuri[$key]);
					$var0 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$var0);
					$val3 = str_replace(array('[id]','[page]'),array('$1','$2'),$val3);
				    $back_arr[$var0] = $val3;
				}elseif($key == 'starinfo'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
				}elseif($key == 'hot'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $back_arr[$var0] = $val3;
				}elseif($key == 'opt'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $back_arr[$var0] = $val3;
				}elseif($key == 'rss'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $back_arr[$val1] = $val2;
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $back_arr[$var0] = $val3;
				}
			}
		}
		return $back_arr;
	}
}