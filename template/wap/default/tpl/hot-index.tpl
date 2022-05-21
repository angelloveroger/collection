<div class="ranking">
	<div class="ranking-head">
		<img class="ranking-bg" src="<?=_tpldir_?>images/ranking-bg.png" alt="">
		<div class="ranking-head-king centerXY ">
			<img class="ranking-j" src="<?=_tpldir_?>images/ranking-j.png" >
			<img class="ranking-t" src="<?=_tpldir_?>images/ranking-t.png">
		</div>
	</div>
	<div class="ranking-nav centerY">
			<p data-sort="rhits" class="active">日榜</p>
			<p data-sort="zhits">周榜</p>
			<p data-sort="yhits">月榜</p>
			<p data-sort="score">高分榜</p>
	</div>
</div>
<div style="height: 179px;"></div>
<ul class="rankingul">
	<li class="rankingul-li">
		<div class="rankingul-nav">
			<a data-id="0" class="rankingul-navactive" href="JavaScript:;">全部</a>
			<?php
			$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',20);
			foreach($class as $k=>$row){
				echo '<a data-id="'.$row['id'].'" href="JavaScript:;">'.$row['name'].'</a>';
			}
			?>
		</div>
		<div id="hot-vod-list">
		<?php
		$uid = (int)get_cookie('user_token');
		$vod = $this->mydb->get_select('vod',array(),'id,name,pic,state,hits,actor,pay,score,text','rhits desc',50);
		foreach($vod as $k=>$row){
		    $fav = $uid > 0 ? $this->mydb->get_row('fav',array('vid'=>$row['id'],'uid'=>$uid),'id') : false;
			$fon = $fav ? 'k' : '';
    		$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
			$pid = $k > 2 ? 4 : $k+1;
			echo '<div class="rankingul-cont"><a href="'.links('info',$row['id']).'" class="rankingul-cover"><img class="rankingul-cover-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" >'.$pay.'<div class="rankingul-rank"><img src="'._tpldir_.'images/ranking-'.$pid.'.png" alt=""><span>'.($k+1).'</span></div></a><div class="rankingul-info flex1"><div class="rankingul-info-head centerY betweenX"><p><a href="'.links('info',$row['id']).'">'.$row['name'].'</a></p><span>'.$row['score'].'</span></div><p class="rankingul-info-per">'.$row['actor'].'</p><p class="rankingul-info-tips"><a href="'.links('info',$row['id']).'" style="color:#999;">'.sub_str($row['text'],50).'</a></p><div class="rankingul-infofun centerY betweenX"><div class="rankingul-degree"><img src="'._tpldir_.'images/ranking-redu.png" alt=""><span>'.get_wan($row['hits']).'</span><span>热度值</span></div><div class="centerY"><div data-type="vod" data-fav="'.($fav?1:0).'" data-id="'.$row['id'].'" class="rankingul-collection centerXY fav-btn"><img src="'._tpldir_.'images/ranking-sc'.$fon.'.png" ></div><a href="'.links('play/'.$row['id']).'" class="rankingul-play centerXY"><img src="'._tpldir_.'images/ranking-bf.png" ><span>播放</span></a></div></div></div></div>';
		}
        if(empty($vod)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
		?>
		</div>
	</li>
</ul>
<!-- tabbat -->
<div style="height:50px;"></div>
<div class="centerY tabbat">
	<a href="/" >
		<img src="<?=_tpldir_?>images/index.png">
		<p>首页</p>
	</a>
	<a href="<?=links('topic')?>" >
		<img src="<?=_tpldir_?>images/special.png" >
		<p>专题</p>
	</a>
	<a href="<?=links('hot')?>" class="tabbat-active">
		<img src="<?=_tpldir_?>images/ranking-r.png" >
		<p>排行</p>
	</a>
	<a href="<?=links('user')?>">
		<img src="<?=_tpldir_?>images/my.png" >
		<p>我的</p>
	</a>
</div>
<script>
$(function(){
	$('#search-key').bind('input propertychange', function() {
	    if($(this).val().length == 0){
	    	$('#search-bank').show();
	    	$('#search-btn').hide();
	    }else{
	    	$('#search-bank').hide();
	    	$('#search-btn').show();
	    }
	});
});
</script>