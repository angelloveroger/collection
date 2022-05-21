<script>$('#nav-hot').addClass('on');</script>
<div class="hot-pic-bg"></div>
<div class="layui-main hot-list">
    <div class="layui-container">
        <div class="layui-row">
            <ul class="nav-list">
                <li><a href="<?=links('hot')?>">影视排行</a><em></em></li>
                <li><a href="<?=links('hot','news')?>">最新更新</a><em></em></li>
                <li class="on"><a href="<?=links('starhot')?>">明星排行</a><em></em></li>
            </ul>
            <div class="star-hot">
                <ul>
                <?php
                $star = $this->mydb->get_select('star',array(),'id,name,pic,constellation,hits','hits desc',20);
                foreach($star as $k=>$row){
                    $kk = $k+1;
                    if($kk < 10) $kk = '0'.$kk;
                    echo '<li><a href="'.links('starinfo',$row['id']).'"><div class="left"><div class="rank"><span class="num n-'.$kk.'">'.$kk.'</span></div><div class="pic"><img alt="'.$row['name'].'" src="'.getpic($row['pic']).'"></div><div class="name"><h3>'.$row['name'].'</h3><p>'.$row['constellation'].'</p></div></div><div class="right"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></a></li>';
                }
                ?>
                </ul>
            </div>
        </div>
    </div>
</div>