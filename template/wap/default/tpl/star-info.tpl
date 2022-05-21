<div class="pageHead betweenX centerY" style="background:  none;">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo" style="color: #fff;"></i>
	</div>
	<div class="pageHead-text"></div>
	<div class="pageHead-right"><a href="<?=links('user/share')?>"><i style="color: #fff;" class="iconfont icon-fenxiang1"></i></a></div>
</div>
<div class="statbg" style="background-image: url(<?=getpic($pic)?>);">
	<div class="bg"></div>
	<div class="info">
		<div class="pic"><img src="<?=getpic($pic)?>"></div>
		<div class="name">
			<h3><?=$name?></h3>
			<p>
			<?php
				if(!empty($nationality)) echo '<span>'.$nationality.'</span>';
				if(!empty($constellation)) echo '<span>'.$constellation.'</span>';
                if(!empty($city)) echo '<span>'.$city.'</span>';
			?>
			</p>
		</div>
	</div>
</div>
<div class="star-nav">
	<ul class="star-nav-ul">
		<li class="on">资料<em></em></li>
	<?php
	$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',4);
	foreach($class as $k=>$rowc){
		echo '<li>'.$rowc['name'].'<em></em></li>';
	}
	?>
	</ul>
</div>
<div style="height: 220px;"></div>
<div class="star-info star-nav-vod" id="star-nav-0">
    <?php
    if(!empty($yname)) echo '<p><b>外文名：</b>'.$yname.'</p>';
    if(!empty($weight)) echo '<p><b>体  重：</b>'.$weight.'</p>';
    if(!empty($height)) echo '<p><b>身  高：</b>'.$height.'</p>';
    if(!empty($nationality)) echo '<p><b>国  籍：</b>'.$nationality.'</p>';
    if(!empty($ethnic)) echo '<p><b>民  族：</b>'.$ethnic.'</p>';
    if(!empty($professional)) echo '<p><b>职  业：</b>'.$professional.'</p>';
    if(!empty($blood_type)) echo '<p><b>血  型：</b>'.$blood_type.'</p>';
    if(!empty($birthday)) echo '<p><b>生  日：</b>'.$birthday.'</p>';
    if(!empty($city)) echo '<p><b>出生地：</b>'.$city.'</p>';
    if(!empty($constellation)) echo '<p><b>星  座：</b>'.$constellation.'</p>';
    if(!empty($academy)) echo '<p><b>毕业院校：</b>'.$academy.'</p>';
    if(!empty($company)) echo '<p><b>经纪公司：</b>'.$company.'</p>';
    if(!empty($production)) echo '<p><b>代表作品：</b>'.$production.'</p>';
    ?>
    <p><b>简介：</b><?=str_checkhtml($text)?></p>
</div>
<?php
foreach($class as $k=>$rowc){
	echo '<ul id="star-nav-'.($k+1).'" class="videoul classification-ul star-nav-vod" style="display:none;">';
    $cids = get_cid($rowc['id']);
    $vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,year,state,pay','rhits DESC',99,array('actor'=>$name));
    foreach($vod as $row){
		$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
		echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
	}
	if(empty($vod)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
    echo '</ul>';
}
?>
<script>
$(function(){
	$('.star-nav-ul li').click(function(){
		var id = $(this).index();
		$('.star-nav-ul li').removeClass('on');
		$(this).addClass('on');
		$('.star-nav-vod').hide();
		$('#star-nav-'+id).show();
	});
});
</script>