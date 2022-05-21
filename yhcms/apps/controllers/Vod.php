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

class Vod extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index(){
		$uri = $this->uri->uri_string();
        $n = strpos($uri,'/index') !== false ? 3 : 2;
        $arr = $this->uri->uri_to_assoc($n);
        $page = !empty($arr['page']) ? (int)$arr['page'] : 1;
        if($page == 0) $page = 1;
        //每页数量
        $size = 48;
        //按断分类是否存在
        if(empty($arr['cid'])){
        	$row = $this->mydb->get_row('class',array('fid'=>0),'*','xid asc');
        }else{
        	$row = $this->mydb->get_row('class',array('id'=>(int)$arr['cid']));
        }
        if(!$row) error('分类不存在~!');
        $fid = $row['fid'];
        if($row['fid'] == 0) $row['fid'] = $row['id'];
        $wh = array();$sort = 'addtime';
        foreach ($arr as $k => $v) {
        	if($k == 'cid') $wh['cid'] = get_cid((int)$v);
        	if($k == 'area') $wh['area'] = safe_replace(urldecode($v));
        	if($k == 'lang') $wh['lang'] = safe_replace(urldecode($v));
        	if($k == 'year') $wh['year'] = (int)$v;
        	if($k == 'sort') $sort = $v;
        }
		//seo
		$data = $row;
		$data['title'] = get_seo('type','title',$row);
		$data['keywords'] = get_seo('type','keywords',$row);
		$data['description'] = get_seo('type','description',$row);
		//sort
		$sarr = array('addtime','hits','score','id');
		if(!in_array($sort,$sarr)) $sort = 'addtime';

		//总数量
	    $nums = $this->mydb->get_nums('vod',$wh);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $data['vod'] = $this->mydb->get_select('vod',$wh,'*',$sort.' DESC',$limit);
	    $data['area_list'] = $this->myconfig['area'];
	    $data['area'] = !empty($arr['area']) ? urldecode($arr['area']) : '';
	    $data['lang'] = !empty($arr['lang']) ? urldecode($arr['lang']) : '';
	    $data['year'] = !empty($arr['year']) ? (int)$arr['year'] : '';
	    $data['sort'] = $sort;
	    $data['cid'] = $fid > 0 ? $row['id'] : 0;
	    $data['page'] = $page;
	    $data['nums'] = $nums;
	    $data['pagejs'] = $pagejs;
		$this->load->view('head.tpl',$data);
		$this->load->view('vod.tpl');
		$this->load->view('bottom.tpl');
	}

	public function hot($op='index'){
		$oarr = array('index','news','fav');
		if(!in_array($op,$oarr)) $op = 'index';
        if(!$this->caches->start('hot-'.$op,$this->myconfig['caches']['time']['hot'])){
			//seo
			$data['title'] = get_seo('hot','title');
			$data['keywords'] = get_seo('hot','keywords');
			$data['description'] = get_seo('hot','description');
			if($op == 'news') $data['title'] = '最近更新影视 - '.WEBNAME;
			$this->load->view('head.tpl',$data);
			$this->load->view('hot-'.$op.'.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}

	public function opt($op=''){
		$oarr = array('reco');
		if(!in_array($op,$oarr)) $op = 'reco';
        if(!$this->caches->start('opt-'.$op,$this->myconfig['caches']['time']['opt'])){
			//seo
			$name = '';
			$data['title'] = get_seo('hot','title');
			$data['keywords'] = get_seo('hot','keywords');
			$data['description'] = get_seo('hot','description');

			if($op == 'reco'){
				$data['title'] = '热门推荐 - '.WEBNAME;
				$data['vod'] = $this->mydb->get_select('vod',array('tid>'=>0),'id,name,pic,state,pay','zhits desc',48);
			}

			$this->load->view('head.tpl',$data);
			$this->load->view('vod-opt-'.$op.'.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}
}
