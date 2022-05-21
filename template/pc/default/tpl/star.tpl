<script>$('#nav-star').addClass('on');</script>
<div class="layui-main">
    <div class="layui-container box7">
        <div class="layui-row">
            <h3><a href="<?=links('starhot')?>">热门明星 <i class="layui-icon">&#xe602;</i></a></h3>
            <ul class="star">
            <?php
            $star = $this->mydb->get_select('star',array(),'id,name,pic','hits desc',9);
            foreach($star as $row){
                echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
            }
            ?>
            </ul>
        </div>
    </div>
    <?php
    $star_class = $this->mydb->get_select('star_class',array(),'id,name','xid asc',10);
    foreach($star_class as $rowc){
    ?>
    <div class="layui-container star-box">
        <div class="layui-row">
            <h3>最新<?=$rowc['name']?><a href="<?=links('starlists',$rowc['id'])?>" class="right">查看全部 <i class="layui-icon">&#xe602;</i></a></h3>
            <ul class="star-list">
            <?php
            $star = $this->mydb->get_select('star',array('cid'=>$rowc['id']),'id,name,pic','id desc',18);
            foreach($star as $k=>$row){
                echo '<li><a href="'.links('starinfo',$row['id']).'"><div class="pic"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="name">'.$row['name'].'</div></a></li>';
            }
            ?>
            </ul>
        </div>
    </div>
    <?php } ?>
</div>
