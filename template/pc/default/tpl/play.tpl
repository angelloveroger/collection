<script>$('#nav-<?=$fid?>').addClass('on');</script>
<link rel="stylesheet" href="/packs/player/player.css">
<script src="/packs/player/player.js"></script>
<script src="<?=_tpldir_?>js/clipboard.min.js"></script>
<div class="layui-main">
    <div class="layui-container">
        <div class="layui-row">
            <div class="vod-play">
                <div class="vod-box">
                    <h3>正在播放：<?=$name?> <?=$jname?></h3>
                    <div class="video" id="player-video" data-jid="<?=$ji['id']?>">
                        <p>加载中...</p>
                    </div>
                    <div class="cmd-box">
                    <?php
                        if($fav == 1){
                            echo '<span class="fav-btn" data-fav="1" data-id="'.$id.'"><i class="layui-icon layui-icon-heart-fill"></i>已收藏</span>';
                        }else{
                            echo '<span class="fav-btn" data-fav="0" data-id="'.$id.'"><i class="layui-icon layui-icon-heart"></i>收藏</span>';
                        }
                    ?>
                        <span class="comment-btn"><i class="layui-icon layui-icon-chat"></i>评论</span>
                        <span class="share-btn" data-clipboard-text="<?=$share_txt?>"><i class="layui-icon layui-icon-release"></i>分享</span>
                        <span class="qrcode-btn"><i class="layui-icon layui-icon-cellphone"></i>用手机看</span>
                        <div class="qrcode-img">
                            <img src="<?=links('ajax/qrcode')?>">
                            <p>扫一扫手机观看</p>
                        </div>
                        <div class="right">
                            <em><i class="layui-icon layui-icon-fire"></i><?=get_wan($hits)?></em>
                            <em><i class="layui-icon layui-icon-heart"></i><?=get_wan($shits)?></em>
                            <em class="comment-btn"><i class="layui-icon layui-icon-chat"></i><?php 
                            $plnums = $this->mydb->get_nums('comment',array('vid'=>$id,'fid'=>0));
                            echo get_wan($plnums)
                            ?></em>
                        </div>
                    </div>
                    <div class="full-btn" data-full="0"><i class="layui-icon layui-icon-right"></i></div>
                </div>
                <div class="zu-vod">
                    <h3><?=$name?></h3>
                    <div class="text">
                        <em><?=$score?>分</em>/<?=$cname?>/<?=$area?>/<?=$year?>
                        <span class="play-zu-btn right">换线路<i class="layui-icon layui-icon-down"></i></span>
                        <ul class="zu-list">
                        <?php
                        foreach($play as $row){
                            $cls = $row['id'] == $ji['zid'] ? ' class="on"' : '';
                            echo '<li data-id="'.$row['id'].'"'.$cls.'>'.$row['name'].'</li>';
                        }
                        ?>
                        </ul>
                    </div>
                    <?php
                    foreach($play as $rowz){
                        $cls = $ji['zid'] == $rowz['id'] ? ' style="display:block;"' : '';
                        echo '<ul class="scrollbar" id="zu-'.$rowz['id'].'"'.$cls.'>';
                        foreach($rowz['ji'] as $row){
                            $cls = $row['id'] == $ji['id'] ? ' class="on"' : '';
                            $pay = $row['pay'] > 0 ? '<span class="pay'.$row['pay'].' jipay2"></span>' : '';
                            echo '<li'.$cls.'><a href="'.links('play',$id,$row['id']).'">'.$row['name'].'</a>'.$pay.'</li>';
                        }
                        echo '</ul>';
                    }
                    ?>
                </div>
            </div>
        </div>
        <div class="ads"><script src="<?=_tpldir_?>adv/play.js"></script></div>
        <div class="layui-row">
            <div class="vod-star">
                <ul class="vod-star-ul">
                <?php 
                $sql = "SELECT id,cid,name,pic,constellation FROM "._DBPREFIX_."star where FIND_IN_SET(name,'".implode(',',$actor_arr)."') order by hits LIMIT 5";
                $star = $this->mydb->get_sql($sql);
                foreach($star as $k=>$row){
                    $cls = $k == 0 ? ' on' : '';
                    echo '<li class="cid'.$row['cid'].$cls.'" data-id="'.$row['id'].'"><a target="_blank" class="wrap" href="'.links('starinfo',$row['id']).'"><div class="pic"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="info"><h3>'.$row['name'].'</h3><p>'.$row['constellation'].'</p></div></a><i class="line"></i></li>';
                }
                echo '</ul>';
                foreach($star as $k=>$row2){
                    $cls = $k == 0 ? ' style="display:block"' : '';
                    echo '<ul class="star-vlist" '.$cls.' id="star-li-'.$row2['id'].'">';
                    $sql = "select id,name,pic,state,pay from "._DBPREFIX_."vod where LOCATE('".$row2['name']."',actor) > 0 and id NOT IN(".$id.") order by rhits desc limit 5";
                    $vod = $this->mydb->get_sql($sql);
                    foreach($vod as $row){
                        $pay = $row['pay'] > 0 ? '<span class="pay'.$row['pay'].'"></span>' : '';
                        echo '<li><a href="'.links('play',$row['id'],0).'"><div class="pic"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<div class="state">'.$row['state'].'</div></div><h3>'.$row['name'].'</h3></a></li>';
                    }
                    echo '</ul>';
                }
                ?>
            </div>
        </div>
        <div class="layui-row">
            <div class="comment-box">
                <div class="comment-list">
                    <?php
                    if(_PL_ == 1){
                        echo '<h3>评论（'.$plnums.'）</h3><div class="box"><textarea data-vid="'.$id.'" data-fid="0" data-nickname="" name="text" placeholder="快来评论一波..."></textarea><div class="num"><span>0</span>/200</div><div class="btn">发布</div><div class="comment-nolog"><p>登录后可发表评论</p><p class="login-btn">立即登录</p></div></div><ul id="comment-list">';
                        $comment = $this->mydb->get_select('comment',array('vid'=>$id,'fid'=>0),'*','id desc',15);
                        foreach($comment as $row){
                            $user = $this->mydb->get_row('user',array('id'=>$row['uid']),'nickname,pic');
                            $zan =  $uid > 0 ? $this->mydb->get_row('comment_zan',array('did'=>$row['id'],'uid'=>$uid)) : false;
                            $zanpic = $zan ? 'zan_on' : 'zan';
                            $del = $row['uid'] == $uid ? '<span data-id="'.$row['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
                            echo '<li>'.$del.'<div class="pic"><img src="'.getpic($user['pic']).'"></div><div class="info"><div class="nickname">'.$user['nickname'].'<span>'.datetime($row['addtime']).'</span></div><div class="text">'.emoji_replace($row['text'],1).'</div><div class="cmd" data-zan="'.($zan?1:0).'" data-id="'.$row['id'].'" data-nickname="'.$user['nickname'].'"><span class="zan"><img src="'._tpldir_.'images/'.$zanpic.'.png"><font>'.$row['zan'].'</font></span><span class="reply one"><img src="'._tpldir_.'images/reply.png">回复</span></div><div class="box"><textarea data-vid="'.$id.'" data-fid="'.$row['id'].'" data-nickname="'.$user['nickname'].'" name="text" placeholder="回复：'.$user['nickname'].'"></textarea><div class="num"><span>0</span>/200</div><div class="btn">发布</div></div>';
                            $reply_num = $this->mydb->get_nums('comment',array('fid'=>$row['id']));
                            if($reply_num > 0){
                                echo '<ul class="reply-list" id="reply-list-'.$row['id'].'">';
                                $reply = $this->mydb->get_select('comment',array('fid'=>$row['id']),'*','id desc',3);
                                foreach($reply as $row2){
                                    $user2 = $this->mydb->get_row('user',array('id'=>$row2['uid']),'nickname,pic');
                                    $zan2 = $uid > 0 ? $this->mydb->get_row('comment_zan',array('did'=>$row2['id'],'uid'=>$uid)) : false;
                                    $zanpic2 = $zan2 ? 'zan_on' : 'zan';
                                    $del2 = $row2['uid'] == $uid ? '<span data-id="'.$row2['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
                                    echo '<li>'.$del2.'<div class="pic"><img src="'.getpic($user2['pic']).'"></div><div class="info"><div class="nickname">'.$user2['nickname'].'<span>'.datetime($row2['addtime']).'</span></div><div class="text">'.emoji_replace($row2['text'],1).'</div><div class="cmd" data-zan="'.($zan2?1:0).'" data-id="'.$row2['id'].'" data-nickname=""><span class="zan"><img src="'._tpldir_.'images/'.$zanpic2.'.png"><font>'.$row2['zan'].'</font></span><span class="reply"><img src="'._tpldir_.'images/reply.png">回复</span></div></li>';
                                }
                                echo '</ul>';
                                if($reply_num > 3) echo '<div data-id="'.$row['id'].'" class="reply-more">查看全部'.$reply_num.'条回复<i class="layui-icon layui-icon-down"></i></div>';
                            }
                            echo '</div></li>';
                        }
                        if($plnums == 0) echo '<div class="nodata">暂无评论，快来评论一波吧~!</div>';
                        if($plnums > 15) echo '<div data-vid="'.$id.'" data-page="1" class="more">查看更多评论</div>';
                        echo '</ul>';
                    }else{
                        echo '<div class="nodata">评论已关闭~!</div>';
                    }
                    ?>
                </div>
            </div>
            <div class="love-box">
                <div class="love-list">
                    <h3>猜你喜欢</h3>
                    <ul>
                    <?php
                    foreach($love as $row){
                        $pay = $row['pay'] > 0 ? '<span class="pay'.$row['pay'].'"></span>' : '';
                        echo '<li><a href="'.links('play',$row['id'],0).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="info"><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div><div class="hits"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></div></a></li>';
                    }
                    ?>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>