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

class Lists extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index($id=0,$page=1){
        $id = (int)$id;
        $page = (int)$page;
        if($page == 0) $page = 1;
        if(empty($id)) error('分类ID错误~!');
        if(!$this->caches->start('vod-lists-'.$id.'-'.$page,$this->myconfig['caches']['time']['lists'])){
	        //每页数量
	        $size = 48;
	        //按断分类是否存在
	        $row = $this->mydb->get_row('class',array('id'=>$id));
	        if(!$row) error('分类不存在~!');
	        $fid = $row['fid'];
	        if($row['fid'] == 0) $row['fid'] = $row['id'];
	        $wh['cid'] = get_cid($id);
			//seo
			$data = $row;
			$data['title'] = get_seo('type','title',$row);
			$data['keywords'] = get_seo('type','keywords',$row);
			$data['description'] = get_seo('type','description',$row);
			//总数量
		    $nums = $this->mydb->get_nums('vod',$wh);
			//总页数
		    $pagejs = ceil($nums / $size);
		    if($page > $pagejs) $page = $pagejs;
		    if($nums < $size) $size = $nums;
		    $limit = array($size,$size*($page-1));
		    //数据
		    $data['vod'] = $this->mydb->get_select('vod',$wh,'*','addtime DESC',$limit);
		    $data['fid'] = $fid > 0 ? $row['id'] : 0;
		    $data['page'] = $page;
		    $data['nums'] = $nums;
		    $data['pagejs'] = $pagejs;
			$this->load->view('head.tpl',$data);
			$this->load->view('lists.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}
}