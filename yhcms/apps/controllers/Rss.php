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

class Rss extends My_Controller {

	public function __construct(){
		parent::__construct();
	}

	//百度
    public function index($type='') {
        $type = str_replace('.xml','',$type);
        $arr = array('baidu','google','so','shenma','sogou','bing');
        if(!in_array($type,$arr)) $type = 'index';
        if(!$this->caches->start('rss-'.$type,$this->myconfig['caches']['time']['rss'])){
            $jtime = strtotime(date('Y-m-d 0:0:0'))-1;
            if($type == 'index'){
                $xml = '<?xml version="1.0" encoding="UTF-8" ?><rss version="2.0"><channel><title>'.WEBNAME.'</title><description>'.WEBNAME.'</description><link>'.WEBURL.'</link><language>zh-cn</language><docs>'.WEBNAME.'</docs><generator>Rss Powered By '.WEBURL.'</generator><image><url>http://'.WEBURL.'/packs/images/logo.png</url></image>';
                $data = $this->mydb->get_select('vod',array('addtime>'=>$jtime),'id,name,actor,state,text,addtime','addtime DESC',5000);
                foreach ($data as $v){
                    $xml .= '<item><title>'.$v['name'].' '.$v['state'].'</title><link>http://'.WEBURL.links('info/'.$v['id']).'</link><author>'.sub_str($v['actor'],50).'</author><pubDate>'.date('Y-m-d H:i:s',$v['addtime']).'</pubDate><description><![CDATA["'.safe_replace(sub_str($v['text'],50)).'"]]></description></item>';
                }
                $xml .= '</channel></rss>';
            }else{
                if($type == 'google'){
                    $xml = '<?xml version="1.0" encoding="UTF-8" ?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">';
                }elseif($type == 'so'){
                    $xml = '<?xml version="1.0" encoding="UTF-8"?><sitemapindex>';
                }else{
                    $xml = '<?xml version="1.0" encoding="UTF-8"?><urlset>';
                }
                $data = $this->mydb->get_select('vod',array('addtime>'=>$jtime),'id,addtime','addtime DESC',5000);
                foreach ($data as $v){
                    if($type == 'so'){
                        $xml .= '<sitemap><loc>http://'.WEBURL.links('info/'.$v['id']).'</loc><lastmod>'.date('Y-m-d',$v['addtime']).'</lastmod></sitemap>';
                    }else{
                        $xml .= '<url><loc>http://'.WEBURL.links('info/'.$v['id']).'</loc><lastmod>'.date('Y-m-d',$v['addtime']).'</lastmod><changefreq>always</changefreq><priority>0.8</priority></url>';
                    }
                }
                if($type == 'so'){
                    $xml .= '</sitemapindex>';
                }else{
                    $xml .= '</urlset>';
                }
            }
            header('Content-Type: text/xml;charset=UTF-8');
            echo $xml;
            $this->caches->end();
        }
	}
}