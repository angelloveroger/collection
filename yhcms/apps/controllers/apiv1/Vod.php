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
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//主页
	public function index() {
		//公告
		$data['notice'] = $this->myconfig['notice'];
		//广告
		$data['ads'] = array('start'=>array(),'banner'=>array(),'heng'=>array());
		//分类
		$data['type'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',20);
		//显示字段
		$field = 'id,name,pic,picx,actor,year,state,score,pay';
		//幻灯图
		$list = array(
			array('query'=>array(),'name'=>'幻灯图','vod'=>$this->mydb->get_select('vod',array('reco'=>1),$field,'rhits desc',6)),
			array('query'=>array('tid'=>1,'sort'=>'rhits'),'name'=>'热门推荐','vod'=>$this->mydb->get_select('vod',array('tid'=>1),$field,'rhits desc',6)),
			array('query'=>array('sort'=>'zhits'),'name'=>'本周热播','vod'=>$this->mydb->get_select('vod','',$field,'zhits desc',6)),
		);
		//栏目数据
		$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',10);
		foreach ($class as $row) {
			$cids = get_cid($row['id']);
			$where = array('cid'=>$cids);
			$list[] = array('query'=>array('cid'=>$row['id']),'name'=>'最新'.$row['name'],'vod'=>$this->mydb->get_select('vod',$where,$field,'addtime desc',6));
		}
		$data['list'] = $list;
		//输出
		get_json($data);
	}

	//获取分类
	public function classify(){
		//分类
		$data['list'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',20);
		//输出
		get_json($data);
	}

	//一级分类
	public function lists() {
		$cid = (int)get_post('cid');
		if($cid == 0) get_json('CID参数错误',0);
		//公告
		$data['notice'] = $this->myconfig['notice'];
		//广告
		$data['ads'] = array('start'=>array(),'banner'=>array(),'heng'=>array());
		//分类
		$class = $this->mydb->get_select('class',array('fid'=>$cid),'id,name','xid asc',20);
		//数据
		$list = array();
		$cids = get_cid($cid);
		$where = array('cid'=>$cids);
		$field = 'id,name,pic,picx,actor,year,state,score,pay';
		$list[] = array('query'=>array(),'name'=>'幻灯图','vod'=>$this->mydb->get_select('vod',array('reco'=>1,'cid'=>$cids),'id,name,pic,picx','rhits desc',6));
		$list[] = array('query'=>array('cid'=>$cid,'sort'=>'zhits'),'name' =>'本周热播','vod'=>$this->mydb->get_select('vod',$where,$field,'addtime desc',6));
		if(empty($class)){
			$list[] = array('query'=>array('cid'=>$cid,'sort'=>'addtime'),'name'=>'近期更新','vod'=>$this->mydb->get_select('vod',$where,$field,'addtime desc',6));
			$list[] = array('query'=>array('cid'=>$cid,'sort'=>'shits'),'name'=>'最受欢迎','vod'=>$this->mydb->get_select('vod',$where,$field,'shits desc',6));
			$list[] = array('query'=>array('cid'=>$cid,'sort'=>'hits'),'name'=>'热播视频','vod'=>$this->mydb->get_select('vod',$where,$field,'hits desc',6));
		}else{
			foreach ($class as $row) {
				$list[] = array('query'=>array('cid'=>$row['id']),'name'=>$row['name'],'vod'=>$this->mydb->get_select('vod',array('cid'=>$row['id']),$field,'addtime desc',6));
			}
		}
		$data['list'] = $list;
		get_json($data);
	}

	//分类参数
	public function type() {
		$cid = (int)get_post('cid');
		if($cid == 0) get_json('CID参数错误',0);
		$fid = (int)getzd('class','fid',$cid);
		if($fid > 0) $cid = $fid;
		$data['nav'] = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',20);
		$data['type'] = $this->mydb->get_select('class',array('fid'=>$cid),'id,fid,name','xid asc',50);
		$data['lang'] = $this->myconfig['lang'];
		$data['area'] = $this->myconfig['area'];
		$data['letter'] = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0-9');
		//年份
		$year = array();
		for($y=date('Y');$y>2001;$y--) $year[] = $y.'';
		$data['year'] = $year;
		get_json($data);
	}

	//自定义获取视频
	public function data(){
		$fid = (int)get_post('fid'); //大类ID
		$cid = (int)get_post('cid'); //小类ID
		$tid = (int)get_post('tid'); //是否推荐，1是
		$year = (int)get_post('year'); //年份
		$area = safe_replace(get_post('area')); //地区
		$lang = safe_replace(get_post('lang')); //语言
		$key = safe_replace(get_post('key',true)); //搜索关键词
		$zm = get_post('zm',true); //字母
		$sort = trim(get_post('sort',true)); //排序方式
		$size = (int)get_post('size'); //每页数量
		$page = (int)get_post('page'); //当前页数
		if($size == 0 || $size > 100) $size = 30;
		if($page == 0) $page = 1;
		$sarr = array('addtime','hits','yhits','zhits','rhits','dhits','shits','score');
		if(!in_array($sort, $sarr)) $sort = 'addtime';
		$zmarr = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

		$wh = array();
		if($fid > 0){
    		if($cid > 0){
    		    $wh[] = 'cid='.$cid;
    		}else{
    		    $cids = get_cid($fid);
	            $wh[] = is_numeric($cids) ? 'cid='.$cids : 'cid in('.$cids.')';
    		}
		}elseif($cid > 0){
		    $cids = get_cid($cid);
	        $wh[] = is_numeric($cids) ? 'cid='.$cids : 'cid in('.$cids.')';
		}
		if($tid > 0) $wh[] = 'tid=1';
		if($year > 0) $wh[] = 'year='.$year;
		if(!empty($lang) && $lang != '全部') $wh[] = "lang='".$lang."'";
		if(!empty($area) && $area != '全部') $wh[] = "area='".$area."'";
		if(!empty($key)) $wh[] = "(LOCATE('".$key."',name) > 0 or LOCATE('".$key."',director) > 0 or LOCATE('".$key."',actor) > 0)";
		if(!empty($zm) && $zm != '全部'){
			$zimu_arr1 = array(-20319,-20283,-19775,-19218,-18710,-18526,-18239,-17922,-1,-17417,-16474,-16212,-15640,-15165,-14922,-14914,-14630,-14149,-14090,-13318,-1,-1,-12838,-12556,-11847,-11055);
			$zimu_arr2 = array(-20284,-19776,-19219,-18711  ,-18527,-18240,-17923,-17418,-1,-16475,-16213,-15641,-15166,-14923,-14915,-14631,-14150,-14091,-13319,-12839,-1,-1,-12557,-11848,-11056,-2050);
            if(!in_array(strtoupper($zm),$zmarr)){
			     $wh[] = "substring(name,1,1) NOT REGEXP '^[a-zA-Z]' and substring(name,1,1) REGEXP '^[u4e00-u9fa5]'";
			}else{
                 $index = array_keys($zmarr,strtoupper($zm))[0];
                 $wh[] = "(((ord(substring(convert(name USING gbk),1,1))-65536>=".($zimu_arr1[$index])." and  ord( substring(convert(name USING gbk),1,1))-65536<=".($zimu_arr2[$index]).")) or UPPER(substring(convert(name USING gbk),1,1))='".$zimu_arr[$index]."')";
			}
		}
		//组装SQL
		$sql = 'SELECT id,name,pic,actor,year,state,score,hits,`text`,pay FROM '._DBPREFIX_.'vod';
		if(!empty($wh)) $sql .= ' WHERE '.implode(' and ', $wh);
		//总数量
		$nums = $this->mydb->get_sql_nums($sql);
		//总页数
		$pagejs = ceil($nums / $size);
		if($pagejs == 0) $pagejs = 1;
		//偏移量
		$limit = $size*($page-1).','.$size;
		$sql .= ' ORDER BY '.$sort.' DESC LIMIT '.$limit;
		$vod = $this->mydb->get_sql($sql);
		//输出
		$data['nums'] = $nums;
		$data['page'] = $page;
		$data['pagejs'] = $pagejs;
		$data['list'] = $vod;
		get_json($data);
	}

	//搜索页面
	public function search() {
		$page = (int)get_post('page');
		if($page == 0) $page = 1;
		$size = 6;
		//热搜词
		$data['hot'] = $this->mydb->get_select('vod',array(),'id,name','sohits desc',10);
		//猜你喜欢
		$cids = array();
		if($this->uid > 0){
			$read = $this->mydb->get_select('watch',array('uid'=>$this->uid),'cid','cid desc',10,'','cid');
			foreach ($read as $row) {
				$cids[] = $row['cid'];
			}
		}
		$where = empty($cids) ? array() : array('cid'=>implode(',',$cids));
		//偏移量
		$limit = array($size,$size*($page-1));
		$data['love'] = $this->mydb->get_select('vod',$where,'id,pic,name,state,pay','rhits desc',$limit);
		get_json($data);
	}

	//视频详情
	public function info(){
		$search = (int)get_post('search');
		$id = (int)get_post('id');
		$row = $this->mydb->get_row('vod',array('id'=>$id));
		if(!$row) get_json('视频不存在',0);
		$row['fid'] = (int)getzd('class','fid',$row['cid']);
		if($row['fid'] == 0) $row['fid'] = $row['cid'];
		//判断收藏
		$row['fav'] = 0;
		//判断下载
		$row['down'] = 0;
		//试看规则
		$row['proved'] = $this->myconfig['proved'];
		//播放记录
		$row['watch'] = (object)array();
		//广告
		$row['ads'] = array('player'=>array(),'heng'=>array());
		$user = get_islog('id,cion,vip');
		if($user){
			$rowf = $this->mydb->get_row('fav',array('vid'=>$id,'uid'=>$this->uid));
			if($rowf) $row['fav'] = 1;
			$watch = $this->mydb->get_row('watch',array('vid'=>$id,'uid'=>$this->uid),'zid,jid,duration');
			if(isset($watch['duration'])) $watch['duration'] = (int)$watch['duration'];
			if($watch) $row['watch'] = $watch;
			if($user['vip'] == 1){
				$row['down'] = 1;
			}
		}else{
			$user = array('id'=>0,'cion'=>0,'vip'=>0);
		}
		//播放组
		$play = array();
		$sql = 'SELECT a.id,a.xid,b.name,b.type,b.jxurl FROM '._DBPREFIX_.'vod_zu a left join '._DBPREFIX_.'player b ON a.pid=b.id WHERE a.vid='.$id.' AND b.yid=0 ORDER BY xid ASC LIMIT 100';
		$zu = $this->mydb->get_sql($sql);
		foreach ($zu as $k => $v) {
			$play[$k]['id'] = $v['id'];
			$play[$k]['name'] = $v['name'];
			$play[$k]['type'] = $v['type'];
			$ji = $this->mydb->get_select('vod_ji',array('zid'=>$v['id']),'id,name,playurl,pay,cion','xid asc',1000);
			if(empty($v['jxurl'])) $v['jxurl'] = $this->myconfig['jxurl'];
			$play[$k]['ji'] = get_player_url($ji,$v['type'],$v['jxurl'],$user,1);
		}
		$row['play'] = $play;
		//分享地址
		$row['share_text'] = $this->myconfig['sharetxt'];
		$row['share_url'] = get_share_url($this->uid,$id);
		$row['jxtoken'] = $this->myconfig['jxtoken'];
		//用户
		$row['user'] = $user;
		//猜你喜欢，根据前5个主演来获取
		$actor_arr = explode(',',str_replace(array('、','/','，',' '),',',$row['actor']));
		$row['starlist'] = $this->mydb->get_sql("SELECT id,cid,name,pic,constellation FROM "._DBPREFIX_."star where FIND_IN_SET(name,'".implode(',',$actor_arr)."') order by hits LIMIT 30");
		$wh = array();
		foreach ($actor_arr as $k=>$v){
			$wh[] = "actor like '%".$v."%'";
			if($k > 5) break;
		}
		$sql = "select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where (".implode(' or ',$wh).") and id NOT IN(".$id.") order by rhits desc limit 20";
		$row['lovelist'] = $this->mydb->get_sql($sql);
		if(count($row['lovelist']) < 5) $row['lovelist'] = $this->mydb->get_sql("select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where cid=".$row['cid']." and id NOT IN(".$id.") order by rhits desc limit 20");
		//增加人气
		$edit = array('hits'=>$row['hits']+1,'rhits'=>$row['rhits']+1,'zhits'=>$row['zhits']+1,'yhits'=>$row['yhits']+1);
		if($search > 0) $edit['sohits'] = $row['sohits']+1;
		$this->mydb->get_update('vod',$edit,$row['id']);
		unset($row['zyid'],$row['up'],$row['rhits'],$row['zhits'],$row['yhits'],$row['dhits'],$row['shits'],$row['sohits']);
		get_json($row);
	}

	//猜你喜欢更多
	public function love(){
		$id = (int)get_post('id');
		$page = (int)get_post('page');
		if($page == 0) $page = 1;
		$row = $this->mydb->get_row('vod',array('id'=>$id),'actor');
		if(!$row) get_json('视频不存在',0);
		//猜你喜欢，根据前5个主演来获取
		$actor_arr = explode(',',str_replace(array('、','/','，',' '),',',$row['actor']));
		$wh = array();
		foreach ($actor_arr as $k=>$v){
			$wh[] = "actor like '%".$v."%'";
			if($k > 5) break;
		}
		$sql = "select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where (".implode(' or ',$wh).") and id NOT IN(".$id.") order by rhits desc limit ".(($page-1)*20).",20";
		$row['lovelist'] = $this->mydb->get_sql($sql);
		if(count($row['lovelist']) < 5) $row['lovelist'] = $this->mydb->get_sql("select id,name,pic,actor,state,score,hits,pay from "._DBPREFIX_."vod where cid=".$row['cid']." and id NOT IN(".$id.") order by rhits desc limit ".(($page-1)*20).",20");
		//输出
		$d['list'] = $row['lovelist'];
		get_json($d,1);
	}

	//购买点播视频
	public function buy(){
		$id = (int)get_post('id');
		if($id == 0) get_json('集数ID为空',0);
		$user = get_islog('id,cion',1);//判断登录
		$row = $this->mydb->get_row('vod_ji',array('id'=>$id));
		if(!$row) get_json('集数不存在',0);
		//判断是否购买
		$rowp = $this->mydb->get_row('user_vod_buy',array('jid'=>$id,'uid'=>$user['id']));
		if($rowp) get_json('已购买');
		//判断金币数量
		if($user['cion'] < $row['cion']) get_json('金币不足，去做任务赚取金币吧',0);
		//扣除金币
		$this->mydb->get_update('user',array('cion'=>$user['cion']-$row['cion']),$this->uid);
		//写入购买记录
		$this->mydb->get_insert('user_vod_buy',array(
			'vid' => $row['vid'],
			'zid' => $row['zid'],
			'jid' => $row['id'],
			'uid' => $user['id'],
			'cion' => $row['cion'],
			'addtime' => time()
		));
		//写入兑换记录
		$this->mydb->get_insert('user_cion_list',array(
			'cid' => 2,
			'uid' => $user['id'],
			'cion' => $row['cion'],
			'text' => '购买视频《'.getzd('vod','name',$row['vid']).'》-'.$row['name'],
			'addtime' => time()
		));
		get_json('购买成功');
	}
}