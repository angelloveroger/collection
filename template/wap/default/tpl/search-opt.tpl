<div class="search-head">
	<div class="centerY search-head-box ">
		<div class="search-head-input flex1 centerY">
			<img src="<?=_tpldir_?>images/search.png" >
			<input id="search-key" type="text" value="" placeholder="搜索影片、明星" />
		</div>
		<div class="search-head-cancel" id="search-bank" onclick="returns()">取消</div>
		<div class="search-head-cancel" id="search-btn" style="display:none;">搜索</div>
	</div>
</div>
<div style="height: 54px;"></div>
<div class="search-box">
	<div class="betweenX search-box-head centerX">
		<div>搜索历史</div>
		<img class="search-del" style="height:19px;" src="<?=_tpldir_?>images/delete.png">
	</div>
	<div class="search-box-content rowW" id="search-list"></div>
</div>
<div class="search-box">
	<div class="betweenX search-box-head centerX">
		<div>热门搜索</div>
	</div>
	<div class="search-box-content rowW">
		<div>
		<?php
		$hot = $this->mydb->get_select('vod',array(),'id,name','sohits desc',10);
		foreach($hot as $row){
			echo '<a href="'.links('info',$row['id']).'">'.$row['name'].'</a>';
		}
		?>
		</div>
	</div>
</div>
<div class="youLike">
	<div class="betweenX search-box-head centerX">
		<div>猜你喜欢</div>
		<img class="refresh" src="<?=_tpldir_?>images/refresh.png">
	</div>
	<ul class="videoul">
	<?php
	//猜你喜欢
	$cids = array();
	$user = get_web_islog();
	if($user){
		$read = $this->mydb->get_select('watch',array('uid'=>$user['id']),'cid','cid desc',10,'','cid');
		foreach ($read as $row) $cids[] = $row['cid'];
	}
	$where = empty($cids) ? array() : array('cid'=>implode(',',$cids));
	$love = $this->mydb->get_select('vod',$where,'id,pic,name,state,pay','rhits desc',30);
	foreach($love as $k=>$row){
		$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
		echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
		if(($k+1)%6 == 0 && $k < 29) echo '</ul><ul class="videoul" style="display:none;">';
	}
	?>
	</ul>
</div>
<script>
$(function(){
	var searchhtml = '';
	var search = getcookie('search');
	if(search){
		var arr = search.split('|');
		for (var i = 0; i < arr.length; i++) {
			searchhtml+='<a href="<?=links('search')?>?key='+arr[i]+'">'+arr[i]+'</a>';
		}
	}
	if(searchhtml == ''){
		$('#search-list').html('<p class="nodata" style="padding:20px 0;color:#999;">暂无搜索历史~！</p>');
	}else{
		$('#search-list').html('<div>'+searchhtml+'</div>');
	}
	var int = 0;
	$('.refresh').click(function(){
		int++;
		if(int == $('.videoul').length) int = 0;
		for (var i = 0; i < $('.videoul').length; i++) {
			if(int == i){
				$('.videoul').eq(i).show();
			}else{
				$('.videoul').eq(i).hide();
			}
		}
	});
	$('.search-del').click(function(){
		layer.confirm('确定要清空吗', {
	        title:'删除提示',
	        btn: ['确定', '取消'], //按钮
	        shade:0.001
	    }, function(index) {
	    	$('#search-list').html('<p class="nodata" style="padding:20px 0;color:#999;">暂无搜索历史~！</p>');
	        setcookie('search','');
	        layer.close(index);
	    }, function(index) {
	        layer.close(index);
	    });
	});
	$('#search-key').bind('input propertychange', function() {
	    if($(this).val().length == 0){
	    	$('#search-bank').show();
	    	$('#search-btn').hide();
	    }else{
	    	$('#search-bank').hide();
	    	$('#search-btn').show();
	    }
	});
	$('#search-btn').click(function(){
		var key = $('#search-key').val();
		if(key != ''){
			var search = getcookie('search');
			var newdata = [];
			newdata.push(key);
			if(search){
				var arr = search.split('|');
				for (var i = 0; i < arr.length; i++) {
					if(arr[i] != key) newdata.push(arr[i]);
				}
			}
			setcookie('search',newdata.join('|'));
			window.location.href = '<?=links('search')?>?key='+key;
		}
	});
});
</script>