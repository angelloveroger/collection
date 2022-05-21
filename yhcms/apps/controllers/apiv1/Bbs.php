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

class Bbs extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
	}

	//获取社区标签
	public function lists(){
		$data['list'] = $this->mydb->get_select('bbs_class',array('yid'=>0),'id,name,pic','xid ASC',500);
		get_json($data);
	}

	//用户主页
	public function user() {
		$uid = (int)get_post('uid');
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0 || $size > 100) $size = 15;
		if($page == 0) $page = 1;
		if($uid == 0) get_json('用户ID为空',0);
		if($page == 1){
			$user = $this->mydb->get_row('user',array('id'=>$uid),'id,nickname,pic,vip');
			if(!$user) get_json('用户不存在',0);
			unset($user['pass'],$user['channel'],$user['deviceid'],$user['addtime'],$user['logtime'],$user['qdnum'],$user['qdznum'],$user['qddate']);
			//是否关注
			$user['is_funco'] = 0;
			if($this->uid > 0){
				$rowf = $this->mydb->get_row('user_fans',array('uid'=>$uid,'fuid'=>$this->uid),'id');
				if($rowf) $user['is_funco'] = 1;
			}
			$user['fans_nums'] = $this->mydb->get_nums('user_fans',array('uid'=>$uid));
			$user['funco_nums'] = $this->mydb->get_nums('user_fans',array('fuid'=>$uid));
			$user['zan_nums'] = $this->mydb->get_sum('bbs','zan',array('uid'=>$uid));
		}
		//帖子列表
		$where = array('uid'=>$uid,'yid'=>0);
		//总数量
	    $nums = $this->mydb->get_nums('bbs',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('bbs',$where,'id,cid,ding,name,text,zan,addtime','ding DESC,id DESC',$limit);
		foreach ($list as $k => $v) {
			$list[$k]['label'] = $this->mydb->get_row('bbs_class',array('id'=>$v['cid']),'id,name,pic');
		    $list[$k]['comment_num'] = $this->mydb->get_nums('comment',array('bid'=>$v['id'],'yid'=>0));
		    $pislist = $this->mydb->get_select('bbs_pic',array('bid'=>$v['id']),'url','id ASC',10);
		    $pics = array();
		    foreach ($pislist as $v2) $pics[] = getpic($v2['url']);
			$list[$k]['pics'] = $pics;
			//是否赞过
			$list[$k]['is_zan'] = 0;
			if($this->uid > 0){
				$rowz = $this->mydb->get_row('bbs_zan',array('did'=>$v['id'],'uid'=>$this->uid),'id');
				if($rowz) $list[$k]['is_zan'] = 1;
			}
			$list[$k]['share_url'] = $v['name']."\r\n".get_share_url($this->uid,$v['id'],'bbs');
			unset($list[$k]['cid']);
		}
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['user'] = $user;
		$data['list'] = $list;
		get_json($data);
	}

	//自定义获取
	public function data(){
		$cid = (int)get_post('cid'); //分类ID
		$reco = (int)get_post('tid'); //是否推荐，1是
		$ding = (int)get_post('ding'); //是否置顶，1是
		$key = safe_replace(get_post('key',true)); //搜索关键词
		$sort = trim(get_post('sort',true)); //排序方式
		$size = (int)get_post('size'); //每页数量
		$page = (int)get_post('page'); //当前页数
		if($size == 0 || $size > 100) $size = 20;
		if($page == 0) $page = 1;
		$sarr = array('addtime','hits','zan','share');
		if(!in_array($sort, $sarr)) $sort = 'addtime';

		$wh = array();
		$wh[] = 'yid=0';
		if($cid > 0) $wh[] = 'cid='.(int)$cid;
		if($reco > 0) $wh[] = 'reco=1';
		if($ding > 0) $wh[] = 'ding=1';
		if(!empty($key)) $wh[] = "(LOCATE('".$key."',text) > 0 or LOCATE('".$key."',nickname) > 0)";
		//组装SQL
		$sql = 'SELECT * FROM '._DBPREFIX_.'bbs';
		if(!empty($wh)) $sql .= ' WHERE '.implode(' and ', $wh);
		//总数量
		$nums = $this->mydb->get_sql_nums($sql);
		//总页数
		$pagejs = ceil($nums / $size);
		if($pagejs == 0) $pagejs = 1;
		//偏移量
		$limit = $size*($page-1).','.$size;
		$sql .= ' ORDER BY ding DESC,'.$sort.' DESC LIMIT '.$limit;
		$list = $this->mydb->get_sql($sql);
		foreach ($list as $k => $v) {
			$list[$k]['label'] = $this->mydb->get_row('bbs_class',array('id'=>$v['cid']),'id,name,pic');
		    $list[$k]['comment_num'] = $this->mydb->get_nums('comment',array('bid'=>$v['id'],'yid'=>0));
		    $list[$k]['user'] = $this->mydb->get_row('user',array('id'=>$v['uid']),'id,nickname,pic,vip');
		    $pislist = $this->mydb->get_select('bbs_pic',array('bid'=>$v['id']),'url','id ASC',10);
		    $pics = array();
		    foreach ($pislist as $v2) $pics[] = getpic($v2['url']);
			$list[$k]['pics'] = $pics;
			//是否赞过
			$list[$k]['is_zan'] = 0;
			$list[$k]['is_funco'] = 0;
			if($this->uid > 0){
				$rowz = $this->mydb->get_row('bbs_zan',array('did'=>$v['id'],'uid'=>$this->uid),'id');
				if($rowz) $list[$k]['is_zan'] = 1;
				$rowz = $this->mydb->get_row('user_fans',array('uid'=>$v['uid'],'fuid'=>$this->uid),'id');
				if($rowz) $list[$k]['is_funco'] = 1;
			}
			$list[$k]['is_admin'] = $v['uid'] == $this->myconfig['bbs']['admin'] ? 1 : 0;
			$list[$k]['share_url'] = $v['name']."\r\n".get_share_url($this->uid,$v['id'],'bbs');
			unset($list[$k]['uid'],$list[$k]['cid']);
		}
		//输出
		$data['nums'] = $nums;
		$data['page'] = $page;
		$data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//帖子详情
	public function info(){
		$id = (int)get_post('id');
		if($id == 0) get_json('id error',0);
		$row = $this->mydb->get_row('bbs',array('id'=>$id));
		if(!$row) get_json('帖子不存在',0);
		$row['label'] = $this->mydb->get_row('bbs_class',array('id'=>$row['cid']),'id,name,pic');
	    $row['comment_num'] = $this->mydb->get_nums('comment',array('bid'=>$row['id'],'yid'=>0));
	    $row['user'] = $this->mydb->get_row('user',array('id'=>$row['uid']),'id,nickname,pic,vip');
	    $pislist = $this->mydb->get_select('bbs_pic',array('bid'=>$row['id']),'url','id ASC',10);
	    $pics = array();
	    foreach ($pislist as $row2) $pics[] = getpic($row2['url']);
		$row['pics'] = $pics;
		//是否赞过
		$row['is_zan'] = 0;
		$row['is_funco'] = 0;
		if($this->uid > 0){
			$rowz = $this->mydb->get_row('bbs_zan',array('did'=>$row['id'],'uid'=>$this->uid),'id');
			if($rowz) $row['is_zan'] = 1;
			$rowz = $this->mydb->get_row('user_fans',array('uid'=>$row['uid'],'fuid'=>$this->uid),'id');
			if($rowz) $row['is_funco'] = 1;
		}
		$row['is_admin'] = $row['uid'] == $this->myconfig['bbs']['admin'] ? 1 : 0;
		$row['share_url'] = $row['name']."\r\n".get_share_url($this->uid,$row['id'],'bbs');
		unset($row['cid'],$row['uid']);
		//增加浏览次数
		$this->mydb->get_update('bbs',array('hits'=>$row['hits']+1),$id);
		get_json($row);
	}

	//发布帖子
	public function add(){
		$this->user = get_islog('*',1);//判断登录
		$cid = (int)get_post('cid');
		$name = get_post('name',true);
		$text = get_post('text',true);
		if($cid == 0) get_json('请选择标签',0);
		if(empty($name)) get_json('标题为空',0);
		if(empty($text)) get_json('内容为空',0);
		//判断权限
		if($this->myconfig['bbs']['open'] == 0) get_json('系统已禁止发帖',0);
		if($this->myconfig['bbs']['open'] == 1){
			if(!in_array($this->uid,$this->myconfig['bbs']['uids'])) get_json('您暂无发帖权限',0);
		}
		//判断发帖数量
		if($this->myconfig['bbs']['daynum'] > 0){
	        $jtime = strtotime(date('Y-m-d 0:0:0'))-1;
	        $nums = $this->mydb->get_nums('bbs',array('uid'=>$this->uid));
	        if($nums >= $this->myconfig['bbs']['daynum']) get_json('当日发表数量上限',0);
		}
        //判断上传图片
        $picarr = array();
        if(!empty($_FILES)){
            $count = count($_FILES)+1;
            for($i=1; $i<$count; $i++){
            	$picarr[] = get_uppic('bbs','file'.$i);
            }
        }
		//入库
		$bid = (int)$this->mydb->get_insert('bbs',array(
			'cid' => $cid,
			'name' => $name,
			'text' => $text,
			'uid' => $this->uid,
			'yid' => $this->myconfig['bbs']['audit'],
			'addtime' => time()
		));
		if($bid == 0) get_json('发帖失败',0);

        //判断上传图片
        if(!empty($picarr)){
            foreach($picarr as $picurl){
                $this->mydb->get_insert('bbs_pic',array('url'=>$picurl,'bid'=>$bid,'uid'=>$this->uid,'addtime'=>time()));
            }
        }
		$msg = $this->myconfig['bbs']['audit'] == 0 ? '发布成功' : '已发布，等待审核';
		get_json($msg,1);
	}
}