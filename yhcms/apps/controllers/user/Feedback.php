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
		$this->user = get_web_islog(1);
	}

	public function index(){
		//seo
		$data['title'] = '我要反馈 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		$data['list'] = $this->myconfig['feedback'];

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/feedback.tpl');
		$this->load->view('bottom.tpl');
	}

	//反馈列表
	public function my() {
		//查询条件
		$where = array('uid'=>$this->uid);
		$data['list'] = $this->mydb->get_select('feedback',$where,'id,text,reply_time,addtime','id DESC',100);

		//seo
		$data['title'] = '我的反馈 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/feedback-my.tpl');
		$this->load->view('bottom.tpl');
	}

	//反馈详情
	public function info($id=0) {
		$id = (int)$id;
		if($id == 0) error('反馈ID为空');
		$row = $this->mydb->get_row('feedback',array('id'=>$id,'uid'=>$this->uid));
		if(!$row) error('反馈不存在',0);
		$row['pics'] = !empty($row['pics']) ? json_decode(base64_decode($row['pics']),1) : array();
		$data = $row;
		//seo
		$data['title'] = '反馈详情 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');
		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/feedback-info.tpl');
		$this->load->view('bottom.tpl');
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