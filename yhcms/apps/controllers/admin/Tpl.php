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

class Tpl extends My_Controller {
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->load->helper('directory');
		//判断是否登陆
		get_admin_islog();
	}

	//模板管理
	public function index($type='pc'){
		$this->load->helper('directory');
		if($type != 'wap') $type = 'pc';
		//获取所有PC模板
		$pcpath = FCPATH.'template/pc/';
		$pcarr = directory_map($pcpath, 1);
		$pcskin = array();
        foreach ($pcarr as $dir) {
			$dir = str_replace("/","",str_replace("\\","/",$dir));
			if(file_exists($pcpath.$dir.'/tpl.php')){
				$arr = require $pcpath.$dir.'/tpl.php';
				$skin_pic = $pcpath.$dir.'/pic.png';
				if(!file_exists($skin_pic)){
					$arr['pic'] = '/packs/admin/images/skin_no.png';
				}else{
					$arr['pic'] = str_replace(FCPATH,'/',$skin_pic);
				}
				$arr['init'] = $arr['dir'] == $this->myconfig['web']['pc_tpl'] ? 1 : 0;
				$arr['dir'] = sys_auth($arr['dir']);
				$arr['type'] = 'pc';
				unset($arr['ads']);
				$pcskin[] = $arr;
			}
		}
        $data['pc'] = $pcskin;
		//获取所有wap模板
		$wappath = FCPATH.'template/wap/';
		$waparr = directory_map($wappath, 1);
		$wapskin = array();
        foreach ($waparr as $dir) {
			$dir = str_replace("/","",str_replace("\\","/",$dir));
			if(file_exists($wappath.$dir.'/tpl.php')){
				$arr = require $wappath.$dir.'/tpl.php';
				$skin_pic = $wappath.$dir.'/pic.png';
				if(!file_exists($skin_pic)){
					$arr['pic'] = '/packs/admin/images/skin_no.png';
				}else{
					$arr['pic'] = str_replace(FCPATH,'/',$skin_pic);
				}
				$arr['init'] = $arr['dir'] == $this->myconfig['web']['wap_tpl'] ? 1 : 0;
				$arr['dir'] = sys_auth($arr['dir']);
				$arr['type'] = 'wap';
				unset($arr['ads']);
				$wapskin[] = $arr;
			}
		}
        $data['wap'] = $wapskin;
        $data['type'] = $type;
		$this->load->view('tpl/index.tpl',$data);
	}

	//设置默认模版
	public function init($op = 'pc'){
		if($op != 'wap') $op = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) get_json('模版目录不存在',0);
		if(!is_dir(FCPATH.'template/'.$op.'/'.$dir)) get_json('模版目录不存在',0);
		//保存
		$this->myconfig['web'][$op.'_tpl'] = $dir;
		$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
		if(!$res) get_json('文件写入失败，请检查config.php权限',0);
		$arr['msg'] = '模版设置成功~！';
		$arr['url'] =  links('tpl/index/'.$op);
		get_json($arr,1);
	}

	//删除模版
	public function del($type = 'pc'){
		if($type != 'wap') $type = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) get_json('模版目录不存在',0);
		if(!is_dir(FCPATH.'template/'.$type.'/'.$dir)) get_json('模版目录不存在',0);
		if($this->myconfig['web'][$type.'_tpl'] == $dir) get_json('默认模版不能删除',0);
		$res = deldir(FCPATH.'template/'.$type.'/'.$dir,'ok');
		if(!$res) get_json('模版目录没有删除权限!!!',0);
		$arr['msg'] = '模版删除成功~！';
		$arr['url'] =  links('tpl/index/'.$type);
		get_json($arr,1);
	}

	//模板广告
	public function ads($type='pc'){
		if($type != 'wap') $type = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) error('模版目录不存在');
		if(!is_dir(FCPATH.'template/'.$type.'/'.$dir)) error('模版目录不存在');
		//获取模板广告
		if(!file_exists(FCPATH.'template/'.$type.'/'.$dir.'/tpl.php')) error('模版配置文件不存在');
		$tpl = require FCPATH.'template/'.$type.'/'.$dir.'/tpl.php';
        $data['ads'] = $tpl['ads'];
        $data['type'] = $type;
        $data['dir'] = $dir;
		$this->load->view('tpl/ads.tpl',$data);
	}

	//模板广告开关
	public function ads_init($type='pc'){
		if($type != 'wap') $type = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		$js = sys_auth(get_post('js'),1);
		$init = (int)get_post('init');
		$op = get_post('op',true);
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) get_json('模版目录不存在',0);
		if(!file_exists(FCPATH.'template/'.$type.'/'.$dir.'/adv/'.$js)) get_json('模版JS文件不存在',0);
		$arr = require FCPATH.'template/'.$type.'/'.$dir.'/tpl.php';
		if(empty($arr['ads'][$op]['list'])) get_json('广告位不存在',0);
		$ok = 0;$jshtml = '';
		foreach ($arr['ads'][$op]['list'] as $k => $v) {
			if($v['jspath'] == $js){
				$arr['ads'][$op]['list'][$k]['init'] = $init;
				$jshtml = $arr['ads'][$op]['list'][$k]['jshtml'];
				$ok = 1;
				break;
			}
		}
		if($ok == 0) get_json('广告位不存在',0);

		$jsfile = FCPATH.'template/'.$type.'/'.$dir.'/adv/'.$js;
		if($init == 0){
			$jshtml = "<!--\r\n".$jshtml."\r\n-->";
		}else{
			$jshtml = str_replace(array("<!--\r\n","\r\n-->"),'',$jshtml);
			if(empty($jshtml)) $jshtml = "\n";
		}
		$res = file_put_contents($jsfile,htmltojs($jshtml));
		if(!$res) get_json('广告js文件没有修改权限!!!',0);

		$res = arr_file_edit($arr,FCPATH.'template/'.$type.'/'.$dir.'/tpl.php');
		if(!$res) get_json('文件写入失败，请检查tpl.php权限',0);

		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//模板广告修改
	public function edit($type='pc',$op=''){
		if($type != 'wap') $type = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		$js = sys_auth(get_post('js'),1);
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) error('模版目录不存在');
		if(!file_exists(FCPATH.'template/'.$type.'/'.$dir.'/adv/'.$js)) error('模版JS文件不存在');
		$arr = require FCPATH.'template/'.$type.'/'.$dir.'/tpl.php';
		if(empty($arr['ads'][$op]['list'])) error('广告位不存在');
		$ok = 0;$jshtml = '';
		foreach ($arr['ads'][$op]['list'] as $k => $v) {
			if($v['jspath'] == $js){
				$jshtml = $v['jshtml'];
				$ok = 1;
				break;
			}
		}
		if($ok == 0) error('广告位不存在');
		$data['jshtml'] = $jshtml;
		$data['type'] = $type;
		$data['dir'] = get_post('dir');
		$data['op'] = $op;
		$data['js'] = get_post('js');
		$this->load->view('tpl/edit.tpl',$data);
	}

	//模板广告保存
	public function save($type='pc',$op=''){
		if($type != 'wap') $type = 'pc';
		$dir = sys_auth(get_post('dir'),1);
		$js = sys_auth(get_post('js'),1);
		$jshtml = get_post('jshtml');
		if(preg_match('/^[0-9a-zA-Z\_\-]$/i',$dir)) get_json('模版目录不存在',0);
		if(!file_exists(FCPATH.'template/'.$type.'/'.$dir.'/adv/'.$js)) get_json('模版JS文件不存在',0);
		$arr = require FCPATH.'template/'.$type.'/'.$dir.'/tpl.php';
		if(empty($arr['ads'][$op]['list'])) get_json('广告位不存在',0);
		$ok = 0;
		foreach ($arr['ads'][$op]['list'] as $k => $v) {
			if($v['jspath'] == $js){
				$arr['ads'][$op]['list'][$k]['jshtml'] = $jshtml;
				$ok = 1;
				break;
			}
		}
		if($ok == 0) get_json('广告位不存在',0);
		//保存JS
		$res = file_put_contents(FCPATH.'template/'.$type.'/'.$dir.'/adv/'.$js,htmltojs($jshtml));
		if(!$res) get_json('模版广告js文件没有修改权限!!!',0);
		//保存html
		$res = arr_file_edit($arr,FCPATH.'template/'.$type.'/'.$dir.'/tpl.php');
		if(!$res) get_json('文件写入失败，请检查tpl.php权限',0);

		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//模板上传
	public function uptpl(){
        $type = get_post('type',true);
        if($type != 'wap') $type = 'pc';
        //上传目录
        $path = FCPATH.'annex/zip';
        mkdirss($path);
        $tempFile = $_FILES['file']['tmp_name'];
        $file_name = $_FILES['file']['name'];
        $file_type = $_FILES['file']['type'];
        $file_size = filesize($tempFile);
        $file_ext = strtolower(trim(substr(strrchr($file_name, '.'), 1)));
        //验证文件mime类型
        $ziptype =  array('application/x-zip','application/zip','application/x-zip-compressed','application/s-compressed','multipart/x-zip');
        if(!in_array($file_type,$ziptype)){
            get_json('不支持的'.$file_ext.'类型文件',0);
        }
        //PHP上传失败
        if (!empty($_FILES['file']['error'])) {
            switch($_FILES['file']['error']){
                case '1':
                    $error = '超过php.ini允许的大小。';
                    break;
                case '2':
                    $error = '超过表单允许的大小。';
                    break;
                case '3':
                    $error = '图片只有部分被上传。';
                    break;
                case '4':
                    $error = '请选择文件。';
                    break;
                case '6':
                    $error = '找不到临时目录。';
                    break;
                case '7':
                    $error = '写文件到硬盘出错。';
                    break;
                case '8':
                    $error = 'File upload stopped by extension。';
                    break;
                case '999':
                default:
                    $error = '服务器未知错误。';
            }
            get_json($error,0);
        }
        $file_path = $path.'/'.time().'.zip';
        if(move_uploaded_file($tempFile, $file_path) !== false) { //上传成功
            //解压
			$this->load->library('yhzip');
			$this->yhzip->PclZip($file_path);
			if($this->yhzip->extract(PCLZIP_OPT_PATH,FCPATH.'template/'.$type.'/',PCLZIP_OPT_REPLACE_NEWER) == 0) {
	            unlink($file_path);
				get_json('文件解压失败，或者没有权限覆盖文件~！',0);
			}else{
				unlink($file_path);
				get_json('模板上传成功',1);
			}
            echo json_encode(array('error'=>0,'url'=>$filepath,'code'=>0,'msg'=>'上传完成','data'=>array('src'=>$filepath)));
        }else{ //上传失败
            get_json('上传失败',0);
        }
	}

	//云模板中心
	public function yun($cid=0,$page = 1){
		$page = (int)$page;
		$data['page'] = $page == 0 ? 1 : $page;
		$data['cid'] = (int)$cid;
		$arr = json_decode(geturl('http:'.base64decode(APIURL).'/tpl/index',array('cid'=>$cid,'page'=>$page)),1);
		$data['skins'] = $arr['code'] == 1 ? $arr['data'] : array('tpl'=>array(),'class'=>array(),'pagejs'=>1);
		$this->load->view('tpl/yun.tpl',$data);
	}

	public function down($id=0){
		set_time_limit(0);
		$id = (int)$id;
		$arr = json_decode(geturl('http:'.base64decode(APIURL).'/tpl/index/down',array('id'=>$id)),1);
		if(!isset($arr['code'])) get_json('未知错误，请联系官方客服');
		if($arr['code'] != 1) get_json($arr['msg'],0);
		if(empty($arr['data']['type'])) get_json('该模板未定义类型',0);
		if(empty($arr['data']['zipurl'])) get_json('没有获取到模板包地址',0);
		$type = $arr['data']['type'];
		//下载文件
		$zipurl = $arr['data']['zipurl'];
		if(empty($zipurl)) get_json('模板包地址错误',0);
		//获取文件头信息
		$arr2 = get_headers($zipurl,true);
		if(!in_array('application/zip',$arr2['Content-Type']) && 
			$arr2['Content-Type'] !== 'application/zip' && 
			$arr2['Content-Type'] !== 'zip'){
			get_json('压缩包不是zip类型文件',0);
		}
		$data = geturl($zipurl);
		if(empty($data)) get_json('获取压缩包失败',0);
		$file_zip = FCPATH."caches/upzip/".date('YmdHis').'.zip';
		if(!file_put_contents($file_zip, $data)) get_json('压缩包下载失败',0);
		//解压
		$this->load->library('yhzip');
		$this->yhzip->PclZip($file_zip);
		if ($this->yhzip->extract(PCLZIP_OPT_PATH, FCPATH.'template/'.$type.'/', PCLZIP_OPT_REPLACE_NEWER) == 0) {
            unlink($file_zip);
			get_json('文件解压失败，或者没有权限覆盖文件~！',0);
		}else{
			unlink($file_zip);
			$arr['url'] = links('tpl/index/'.$type);
			$arr['msg'] = '模板下载成功~！';
			get_json($arr,1);
		}
	}
}