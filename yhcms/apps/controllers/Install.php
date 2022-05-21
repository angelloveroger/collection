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

class Install extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
        if(file_exists(FCPATH.'caches/install.lock')){
            exit('重新安装请删除文件：./caches/install.lock');
        }
	}

	public function index($page=1){
        set_time_limit(0);
		$page = (int)$page;
		if($page == 0) $page = 1;
		$data['page'] = $page;
		if($page > 1) $this->load->model('mydb');
        $this->load->get_templates('install');
		if($page == 2){
        	$star = (int)get_post('star');
            //导入数据表
            $sql = file_get_contents("./caches/table.sql");
            $sql = str_replace('[dbprefix]',$this->myconfig['db']['dbprefix'],$sql);
            preg_match_all('/DROP TABLE IF EXISTS `(.*?)`/',$sql,$arr);
            $sqlarr = explode(";",$sql);
            for($i=0;$i<count($sqlarr);$i++){
            	if(!empty($sqlarr[$i])) $this->db->query($sqlarr[$i]);
            }
            //导入默认数据
            $sql = file_get_contents("./caches/data.sql");
            $sql = str_replace('[dbprefix]',$this->myconfig['db']['dbprefix'],$sql);
            $sqlarr = explode(";[yhcms]",$sql);
            for($i=0;$i<count($sqlarr);$i++){
				if(!empty($sqlarr[$i])) $this->db->query($sqlarr[$i]);
            }
            //导入歌手库
            if($star == 1){
	            $sql = file_get_contents("./caches/star_data.sql");
	            $sql = str_replace('[dbprefix]',$this->myconfig['db']['dbprefix'],$sql);
	            $sqlarr = explode(";[yhcms]",$sql);
	            for($i=0;$i<count($sqlarr);$i++){
					if(!empty($sqlarr[$i])) $this->db->query($sqlarr[$i]);
	            }
            }
            $data['table'] = $arr[1];
		}elseif($page == 4){
			$webname = get_post('webname',true);
			$weburl = get_post('weburl',true);
			$admin_name = get_post('admin_name',true);
			$admin_pass = get_post('admin_pass',true);
			$admin_code = get_post('admin_code',true);

			if(empty($webname)) get_json('请填写站点名字',0);
			if(empty($weburl)) get_json('请填写站点域名',0);
			if(empty($admin_name)) get_json('请填写管理员账号',0);
			if(empty($admin_pass)) get_json('请填写管理员密码',0);
			if(empty($admin_code)) get_json('请填写后台认证码',0);

			$this->myconfig['name'] = $webname;
			$this->myconfig['url'] = $weburl;
			$this->myconfig['admin_code'] = $admin_code;
			$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
			if(!$res) get_json('文件写入失败，请检查./yhcms/config/config.php权限',0);
			//创建管理员
			$res = $this->mydb->get_insert('admin',array('name'=>$admin_name,'pass'=>md5($admin_pass),'qx'=>''));
			if(!$res) get_json('创建管理员失败',0);
			get_json('设置完成，请稍后...',1);
		}elseif($page == 5){
			file_put_contents(FCPATH.'caches/install.lock','yhcms');
			unlink(FCPATH.'install.php');
		}
		//输出
		$this->load->view('index-'.$page.'.tpl',$data);
	}

	//创建数据库
	public function dbtest(){
        set_time_limit(0);
        $dbdriver = get_post('dbdriver');
        $dbhost = get_post('dbhost');
        $dbuser = get_post('dbuser');
        $dbpwd = get_post('dbpwd');
        $dbname = get_post('dbname');
        $dbprefix = get_post('dbprefix');
		if(is_numeric($dbname)) get_json('数据库名不能为纯数字，请修改！',0);
		if(empty($dbdriver)) $dbdriver='mysql';
		if($dbdriver == 'mysqli'){
			$mysqli = new mysqli($dbhost,$dbuser,$dbpwd);
			if(mysqli_connect_errno()){
				get_json('无法连接数据库服务器，请检查配置！',0);
			}else{
				if(!$mysqli->select_db($dbname) && !$mysqli->query("CREATE DATABASE `".$dbname."`")) get_json('成功连接数据库，但是指定的数据库不存在并且无法自动创建，请先通过其他方式建立数据库！',0);
				mysqli_select_db($mysqli,$dbname);
				//修改数据库配置
				$this->load->helper('string');
				$token = random_string('alnum',15);
				//修改配置
				$this->myconfig['sys_key'] = md5($token);
				$this->myconfig['db'] = array (
				    'dbdriver' => $dbdriver,
				    'hostname' => $dbhost,
				    'database' => $dbname,
				    'username' => $dbuser,
				    'password' => $dbpwd,
				    'dbprefix' => $dbprefix,
				    'charset' => 'utf8',
				);
				$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
				if(!$res) get_json('文件写入失败，请检查./yhcms/config/config.php权限',0);
				//判断是否存在相同表
                $res = $mysqli->query("SHOW TABLES LIKE '%".$dbprefix."vod%'");
                $row = mysqli_fetch_array($res,MYSQLI_ASSOC);
				if($row) get_json('系统检测到数据库有数据，重新安装会删除原来的老数据！',1);
				get_json('ok',1);
			}
		}else{
			$lnk = mysql_connect($dbhost,$dbuser,$dbpwd);
			if(!$lnk) {
				get_json('无法连接数据库服务器，请检查配置！',0);
			}else{
			   	if(!mysql_select_db($dbname) && !mysql_query("CREATE DATABASE `".$dbname."`")) get_json('成功连接数据库，但是指定的数据库不存在并且无法自动创建，请先通过其他方式建立数据库！',0);
			   	//修改数据库配置
			   	if(mysql_select_db($dbname)){
					$this->load->helper('string');
					$token = random_string('alnum',15);
					//修改配置
					$this->myconfig['sys_key'] = md5($token);
					$this->myconfig['db'] = array (
					    'dbdriver' => $dbdriver,
					    'hostname' => $dbhost,
					    'database' => $dbname,
					    'username' => $dbuser,
					    'password' => $dbpwd,
					    'dbprefix' => $dbprefix,
					    'charset' => 'utf8',
					);
					$res = arr_file_edit($this->myconfig,FCPATH.'yhcms/config/config.php');
					if(!$res) get_json('文件写入失败，请检查./yhcms/config/config.php权限',0);
			   	}
			   	//判断是否存在相同表
			   	if(mysql_query("SHOW TABLES LIKE '%".$dbdriver."vod%'")) get_json('系统检测到数据库有数据，重新安装会删除原来的老数据！',1);
			   	get_json('ok',1);
			}
		}
	}
}