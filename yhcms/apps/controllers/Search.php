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

class Search extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index(){
		$type = get_post('type',true);
		$key = get_post('key',true);
		$page = (int)get_post('page');
		$tarr = array('director','actor','name');
		if(!in_array($type, $tarr)) $type = 'name';
        if($page == 0) $page = 1;
        if(empty($key)) error('请输入搜索关键字');
		//seo
		$data['title'] = '搜索结果 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//SQL
		if($type == 'name'){
		    $myver = $this->db->version();
			preg_match_all("/./us",$key,$match);
			if(count($match[0]) > 3 && $myver > '5.6.4'){
    		    $sql1 = "SELECT * FROM information_schema.statistics WHERE table_schema=DATABASE() AND table_name = '"._DBPREFIX_."vod' AND index_name = 'name_text'";
    			$res = $this->db->query($sql1)->row_array();
    			if(!$res){
    				$sql2 = "ALTER TABLE "._DBPREFIX_."vod ADD FULLTEXT INDEX name_text (`name`,`director`,`actor`)";
    				$this->db->query($sql2);
    			}
    			$sql = "select * from "._DBPREFIX_."vod where match(name,director,actor) against ('".$key."*' IN BOOLEAN MODE) order by addtime desc";
			}else{
			    $sql = "select * from "._DBPREFIX_."vod where LOCATE('".$key."',".$type.") > 0 order by addtime desc";
			}
		}else{
			$sql = "select * from "._DBPREFIX_."vod where LOCATE('".$key."',".$type.") > 0 order by addtime desc";
		}
		//总数量
	    $nums = $this->mydb->get_sql_nums($sql);
	    if($type == 'name' && $nums == 0){
	    	$sql = "select * from "._DBPREFIX_."vod where LOCATE('".$key."',name) > 0 order by addtime desc";
	    	$nums = $this->mydb->get_sql_nums($sql);
	    }
        //每页数量
        $size = 48;
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($pagejs == 0) $pagejs = 1;
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = $size*($page-1).','.$size;
	    $data['vod'] = $this->mydb->get_sql($sql.' limit '.$limit);
	    $data['key'] = $key;
	    $data['page'] = $page;
	    $data['nums'] = $nums;
	    $data['pagejs'] = $pagejs;
		$this->load->view('head.tpl',$data);
		$this->load->view('search.tpl');
		$this->load->view('bottom.tpl');
	}

	public function opt(){
		//seo
		$data['title'] = '搜索 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
		
		$this->load->view('head.tpl',$data);
		$this->load->view('search-opt.tpl');
		$this->load->view('bottom.tpl');
	}
}
