<script>$('#nav-hot').addClass('on');</script>
<div class="hot-pic-bg"></div>
<div class="layui-main hot-list">
    <div class="layui-container">
        <div class="layui-row">
            <ul class="nav-list">
                <li class="on"><a href="<?=links('hot')?>">影视排行</a><em></em></li>
                <li><a href="<?=links('hot','news')?>">最新更新</a><em></em></li>
                <li><a href="<?=links('starhot')?>">明星排行</a><em></em></li>
            </ul>
            <div class="hot-box">
            <?php
            $class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',6);
            foreach($class as $rowc){
                echo '<ul><h3>'.$rowc['name'].'</h3>';
                $cids = get_cid($rowc['id']);
                $vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,state,hits,actor','yhits desc',8);
                foreach($vod as $k=>$row){
                    $kk = $k+1;
                    echo '<li><a href="'.links('info',$row['id']).'"><div class="m-left"><div class="rank"><span class="num n-'.$kk.'">'.$kk.'</span></div><div class="pic"><img alt="'.$row['name'].'" src="'.getpic($row['pic']).'"><div class="state">'.$row['state'].'</div></div></div><div class="m-right"><div class="name">'.$row['name'].'</div><div class="actor">'.$row['actor'].'</div><div class="hits"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></div></a></li>';
                }
                echo '</ul>';
            }
            ?>
            </div>
        </div>
    </div>
</div>