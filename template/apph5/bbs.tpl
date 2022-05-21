<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
    <meta name="format-detection" content="telephone=no, email=no">
    <title><?=$bbs['name']?></title>
    <link rel="stylesheet" href="/packs/layui/css/layui.css"/>
    <style>
    *{margin:0;padding:0;}
    html,body{width:100%;height:100%;background: #f5f5f5;}
    img{object-fit:cover}
    .box{width: 100%;margin:0 auto;max-width: 500px;background: #fff;min-height:100%;}
    .wxbg{width: 100%;height: 100%;position: fixed;top:0;left:0;background: rgba(0, 0, 0, 0.8);z-index:999;}
    .wxbg p{text-align: center;margin-top: 10%;padding: 0 5%;}
    .wxbg p img{max-width: 100%;height: auto;}
    .bbs{padding:15px;}
    .line{width: 100%;height: 6px;background: #EDEDED;}
    .user{width: 100%;position: relative;}
    .user .pic{position: absolute;top:5px;left:0;width: 34px;height: 34px;border-radius: 50%;border: 1px solid #EDEDED;}
    .user .pic img{width: 34px;height: 34px;border-radius: 50%;}
    .user .uinfo{padding-left: 47px;}
    .user .uinfo .tags{border-radius: 10px;border: 1px solid #333333;display: inline-block;font-size:12px;padding: 2px 5px;margin-top: 5px;}
    .user .funco{position: absolute;top:10px;right:0;width: 50px;height: 23px;line-height: 23px;background: linear-gradient(270deg, #FEA301 0%, #F6B204 100%);border-radius: 9px;text-align: center;color:#fff;font-size:12px;}
    .btitle{padding-top: 10px;}
    .btext{padding-top: 10px;}
    .img{width: 100%;padding-top: 10px;font-size: 0;}
    .img img{display: inline-block;width: 32%;height: 106px;margin-right: 2%;border-radius: 5px;margin-bottom: 10px;}
    .img img:nth-child(3n){margin-right:0;}
    .p1 img{width: 100%;height: 106px;}
    .bottom{width: 100%;padding-top: 10px;}
    .bottom span{display: inline-block;color:#999;}
    .bottom span img{vertical-align: middle;margin-right: 5px;}
    .bottom span.share{float: right;}
    ul{width: 100%;margin-top: -15px;}
    li{list-style-type:none;width: 100%;border-bottom: 1px solid #EDEDED;padding: 15px 0;}
    li .u{width: 100%;}
    li .u img{width: 24px;height: 24px;border-radius: 50%;margin-right: 6px;}
    li .info{padding-left: 30px;}
    .nodata{width: 100%;padding-top: 100px;text-align: center;}
    .more{padding-top: 15px;text-align: center;color:red;}
    .down{background:#ff6600;color:#fff;position: fixed;bottom:20px;left:50%;width: 160px;height: 35px;line-height: 35px;text-align: center;margin-left: -80px;border-radius: 17px;}
    </style>
</head>
<body>
<?php if($is_wxqq == 2) echo '<div class="wxbg"><p><img src="/packs/images/tip.png"></p></div>';?>
<div class="box">
    <div class="bbs">
        <div class="user">
            <div class="pic"><img src="<?=getpic($bbs['user']['pic'])?>"></div>
            <div class="uinfo">
                <p><?=$bbs['user']['nickname']?></p>
                <p class="tags"><?=getzd('bbs_class','name',$bbs['cid'])?></p>
            </div>
            <div class="funco">关注</div>
        </div>
        <div class="btitle"><?=$bbs['name']?></div>
        <div class="btext"><?=$bbs['text']?></div>
        <?php
        if(!empty($bbs['pics'])){
            $pic = '';
            foreach($bbs['pics'] as $v) $pic.='<img src="'.$v['url'].'">';
            echo '<div class="img p'.count($bbs['pics']).'">'.$pic.'</div>';
        }
        ?>
        <div class="bottom">
            <span><img width="18" height="18" src="data:image/png;base64,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" /><?=$bbs['zan']?></span>
            <span style="margin-left:20px;"><img width="18" height="18" src="data:image/png;base64,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" /><?=$this->mydb->get_nums('comment',array('bid'=>$bbs['id']))?></span>
            <span class="share"><img width="18" height="18" src="data:image/png;base64,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" />分享</span>
        </div>
    </div>
    <div class="line"></div>
    <div class="bbs" style="padding-bottom: 100px;">
        <ul>
        <?php
        foreach($bbs['comment'] as $row){
            $user = $this->mydb->get_row('user',array('id'=>$row['uid']),'nickname,pic,vip');
            $report_num = $this->mydb->get_nums('comment',array('fid'=>$row['id']));
            $report = '';
            if($report_num > 0){
                $report .= '<div class="report">';
                $arr = $this->mydb->get_select('comment',array('fid'=>$row['id']),'*','id desc',3);
                foreach($arr as $row2){
                    $report.='<p>'.getzd('user','nickname',$row2['uid']).'：'.$row2['text'].'</p>';
                }
                $report .= '</div>';
            }
            echo '<li><div class="u"><img src="'.$user['pic'].'">'.$user['nickname'].'</div><div class="info"><div class="text">'.$row['text'].'</div><div class="time"><div class="t">'.date('Y-m-d H:i:s',$row['addtime']).'</div><div class="right"><span><i class="layui-icon "></i>'.$row['zan'].'</span><span><i class="layui-icon "></i>'.$report_num.'</span></div></div>'.$report.'</div></li>';
        }
        if(empty($bbs['comment'])){
            echo '<div class="nodata">暂无评论</div>';
        }else{
            echo '<div class="more">去APP查看全部内容 ></div>';
        }
        ?>
        </ul>
    </div>
</div>
<div class="down">去APP免费看视频</div>
<script src="/packs/jquery/jquery.min.js"></script>
</body>
</html>