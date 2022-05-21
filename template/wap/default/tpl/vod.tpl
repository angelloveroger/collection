<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left">
		<a style="display:block;" href="/"><i class="iconfont icon-xiangzuo"></i></a>
	</div>
	<div class="pageHead-text">全部影片</div>
	<div class="pageHead-right">
		<a href="<?=links('search/opt')?>"><i class="iconfont icon-sousuo4"></i></a>
	</div>
</div>
<div style="height: 54px;"></div>
<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/vod1.js"></script></div>
<ul class="classification-type">
	<li>
        <?php
        $class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',30);
        foreach($class as $row){
            $cls = $row['id'] == $fid ? 'clactive' : '';
            echo '<a href="'.get_vod_url(array('cid'=>$row['id'])).'" class="'.$cls.'">'.$row['name'].'</a>';
        }
        ?>
	</li>
	<li id="cid">
        <a href="<?=get_vod_url(array('cid'=>$fid))?>" <?php if($cid == 0) echo ' class="clactive"';?>>全部</a>
    	<?php
        $class = $this->mydb->get_select('class',array('fid'=>$fid),'id,name','xid asc',50);
        foreach($class as $row){
            $cls = $row['id'] == $id ? 'clactive' :'';
            echo '<a href="'.get_vod_url(array('cid'=>$row['id'])).'" class="cid '.$cls.'">'.$row['name'].'</a>';
        }
    	?>
	</li>
    <script>if($('#cid .cid').length == 0) $('#cid').hide();</script>
	<li>
        <a href="<?=get_vod_url(array('area'=>''))?>" <?php if($area == '') echo ' class="clactive"';?>>全部</a>
    	<?php
        foreach($area_list as $v){
            $cls = $v == $area ? 'clactive' :'';
            echo '<a href="'.get_vod_url(array('area'=>$v)).'" class="'.$cls.'">'.$v.'</a>';
        }
    	?>
	</li>
	<li>
		<a href="<?=get_vod_url(array('year'=>''))?>" <?php if($year == '') echo ' class="clactive"';?>>全部</a>
        <?php
        for($y=date('Y');$y>2006;$y--){
            $cls = $y == $year ? 'clactive' :'';
            echo '<a href="'.get_vod_url(array('year'=>$y)).'" class="'.$cls.'">'.$y.'</a>';
        }
        ?>
	</li>
	<li>
        <a href="<?=get_vod_url(array('sort'=>''))?>"<?php if($sort == 'addtime') echo ' class="clactive"';?>>更新</a>
        <a href="<?=get_vod_url(array('sort'=>'hits'))?>"<?php if($sort == 'hits') echo ' class="clactive"';?>>人气</a>
        <a href="<?=get_vod_url(array('sort'=>'score'))?>"<?php if($sort == 'score') echo ' class="clactive"';?>>评分</a>
	</li>
</ul>
<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/vod2.js"></script></div>
<ul class="videoul classification-ul" id="page-more" data-json='<?=json_encode(array('cid'=>$cid,'area'=>$area,'year'=>$year,'sort'=>$sort))?>'>
	<?php
	if(empty($vod)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
	foreach($vod as $k=>$row){
		$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
		echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
	}
	?>
</ul>
<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/vod3.js"></script></div>
<script>
$(function(){
	var isWidth = $('.classification-type').width() / 7;
	$(".classification-type li").each(function(){
		var tempIndex = $(this).children('.clactive').index() - 2;
		tempIndex = tempIndex <= 0 ? 0 : tempIndex;
		var left = tempIndex * isWidth;
		console.log(left);
		$(this).animate({scrollLeft: left},500);
	});
});
</script>