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

class Myopia extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//自定义获取视频
	public function data(){
		$cid = (int)get_post('cid'); //分类ID
		$tid = (int)get_post('tid'); //是否推荐，1是
		$key = safe_replace(get_post('key',true)); //搜索关键词
		$sort = trim(get_post('sort',true)); //排序方式
		$size = (int)get_post('size'); //每页数量
		$page = (int)get_post('page'); //当前页数
		if($size == 0 || $size > 100) $size = 20;
		if($page == 0) $page = 1;
		$sarr = array('addtime','hits','zan','share');
		if(!in_array($sort, $sarr)) $sort = 'px DESC,addtime';

		$wh = array();
		$wh[] = 'yid=0';
		if($cid > 0) $wh[] = 'cid='.(int)$cid;
		if($tid > 0) $wh[] = 'tid=1';
		if(!empty($key)) $wh[] = "(LOCATE('".$key."',text) > 0 or LOCATE('".$key."',nickname) > 0)";
		//组装SQL
		$sql = 'SELECT * FROM '._DBPREFIX_.'myopia';
		if(!empty($wh)) $sql .= ' WHERE '.implode(' and ', $wh);
		//总数量
		$nums = $this->mydb->get_sql_nums($sql);
		//总页数
		$pagejs = ceil($nums / $size);
		if($pagejs == 0) $pagejs = 1;
		//偏移量
		$limit = $size*($page-1).','.$size;
		//人气权重
		$order_calc = '*,(zan+share+hits+tid+addtime) as px';
		$sql = str_replace('*',$order_calc,$sql);
		$sql .= ' ORDER BY '.$sort.' DESC LIMIT '.$limit;
		$vod = $this->mydb->get_sql($sql);
		foreach ($vod as $k => $v) {
			//是否赞过
			$vod[$k]['is_zan'] = 0;
			if($this->uid > 0){
				$rowz = $this->mydb->get_row('myopia_zan',array('did'=>$v['id'],'uid'=>$this->uid),'id');
				if($rowz) $vod[$k]['is_zan'] = 1;
			}
			$vod[$k]['comment_num'] = $this->mydb->get_nums('comment',array('did'=>$v['id'],'yid'=>0));
			$vod[$k]['share_num'] = $v['share'];
			$vod[$k]['share_url'] = $v['text']."\r\n".get_share_url($this->uid,$v['id'],'myopia');
			unset($vod[$k]['cid'],$vod[$k]['px'],$vod[$k]['share'],$vod[$k]['uid'],$vod[$k]['yid'],$vod[$k]['pay'],$vod[$k]['cion'],$vod[$k]['tid'],$vod[$k]['md5']);
		}
		//打乱数组
		shuffle($vod);
		//输出
		$data['nums'] = $nums;
		$data['page'] = $page;
		$data['pagejs'] = $pagejs;
		$data['list'] = $vod;
		get_json($data);
	}

	//获取视频详情
	public function info(){
		$id = (int)get_post('id');
		if($id == 0) get_json('短视频ID为空',0);
		$row = $this->mydb->get_row('myopia',array('id'=>$id));
		if(!$row) get_json('数据不存在',0);
		//是否赞过
		$row['is_zan'] = 0;
		if($this->uid > 0){
			$rowz = $this->mydb->get_row('myopia_zan',array('did'=>$row['id'],'uid'=>$this->uid),'id');
			if($rowz) $row['is_zan'] = 1;
		}
		$row['comment_num'] = $this->mydb->get_nums('comment',array('did'=>$row['id'],'yid'=>0));
		$row['share_num'] = $row['share'];
		$row['share_url'] = $row['text']."\r\n".get_share_url($this->uid,$row['id'],'myopia');
		unset($row['cid'],$row['px'],$row['share'],$row['uid'],$row['yid'],$row['pay'],$row['cion'],$row['tid'],$row['md5']);
		get_json($row);
	}

	//提交分享次数
	public function share(){
		$id = (int)get_post('id');
		if($id > 0){
			$row = $this->mydb->get_row('myopia',array('id'=>$id),'share');
			if($row){
				$this->mydb->get_update('myopia',array('share'=>$row['share']+1),$id);
			}
		} 
		get_json('提交成功',1);
	}

	//提交播放次数
	public function hits(){
		$id = (int)get_post('id');
		if($id > 0){
			$row = $this->mydb->get_row('myopia',array('id'=>$id),'hits');
			if($row){
				$this->mydb->get_update('myopia',array('hits'=>$row['hits']+1),$id);
			}
		} 
		get_json('提交成功',1);
	}

	//无法播放上报
	public function error(){
		$id = (int)get_post('id');
		if($id > 0){
			$row = $this->mydb->get_row('myopia',array('id'=>$id),'type,md5');
			if($row){
				$this->mydb->get_del('myopia',$id);
				geturl('http:'.base64decode(APIURL).'myopia/errurl?vid='.$row['md5']);
			}
		} 
		get_json('提交成功',1);
	}
}