<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="js-data">
            <?php
            if(empty($topic)){
                echo '<div class="nodata"><img src="'._tpldir_.'images/nodata.png"><p>暂无记录~!</p></div>';
            }else{
                echo '<ul class="vod"><h3 style="height:0;padding-top:0;"><span class="right" style="margin-top:-50px;">编辑</span></h3>';
                foreach($topic as $k=>$row){
                    $cls = ($k+1)%5 == 0 ? 'mr0' : '';
                    echo '<li class="'.$cls.'"><a href="'.links('topicinfo',$row['tid']).'"><div class="pic"><img src="'.getpic($row['pic']).'"><div class="play"></div></div><div class="name">'.$row['name'].'</div></a><div data-vid="'.$row['tid'].'" class="xuan none"><i class="layui-icon layui-icon-circle"></i></div></li>';
                }
                echo '</ul>';
            }
            ?>
            </div>
        </div>
        <?php if($pagejs > 1){ ?>
        <div class="layui-row">
            <div id="pages" data-count="<?=$nums?>" data-limit="20" data-page="<?=$page?>" data-link="<?=links('user/fav/topic/[page]')?>"></div>
        </div>
        <?php } ?>
    </div>
</div>
<div class="user-xuan-cmd none">
    <div class="layui-container">
        <div class="layui-row">
            <span data-type="xuan">全选</span>
            <span data-table="topic" data-op="fav" data-type="del">删除</span>
        </div>
    </div>
</div>