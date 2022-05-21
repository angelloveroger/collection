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

class Star extends My_Controller {
	
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
 	    	$kstime = get_post('kstime',true);
 	    	$jstime = get_post('jstime',true);
			$order = get_post('order',true);
	        if($page==0) $page=1;
	        $oarr = array('id','addtime','hits');
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
	        	$where['cid'] = get_cid($cid,'star_class');
	        }
	        //总数量
		    $total = $this->mydb->get_nums('star',$where,$like);
			//总页数
		    $pagejs = ceil($total / $per_page);
		    if($pagejs == 0) $pagejs = 1;
		    if($page > $pagejs) $page = $pagejs;
		    $limit = array($per_page,$per_page*($page-1));
		    $list = $this->mydb->get_select('star',$where,'*',$order.' desc',$limit,$like);
		    foreach($list as $k=>$v){
		    	$list[$k]['addtime'] = date('Y-m-d H:i:s',$v['addtime']);
		    	if(date('Y-m-d',$v['addtime']) == date('Y-m-d')) $list[$k]['addtime'] = '<font color=red>'.$list[$k]['addtime'].'</font>';
				$list[$k]['pic'] = getpic($v['pic']);
				$list[$k]['hits'] = get_wan($v['hits']);
				$list[$k]['cname'] = getzd('star_class','name',$v['cid']);
		    }
	        //记录数组
	        $data['count'] = $total;
	        $data['data'] = $list;
			get_json($data,0);
		}else{
			$data['class'] = $this->mydb->get_select('star_class',array('fid'=>0),'id,name','xid asc',50);
			$this->load->view('star/index.tpl',$data);
		}
	}

	//状态
	public function init() {
		$id = get_post('id',true);
		$tid = (int)get_post('tid');
		if(is_array($id)) $id = implode(',',$id);
		$edit['tid'] = $tid;
		$this->mydb->get_update('star',$edit,$id);
		get_json('操作成功',1);
	}

	//修改
	public function edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$vod = array('id' => 0,'cid' => 0,'tid' => 0,'name' => '','pic' => '','yname' => '','weight' => '','height' => '','alias' => '','nationality'=>'','ethnic' => '','professional' => '','blood_type' => '','birthday' => '','city'=>'','constellation'=>'','company'=>'','production'=>'','academy'=>'','hits' => 0,'text'=>'','hits'=>0);
		}else{
			$vod = $this->mydb->get_row('star',array('id'=>$id));
			if(!$vod) error('演员不存在');
		}
		$vod['class'] = $this->mydb->get_select('star_class',array('fid'=>0),'id,name','xid asc',50);
		//输出
		$this->load->view('star/edit.tpl',$vod);
	}

	//入库
	public function save() {
		$id = (int)get_post('id');
		$zu = get_post('zu',true);
		$edit = array(
			'cid' => (int)get_post('cid'),
			'tid' => (int)get_post('tid'),
			'name' => get_post('name',true),
			'pic' => get_post('pic',true),
			'yname' => get_post('yname',true),
			'weight' => get_post('weight',true),
			'height' => get_post('height',true),
			'alias' => get_post('alias',true),
			'nationality'=> get_post('nationality',true),
			'ethnic' => get_post('ethnic',true),
			'professional' => get_post('professional',true),
			'blood_type' => get_post('blood_type',true),
			'birthday' => get_post('birthday',true),
			'city' => get_post('city',true),
			'constellation' => get_post('constellation',true),
			'company' => get_post('company',true),
			'production' => get_post('production',true),
			'academy' => get_post('academy',true),
			'hits' => (int)get_post('hits'),
			'text'=> get_post('text',true)
		);
		if($edit['cid'] == 0) get_json('请选择演员分类',0);
		if(empty($edit['name'])) get_json('请填写演员名称',0);
		//判断新增
		if($id == 0){
			$edit['addtime'] = time();
			$id = $this->mydb->get_insert('star',$edit);
			if(!$id) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('star',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//演员删除
	public function del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('star',$id);
		get_json('删除成功');
	}

	//转移分类
	public function transfer(){
		$id = (int)get_post('id');
		$cid = (int)get_post('cid');
		$this->mydb->get_update('star',array('cid'=>$cid),$id);
		get_json(array('msg'=>'转移成功','name'=>getzd('star_class','name',$cid)));
	}

	//分类
	public function lists(){
		$data['class'] = $this->mydb->get_select('star_class',array('fid'=>0),'*','xid asc',50);
		$this->load->view('star/lists.tpl',$data);
	}

	//修改
	public function lists_edit($id=0) {
		$id = (int)$id;
		if($id == 0){
			$data = array('id' => 0,'fid' => 0,'name' => '','xid'=>0);
		}else{
			$data = $this->mydb->get_row('star_class',array('id'=>$id));
			if(!$data) error('分类不存在');
		}
		$data['class'] = $this->mydb->get_select('star_class',array('fid'=>0),'id,name','xid asc',50);
		//输出
		$this->load->view('star/lists_edit.tpl',$data);
	}

	//入库
	public function lists_save() {
		$id = (int)get_post('id');
		$edit = array(
			'fid' => (int)get_post('fid'),
			'xid' => (int)get_post('xid'),
			'name' => get_post('name',true)
		);
		if(empty($edit['name'])) get_json('请填写分类名称',0);
		//判断新增
		if($id == 0){
			$res = $this->mydb->get_insert('star_class',$edit);
			if(!$res) get_json('入库失败',0);
		}else{
			$res = $this->mydb->get_update('star_class',$edit,$id);
			if(!$res) get_json('修改失败',0);
		}
		//输出
		$d['code'] = 1;
		$d['msg'] = '操作成功';
		$d['parent'] = 1;
		get_json($d,1);
	}

	//批量修改
	public function lists_update() {
		$ids = get_post('ids',true);
		if(empty($ids)) get_json('请选择要修改的数据',0);
		foreach ($ids as $_id) {
			$_id = (int)$_id;
			if($_id > 0){
				$edit = array();
				$edit['name'] = get_post('name_'.$_id,true);
				$edit['xid'] = (int)get_post('xid_'.$_id);
				$this->mydb->get_update('star_class',$edit,$_id);
			}
		}
		get_json('更新成功',1);
	}

	//删除
	public function lists_del(){
		$id = get_post('id',true);
		if(is_array($id)) $id = implode(',',$id);
		$this->mydb->get_del('star_class',$id);
		$this->mydb->get_del('star_class',$id,'fid');
		get_json('删除成功');
	}

	//一键同步远程图片
	public function tongbu(){
		echo '<link rel="stylesheet" href="/packs/admin/css/style.css"><style>p{padding:2px 0;}</style><body style="padding:20px;">';
		$sql = "SELECT id,pic FROM "._DBPREFIX_."star where Lower(Left(pic,7))='http://' or Lower(Left(pic,8))='https://' or Lower(Left(pic,2))='//' order by id asc limit 15";
		$arr = $this->mydb->get_sql($sql);
		if(empty($arr)){
			echo "<p><b style='color:#080;'>所有图片全部同步完成...</b></p><script>window.setTimeout(function(){window.location.href = '".links('star/index')."';},5000);</script>";
			exit;
		}
		$picdir = FCPATH.'annex/star/'.date('Y-m').'/'.date('d').'/';
		mkdirss($picdir); //创建文件夹
		foreach($arr as $row){
			$file_ext = strtolower(trim(substr(strrchr($row['pic'], '.'), 1)));
			$file_path = $picdir.md5($row['pic']).'.'.$file_ext;
			$img = file_get_contents($row['pic']);
			$ok = 0;
			if(!empty($img)){
				$res = file_put_contents($file_path,$img);
				if($res){
					$file_path = get_tongbu($this->myconfig,$file_path,$this);
					$this->mydb->get_update('star',array('pic'=>$file_path),$row['id']);
					$ok = 1;
				}
			}
			if($ok == 1){
				echo '<p>'.$row['pic'].'---------->同步完成</p>';
			}else{
				echo '<p style="color:#f90;">'.$row['pic'].'---------->同步失败...</p>';
			}
		}
		echo "<br><b>3秒后继续下一页......</b><script>window.setTimeout(function(){window.location.href = '".links('star/tongbu')."';},3000);</script>";
	}

	//导入默认资源
	public function daoru(){
		//删除表
		$sql = 'DROP TABLE IF EXISTS `'._DBPREFIX_.'star`';
		$this->db->query($sql);
		$sql = "CREATE TABLE `"._DBPREFIX_."star` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `cid` int(11) DEFAULT '0' COMMENT '分类ID',
		  `tid` tinyint(1) DEFAULT '0' COMMENT '是否推荐：0未，1已',
		  `name` varchar(128) DEFAULT '' COMMENT '名字',
		  `yname` varchar(128) DEFAULT '' COMMENT '英文名',
		  `pic` varchar(255) DEFAULT '' COMMENT '图片地址',
		  `weight` varchar(64) DEFAULT '' COMMENT '体重',
		  `height` varchar(64) DEFAULT '' COMMENT '身高',
		  `alias` varchar(128) DEFAULT '' COMMENT '别名',
		  `nationality` varchar(64) DEFAULT '' COMMENT '国籍',
		  `ethnic` varchar(64) DEFAULT '' COMMENT '民族',
		  `professional` varchar(128) DEFAULT '' COMMENT '职业',
		  `blood_type` varchar(20) DEFAULT '' COMMENT '血型',
		  `birthday` varchar(30) DEFAULT '' COMMENT '生日',
		  `city` varchar(64) DEFAULT '' COMMENT '地区',
		  `constellation` varchar(20) DEFAULT '' COMMENT '星座',
		  `company` varchar(128) DEFAULT '' COMMENT '经纪公司',
		  `production` varchar(255) DEFAULT '' COMMENT '代表作品',
		  `academy` varchar(255) DEFAULT '' COMMENT '毕业院校',
		  `text` text COMMENT '简介',
		  `hits` int(11) DEFAULT '0' COMMENT '人气',
		  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
		  PRIMARY KEY (`id`),
		  KEY `cid` (`cid`),
		  KEY `hits` (`hits`),
		  KEY `addtime` (`addtime`),
		  KEY `tid` (`tid`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;";
		$this->db->query($sql);
		$sql = file_get_contents("./caches/star_data.sql");
        $sql = str_replace('[dbprefix]',_DBPREFIX_,$sql);
        $sqlarr = explode(";[yhcms]",$sql);
        for($i=0;$i<count($sqlarr);$i++){
			if(!empty($sqlarr[$i])) $this->db->query($sqlarr[$i]);
        }
        get_json('导入完成',1);
	}
}