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

class Appdown extends My_Controller {

	public function __construct(){
		parent::__construct();
		$this->myconfig = json_decode(_SYSJSON_,1);
	}

	public function index(){
		//邀请地址
        $shareurl = get_share_url();
        if(defined('IS_WAP')){
        	header("location:".$shareurl);
			exit;
        }
		//seo
		$data['title'] = 'APP下载 - '.WEBNAME;
		$data['keywords'] = get_seo('index','keywords');
		$data['description'] = get_seo('index','description');

		$data['android_downurl'] = $this->myconfig['app']['android_downurl'];
		$data['ios_downurl'] = $this->myconfig['app']['ios_downurl'];

        //生成二维码
        require_once FCPATH.'yhcms/myclass/phpqrcode/phpqrcode.php';
        $qrcode_path = FCPATH.'caches/qrcode/0.png';
        QRcode::png($shareurl,$qrcode_path,'L',9,2);
        //合并二维码
        $logo = imagecreatefrompng('./packs/images/logo_icon.png');
        $QR = imagecreatefrompng($qrcode_path);
        //重新组合图片并调整大小
        $QR_width = imagesx($QR);//二维码图片宽度 
        $QR_height = imagesy($QR);//二维码图片高度 
        $logo_width = imagesx($logo);//logo图片宽度 
        $logo_height = imagesy($logo);//logo图片高度 
        $logo_qr_width = $QR_width / 8; 
        $scale = $logo_width/$logo_qr_width; 
        $logo_qr_height = $logo_height/$scale; 
        $from_width = ($QR_width - $logo_qr_width) / 2; 
        //重新组合图片并调整大小 
        imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width, $logo_qr_height, $logo_width, $logo_height);
        imagepng($QR,$qrcode_path,9);
        imagedestroy($QR);
        $data['qrcode'] = imgToBase64($qrcode_path);

		//输出
		$this->load->view('head.tpl',$data);
		$this->load->view('appdown.tpl');
		$this->load->view('bottom.tpl');
	}
}