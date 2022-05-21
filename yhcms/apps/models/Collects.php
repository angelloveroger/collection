<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('BASEPATH')) exit('No direct script access allowed');
class Collects extends CI_Model{

    function __construct (){
		parent:: __construct();
	}
    //获取资源视频列表
    function vodlist($zyurl,$op='show',$pid=0){
    	$strs = geturl($zyurl);
		//数据解析
		$data = array('nums'=>0,'pagejs'=>1,'size'=>30,'page'=>1);
		//组合分页信息
		$vod = array();
		preg_match('<list page="([0-9]+)" pagecount="([0-9]+)" pagesize="([0-9]+)" recordcount="([0-9]+)">',$strs,$page_array);
		if(!empty($page_array[1])){
			$data['nums'] = $page_array[4];
			$data['pagejs'] = $page_array[2];
			$data['size'] = $page_array[3];
			$data['page'] = $page_array[1];
			//组合列表
			preg_match_all('/<video>([\s\S]*?)<\/video>/',$strs,$vod_array);
			foreach($vod_array[1] as $k=>$val){
				preg_match('/<last>([\s\S]*?)<\/last>/',$val,$times);
				preg_match('/<id>([0-9]+)<\/id>/',$val,$ids);
				preg_match('/<tid>([0-9]+)<\/tid>/',$val,$cids);
				preg_match('/<name><\!\[CDATA\[([\s\S]*?)\]\]><\/name>/',$val,$names);
				preg_match('/<type>([\s\S]*?)<\/type>/',$val,$tags);
				preg_match('/<note><\!\[CDATA\[([\s\S]*?)\]\]><\/note>/',$val,$note);

				$vod[$k]['addtime'] = $times[1];
				$vod[$k]['zyid'] = $ids[1];
				$vod[$k]['cid'] = intval($cids[1]);
				$vod[$k]['name'] = $names[1];
				$vod[$k]['state'] = $note[1];
				$vod[$k]['tags'] = $tags[1];


				//播放地址
				if($op == 'ruku'){
					preg_match('/<pic>([\s\S]*?)<\/pic>/',$val,$pic);
					preg_match('/<lang>([\s\S]*?)<\/lang>/',$val,$lang);
					preg_match('/<area>([\s\S]*?)<\/area>/',$val,$area);
					preg_match('/<year>([\s\S]*?)<\/year>/',$val,$year);
					preg_match('/<actor><\!\[CDATA\[([\s\S]*?)\]\]><\/actor>/',$val,$actor);
					preg_match('/<director><\!\[CDATA\[([\s\S]*?)\]\]><\/director>/',$val,$director);
					preg_match('/<des><\!\[CDATA\[([\s\S]*?)\]\]><\/des>/',$val,$text);

					$vod[$k]['pic'] = $pic[1];
					$vod[$k]['lang'] = $lang[1] == '汉语普通话' ? '国语' : $lang[1];
					$vod[$k]['area'] = str_replace(array('中国大陆','中国香港','中国台湾'),array('大陆','香港','台湾'),$area[1]);
					$vod[$k]['year'] = (int)$year[1] == 0 ? date('Y') : (int)$year[1];
					$vod[$k]['actor'] = $actor[1];
					$vod[$k]['director'] = $director[1];
					$vod[$k]['text'] = sub_str(str_checkhtml($text[1]),230);

					preg_match_all('/<dt jxurl="([\s\S]*?)" name="([\s\S]*?)" flag="([\s\S]*?)" type="([\s\S]*?)"><\/dt>/',$val,$player);
					preg_match_all('/<dd flag="([\s\S]*?)"><\!\[CDATA\[([\s\S]*?)\]\]><\/dd>/',$val,$urlarr);
					//print_r($urlarr);exit;
					$zu = array();
					foreach($urlarr[2] as $k2=>$val2){
						if(!empty($player[3][$k2])){
							$rowp = $this->mydb->get_row('player',array('alias'=>$player[3][$k2]),'id,jxurl');
							if(!$rowp){
								$pid = $this->mydb->get_insert('player',array(
									'name' => $player[2][$k2],
									'alias' => $player[3][$k2],
									'type' => 'web',
									'jxurl' => $player[1][$k2],
									'xid' => 99
								));
							}else{
								$pid = $rowp['id'];
								if(!empty($player[1][$k2]) && $rowp['jxurl'] != $player[1][$k2]){
									$this->mydb->get_update('player',array('jxurl'=>$player[1][$k2]),$pid);
								}
							}
						}elseif($pid == 0){
							$ly = $urlarr[1][$k2];
							$rowp = $this->mydb->get_row('player',array('alias'=>$ly),'id');
							if(!$rowp){
								$pid = $this->mydb->get_insert('player',array('name'=>$ly,'alias'=>$ly,'type'=>'app','jxurl'=>'','xid'=>99));
							}else{
								$pid = $rowp['id'];
							}
						}
						//集数
						$jiarr = explode('#',$val2);
						//print_r($jiarr);exit;
						$xji = array();
						foreach ($jiarr as $k3 => $val3) {
							if(strstr($val3,'$')){
								$arr = explode('$',$val3);
								if(empty(trim($arr[0]))) $arr[0] = '高清';
							}else{
								$arr = array('高清',$val3);
							}
							$xji[$k3] = array('name'=>$arr[0],'playurl'=>$arr[1],'xid'=>$k3+1,'pid'=>$pid);
						}
						$zu[$k2] = array('pid'=>$pid,'ji'=>$xji);
					}
					$vod[$k]['zu'] = $zu;
				}
			}
			//组合分类
			if($op == 'show'){
				$vod_list = array();
				preg_match_all('/<ty id="([0-9]+)">([\s\S]*?)<\/ty>/',$strs,$list_array);
				foreach($list_array[1] as $k=>$val){
					$vod_list[$k]['id'] = $val;
				    $vod_list[$k]['name'] = $list_array[2][$k];
				}
				$data['vod_list'] = $vod_list;
			}
		}
		$data['vod'] = $vod;
		return $data;
	}

    //获取json资源视频列表
    function vodjsonlist($zyurl,$op='show',$pid=0){
    	$arr = json_decode(geturl($zyurl),1);
		//数据解析
		$data = array('nums'=>(int)$arr['total'],'pagejs'=>(int)$arr['pagecount'],'size'=>(int)$arr['limit'],'page'=>(int)$arr['page']);
		//组合分页信息
		$vod = array();
		if(!empty($arr['list'])){
			foreach($arr['list'] as $k=>$v){
				$vod[$k]['addtime'] = $v['vod_time'];
				$vod[$k]['zyid'] = intval($v['vod_id']);
				$vod[$k]['cid'] = intval($v['type_id']);
				$vod[$k]['name'] = $v['vod_name'];
				$vod[$k]['state'] = $v['vod_remarks'];
				$vod[$k]['tags'] = $v['type_name'];

				//播放地址
				if($op == 'ruku'){

					$vod[$k]['pic'] = $v['vod_pic'];
					$vod[$k]['lang'] = $v['vod_lang'] == '汉语普通话' ? '国语' : $v['vod_lang'];
					$vod[$k]['area'] = str_replace(array('中国大陆','中国香港','中国台湾'),array('大陆','香港','台湾'),$v['vod_area']);
					$vod[$k]['year'] = (int)$v['vod_year'] == 0 ? date('Y') : (int)$v['vod_year'];
					$vod[$k]['actor'] = $v['vod_actor'];
					$vod[$k]['director'] = $v['vod_director'];
					$vod[$k]['text'] = sub_str(str_checkhtml($v['vod_writer']),230);

					$zarr = explode('$$$',$v['vod_play_from']);
					$parr = explode('$$$',$v['vod_play_url']);
					$zu = array();
					foreach($zarr as $k2=>$v2){
						if($pid == 0){
							$rowp = $this->mydb->get_row('player',array('alias'=>$v2),'id');
							if(!$rowp){
								$pid = $this->mydb->get_insert('player',array('name'=>$v2,'alias'=>$v2,'type'=>'app','jxurl'=>'','xid'=>99));
							}else{
								$pid = $rowp['id'];
							}
						}
						//集数
						$jiarr = explode('#',$parr[$k2]);
						//print_r($jiarr);exit;
						$xji = array();
						foreach ($jiarr as $k3 => $v3) {
							if(strstr($v3,'$')){
								$jarr = explode('$',$v3);
								if(empty(trim($jarr[0]))) $jarr[0] = '高清';
							}else{
								$jarr = array('高清',$v3);
							}
							$xji[$k3] = array('name'=>$jarr[0],'playurl'=>$jarr[1],'xid'=>$k3+1,'pid'=>$pid);
						}
						$zu[$k2] = array('pid'=>$pid,'ji'=>$xji);
					}
					$vod[$k]['zu'] = $zu;
				}
			}
			//组合分类
			if($op == 'show'){
				$vod_list = array();
				foreach($arr['class'] as $k=>$v){
					$vod_list[$k]['id'] = $v['type_id'];
				    $vod_list[$k]['name'] = $v['type_name'];
				}
				$data['vod_list'] = $vod_list;
			}
		}
		$data['vod'] = $vod;
		return $data;
	}

	//数据入库
	function get_send($vod,$ly){
		unset($vod['zyid']);
		$vod['cid'] = $this->collect['bind'][$ly][$vod['cid']];
		//播放组
		$zu = $vod['zu'];
		unset($vod['zu']);
		//判断标题过滤
		if(in_array($vod['name'], $this->collect['config']['filter_name'])){
			return '<font color=#ff6600>标题命中过滤规则，跳过</font>';
		}
		//判断数据是否存在
		$row = $this->get_query($vod);
		//数据存在，更新
		if($row){
			$vid = $row['id'];
			$edit = array();
			foreach ($this->collect['config']['upzd'] as $k) {
				if(!empty($vod[$k])) $edit[$k] = $vod[$k];
			}
			//更新
			if(!empty($edit)){
				//同步封面图
				if(isset($edit['pic'])) $edit['pic'] = $this->get_tbpic($edit['pic']);
				//入库时间
				if(isset($edit['addtime'])) $edit['addtime'] = $this->collect['config']['rktime'] == 0 ? time() : strtotime($edit['addtime']);
				if(isset($this->collect['pay'][$ly]['pay'])) $edit['pay'] = (int)$this->collect['pay'][$ly]['pay'];
				$this->mydb->get_update('vod',$edit,$vid);
			}
			$msg = '<font color=#1E9FFF>数据存在，更新成功</font>';
		}else{
			//判断随机人气
			if($this->collect['config']['hits_rand'] == 1){
				$vod['hits'] = rand($this->collect['config']['min_hits'],$this->collect['config']['max_hits']);
			}
			//同步封面图
			$vod['pic'] = $this->get_tbpic($vod['pic']);
			//入库时间
			$vod['addtime'] = $this->collect['config']['rktime'] == 0 ? time() : strtotime($vod['addtime']);
			//收费状态
			if(isset($this->collect['pay'][$ly]['pay'])) $vod['pay'] = (int)$this->collect['pay'][$ly]['pay'];
			//入库
			$vid = $this->mydb->get_insert('vod',$vod);
			$msg = '<font color=#080>数据不存在，添加成功</font>';
		}
		//更新播放组
		foreach ($zu as $k => $v) {
			//判断播放组是否存在
			$row = $this->mydb->get_row('vod_zu',array('vid'=>$vid,'pid'=>$v['pid']),'id');
			if(!$row){
				$zid = $this->mydb->get_insert('vod_zu',array('vid'=>$vid,'pid'=>$v['pid'],'xid'=>$k+1));
			}else{
				$zid = $row['id'];
			}
			//判断更新规则
			$up = 1;
			if($this->collect['config']['update'] == 1){
				$znums = $this->mydb->get_nums('vod_ji',array('zid'=>$zid));
				if($znums >= count($v['ji'])) $up = 0;
			}
			if(!empty($v['ji']) && $up == 1){
				foreach ($v['ji'] as $k2 => $v2) {
					if(!empty($v2['name']) && !empty($v2['playurl']) && $k2>=$znums){
						$xid = (int)$v2['xid'] == 0 ? $k2+1 : (int)$v2['xid'];
						$rowj = $this->mydb->get_row('vod_ji',array('zid'=>$zid,'xid'=>$xid),'id');
						if(!$rowj){
							$this->mydb->get_insert('vod_ji',array(
								'vid'=>$vid,
								'pid'=>(int)$v['pid'],
								'xid'=>$xid,
								'zid'=>$zid,
								'name'=>$v2['name'],
								'pay' => isset($this->collect['pay'][$ly]['pay']) ? (int)$this->collect['pay'][$ly]['pay'] : 0,
								'cion' => isset($this->collect['pay'][$ly]['cion']) ? (int)$this->collect['pay'][$ly]['cion'] : 0,
								'playurl'=>$v2['playurl']
							));
						}else{
							$this->mydb->get_update('vod_ji',array(
								'pid'=>(int)$v['pid'],
								'name'=>$v2['name'],
								//'pay' => isset($this->collect['pay'][$ly]['pay']) ? (int)$this->collect['pay'][$ly]['pay'] : 0,
								//'cion' => isset($this->collect['pay'][$ly]['cion']) ? (int)$this->collect['pay'][$ly]['cion'] : 0,
								'playurl'=>$v2['playurl']
							),$rowj['id']);
						}
					}
				}
			}
		}
		return $msg;
	}

	//判断数据是否存在
	function get_query($vod){
		$where = array();
		foreach ($this->collect['config']['inspect'] as $k => $v) {
			if(!empty($vod[$v])) $where[$v] = $vod[$v];
		}
		return $this->mydb->get_row('vod',$where);
	}

	//标题替换
	function get_name_replace($name){
		$replace_name = $this->collect['config']['replace_name'];
		foreach ($replace_name as $k => $v) {
			$a = explode('->',$v);
			if(!empty($a[0])) $name = str_replace($a[0],$a[1],$name);
		}
		return $name;
	}

	//同步封面
	function get_tbpic($pic){
		$picurl = $pic;
		if($this->collect['config']['tbpic'] == 0) return $picurl;
		if(!strstr($pic,'://') && substr($pic,0,2) != '//') return $picurl;
		if(substr($pic,0,2) == '//') $pic = 'http:'.$pic;
		$img = geturl($pic);
		if(empty($img)) return $picurl;
		if($this->myconfig['annex']['type'] == 'sys'){
			$picdir = FCPATH.'annex/vod/'.date('Y-m').'/'.date('d').'/';
		}else{
			$picdir = FCPATH.'annex/vod/';
		}
		mkdirss($picdir); //创建文件夹
		//保存文件名
		$file_path = $picdir.md5($pic).'.'.strtolower(trim(substr(strrchr($pic, '.'), 1)));
		file_put_contents($file_path,$img);
		$file_path = get_tongbu($this->myconfig,$file_path,$this);
		if(!$file_path) return $picurl;
		return str_replace(str_replace("\\",'/',FCPATH),'/',$file_path);
	}
}