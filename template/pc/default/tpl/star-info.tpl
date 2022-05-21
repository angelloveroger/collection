<script>$('#nav-star').addClass('on');</script>
<div class="layui-main" style="padding-bottom:20px;">
    <div class="layui-container">
        <div class="layui-row">
            <div class="star-info-box">
                <div class="pic"><img src="/packs/images/load.gif" lay-src="<?=getpic($pic)?>"></div>
                <div class="text">
                    <h4><?=$name?></h4>
                    <div class="row">
                    <?php
                    if(!empty($yname)) echo '<span>外文名：'.$yname.'</span>';
                    if(!empty($weight)) echo '<span>体  重：'.$weight.'</span>';
                    if(!empty($height)) echo '<span>身  高：'.$height.'</span>';
                    if(!empty($nationality)) echo '<span>国  籍：'.$nationality.'</span>';
                    if(!empty($ethnic)) echo '<span>民  族：'.$ethnic.'</span>';
                    if(!empty($professional)) echo '<span>职  业：'.$professional.'</span>';
                    if(!empty($blood_type)) echo '<span>血  型：'.$blood_type.'</span>';
                    if(!empty($birthday)) echo '<span>生  日：'.$birthday.'</span>';
                    if(!empty($city)) echo '<span>出生地：'.$city.'</span>';
                    if(!empty($constellation)) echo '<span>星  座：'.$constellation.'</span>';
                    if(!empty($academy)) echo '<span>毕业院校：'.$academy.'</span>';
                    if(!empty($company)) echo '<span>经纪公司：'.$company.'</span>';
                    if(!empty($production)) echo '<span class="auto">代表作品：'.$production.'</span>';
                    ?>
                    </div>
                    <p>简介：<?=str_checkhtml($text)?></p>
                </div>
            </div>
        </div>
    </div>
    <?php
    $class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',5);
    foreach($class as $rowc){
    ?>
    <div class="layui-container star-box">
        <div class="layui-row">
            <h3>TA演过的<?=$rowc['name']?></h3>
            <div class="star_vod_list">
                <ul class="star_vod_ul">
                <?php
                $cids = get_cid($rowc['id']);
                $vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,year,state,score','rhits DESC',100,array('actor'=>$name));
                foreach($vod as $row){
                    echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="'.getpic($row['pic']).'"><div class="play"></div><div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="name">'.$row['name'].'</div><div class="actor">'.$row['year'].'</div></a></li>';
                }
                ?>
                </ul>
                <?php if(count($vod) > 6){ ?>
                <div class="more-left"><i class="layui-icon layui-icon-left"></i></div>
                <div class="more-right"><i class="layui-icon layui-icon-right"></i></div>
                <?php } ?>
            </div>
        </div>
    </div>
    <?php } ?>
</div>
<script type="text/javascript">
$('.star_vod_ul').each(function(){
    if($(this).children('li').length == 0){
        $(this).parent().parent().parent().remove();
    }
});
</script>