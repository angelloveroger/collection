<div class="search-head">
	<div class="centerY search-head-box ">
		<div class="search-head-input flex1 centerY">
			<img src="<?=_tpldir_?>images/search.png" >
			<input id="search-key" type="text" value="<?=$key?>" placeholder="搜索影片、明星" />
		</div>
		<div class="search-head-cancel" id="search-bank" onclick="returns()">取消</div>
		<div class="search-head-cancel" id="search-btn" style="display:none;">搜索</div>
	</div>
</div>
<div style="height: 54px;"></div>
<div class="youLike">
	<ul style="margin-top:15px;" class="videoul" id="page-more" data-json='<?=json_encode(array('key'=>$key))?>'>
	<?php
	foreach($vod as $k=>$row){
		$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
		echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
	}
	if(empty($vod)){
	    echo '<p class="nodata">未找到相关记录，<b class="forum-btn" data-name="'.$key.'">点击求片</b></p>';
	}
	?>
	</ul>
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