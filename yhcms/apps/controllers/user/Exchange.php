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

class Exchange extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
		$this->user = get_web_islog(1);
	}

	public function index(){
        $data = $this->user;
        $data['tel'] = get_sub($data['tel']);
		//seo
		$data['title'] = '金币兑换 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//套餐
		$data['list'] = $this->myconfig['pay']['exchange'];

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/exchange.tpl');
		$this->load->view('bottom.tpl');
	}

	public function lists(){
		$page = (int)get_post('page');;
		if($page == 0) $page = 1;

		$size = 15;
		//查询条件
		$where = array('uid'=>$this->user['id']);
		//总数量
	    $nums = $this->mydb->get_nums('user_cion_list',$where);
		//总页数
	    $pagejs = ceil($nums / $size);
	    if($page > $pagejs) $page = $pagejs;
	    if($nums < $size) $size = $nums;
	    $limit = array($size,$size*($page-1));
	    $list = $this->mydb->get_select('user_cion_list',$where,'cid,text,cion,addtime','id DESC',$limit);
	    foreach ($list as $k => $v) {
	    	$list[$k]['addtime'] = date('Y/m/d H:i:s',$v['addtime']);
	    }
        //记录数组
        $data['nums'] = $nums;
        $data['page'] = $page;
        $data['pagejs'] = $pagejs;
		$data['list'] = $list;
		if($page > 1) get_json($data);

		//seo
		$data['title'] = '兑换记录 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('user/exchange-lists.tpl');
		$this->load->view('bottom.tpl');
	}

	//兑换
	public function send() {
		$day = (int)get_post('day');
		if($day == 0) get_json('请选择兑换套餐',0);
		$cion = 0;
		foreach ($this->myconfig['pay']['exchange'] as $v) {
			if($v['day'] == $day){
				$cion = $v['cion'];
				break;
			}
		}
		if($cion == 0) get_json('套餐不存在',0);
		//判断金币数量
		if($this->user['cion'] < $cion) get_json('金币不足，去做任务赚取金币吧',0);
		//扣除金币
		$viptime = $this->user['viptime'] > time() ? $this->user['viptime']+$day*86400 :time()+$day*86400;
		$this->mydb->get_update('user',array('cion'=>$this->user['cion']-$cion,'vip'=>1,'viptime'=>$viptime),$this->user['id']);
		//写入兑换记录
		$this->mydb->get_insert('user_cion_list',array(
			'cid' => 2,
			'uid' => $this->user['id'],
			'cion' => $cion,
			'text' => '兑换'.$day.'天VIP',
			'addtime' => time()
		));
		get_json('兑换成功',1);
	}
}