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

class Setting extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	//基础配置
	public function index(){
		$data['sys'] = $this->myconfig;
		if(!isset($data['sys']['jxtoken'])) $data['sys']['jxtoken'] = '';
		$this->load->view('setting/index.tpl',$data);
	}

	//WEB配置
	public function web(){
		$this->load->helper('directory');
		$data['web'] = $this->myconfig['web'];
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
        $data['url'] = $this->myconfig['url'];
        $data['wapurl'] = $this->myconfig['wapurl'];
		$this->load->view('setting/web.tpl',$data);
	}

	//APP配置
	public function app(){
		$data['app'] = $this->myconfig['app'];
		$this->load->view('setting/app.tpl',$data);
	}

	//存储配置
	public function annex(){
		$data['annex'] = $this->myconfig['annex'];
		$this->load->view('setting/annex.tpl',$data);
	}

	//财务配置
	public function pay(){
		$data['pay'] = $this->myconfig['pay'];
		$this->load->view('setting/pay.tpl',$data);
	}

	//文本配置
	public function txt(){
		$data['agreement'] = file_get_contents('./caches/txt/agreement.txt');
		$data['privacy'] = file_get_contents('./caches/txt/privacy.txt');
		$this->load->view('setting/txt.tpl',$data);
	}

	//缓存配置
	public function caches(){
		$data['caches'] = $this->myconfig['caches'];
		$this->load->view('setting/caches.tpl',$data);
	}

	//公众号配置
	public function mp(){
		if(isset($this->myconfig['mp'])){
			$data['mp'] = $this->myconfig['mp'];
		}else{
			$data['mp'] = array('open'=>0,'url'=>'','token'=>'','focus_msg'=>'感谢关注，回复视频名字即可观看','empty_msg'=>'没找到资源，请更换关键词或等待更新','url_type'=>1,'msg_type'=>1,'msg_key'=>array());
		}
		$this->load->view('setting/mp.tpl',$data);
	}

	//基础配置保存
	public function save(){
		$config = $this->myconfig;
		$post = get_post();
		$post['shareurl'] = !empty($post['shareurl']) ? explode("\n", $post['shareurl']) : array();
		$post['area'] = !empty($post['area']) ? explode("|", $post['area']) : array();
		$post['lang'] = !empty($post['lang']) ? explode("|", $post['lang']) : array();
		$post['report'] = !empty($post['report']) ? explode("|", $post['report']) : array();
		$post['feedback'] = !empty($post['feedback']) ? explode("|", $post['feedback']) : array();
		if(!isset($config['sharewxqq'])) $config['sharewxqq'] = (int)$post['sharewxqq'];
		if(!isset($config['notice2'])) $config['notice2'] = $post['notice2'];
		if(!isset($config['jxtoken'])) $config['jxtoken'] = $post['jxtoken'];
		if(!isset($config['share_pngtxt'])) $config['share_pngtxt'] = $post['share_pngtxt'];
		//循环替换
		foreach ($config as $k => $v) {
			if(isset($post[$k])) $config[$k] = $post[$k];
		}
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/index');
		get_json($d,1);
	}

	//网站配置保存
	public function web_save(){
		$config = $this->myconfig;
		$config['url'] = get_post('url');
		$config['wapurl'] = get_post('wapurl');
		$config['web'] = get_post();
		if(!$config['wapurl']) $config['wapurl'] = '';
		unset($config['web']['url'],$config['web']['wapurl'],$config['web']['uri']['vod']);
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		//配置保存路由
 		$uri = $config['web']['uri'];
 		unset($uri['delindex'],$uri['ext']);
        $this->route_file($uri);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/web');
		get_json($d,1);
	}

	//APP配置保存
	public function app_save(){
		$config = $this->myconfig;
		$config['app'] = get_post();
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/app');
		get_json($d,1);
	}

	//附件配置保存
	public function annex_save(){
		$config = $this->myconfig;
		$config['annex'] = get_post();
		if($config['annex']['type'] != 'sys'){
			$type = $config['annex']['type'];
			foreach ($config['annex'][$type] as $k => $v) {
				if($v == '') get_json($k.'不能为空',0);
			}
		}
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/annex');
		get_json($d,1);
	}

	//财务配置保存
	public function pay_save(){
		$config = $this->myconfig;
		$config['pay'] = get_post();
		$config['pay']['vip'] = !empty($config['pay']['vip']) ? array_values($config['pay']['vip']) : array();
		$config['pay']['cion'] = !empty($config['pay']['cion']) ? array_values($config['pay']['cion']) : array();
		$config['pay']['exchange'] = !empty($config['pay']['exchange']) ? array_values($config['pay']['exchange']) : array();
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/pay');
		get_json($d,1);
	}

	//文本配置保存
	public function txt_save(){
		$agreement = get_post('agreement');
		$privacy = get_post('privacy');

		file_put_contents(FCPATH.'caches/txt/agreement.txt',$agreement);
		file_put_contents(FCPATH.'caches/txt/privacy.txt',$privacy);

		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['url'] = links('setting/txt');
		get_json($d,1);
	}

	//缓存配置保存
	public function caches_save(){
		$config = $this->myconfig;
		$config['caches'] = get_post();
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/caches');
		get_json($d,1);
	}

	//公众号配置保存
	public function mp_save(){
		$config = $this->myconfig;
		$config['mp'] = get_post();
		if(!isset($config['mp']['msg_key'])) $config['mp']['msg_key'] = array();
		$config['mp']['msg_key'] = array_values($config['mp']['msg_key']);
		$res = arr_file_edit($config,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);

		$d['code'] = 1;
		$d['msg'] = '修改成功';
		$d['url'] = links('setting/mp');
		get_json($d,1);
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
		$string = '<?php'.PHP_EOL;
		$string.= 'if (!defined(\'BASEPATH\')) exit(\'No direct script access allowed\');';
		if($uri) {
			arsort($uri);
			foreach ($uri as $key => $val1) {
				if(substr($val1,0,1) === '/') $val1 = substr($val1,1);
				$var0 = $val1;
				$val2 = $yuri[$key];
				if($key == 'lists'){
					$val1 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[page]'),array('$1','$2'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[page]','',$var0);
					$val3 = str_replace('/[page]','',$yuri[$key]);
					$var0 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$var0);
					$val3 = str_replace(array('[id]','[page]'),array('$1','$2'),$val3);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}elseif($key == 'info'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'play'){
					$val1 = str_replace(array('[id]','[jid]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[jid]'),array('$1','$2'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[jid]','',$var0);
					$val3 = str_replace('/[jid]','',$yuri[$key]);
					$var0 = str_replace(array('[id]'),array('(\d+)'),$var0);
					$val3 = str_replace(array('[id]'),array('$1'),$val3);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}elseif($key == 'topic'){
					$val1 = str_replace(array('[page]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[page]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'topicinfo'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'star' ){
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'starhot' ){
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'starlists'){
					$val1 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$val1);
					$val2 = str_replace(array('[id]','[page]'),array('$1','$2'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[page]','',$var0);
					$val3 = str_replace('/[page]','',$yuri[$key]);
					$var0 = str_replace(array('[id]','[page]'),array('(\d+)','(\d+)'),$var0);
					$val3 = str_replace(array('[id]','[page]'),array('$1','$2'),$val3);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}elseif($key == 'starinfo'){
					$val1 = str_replace(array('[id]'),array('(\d+)'),$val1);
					$val2 = str_replace(array('[id]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
				}elseif($key == 'hot'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}elseif($key == 'opt'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}elseif($key == 'rss'){
					$val1 = str_replace(array('[type]'),array('([a-zA-Z0-9\-\_]+)'),$val1);
					$val2 = str_replace(array('[type]'),array('$1'),$val2);
				    $string.= PHP_EOL.'$route[\''.$val1.'\'] = \''.$val2.'\';';
					$var0 = str_replace('/[type]','',$var0);
					$val3 = str_replace('/[type]','',$yuri[$key]);
				    $string.= PHP_EOL.'$route[\''.$var0.'\'] = \''.$val3.'\';';
				}
			}
		}
		file_put_contents(FCPATH.'yhcms/config/uri.php', $string);
	}
}