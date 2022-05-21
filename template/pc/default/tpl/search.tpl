<div class="layui-main">
    <div class="layui-container">
        <div class="layui-row">
            <h3 class="search_name">为您找到 <?=$nums?> 个“<?=$key?>”的相关视频</h3>
            <ul class="vod_list">
            <?php
            foreach($vod as $row){
                echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"><div class="play"></div><div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div></a></li>';
            }
            if(empty($vod)){
                echo '<p class="nodata">未找到相关记录，<b class="forum-btn" data-name="'.$key.'">点击求片</b></p>';
            }
            ?>
            </ul>
        </div>
        <?php if($pagejs > 1){ ?>
        <div class="layui-row">
            <div id="pages" data-count="<?=$nums?>" data-limit="48" data-page="<?=$page?>" data-link="<?=links('search')?>?key=<?=$key?>&page={page}"></div>
        </div>
        <?php } ?>
    </div>
</div>