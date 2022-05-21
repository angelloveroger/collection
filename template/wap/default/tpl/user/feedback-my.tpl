<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">反馈记录</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="feedrecord">
<?php
foreach($list as $row){
	$msg = $row['reply_time'] > 0 ? '<span class="typere2">已回复</span>' : '<span class="typere1">待回复</span>';
	echo '<a href="'.links('user/feedback/info/'.$row['id']).'" class="feedrecord-list centerY betweenX"><div class="feedrecord-info"><p class="feedrecord-title">'.sub_str($row['text'],30).'</p><p class="feedrecord-item">'.date('Y-m-d H:i:s',$row['addtime']).'</p></div><div class="feedrecord-type centerY">'.$msg.'<img src="'._tpldir_.'images/right2.png"></div></a>';
}
?>
</div>