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

class Info extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index($vid=0){
		$vid = (int)$vid;
        if($vid == 0) error('视频不存在',404);
        if(!$this->caches->start('vod-info-'.$vid,$this->myconfig['caches']['time']['info'])){
	        $row = $this->mydb->get_row('vod',array('id'=>$vid));
	        if(!$row) error('视频不存在',404);
	        $rowc = $this->mydb->get_row('class',array('id'=>$row['cid']));
	        $row['cname'] = $rowc['name'];
	        $row['fid'] = $rowc['fid'] > 0 ? $rowc['fid'] : $row['cid'];
	        $data = $row;
			//seo
			$data['title'] = get_seo('info','title',$row);
			$data['keywords'] = get_seo('info','keywords',$row);
			$data['description'] = get_seo('info','description',$row);
	        $data['actor_arr'] = explode(',',str_replace(array('、','/','，',' '),',',$row['actor']));
	        $data['director_arr'] = explode(',',str_replace(array('、','/','，',' '),',',$row['director']));
			//播放组
			$play = array();
			$sql = 'SELECT a.id,b.name,b.type,b.jxurl,b.xid FROM '._DBPREFIX_.'vod_zu a left join '._DBPREFIX_.'player b ON a.pid=b.id WHERE a.vid='.$vid.' AND b.yid=0 ORDER BY b.xid ASC LIMIT 100';
			$zu = $this->mydb->get_sql($sql);
			foreach ($zu as $k => $v) {
				$play[$k]['id'] = $v['id'];
				$play[$k]['name'] = $v['name'];
				$play[$k]['type'] = $v['type'];
				$play[$k]['ji'] = $this->mydb->get_select('vod_ji',array('zid'=>$v['id']),'id,name,pay,cion','xid asc',1000);
			}
			$data['play'] = $play;
			$data['fav'] = 0;
			//按断是否收藏
			$user = get_web_islog();
			$data['uid'] = 0;
			if($user){
				$data['uid'] = $user['id'];
				$rowf = $this->mydb->get_row('fav',array('vid'=>$vid,'uid'=>$user['id']));
				if($rowf) $data['fav'] = 1;
			}
			//猜你喜欢，根据前5个主演来获取
			$wh = array();
			foreach ($data['actor_arr'] as $k=>$v){
				$wh[] = "LOCATE('".$v."',actor) > 0";
				if($k > 5) break;
			}
			if(empty($wh)){
				$sql = "select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where cid=".$row['cid']." order by rhits desc limit 10";
			}else{
				$sql = "select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where (".implode(' or ',$wh).") order by rhits desc limit 10";
			}
			$data['love'] = $this->mydb->get_sql($sql);
			//输出
			$this->load->view('head.tpl',$data);
			$this->load->view('info.tpl');
			$this->load->view('bottom.tpl');
			$this->caches->end();
		}
	}
}