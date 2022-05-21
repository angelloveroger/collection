
<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="js-data">
            <?php
            if(empty($watch)){
                echo '<div class="nodata"><img src="'._tpldir_.'images/nodata.png"><p>暂无记录~!</p></div>';
            }else{
                echo '<ul class="vod">';
                $i = $n = 0;
                foreach($watch as $k=>$row){
                    if($row['type'] == 1) echo '<h3>今日<span class="right">编辑</span></h3>';
                    if($row['type'] > 0) $i = 0;
                    $i++;
                    $cls = $i%5 == 0 ? 'mr0' : ''; 
                    if($i > 1 && ($i-1)%10 == 0) $n = 1;
                    $none = $n == 1 ? 'none' : '';
                    if($row['type'] == 7) echo '<h3 class="'.$none.'">一周内</h3>';
                    if($row['type'] == 999) echo '<h3 class="'.$none.'">更早</h3>';
                    echo '<li class="'.$cls.' '.$none.'"><a href="'.links('play',$row['vid'],$row['jid']).'"><div class="pic"><img src="'.getpic($row['pic']).'"><div class="play"></div></div><div class="name">'.$row['name'].'</div><div class="duration">'.$row['duration'].'</div></a><div data-vid="'.$row['vid'].'" class="xuan none"><i class="layui-icon layui-icon-circle"></i></div></li>';
                }
                if($n == 1){
                    echo '<div class="data-more">加载更多记录<i class="layui-icon layui-icon-down"></i></div>';
                }
                echo '</ul>';
            }
            ?>
            </div>
        </div>
    </div>
</div>
<div class="user-xuan-cmd none">
    <div class="layui-container">
        <div class="layui-row">
            <span data-type="xuan">全选</span>
            <span data-op="watch" data-type="del">删除</span>
        </div>
    </div>
</div>