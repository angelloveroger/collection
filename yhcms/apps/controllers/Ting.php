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

class Ting extends My_Controller {

	public function __construct(){
		parent::__construct();
        $this->myconfig = json_decode(_SYSJSON_,1);
        $this->collect = require_once FCPATH.'yhcms/config/collect.php';
	}

	public function delhits(){
        //清空月人气
        $month = file_get_contents(FCPATH."caches/month.txt");
        if($month != date('m')){
            $this->db->query("update vod set yhits=0");
            file_put_contents(FCPATH."caches/month.txt",date('m'));
        }
        //清空周人气
        $week = file_get_contents(FCPATH."caches/week.txt");
        if($week != date('W',time())){
            $this->db->query("update vod set zhits=0");
            file_put_contents(FCPATH."caches/week.txt",date('W',time()));
        }
        //清空日人气
        $day = file_get_contents(FCPATH."caches/day.txt");
        if($day != date('d')){
            $this->db->query("update vod set rhits=0");
            file_put_contents(FCPATH."caches/day.txt",date('d'));
        }
        echo 'ok';
	}

    //win访问
    public function win($ly='') {
        $pass = $this->input->get('pass',true);
        if(empty($pass)) exit('访问密码不能为空');
        if(!isset($this->collect['ting'][$ly])) exit('任务不存在');
        $tim = $this->collect['ting'][$ly];
        $tim['ly'] = $ly;
        if($tim['pass'] != $pass) exit('密码不正确');
        $data['i'] = $tim['i'];
        $data['cjurl'] = links('ting/send').'?token='.urlencode(sys_auth($tim));
        $this->load->get_templates('admin');
        $this->load->view('caiji/timing_win.tpl',$data);
    }

    //os访问
    public function os($ly='') {
        set_time_limit(0); //不超时
        $pass = $this->input->get('pass',true);
        if(empty($pass)) exit('访问密码不能为空');
        if(!isset($this->collect['ting'][$ly])) exit('任务不存在!');
        $tim = $this->collect['ting'][$ly];
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
        $data = $this->collects->vodlist($zyurl.'&pg='.$page,'ruku',$pid);
        //循环入库
        $msg = array();
        foreach ($data['vod'] as $k => $v) {
            $v = str_checkhtml($v,1);
            //标题替换
            $v['name'] = $this->collects->get_name_replace($v['name']);
            $msgstr = '第'.($k+1).'条数据《'.$v['name'].'》更新至'.$v['state'].' ';
            //判断采集内容
            if(empty($v['name'])){
                $msgstr .= '<font color=#ff6600>未获取到标题，跳过</font>';
            }elseif(!isset($this->collect['bind'][$ly][$v['cid']])){ //未绑定
                $msgstr .= '<font color=red>未绑定分类，跳过</font>';
            }else{
                $msgstr .= $this->collects->get_send($v,$ly);//更新入库
            }
            if($op == 'win') echo $msgstr."<br>";
        }
        if($op == 'win') echo '<br><b>第'.$page.'/'.$data['pagejs'].'页采集完毕，3秒后继续下一页</b>.....';
        //更新最后执行时间
        $this->collect['ting'][$ly]['time'] = date('Y-m-d H:i:s');
        arr_file_edit($this->collect,FCPATH.'yhcms/config/collect.php');
        //判断采集完成
        if($page >= $data['pagejs']){
            return 2;
        }
        //还有下一页
        return 1;
    }
}
