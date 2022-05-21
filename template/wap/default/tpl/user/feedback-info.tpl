<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">我的反馈</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<?php if($reply_time == 0) echo '<p class="feedbackmy-tips">您的问题将于1-2个工作日内收到并回复，感谢您的支持</p>';?>
<div class="feedbackmy-wt centerY betweenX">
	<p class="feedbackmy-title"><?=$text?></p>
	<p class="feedbackmy-item"><?=date('Y-m-d H:i:s',$addtime)?></p>
</div>
<?php if($reply_time > 0){ ?>
<p class="feedbackmy-huif">
	已回复：
</p>
<div class="feedbackmy-cont">
	<?=$reply_text?>
</div>
<?php } ?>
<div style="height: 46px;"></div>
<a href="<?=links('user/feedback')?>" class="centerXY feedbackmy-bnt" >
	<img src="<?=_tpldir_?>images/feedback.png">
	<span>继续反馈<span>
</a>