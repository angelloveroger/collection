<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">兑换记录</div>
	<div class="pageHead-right"></div>
</div>
<div style="height: 50px;"></div>
<div class="pageHead-tab">
	<div class="exchange collzt" id="pagejs">
	<?php
	foreach($list as $row){
		$cid = $row['cid'] == 2 ? '<p class="record-pirce">-'.$row['cion'].'金币</p>' : '<p class="record-pirce2">+'.$row['cion'].'金币</p>';
		echo '<div class="record-list centerY betweenX"><div><p class="record-title">'.$row['text'].'</p><p class="record-item">'.$row['addtime'].'</p></div>'.$cid.'</div>';
	}
	if(empty($list)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
	?>
	</div>
</div>
<script>
isloading = false,page = 1;
$(window).bind("scroll", function () {
    if($(document).scrollTop() + $(window).height() 
          > $(document).height() - 10 && !isloading) {
    	page++;
        isloading = true;
    	var tindex = layer.load();
        $.post('<?=links('user/exchange/lists')?>',{page:page}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.list.length; i++) {
                	var cion = res.data.list[i].cid == 2 ? '<p class="record-pirce">-'+res.data.list[i].cion+'金币</p>' : '<p class="record-pirce2">+'+res.data.list[i].cion+'金币</p>';
					html+='<div class="record-list centerY betweenX"><div><p class="record-title">'+res.data.list[i].text+'</p><p class="record-item">'+res.data.list[i].addtime+'</p></div>'+cion+'</div>';
                }
                $('#pagejs').append(html);
                if(res.data.page < res.data.pagejs) isloading = false;
            }
        },'json');
    }
});
</script>