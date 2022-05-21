<div class="layui-main">
    <div class="layui-container box6">
        <div class="layui-row">
            <h3>专题列表</h3>
            <ul class="topic">
            <?php
            foreach($topic as $row){
                $nums = $this->mydb->get_nums('vod',array('ztid'=>$row['id']));
                echo '<li><a href="'.links('topicinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="text"><p>—— '.$nums.'个影片 ——</p><p>'.$row['name'].'</p></div></a></li>';
            }
            ?>
            </ul>
        </div>
    </div>
</div>
