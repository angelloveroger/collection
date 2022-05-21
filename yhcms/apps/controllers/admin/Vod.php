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
	
	function __construct(){
	    parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断是否登陆
		get_admin_islog();
	}

	public function index($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $cid = (int)get_post('cid');
	 	    $tid = (int)get_post('tid');
	 	    $ztid = (int)get_post('ztid');
	 	    $pay = (int)get_post('pay');
	 	    $reco = (int)get_post('reco');
	 	    $app = (int)get_post('app');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$lang = get_post('lang',true);
			$area = get_post('area',true);
			$year = (int)get_post('year');
			$order = get_post('order',true);
	        if($page==0) $page=1;
	        $oarr = array('id','addtime','hits','rhits','zhits','yhits','sohits','shits','score');
	        if(!in_array($order,$oarr)) $order = 'addtime';
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id'){
		    		$where[$zd] = (int)$key;
		    	}else{
		    		$like[$zd] = $key;
		    	}
		    }
	        if(!empty($kstime)){
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if(!empty($lang)) $where['lang'] = $lang;
	        if(!empty($area)) $where['area'] = $area;
	        if($cid > 0){
	        	$where['cid'] = get_cid($cid);
	        }
	        if($year > 0) $where['year'] = $year;
	        if($tid > 0) $where['tid'] = $tid-1;
	        if($pay > 0) $where['pay'] = $pay-1;
	        if($reco > 0) $where['reco'] = $reco-1;
	        if($app > 0) $where['app'] = $app-1;
	        if($ztid > 0) $where['ztid'] = $ztid;

	        //总数量
		    $total = $this->mydb->get_nums('vod',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('vod',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	if($v['pay'] == 2){
		    		$list[$k]['pay'] = '<font color=red>点播</font>';
		    	}elseif($v['pay'] == 1){
		    		$list[$k]['pay'] = '<font color=#1E9FFF>VIP</font>';
		    	}else{
					$list[$k]['pay'] = '免费';
		    	}
				$list[$k]['pic'] = getpic($v['pic']);
				$list[$k]['hits'] = get_wan($v['hits']);
				$list[$k]['cname'] = getzd('class','name',$v['cid']);
				$list[$k]['link'] = links('info',$v['id'],1,1);
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',50);
			$data['topic'] = $this->mydb->get_select('topic',array(),'id,name','id desc',200);
			$data['lang'] = $this->myconfig['lang'];
			$data['area'] = $this->myconfig['area'];
			$this->load->view('vod/index.tpl',$data);
		}
	}

	//重复视频
	public function repeat($op=''){
		if($op == 'json'){
			$page = (int)get_post('page');
	 	    $per_page = (int)get_post('limit');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
	 	    $cid = (int)get_post('cid');
	 	    $tid = (int)get_post('tid');
	 	    $ztid = (int)get_post('ztid');
	 	    $pay = (int)get_post('pay');
	 	    $reco = (int)get_post('reco');
	 	    $app = (int)get_post('app');
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$lang = get_post('lang',true);
			$area = get_post('area',true);
			$year = (int)get_post('year');
			$order = get_post('order',true);
	        if($page==0) $page=1;
	        $oarr = array('id','addtime','hits','rhits','zhits','yhits','sohits','shits','score');
	        if(!in_array($order,$oarr)) $order = 'addtime';
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'id'){
		    		$where[] = $zd.'='.(int)$key;
		    	}else{
		    		$where[] = $zd." like '%".$key."%'";
		    	}
		    }
	        if(!empty($kstime)){
	        	$where[] = 'addtime>'.(strtotime($kstime)-1);
	        }
	        if(!empty($jstime)){
	        	$where[] = 'addtime<'.(strtotime($jstime)+86401);
	        }
	        if(!empty($lang)) $where[] = "lang='".$lang."'";
	        if(!empty($area)) $where[] = "area='".$area."'";
	        if($cid > 0){
	        	$cids = get_cid($cid);
	        	$where[] = is_numeric($cids) ? 'cid='.$cids : 'cid in ('.$cids.')';
	        }
	        if($year > 0) $where[] = 'year='.$year;
	        if($tid > 0) $where[] = 'tid='.($tid-1);
	        if($pay > 0) $where[] = 'pay='.($pay-1);
	        if($reco > 0) $where[] = 'reco='.($reco-1);
	        if($app > 0) $where[] = 'app='.($app-1);
	        if($ztid > 0) $where[] = 'ztid='.($ztid);
	        $where[] = "name in (select name From "._DBPREFIX_."vod Group By name Having Count(*)>1)";
	       	$wh = implode(' and ',$where);

	        //总数量
	        $sql = "select * From "._DBPREFIX_."vod Where ".$wh;
	        //总数量
		    $total = $this->db->query($sql)->num_rows();
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = ($per_page*($page-1)).','.$per_page;
		    $sql .= " order by ".$order." desc limit ".$limit;
        	$list = $this->mydb->get_sql($sql,1);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    	if($v['pay'] == 2){
		    		$list[$k]['pay'] = '<font color=red>点播</font>';
		    	}elseif($v['pay'] == 1){
		    		$list[$k]['pay'] = '<font color=#1E9FFF>VIP</font>';
		    	}else{
					$list[$k]['pay'] = '免费';
		    	}
				$list[$k]['pic'] = getpic($v['pic']);
				$list[$k]['hits'] = get_wan($v['hits']);
				$list[$k]['cname'] = getzd('class','name',$v['cid']);
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',50);
			$data['topic'] = $this->mydb->get_select('topic',array(),'id,name','id desc',200);
			$data['lang'] = $this->myconfig['lang'];
			$data['area'] = $this->myconfig['area'];
			$this->load->view('vod/repeat.tpl',$data);
		}
	}

	//状态
	public function init($zd='tid') {
		if($zd != 'reco' && $zd != 'ztid' && $zd != 'app') $zd = 'tid';
		$id = get_post('id',true);
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit[$zd] = $tid;
		$this->mydb->get_update('vod',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$vod = array('id' => 0,'cid' => 0,'reco' => 0,'tid' => 0,'ztid' => 0,'name' => '','pic' => '','picx' => '','director' => '','actor' => '','tags' => '','year'=>date('Y'),'area' => '','lang' => '','state' => '','score' => rand(5,9).'.'.rand(1,9),'hits' => 0,'yhits' => 0,'zhits' => 0,'rhits' => 0,'pay'=>0,'app'=>0,'text'=>'','zu'=>array());
		}else{
			$vod = $this->mydb->get_row('vod',array('id'=>$id));
			if(!$vod) error('视频不存在');
			//播放组
			$zu = $this->mydb->get_select('vod_zu',array('vid'=>$id),'id,pid','xid asc',100);
			foreach ($zu as $k => $v) {
				$zu[$k]['ji'] = $this->mydb->get_select('vod_ji',array('zid'=>$v['id']),'*','xid asc',5000);
			}
			$vod['zu'] = $zu;
		}
		$vod['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',50);
		$vod['topic'] = $this->mydb->get_select('topic',array(),'id,name','id desc',200);
		$vod['player'] = $this->mydb->get_select('player',array(),'id,name','xid asc',200);
		$vod['lang_list'] = $this->myconfig['lang'];
		$vod['area_list'] = $this->myconfig['area'];
		//输出
		$this->load->view('vod/edit.tpl',$vod);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$zu = get_post('zu',true);
		$edit = array(
			'cid' => (int)get_post('cid'),
			'reco' => (int)get_post('reco'),
			'tid' => (int)get_post('tid'),
			'ztid' => (int)get_post('ztid'),
			'name' => get_post('name',true),
			'pic' => get_post('pic',true),
			'picx' => get_post('picx',true),
			'director' => get_post('director',true),
			'actor' => get_post('actor',true),
			'tags' => get_post('tags',true),
			'year'=> (int)get_post('year'),
			'area' => get_post('area',true),
			'lang' => get_post('lang',true),
			'state' => get_post('state',true),
			'score' => get_post('score',true),
			'hits' => (int)get_post('hits'),
			'yhits' => (int)get_post('yhits'),
			'zhits' => (int)get_post('zhits'),
			'rhits' => (int)get_post('rhits'),
			'pay'=> (int)get_post('pay'),
			'app'=> (int)get_post('app'),
			'text'=> get_post('text',true)
		);
		if($edit['cid'] == 0) get_json('请选择视频分类',0);
		if(empty($edit['name'])) get_json('请填写视频名称',0);
		//判断新增
		if($id == 0){
			$edit['addtime'] = time();
			$id = $this->mydb->get_insert('vod',$edit);
			if(!$id) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('vod',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//播放组操作
		$zuarr = $jiarr = array();
		if(!empty($zu)){
			$pay = 0;
			foreach ($zu as $k => $v) {
				//判断播放组是否存在
				$row = $this->mydb->get_row('vod_zu',array('vid'=>$id,'pid'=>$v['pid']),'id');
				if(!$row){
					$zid = $this->mydb->get_insert('vod_zu',array('vid'=>$id,'pid'=>$v['pid'],'xid'=>$k+1));
				}else{
					$zid = $row['id'];
				}
				$zuarr[] = $zid;
				if(!empty($v['ji'])){
					foreach ($v['ji'] as $k2 => $v2) {
						if($v2['pay'] == 2 && $v2['cion'] == 0) get_json('第'.($k+1).'组-第'.($k2+1).'集点播金币不能为空',0);
						if(!empty($v2['name']) && !empty($v2['playurl'])){
							if($v2['pay'] > $pay) $pay = $v2['pay'];
							if($v2['pay'] < 2) $v2['cion'] = 0;
							$xid = (int)$v2['xid'] == 0 ? $k2+1 : (int)$v2['xid'];
							$jid = (int)$v2['id'];
							if($jid == 0){
								$jid = $this->mydb->get_insert('vod_ji',array(
									'vid'=>$id,
									'pid'=>(int)$v['pid'],
									'xid'=>$xid,
									'zid'=>$zid,
									'name'=>$v2['name'],
									'pay'=>(int)$v2['pay'],
									'cion'=>(int)$v2['cion'],
									'playurl'=>$v2['playurl']
								));
							}else{
								$this->mydb->get_update('vod_ji',array(
									'pid'=>(int)$v['pid'],
									'name'=>$v2['name'],
									'xid'=>$xid,
									'pay'=>(int)$v2['pay'],
									'cion'=>(int)$v2['cion'],
									'playurl'=>$v2['playurl']
								),$jid);
							}
							$jiarr[] = $jid;
						}
					}
				}
			}
			//设置收费状态
			$this->mydb->get_update('vod',array('pay'=>$pay,'addtime'=>time()),$id);
		}
		//删除未用组
		$vzu = $this->mydb->get_select('vod_zu',array('vid'=>$id),'id','xid asc',100);
		foreach ($vzu as $k => $v) {
			if(!in_array($v['id'], $zuarr)){
				$this->mydb->get_del('vod_zu',$v['id']);
				$this->mydb->get_del('vod_ji',$v['id'],'zid');
			}
		}
		//删除未用集数
		$vji = $this->mydb->get_select('vod_ji',array('vid'=>$id),'id','xid asc',100);
		foreach ($vji as $k => $v) {
			if(!in_array($v['id'], $jiarr)){
				$this->mydb->get_del('vod_ji',$v['id']);
			}
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//视频删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('vod',$id);
		$this->mydb->get_del('vod_zu',$id,'vid');
		$this->mydb->get_del('vod_ji',$id,'vid');
		$this->mydb->get_del('fav',$id,'vid');
		$this->mydb->get_del('down',$id,'vid');
		$this->mydb->get_del('watch',$id,'vid');
		$this->mydb->get_del('comment',$id,'vid');
		$this->mydb->get_del('vod_barrage',$id,'vid');
		get_json('删除成功');
	}

	//转移分类
	public function transfer(){
		$id = (int)get_post('id');
		$cid = (int)get_post('cid');
		$this->mydb->get_update('vod',array('cid'=>$cid),$id);
		get_json(array('msg'=>'转移成功','name'=>getzd('class','name',$cid)));
	}

	//批量操作
	public function batch() {
		$data['class'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',50);
		$data['topic'] = $this->mydb->get_select('topic',array(),'id,name','id desc',200);
		$data['player'] = $this->mydb->get_select('player',array(),'id,name','xid asc',200);
		$vod['lang_list'] = $this->myconfig['lang'];
		$vod['area_list'] = $this->myconfig['area'];
		//输出
		$this->load->view('vod/batch.tpl',$data);
	}

	//批量操作入库
	public function batch_save() {
		$op = get_post('op',true);
		$cid = (int)get_post('cid');
		$ztid = (int)get_post('ztid');
		$pid = (int)get_post('pid');
		$day = (int)get_post('day');
		$vid = get_post('vid',true);
		//删除
		if($op == 'del'){
			//按播放器
			if($pid > 0){
				$list = $this->mydb->get_select('vod_zu',array('pid'=>$pid),'vid','vid asc',100,'','vid');
				foreach ($list as $row) {
					$this->mydb->get_del('vod',$row['vid']);
					$this->mydb->get_del('fav',$row['vid'],'vid');
					$this->mydb->get_del('down',$row['vid'],'vid');
					$this->mydb->get_del('watch',$row['vid'],'vid');
					$this->mydb->get_del('comment',$row['vid'],'vid');
					$this->mydb->get_del('vod_barrage',$row['vid'],'vid');
				}
				$this->mydb->get_del('vod_zu',$pid,'pid');
				$this->mydb->get_del('vod_ji',$pid,'pid');
			}elseif($cid > 0){ //按分类
				$this->mydb->get_del('vod',$cid,'cid');
			}elseif($ztid > 0){ //按专题
				$this->mydb->get_del('vod',$ztid,'ztid');
			}else{ //按时间
				$day--;
				$time = strtotime(date('Y-m-d 0:0:0'))-$day*86400-1;
				$list = $this->mydb->get_select('vod',array('addtime>'=>$time),'id','id desc',10000);
				foreach ($list as $row) {
					$this->mydb->get_del('vod',$row['id']);
					$this->mydb->get_del('vod_zu',$row['id'],'vid');
					$this->mydb->get_del('vod_ji',$row['id'],'vid');
					$this->mydb->get_del('fav',$row['id'],'vid');
					$this->mydb->get_del('down',$row['id'],'vid');
					$this->mydb->get_del('watch',$row['id'],'vid');
					$this->mydb->get_del('comment',$row['id'],'vid');
					$this->mydb->get_del('vod_barrage',$row['id'],'vid');
				}
			}
		}else{
			$farr = array('pay','lang','area','cid','ztid','tid','reco','app','year','score');
			$field = get_post('field',true);
			$val = get_post('val',true);
			$xid = (int)get_post('xid');
			$cion = (int)get_post('cion');
			if(empty($val) && $val != 0) get_json('请填写修改内容',0);
			if(!in_array($field,$farr)) get_json('非法字段',0);
			if((int)$val < 2) $cion = 0;
			//按播放器
			if($pid > 0){
				$list = $this->mydb->get_select('vod_zu',array('pid'=>$pid),'id,vid','xid asc',100,'','vid');
				foreach ($list as $row) {
					$this->mydb->get_update('vod',array($field=>$val),$row['vid']);
				}
				if($field == 'pay'){
					$this->mydb->get_update('vod_ji',array('pay'=>(int)$val,'cion'=>$cion),array('pid'=>$pid,'xid>'=>($xid-1)));
				}
			}elseif($cid > 0){ //按分类
				$this->mydb->get_update('vod',array($field=>$val),$cid,'cid');
				if($field == 'pay'){
					$list = $this->mydb->get_select('vod',array('cid'=>$cid),'id','id desc',10000);
					foreach ($list as $row) {
						$this->mydb->get_update('vod_ji',array('pay'=>(int)$val,'cion'=>$cion),array('vid'=>$row['id'],'xid>'=>($xid-1)));
					}
				}
			}elseif($ztid > 0){ //按专题
				$this->mydb->get_update('vod',array($field=>$val),$ztid,'ztid');
				if($field == 'pay'){
					$list = $this->mydb->get_select('vod',array('ztid'=>$ztid),'id','id desc',10000);
					foreach ($list as $row) {
						$this->mydb->get_update('vod_ji',array('pay'=>(int)$val,'cion'=>$cion),array('vid'=>$row['id'],'xid>'=>($xid-1)));
					}
				}
			}elseif(!empty($vid)){ //按ID
				$vid = str_replace('，',',',$vid);
				$varr = explode(',', $vid);
				foreach ($varr as $vid) {
					$vid = (int)$vid;
					if($vid > 0){
						$this->mydb->get_update('vod',array($field=>$val),$vid);
						if($field == 'pay'){
							$this->mydb->get_update('vod_ji',array('pay'=>(int)$val,'cion'=>$cion),array('vid'=>$vid,'xid>'=>($xid-1)));
						}
					}
				}
			}else{ //按时间
				$day--;
				$time = strtotime(date('Y-m-d 0:0:0'))-$day*86400-1;
				$sql = "UPDATE `yh_vod` SET `".$field."` = '".$val."' WHERE `addtime` > ".$time;
				$this->db->query($sql);
				if($field == 'pay'){
					$list = $this->mydb->get_select('vod',array('addtime>'=>$time),'id','id desc',10000);
					foreach ($list as $row) {
						$this->mydb->get_update('vod_ji',array('pay'=>(int)$val,'cion'=>$cion),array('vid'=>$row['id'],'xid>'=>($xid-1)));
					}
				}
			}
		}
		get_json('操作成功',1);
	}
}