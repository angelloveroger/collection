<div class="specialhead">拯救剧荒</div>
<div style="height: 50px;"></div>
<ul class="specialul">
<?php
foreach($topic as $row){
	echo '<li class="specialli"><a href="'.links('topicinfo',$row['id']).'" class="special-li"><img style="max-height: 170px;" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" ><p>'.$row['name'].'</p></a></li>';
}
if(empty($topic)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
?>
</ul>
<!-- tabbat -->
<div style="height:50px;"></div>
<div class="centerY tabbat">
	<a href="/">
		<img src="<?=_tpldir_?>images/index.png">
		<p>首页</p>
	</a>
	<a href="<?=links('topic')?>" class="tabbat-active">
		<img src="<?=_tpldir_?>images/special-r.png" >
		<p>专题</p>
	</a>
	<a href="<?=links('hot')?>">
		<img src="<?=_tpldir_?>images/ranking.png" >
		<p>排行</p>
	</a>
	<a href="<?=links('user')?>">
		<img src="<?=_tpldir_?>images/my.png" >
		<p>我的</p>
	</a>
</div>