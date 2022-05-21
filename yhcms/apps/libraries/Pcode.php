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

Class Pcode{
    private $fontSize  =  22;              // 验证码字体大小(px)
    private $useCurve  =  true;            // 是否画混淆曲线
    private $useNoise  =  true;            // 是否添加杂点	
    private $imageH    =  116;               // 验证码图片高度
    private $imageW    =  268;               // 验证码图片宽度
    private $length    =  4;               // 中文文字位数
    private $bgpath    =  FCPATH.'caches/codes/bg.png';  // 背景图片地址
    private $fontttf   =  FCPATH.'caches/codes/font.ttf';  // 背景图片地址
    private $_image    = NULL;     // 验证码图片实例
    private $_color    = NULL;     // 验证码字体颜色

    /**
     * 架构方法 设置参数
     * @access public     
     * @param  array $config 配置参数
     */    
    public function __construct($config=array()){
    	foreach ($config as $key => $value) {
    		$this->$key = $value;
    	}
    }

    /**
     * 验证验证码是否正确
     */
    public function check() {
        $code = get_post('code');
        $ckey = get_post('ckey');
        if(empty($code) || empty($ckey)) return false;
        $arr = json_decode($code,1);
        $yarr = sys_auth($ckey,1);
        // 验证码不能为空
        if(empty($arr) || empty($yarr)) return false;

        //验证第一个文字X-Y坐标
        $xks1 = $yarr[0]['x']-5;$xjs1 = $yarr[0]['x']+$this->fontSize+5;
        $yks1 = $yarr[0]['y']-$this->fontSize-5;$yjs1 = $yarr[0]['y']+5;
        //验证第二个文字X-Y坐标
        $xks2 = $yarr[1]['x']-5;$xjs2 = $yarr[1]['x']+$this->fontSize+5;
        $yks2 = $yarr[1]['y']-$this->fontSize-5;$yjs2 = $yarr[1]['y']+5;
        //验证
        if(
            ($arr[0]['x'] > $xks1 && $arr[0]['x'] < $xjs1) && ($arr[0]['y'] > $yks1 && $arr[0]['y'] < $yjs1) && 
            ($arr[1]['x'] > $xks2 && $arr[1]['x'] < $xjs2) && ($arr[1]['y'] > $yks2 && $arr[1]['y'] < $yjs2)
        ){
            return true;
        }
        //验证失败
        return false;
    }

    /**
     * 生成验证码图片
     */
    public function entry() {
        $this->_image = imagecreatefrompng($this->bgpath);
        // 验证码字体颜色，默认灰色
        $this->_color = imagecolorallocate($this->_image, 102, 102, 102);
        // 绘杂点
        if ($this->useNoise) {
            $this->_writeNoise();
        } 
        // 绘干扰线
        if ($this->useCurve) {
            $this->_writeCurve();
            $this->_writeCurve();
            $this->_writeCurve();
        }
        //验证码
        $code = $this->getChar();
        //坐标
        $xyarr = $xyarr2 = $this->getFontxy();
        //绘验证码
        for ($i = 0; $i<$this->length; $i++) {
            imagettftext($this->_image, $this->fontSize, mt_rand(-40, 40), $xyarr[$i]['x'], $xyarr[$i]['y'], $this->_color, $this->fontttf, $code[$i]);
        }
        $imgpath = FCPATH.'caches/codes/'.rand(111111,999999).'.png';
        // 输出图像
        imagepng($this->_image,$imgpath);
        imagedestroy($this->_image);
        shuffle($xyarr);
        //找出前两位
        $a1 = $a2 = 0;
        foreach ($xyarr2 as $k => $v) {
            if($xyarr[0]['x'] == $v['x']){
                $a1 = $k;
            }
            if($xyarr[1]['x'] == $v['x']){
                $a2 = $k;
            }
        }
        $data['font'] = $code[$a1].$code[$a2];
        $ckeyarr = array($xyarr2[$a1],$xyarr2[$a2]);
        //生成ckey
        $data['ckey'] = sys_auth($ckeyarr);
        //base64图片
        $data['img'] = imgToBase64($imgpath);
        get_json($data);
    }

    //生成汉字
    private function getChar(){
        $b = array();
        for ($i=0; $i<$this->length; $i++) {
            // 使用chr()函数拼接双字节汉字，前一个chr()为高位字节，后一个为低位字节
            $a = chr(mt_rand(0xB0,0xD0)).chr(mt_rand(0xA1, 0xF0));
            // 转码
            $b[]= iconv('GB2312', 'UTF-8', $a);
        }
        return $b;
    }
    //生成坐标
    private function getFontxy(){
        $arr = array();
        $x = 0;
        for ($i=0; $i<$this->length; $i++) {
            $k = $i+1;
            $x = $this->fontSize*$k+$x;
            $arr[$i]['x'] = $x;
            $arr[$i]['y'] = mt_rand(50,90);
        }
        return $arr;
    }
    /** 
     * 画一条由两条连在一起构成的随机正弦函数曲线作干扰线(你可以改成更帅的曲线函数) 
     *      
     *      高中的数学公式咋都忘了涅，写出来
     *		正弦型函数解析式：y=Asin(ωx+φ)+b
     *      各常数值对函数图像的影响：
     *        A：决定峰值（即纵向拉伸压缩的倍数）
     *        b：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
     *        φ：决定波形与X轴位置关系或横向移动距离（左加右减）
     *        ω：决定周期（最小正周期T=2π/∣ω∣）
     *
     */
    private function _writeCurve() {
        $px = $py = 0;
        // 曲线前部分
        $A = mt_rand(1, $this->imageH/2);                  // 振幅
        $b = mt_rand(-$this->imageH/4, $this->imageH/4);   // Y轴方向偏移量
        $f = mt_rand(-$this->imageH/4, $this->imageH/4);   // X轴方向偏移量
        $T = mt_rand($this->imageH, $this->imageW*2);  // 周期
        $w = (2* M_PI)/$T;
                        
        $px1 = 0;  // 曲线横坐标起始位置
        $px2 = mt_rand($this->imageW/2, $this->imageW * 0.8);  // 曲线横坐标结束位置

        for ($px=$px1; $px<=$px2; $px = $px + 1) {
            if ($w!=0) {
                $py = $A * sin($w*$px + $f)+ $b + $this->imageH/2;  // y = Asin(ωx+φ) + b
                $i = (int) ($this->fontSize/5);
                while ($i > 0) {	
                    imagesetpixel($this->_image, $px + $i , $py + $i, $this->_color);  // 这里(while)循环画像素点比imagettftext和imagestring用字体大小一次画出（不用这while循环）性能要好很多				
                    $i--;
                }
            }
        }
        
        // 曲线后部分
        $A = mt_rand(1, $this->imageH/2);                  // 振幅		
        $f = mt_rand(-$this->imageH/4, $this->imageH/4);   // X轴方向偏移量
        $T = mt_rand($this->imageH, $this->imageW*2);  // 周期
        $w = (2* M_PI)/$T;		
        $b = $py - $A * sin($w*$px + $f) - $this->imageH/2;
        $px1 = $px2;
        $px2 = $this->imageW;

        for ($px=$px1; $px<=$px2; $px=$px+ 1) {
            if ($w!=0) {
                $py = $A * sin($w*$px + $f)+ $b + $this->imageH/2;  // y = Asin(ωx+φ) + b
                $i = (int) ($this->fontSize/5);
                while ($i > 0) {			
                    imagesetpixel($this->_image, $px + $i, $py + $i, $this->_color);	
                    $i--;
                }
            }
        }
    }

    /**
     * 画杂点
     * 往图片上写不同颜色的字母或数字
     */
    private function _writeNoise() {
        $codeSet = '2345678abcdefhijkmnpqrstuvwxyz';
        for($i = 0; $i < 10; $i++){
            //杂点颜色
            $noiseColor = imagecolorallocate($this->_image, mt_rand(150,225), mt_rand(150,225), mt_rand(150,225));
            for($j = 0; $j < 5; $j++) {
                // 绘杂点
                imagestring($this->_image, 5, mt_rand(-10, $this->imageW),  mt_rand(-10, $this->imageH), $codeSet[mt_rand(0, 29)], $noiseColor);
            }
        }
    }
}