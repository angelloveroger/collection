<div class="special-dhead">
	<img class="special-dbg" src="<?=empty($pic) ? _tpldir_.'images/sc-bg.png' : getpic($pic);?>">
	<div class="bg"></div>
	<div class="back" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="special-dbox">
		<div class="centerY betweenX special-dcont">
			<div class="special-dtitle">合集>><?=$name?></div>
			<?php
			$uid = (int)get_cookie('user_token');
			$fav = $uid > 0 ? $this->mydb->get_row('topic_fav',array('tid'=>$id,'uid'=>$uid),'id') : false;
			if($fav){
				echo '<div data-type="topic" data-fav="'.($fav?1:0).'" data-id="'.$id.'" class="centerXY special-dshouc fav-btn"><span>已收藏</span></div>';
			}else{
				echo '<div data-type="topic" data-fav="'.($fav?1:0).'" data-id="'.$id.'" class="centerXY special-dshouc fav-btn"><img src="'._tpldir_.'images/sc-add.png"><span>收藏</span></div>';
			}
			?>
		</div>
		<div class="special-dnum">共<?=count($vodlist)?>部</div>
	</div>
</div>
<div style="height:179px;"></div>
<ul class="rankingul specialDetails">
	<?php
    foreach($vodlist as $row){
    	$fav = $uid > 0 ? $this->mydb->get_row('fav',array('vid'=>$row['id'],'uid'=>$uid),'id') : false;
		$fon = $fav ? 'k' : '';
    	$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
        echo '<li class="rankingul-li"><a href="'.links('info',$row['id']).'" class="rankingul-cont centerY"><div  class="rankingul-cover"><img class="rankingul-cover-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'</div><div class="centerY betweenX flex1"><div class="info"><div class="rankingul-info-head centerY betweenX"><p>'.$row['name'].'</p></div><p class="rankingul-info-per">'.$row['actor'].'</p><p class="rankingul-info-tips">'.sub_str($row['text'],100).'</p></div><div data-type="vod" data-fav="'.($fav?1:0).'" data-id="'.$row['id'].'" class="specialDetails-sck fav-btn"><img src="'._tpldir_.'images/ranking-sc'.$fon.'.png" ></div></div></a></li>';
    }
    ?>
</ul>