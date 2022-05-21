<link rel="stylesheet" href="/packs/player/player.css">
<script src="/packs/player/player.js?v=1.25"></script>
<script src="/packs/jquery/clipboard.min.js"></script>
<div class="pageHead betweenX centerY">
    <div class="pageHead-left" onclick="window.location.href='<?=links('info',$id)?>';">
        <i class="iconfont icon-xiangzuo"></i>
    </div>
    <div class="pageHead-text" style="height:25px;overflow:hidden;"><?=$name?></div>
    <div class="pageHead-right copy" data-clipboard-text="<?=$share_txt?>"><i class="iconfont icon-fenxiang1"></i></div>
</div>
<div class="vod-box">
    <div style="width:100%;height:230px;" id="player-video" data-jid="<?=$ji['id']?>">
        <p>加载中...</p>
    </div>
</div>
<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/play.js"></script></div>
<div class="play-nav">
    <span data-type="vod" class="on">视频<em></em></span>
    <span data-type="comment">评论<i><?php $plnums = $this->mydb->get_nums('comment',array('vid'=>$id,'fid'=>0));echo $plnums;?></i><em></em></span>
    <?php if(count($play) > 1) echo '<span data-type="zu">换源<em></em></span>';?>
</div>
<div style="height: 325px;"></div>
<div class="play-info">
    <h3><?=$name?><span class="text-btn">简介<i class="layui-icon layui-icon-right"></i></span></h3>
    <div class="row">
        <i class="layui-icon layui-icon-fire"></i>热度<?=get_wan($hits)?>
        <?php if(!empty($state)) echo ' • '.$state;?>
        <?php if(!empty($area)) echo ' • '.$area;?>
        <?php if(!empty($year)) echo ' • '.$year;?>
    </div>
    <div id="play-zu-box" style="display:none;">
    <?php
        echo '<h4>站源<span>如无法播放，请尝试更换线路</span></h4><ul class="play-zu-ul">';
        foreach($play as $rowz){
            $cls = $ji['zid'] == $rowz['id'] ? 'on' : '';
            echo '<li data-id="'.$rowz['id'].'" class="'.$cls.'">'.$rowz['name'].'</li>';
        }
        echo '</ul>';
    ?>
    </div>
    <div id="play-ji-box">
        <h4>选集<span class="ji-btn"><?php if($pay == 1) echo 'Vip用户抢先看全集';?><i class="layui-icon layui-icon-right"></i></span></h4>
        <?php
        foreach($play as $rowz){
            $cls = $ji['zid'] == $rowz['id'] ? 'on' : '';
            echo '<ul class="play-ji-ul '.$cls.'" id="zu-'.$rowz['id'].'">';
            foreach($rowz['ji'] as $k=>$row){
                $cls2 = $row['id'] == $ji['id'] ? ' class="on"' : '';
                $pay = '';
                if($row['pay'] > 0) $pay = $row['pay'] == 1 ? '<span class="pay1">VIP</span>' : '<span class="pay2">点播</span>';
                echo '<li'.$cls2.'><a href="'.links('play',$id,$row['id']).'">'.$row['name'].'</a>'.$pay.'</li>';
            }
            echo '</ul>';
        }
        ?>
    </div>
    <?php
    $sql = "SELECT id,cid,name,pic,constellation FROM "._DBPREFIX_."star where FIND_IN_SET(name,'".implode(',',$actor_arr)."') order by hits LIMIT 30";
    $star = $this->mydb->get_sql($sql);
    if(!empty($star)){
        echo '<h4>演员表</h4><ul class="starul">';
        foreach($star as $row){
            echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
        }
        echo '</ul>';
    }
    ?>
    <h4 style="margin-top:10px;">猜你喜欢</h4>
    <ul class="vod-love">
        <?php
        foreach($love as $row){
            $pay = '';
            if($row['pay'] > 0) $pay = $row['pay'] == 1 ? '<span class="pay1">VIP</span>' : '<span class="pay2">点播</span>';
            echo '<li><a href="'.links('play',$row['id'],0).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<div class="state">'.$row['state'].'</div></div><div class="info"><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div><div class="hits"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></div></a></li>';
        }
        ?>
    </ul>
    <div style="height: 50px;"></div>
    <div class="comment-input-box">
        <div class="left comment-show-btn"><i class="layui-icon layui-icon-edit"></i>写评论</div>
        <div class="right">
            <span class="comment-show-btn"><i class="layui-icon layui-icon-chat"></i>评论</span>
            <span data-fav="<?=$fav?>" data-id="<?=$id?>" class="fav-btn<?=$fav==1?' on':''?>"><i class="layui-icon layui-icon-heart<?=$fav==1?'-fill':''?>"></i><?=$fav==1?'已':''?>收藏</span>
        </div>
    </div>
</div>
<div class="comment-list">
<?php
if(_PL_ == 1){
    echo '<ul id="comment-list">';
    $comment = $this->mydb->get_select('comment',array('vid'=>$id,'fid'=>0),'*','id desc',15);
    foreach($comment as $row){
        $user = $this->mydb->get_row('user',array('id'=>$row['uid']),'nickname,pic');
        $zan =  $uid > 0 ? $this->mydb->get_row('comment_zan',array('did'=>$row['id'],'uid'=>$uid)) : false;
        $zanpic = $zan ? 'zan_on' : 'zan';
        $del = $row['uid'] == $uid ? '<span data-id="'.$row['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i></span>' : '';
        echo '<li>'.$del.'<div class="pic"><img src="'.getpic($user['pic']).'"></div><div class="info"><div class="nickname">'.$user['nickname'].'<span>'.datetime($row['addtime']).'</span></div><div class="text">'.emoji_replace($row['text'],1).'</div><div class="cmd" data-zan="'.($zan?1:0).'" data-id="'.$row['id'].'" data-fid="'.$row['id'].'" data-nickname=""><span class="zan"><img src="'._tpldir_.'images/'.$zanpic.'.png"><font>'.$row['zan'].'</font></span><span class="reply one"><img src="'._tpldir_.'images/reply.png">回复</span></div>';
        $reply_num = $this->mydb->get_nums('comment',array('fid'=>$row['id']));
        if($reply_num > 0){
            echo '<ul class="reply-list" id="reply-list-'.$row['id'].'">';
            $reply = $this->mydb->get_select('comment',array('fid'=>$row['id']),'*','id desc',3);
            foreach($reply as $row2){
                $user2 = $this->mydb->get_row('user',array('id'=>$row2['uid']),'nickname,pic');
                $zan2 = $uid > 0 ? $this->mydb->get_row('comment_zan',array('did'=>$row2['id'],'uid'=>$uid)) : false;
                $zanpic2 = $zan2 ? 'zan_on' : 'zan';
                $del2 = $row2['uid'] == $uid ? '<span data-id="'.$row2['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i></span>' : '';
                echo '<li>'.$del2.'<div class="pic"><img src="'.getpic($user2['pic']).'"></div><div class="info"><div class="nickname">'.$user2['nickname'].'<span>'.datetime($row2['addtime']).'</span></div><div class="text">'.emoji_replace($row2['text'],1).'</div><div class="cmd" data-zan="'.($zan2?1:0).'" data-fid="'.$row['id'].'" data-id="'.$row2['id'].'" data-nickname="'.$user2['nickname'].'"><span class="zan"><img src="'._tpldir_.'images/'.$zanpic2.'.png"><font>'.$row2['zan'].'</font></span><span class="reply"><img src="'._tpldir_.'images/reply.png">回复</span></div></li>';
            }
            echo '</ul>';
            if($reply_num > 3) echo '<div data-id="'.$row['id'].'" class="reply-more">查看全部'.$reply_num.'条回复<i class="layui-icon layui-icon-down"></i></div>';
        }
        echo '</div></li>';
    }
    if($plnums == 0) echo '<div class="nodata">暂无评论，快来评论一波吧~!</div>';
    if($plnums > 15) echo '<div data-vid="'.$id.'" data-page="1" class="more">查看更多评论</div>';
}else{
    echo '<div class="nodata">评论已关闭~!</div>';
}
?>
    <div style="height: 50px;"></div>
    <div class="comment-input-box">
        <div class="comment-box">
            <i class="layui-icon layui-icon-edit"></i>
            <textarea id="comment-input" data-vid="<?=$id?>" data-fid="0" data-nickname="" name="text" placeholder="快来评论一波..."></textarea>
            <div class="comment-btn">发送</div>
        </div>
    </div>
</div>
<div class="play-info-text scrollbar">
    <h3>简介 <span class="play-info-close"><i class="layui-icon layui-icon-close"></i></span></h3>
    <div style="height: 40px;"></div>
    <div class="name"><?=$name?></div>
    <div class="row">
        <?=$state?>
        <?php if(!empty($area)) echo ' / '.$area;?>
        <?php if(!empty($year)) echo ' / '.$year;?>
        <?php if(!empty($lang)) echo ' / '.$lang;?>
    </div>
    <div class="text"><?=sub_str($text,600)?></div>
</div>
<div class="play-info-ji-box scrollbar">
    <h3>选集 <span class="play-info-ji-close"><i class="layui-icon layui-icon-close"></i></span></h3>
    <div style="height: 40px;"></div>
    <ul class="play-info-ji-ul"></ul>
</div>
<script>
$(function(){
    var clipboard = new Clipboard('.copy');
    clipboard.on('success',function(e) {
        e.clearSelection();
        layer.msg('分享地址复制成功');
    });
    var isWidth = $('.play-info').width();
    var tempIndex = $(".play-ji-ul.on li.on").index() - 2;
    tempIndex = tempIndex <= 0 ? 0 : tempIndex;
    var left = tempIndex * (isWidth / 7);
    $(".play-ji-ul.on").animate({scrollLeft: left},500);
    var tempIndex2 = $(".play-zu-ul li.on").index() - 2;
    tempIndex2 = tempIndex2 <= 0 ? 0 : tempIndex2;
    var left = tempIndex2 * (isWidth / 4);
    $(".play-zu-ul").animate({scrollLeft: left},500);
    var height = document.documentElement.clientHeight;
    $('.scrollbar').css('height',(height-230)+'px');
});
</script>