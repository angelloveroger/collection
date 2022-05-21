<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('FCPATH')) exit('No direct script access allowed');
use OSS\OssClient;
use OSS\Core\OssException;
require_once FCPATH.'yhcms/myclass/aliyun_oss/autoload.php';
Class Oss{
 
    public function __construct(){
        $myconfig = json_decode(_SYSJSON_,1);
        $this->ossid = $myconfig['annex']['oss']['access_id'];
        $this->osskey = $myconfig['annex']['oss']['access_key'];
        $this->ossend = $myconfig['annex']['oss']['end_point'];
        $this->bucket = $myconfig['annex']['oss']['bucket'];
    }

    //上传
    public function upload($file_path,$oss_path){
        $oss_path = str_replace(FCPATH.'annex/','',$oss_path);
        //获取对象
        $ossClient = new OssClient($this->ossid, $this->osskey, $this->ossend);
        try {
            $result = $ossClient->uploadFile($this->bucket,$oss_path,$file_path);
            //判断删除本地文件
            unlink($file_path);
            return $oss_path;
        } catch (OssException $e) {
            unlink($file_path);
            //exit($e->getMessage());
            return false;
        }
    }

    //删除
    public function del($file_path){
        //获取对象
        $ossClient = new OssClient($this->ossid, $this->osskey, $this->ossend);
        try {
            $oss_file_path = str_replace(FCPATH, '', $file_path);
            return $ossClient->deleteObject($this->bucket,$file_path);
        } catch (OssException $e) {
            //exit($e->getMessage());
            return false;
        }
    }
}