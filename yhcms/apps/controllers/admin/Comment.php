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
	 	    $yid = (int)get_post('yid');
			$zd = get_post('zd',true);
			$key = get_post('key',true);
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
 	    	$order = get_post('order',true);
			$type = get_post('type',true);
	        if($page==0) $page=1;
	        if($order != 'zan') $order = 'id';
			//每页数量
		    if($per_page > 500) $per_page = 500;
		    if($per_page == 0) $per_page = 20;

			//查询条件
		    $where = $like = array();
		    if(!empty($zd) && !empty($key)){
		    	if($zd == 'text'){
		    		$like[$zd] = $key;
		    	}else{
		    		$where[$zd] = (int)$key;
		    	}
		    }
	        if(!empty($kstime)){
	        	$where['addtime>'] = strtotime($kstime)-1;
	        }
	        if(!empty($jstime)){
	        	$where['addtime<'] = strtotime($jstime)+86401;
	        }
	        if($type == 'vid') $where['vid>'] = 0;
	        if($type == 'did') $where['did>'] = 0;
	        if($type == 'bid') $where['bid>'] = 0;
	        if($yid > 0) $where['yid'] = $yid-1;

	        //总数量
		    $total = $this->mydb->get_nums('comment',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('comment',$where,'*',$order.' desc',$limit,$like);
		    foreach ($list as $k => $v) {
		    	$list[$k]['type'] = $v['vid'] > 0 ? '视频(id:'.$v['vid'].')' : ($v['did'] > 0 ? '短视(id:'.$v['did'].')' : '帖子(id:'.$v['bid'].')');
		    	$list[$k]['text'] = emoji_replace($v['text'],1);
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$this->load->view('comment/index.tpl');
		}
	}

	//审核
	public function init() {
		$id = get_post('id',true);
		$yid = (int)get_post('yid');
		$edit['yid'] = $yid;
		//发送系统消息
		if($yid == 0){
			$ids = !is_array($id) ? array($id) : $id;
			foreach ($ids as $_id) {
				$row = $this->mydb->get_row('comment',array('id'=>$_id),'uid,text');
				$this->mydb->get_insert('user_message',array('uid'=>$row['uid'],'did'=>$_id,'text'=>'您的评论【'.$row['text'].'】已通过审核~','addtime'=>time()));
			}
		}
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_update('comment',$edit,$id);
		get_json('操作成功',1);
	}

	//删除
	public function del(){
		$id = get_post('id',true);
		//发送系统消息
		$ids = !is_array($id) ? array($id) : $id;
		foreach ($ids as $_id) {
			$row = $this->mydb->get_row('comment',array('id'=>$_id),'uid,yid,text');
			$text = $row['yid'] == 0 ? '已被删除~' : '审核不能通过~';
			$this->mydb->get_insert('user_message',array('uid'=>$row['uid'],'did'=>$_id,'text'=>'您的评论【'.$row['text'].'】'.$text,'addtime'=>time()));
		}
		if(is_array($id)) $id = implode(',',$id);
		//删除用户信息
		$this->mydb->get_del('comment',$id);
		$this->mydb->get_del('comment',$id,'fid');
		$this->mydb->get_del('comment_report',$id,'did');
		$this->mydb->get_del('comment_zan',$id,'did');
		get_json('删除成功');
	}
}