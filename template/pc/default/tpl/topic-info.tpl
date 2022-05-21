<div class="layui-main">
    <div class="layui-container">
        <div class="layui-row">
            <div class="topic-info-box">
                <div class="pic"><img src="/packs/images/load.gif" lay-src="<?=getpic($pic)?>"></div>
                <div class="text">
                    <h4><?=$name?></h4>
                    <p><?=$text?></p>
                </div>
            </div>
            <h3 class="search_name">该专题所包含的影片<span class="right">本专题共“<?=count($vodlist)?>”部影片</span></h3>
            <ul class="vod_list">
            <?php
            foreach($vodlist as $row){
                echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"><div class="play"></div><div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div></a></li>';
            }
            ?>
            </ul>
        </div>
    </div>
</div>