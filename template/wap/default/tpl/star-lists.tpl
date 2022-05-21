<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text"><?=$name?></div>
	<div class="pageHead-right"></div>
</div>
<div style="height: 54px;"></div>
<ul class="starlist" style="margin-top:12px;" id="star-page-more" data-json='<?=json_encode(array('cid'=>$id,'size'=>30))?>'>
	<?php
    foreach($star as $k=>$row){
		echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
	}
	?>
</ul>