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

class Myopiating extends My_Controller {

	public function __construct(){
		parent::__construct();
        $this->myconfig = json_decode(_SYSJSON_,1);
        $this->collect = require_once FCPATH.'yhcms/config/collect.php';
	}

    //win访问
    public function win($ly='') {
        $pass = $this->input->get('pass',true);
        if(empty($pass)) exit('访问密码不能为空');
        if(!isset($this->collect['myopia']['ting'][$ly])) exit('任务不存在');
        $tim = $this->collect['myopia']['ting'][$ly];
        $tim['ly'] = $ly;
        if($tim['pass'] != $pass) exit('密码不正确');
        $data['i'] = $tim['i'];
        $data['cjurl'] = links('myopiating/send').'?token='.urlencode(sys_auth($tim));
        $this->load->get_templates('admin');
        $this->load->view('caiji/timing_win.tpl',$data);
    }

    //os访问
    public function os($ly='') {
        set_time_limit(0); //不超时
        $pass = $this->input->get('pass',true);
        if(empty($pass)) exit('访问密码不能为空');
        if(!isset($this->collect['myopia']['ting'][$ly])) exit('任务不存在!');
        $tim = $this->collect['myopia']['ting'][$ly];
        if($tim['pass'] != $pass) exit('密码不正确');
        $page = 1;
        $cjurl = $tim['url'].'?ac=videolist&h='.$tim['day']*24;
        do {
            $res = $this->ruku($cjurl,$page,$ly,'os');
            $page++;
            sleep(3);
        } while ($res==1);
        echo '全部采集完毕，等待下个时间点继续!!!';
    }

    //WIN采集
    public function send() {
        set_time_limit(0); //不超时
        $token = $this->input->get('token');
        $page = (int)$this->input->get('page');
        if($page == 0) $page = 1;
        $tim = sys_auth($token,1);
        if(!isset($tim['url'])) exit('非法访问!!');
        $cjurl = $tim['url'].'?ac=videolist&h='.$tim['day']*24;
        $res = $this->ruku($cjurl,$page,$tim['ly']);
        if($res == 1){
            echo "<script>setTimeout(function() {
                window.location.href = '?token=".$token."&page=".($page+1)."';
            }, 3000);</script>";
        }else{
            exit('<br><script>parent.n = 0;</script><b>全部采集完成，等待下个时间点继续!!!</b>');
        }
    }

    //采集入库开始
    private function ruku($zyurl='',$page=1,$ly,$op='win'){
        //加载采集模型
        $this->load->model('collects');
        //播放器ID
        $pid = (int)getzd('player','id',$ly,'alias');
        if($pid == 0) $pid = 1;

        $zyurl .= '&page='.$page;
        $json = geturl($zyurl);
        $arr = json_decode($json,1);
        //循环入库
        if(!empty($arr['vod'])){
            foreach ($arr['vod'] as $k => $v) {
                $msgstr = '第'.($k+1).'条数据《'.$v['text'].'》';
                //未绑定分类
                if(!isset($this->collect['myopia']['bind'][$ly][$v['cid']])){
                    $msgstr .= '<font color=#00f>未绑定分类，跳过</font>';
                }else{
                    //下载图片到本地
                    $pic = $this->down_pic($v['pic'],$v['id']);
                    if(!$pic){
                        $msgstr .= '<font color=#f90>封面图片下载失败，跳过</font>';
                    }else{
                        $add = array(
                            'cid' => $this->collect['myopia']['bind'][$ly][$v['cid']],
                            'md5' => md5($v['id']),
                            'text' => $v['text'],
                            'playurl' => $v['playurl'],
                            'pic' => $pic,
                            'type' => 1,
                            'upic' => $v['author']['pic'],
                            'nickname' => $v['author']['nickname'],
                            'addtime' => time()
                        );
                        $add = str_checkhtml($add);
                        //print_r($add);exit;
                        //判断是否存在
                        $row = $this->mydb->get_row('myopia',array('md5'=>$add['md5']),'id');
                        if($row){
                            $msgstr .= '<font color=red>已存在，跳过</font>';
                        }else{
                            $res = $this->mydb->get_insert('myopia',$add);
                            if($res){
                                $msgstr .= '<font color=#080>入库成功~</font>';
                            }else{
                                $msgstr .= '<font color=#f30>入库失败~</font>';
                            }
                        }
                    }
                }
                if($op == 'win') echo $msgstr."<br>";
            }
        }else{
            if($op == 'win') echo "<font color=red>获取数据失败</font><br>";
        }
        if($op == 'win') echo '<br><b>第'.$page.'/'.$arr['pagejs'].'页采集完毕，3秒后继续下一页</b>.....';
        //更新最后执行时间
        $this->collect['myopia']['ting'][$ly]['time'] = date('Y-m-d H:i:s');
        arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
        //判断采集完成
        if($page >= $arr['pagejs']){
            return 2;
        }
        //还有下一页
        return 1;
    }

    //下载图片到本地
    private function down_pic($pic,$vid){
        $picdir = FCPATH.'annex/myopia/'.date('Y').'/'.date('m').'/'.date('d').'/';
        $picfile = $picdir.md5($vid).'.jpeg';
        if(file_exists($picfile)) return str_replace(FCPATH,'/',$picfile);
        //获取文件头信息
        $arr = get_headers($pic,true);
        //print_r($arr);exit;
        if(!empty($arr['location'])){
            $data = geturl($arr['location']);
            if(!empty($data)){
                mkdirss($picdir); //创建文件夹
                file_put_contents($picfile,$data);
                return str_replace(FCPATH,'/',$picfile);
            }
        }
        return false;
    }
}
