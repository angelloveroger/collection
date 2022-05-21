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

class Feedback extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		//判断签名
		$this->app->is_sign();
		//用户ID
		$this->uid = (int)sys_auth(get_post('user_token'),1);
		$this->user = get_islog('*',1);//判断登录
	}

	//反馈列表
	public function index() {
		$size = (int)get_post('size');
		$page = (int)get_post('page');
		if($size == 0) $size = 15;
		if($page == 0) $page = 1;

		//查询条件
		$where = array('uid'=>$this->uid);
		//总数量
	    $nums = $this->mydb->get_nums('feedback',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    //if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('feedback',$where,'id,text,reply_time,addtime','id DESC',$limit);
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		get_json($data);
	}

	//反馈类型
	public function type() {
		$data['list'] = $this->myconfig['feedback'];
		get_json($data);
	}

	//反馈详情
	public function info() {
		$id = (int)get_post('id');
		if($id == 0) get_json('反馈ID为空',0);
		$row = $this->mydb->get_row('feedback',array('id'=>$id,'uid'=>$this->uid));
		if(!$row) get_json('反馈不存在',0);
		$row['pics'] = !empty($row['pics']) ? json_decode(base64_decode($row['pics'])) : array();
		$row['reply_time'] = $row['reply_time'];
		unset($row['id'],$row['uid']);
		get_json($row);
	}

	//提交
	public function send() {
		$type = get_post('type',true);
		$text = get_post('text',true);
		$pics = get_post('pics',true);
		if(empty($type)) get_json('请选择反馈类型',0);
		if(empty($text)) get_json('请填写反馈内容',0);
		//判断灌水
		$row = $this->mydb->get_row('feedback',array('uid'=>$this->uid),'addtime','addtime desc');
		if($row && $row['addtime']+60 > time()) get_json('请勿灌水',0);
        //判断上传图片
		if(!empty($pics)){
			$pics = base64_encode(json_encode(explode(',',$pics)));
		}
		//写入
		$this->mydb->get_insert('feedback',array(
			'type' => $type,
			'uid' => $this->uid,
			'pics' => $pics,
			'text' => $text,
			'addtime' => time()
		));
		get_json('感谢您的反馈');
	}

	//上传图片
	public function uppic() {
		$pic = get_uppic('feedback','file');
		$data['pic_path'] = $pic;
		get_json($data);
	}
}