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

class Comment extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog(1);
	}

	public function index($page=1){
		$page = (int)$page;
		if($page == 0) $page = 1;
		$size = 20;
        $data = $this->user;
		//seo
		$data['title'] = '我的评论 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//查询条件
		$where = array('uid'=>$this->user['id'],'fid'=>0);
		//总数量
	    $nums = $this->mydb->get_nums('comment',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($pagejs == 0) $pagejs = 1;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('comment',$where,'id,vid,uid,text,zan,addtime','id DESC',$limit);
		$list = $this->data_replace($list);
		foreach ($list as $k => $v) {
		    $list[$k]['reply_num'] = $this->mydb->get_nums('comment',array('fid'=>$v['id'],'yid'=>0));
			$list[$k]['reply'] = $this->data_replace($this->mydb->get_select('comment',array('fid'=>$v['id']),'id,uid,text,zan,addtime','id desc',3));
			$list[$k]['vname'] = getzd('vod','name',$v['vid']);
			$list[$k]['vlink'] = links('info',$v['vid']);
		}
		$data['comment'] = $list;
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
        $data['op'] = 'comment';
        if($page > 1 && defined('IS_WAP')) get_json($data);

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/top.tpl');
		$this->load->view('user/comment.tpl');
		$this->load->view('bottom.tpl');
	}

	//数据替换
	private function data_replace($arr) {
		foreach ($arr as $k => $v) {
		    $arr[$k]['text'] = emoji_replace($v['text'],1);
			$arr[$k]['addtime'] = datetime($v['addtime']);
			$row = $this->mydb->get_row('user',array('id'=>$v['uid']),'nickname,pic');
			$arr[$k]['nickname'] = $row ? $row['nickname'] : '佚名';
			$arr[$k]['upic'] = $row ? getpic($row['pic'],'user') : getpic('','user');
			//检测是否赞过
			$arr[$k]['is_zan'] = 0;
			$arr[$k]['is_del'] = $this->user['id'] == $v['uid'] ? 1 : 0;
		    $rowz = $this->mydb->get_row('comment_zan',array('did'=>$v['id'],'uid'=>$this->user['id']),'id');
		    if($rowz) $arr[$k]['is_zan'] = 1;
		}
		return $arr;
	}
}