<script>$('#nav-<?=$fid?>').addClass('on');</script>
<div class="layui-main">
    <div class="layui-container">
        <div class="layui-row">
            <div class="vod-info">
                <div class="pic"><img src="/packs/images/load.gif" lay-src="<?=getpic($pic)?>"></div>
                <div class="info">
                    <h3><?=$name?></h3>
                    <p><span>分类：</span><a href="<?=get_vod_url(array('cid'=>$cid))?>"><?=$cname?></a><em>|</em><span>地区：</span><a href="<?=get_vod_url(array('cid'=>$cid,'area'=>$area))?>"><?=$area?></a><em>|</em><span>年份：</span><a href="<?=get_vod_url(array('cid'=>$cid,'year'=>$year))?>"><?=$year?></a></p>
                    <p><span>导演：</span>
                    <?php 
                    foreach($director_arr as $v){
                        echo '<a href="'.links('search').'?key='.$v.'">'.$v.'</a>';
                    }
                    ?>
                    </p>
                    <p><span>主演：</span>
                    <?php 
                    foreach($actor_arr as $v){
                        echo '<a href="'.links('search').'?key='.$v.'">'.$v.'</a>';
                    }
                    ?>
                    </p>
                    <p><span>更新：</span><?=$state?><em>|</em><?=date('Y-m-d',$addtime)?></p>
                    <div class="text"><span>简介：</span><?=$text?></div>
                    <div class="btn">
                        <a href="<?=links('play',$id,0)?>"><i class="layui-icon layui-icon-triangle-r"></i>立即播放</a>
                        <?php
                        if($fav == 1){
                            echo '<a data-fav="1" data-id="'.$id.'" class="fav-btn" href="javascript:;"><i class="layui-icon layui-icon-heart-fill"></i>已收藏</a>';
                        }else{
                            echo '<a data-fav="0" data-id="'.$id.'" class="fav-btn" href="javascript:;"><i class="layui-icon layui-icon-heart"></i>收藏</a>';
                        }
                        ?>
                    </div>
                    <div class="qrcode">
                        <div class="txt"><i class="layui-icon layui-icon-cellphone"></i>手机观看</div>
                        <div class="img">
                            <img src="<?=links('ajax/qrcode')?>">
                            <p>扫一扫手机观看</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ads"><script src="<?=_tpldir_?>adv/info.js"></script></div>
        <div class="layui-row">
            <div class="vod-zu">
                <div class="zu-box">
                    <h3>播放地址</h3>
                    <ul>
                    <?php
                    foreach($play as $k=>$v){
                        $cls = $k == 0 ? 'on' : '';
                        echo '<li data-id="'.$v['id'].'" class="'.$cls.'">'.$v['name'].'<em></em></li>';
                    }
                    ?>
                    </ul>
                    <div class="right" data-sort="asc"><span><i class="layui-icon">&#xe66b;</i></span>正序</div>
                </div>
                <div class="ji-box scrollbar">
                    <?php
                    foreach($play as $k=>$v){
                        $cls = $k == 0 ? ' style="display:block"' : '';
                        echo '<ul id="zu-'.$v['id'].'"'.$cls.'>';
                        foreach($v['ji'] as $v2){
                            $pay = $v2['pay'] > 0 ? '<span class="pay'.$v2['pay'].' jipay"></span>' : '';
                            echo '<li><a href="'.links('play',$id,$v2['id']).'">'.$v2['name'].'</a>'.$pay.'</li>';
                        }
                        echo '</ul>';
                    }
                    ?>
                </div>
            </div>
        </div>
        <div class="layui-row box7">
            <h3>演员表</h3>
            <div class="star">
                <ul>
                <?php 
                $sql = "SELECT * FROM "._DBPREFIX_."star where FIND_IN_SET(name,'".implode(',',$actor_arr)."') order by hits LIMIT 30";
                $star = $this->mydb->get_sql($sql);
                foreach($star as $row){
                    echo '<li><a target="_blank" href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
                }
                ?>
                </ul>
                <?php if(count($star) > 9){ ?>
                <div class="more-left"><i class="layui-icon layui-icon-left"></i></div>
                <div class="more-right"><i class="layui-icon layui-icon-right"></i></div>
                <?php } ?>
            </div>
        </div>
        <script>if($('.star li').length == 0) $('.box7').hide();</script>
        <div class="layui-row">
            <div class="comment-box">
                <div class="comment-list">
                    <?php
                    if(_PL_ == 1){
                        $plnums = $this->mydb->get_nums('comment',array('vid'=>$id,'fid'=>0));
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
                        echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="info"><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div><div class="hits"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></div></a></li>';
                    }
                    ?>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>