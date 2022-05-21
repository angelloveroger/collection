<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="js-data">
            <?php
            if(empty($comment)){
                echo '<div class="nodata"><img src="'._tpldir_.'images/nodata.png"><p>暂无记录~!</p></div>';
            }else{
                echo '<div class="comment-box" style="width: 100%;"><div class="comment-list"><ul id="comment-list">';
                foreach($comment as $row){
                    $zanpic = $row['is_zan'] ? 'zan_on' : 'zan';
                    $del = $row['is_del'] ? '<span data-id="'.$row['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
                    echo '<li>'.$del.'<div class="pic"><img src="'.getpic($row['upic']).'"></div><div class="info"><div class="nickname">'.$row['nickname'].'<span>'.datetime($row['addtime']).'</span></div><div class="text">'.emoji_replace($row['text'],1).'</div><div class="cmd" data-zan="'.($row['is_zan']?1:0).'" data-id="'.$row['id'].'" data-nickname="'.$user['nickname'].'"><span class="zan"><img src="'._tpldir_.'images/'.$zanpic.'.png"><font>'.$row['zan'].'</font></span></div><a href="'.links('play',$row['vid']).'" class="vod"><img src="'._tpldir_.'images/pc.png">'.$row['vname'].'</a>';
                    if($row['reply_num'] > 0){
                        echo '<ul class="reply-list" id="reply-list-'.$row['id'].'">';
                        foreach($row['reply'] as $row2){
                            $zanpic2 = $row2['is_zan'] ? 'zan_on' : 'zan';
                            $del2 = $row2['is_del'] ? '<span data-id="'.$row2['id'].'" class="del"><i class="layui-icon layui-icon-delete"></i>删除</span>' : '';
                            echo '<li>'.$del2.'<div class="pic"><img src="'.getpic($row2['upic']).'"></div><div class="info"><div class="nickname">'.$row2['nickname'].'<span>'.datetime($row2['addtime']).'</span></div><div class="text">'.emoji_replace($row2['text'],1).'</div><div class="cmd" data-zan="'.($row2['is_zan']?1:0).'" data-id="'.$row2['id'].'" data-nickname=""><span class="zan"><img src="'._tpldir_.'images/'.$zanpic2.'.png"><font>'.$row2['zan'].'</font></span></div></li>';
                        }
                        echo '</ul>';
                        if($row['reply_num'] > 3) echo '<div data-id="'.$row['id'].'" class="reply-more">查看全部'.$row['reply_num'].'条回复<i class="layui-icon layui-icon-down"></i></div>';
                    }
                    echo '</div></li>';
                }
                echo '</ul></div></div>';
            }
            ?>
            </div>
        </div>
        <?php if($pagejs > 1){ ?>
        <div class="layui-row">
            <div id="pages" data-count="<?=$nums?>" data-limit="20" data-page="<?=$page?>" data-link="<?=links('user/comment/index/[page]')?>"></div>
        </div>
        <?php } ?>
    </div>
</div>