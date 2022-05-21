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

class Star extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index(){
        if(!$this->caches->start('star',$this->myconfig['caches']['time']['star'])){
    		//seo
    		$data['title'] = get_seo('star','title');
    		$data['keywords'] = get_seo('star','keywords');
    		$data['description'] = get_seo('star','description');

    		$this->load->view('head.tpl',$data);
    		$this->load->view('star.tpl');
    		$this->load->view('bottom.tpl');
            $this->caches->end();
        }
	}

    public function hot(){
        if(!$this->caches->start('starhot',$this->myconfig['caches']['time']['starhot'])){
            //seo
            $data['title'] = '明星排行榜 - '.WEBNAME;
            $data['keywords'] = get_seo('hot','keywords');
            $data['description'] = get_seo('hot','description');
            $this->load->view('head.tpl',$data);
            $this->load->view('star-hot.tpl');
            $this->load->view('bottom.tpl');
            $this->caches->end();
        }
    }

    public function lists($id=0,$page=1){
        $id = (int)$id;
        $page = (int)$page;
        $size = 48; //每页数量
        if($id == 0) error('分类不存在',404);
        if(!$this->caches->start('star-list-'.$id.'-'.$page,$this->myconfig['caches']['time']['starlists'])){
            $row = $this->mydb->get_row('star_class',array('id'=>$id));
            if(!$row) error('分类不存在',404);
            $data = $row;
            //seo
            $data['title'] = get_seo('starlist','title',$row);
            $data['keywords'] = get_seo('starlist','keywords',$row);
            $data['description'] = get_seo('starlist','description',$row);
            
            //查询条件
            $where = array('cid'=>$id);
            //总数量
            $nums = $this->mydb->get_nums('star',$where);
            //总页数
            $pagejs = ceil($nums / $size);
            if($page > $pagejs) $page = $pagejs;
            if($nums < $size) $size = $nums;
            $limit = array($size,$size*($page-1));
            $data['star'] = $this->mydb->get_select('star',$where,'id,name,pic','id DESC',$limit);
            $data['nums'] = $nums;
            $data['page'] = $page;
            $data['pagejs'] = $pagejs;
            //输出
            $this->load->view('head.tpl',$data);
            $this->load->view('star-lists.tpl');
            $this->load->view('bottom.tpl');
            $this->caches->end();
        }
    }

    public function info($id=0){
        $id = (int)$id;
        if($id == 0) error('明星不存在',404);
        if(!$this->caches->start('star-info-'.$id,$this->myconfig['caches']['time']['starinfo'])){
            $row = $this->mydb->get_row('star',array('id'=>$id));
            if(!$row) error('明星不存在',404);
            $data = $row;
            //seo
            $data['title'] = get_seo('starinfo','title',$row);
            $data['keywords'] = get_seo('starinfo','keywords',$row);
            $data['description'] = get_seo('starinfo','description',$row);
            //增加人气
            $this->mydb->get_update('star',array('hits'=>$row['hits']+1),$row['id']);
            //输出
            $this->load->view('head.tpl',$data);
            $this->load->view('star-info.tpl');
            $this->load->view('bottom.tpl');
            $this->caches->end();
        }
    }
}
