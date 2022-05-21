<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="js-data">
            <?php
            if(empty($fav) && empty($topic)){
                echo '<div class="nodata"><img src="'._tpldir_.'images/nodata.png"><p>暂无记录~!</p></div>';
            }else{
                echo '<ul class="vod"><h3>视频<a href="'.links('user/fav/vod').'" class="right">更多</a></h3>';
                foreach($fav as $k=>$row){
                    $cls = ($k+1)%5 == 0 ? 'mr0' : '';
                    echo '<li class="'.$cls.'"><a href="'.links('play',$row['vid']).'"><div class="pic"><img src="'.getpic($row['pic']).'"><div class="play"></div></div><div class="name">'.$row['name'].'</div><div class="duration">'.$row['state'].'</div></a><div data-vid="'.$row['vid'].'" class="xuan none"><i class="layui-icon layui-icon-circle"></i></div></li>';
                }
                echo '</ul>';
                echo '<ul class="vod"><h3>专辑<a href="'.links('user/fav/topic').'" class="right">更多</a></h3>';
                foreach($topic as $k=>$row){
                    $cls = ($k+1)%5 == 0 ? 'mr0' : '';
                    echo '<li class="'.$cls.'"><a href="'.links('topicinfo',$row['tid']).'"><div class="pic"><img src="'.getpic($row['pic']).'"><div class="play"></div></div><div class="name">'.$row['name'].'</div></a><div data-vid="'.$row['tid'].'" class="xuan none"><i class="layui-icon layui-icon-circle"></i></div></li>';
                }
                echo '</ul>';
            }
            ?>
            </div>
        </div>
    </div>
</div>