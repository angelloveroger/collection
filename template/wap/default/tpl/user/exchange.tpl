<!-- tabhead -->
<div class="pageHead betweenX centerY" style="background:  none;">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">兑换中心</div>
	<div class="pageHead-right">
		<a href="<?=links('user/exchange/lists')?>">兑换记录</a>
	</div>
</div>
<div class="exchangeTask-head">
	<img src="<?=_tpldir_?>images/exchange-bg.png" >
	<div>
		<p>当前金币余额</p>
		<p><span><?=$cion?></span></p>
	</div>
</div>
<div style="height: 183px;"></div>
<div class="exchange-cent">
<?php foreach($list as $row){ ?>
	<div class="exchange-list centerY betweenX">
		<div class="exchange-left centerY">
			<img src="<?=_tpldir_?>images/exchange-dh.png">
			<div class="exchange-info">
				<p class="exchange-janli"><?=$row['name']?></p>
				<p class="exchange-price"><?=$row['cion']?>金币</p>
			</div>
		</div>
		<p data-day="<?=$row['day']?>" data-cion="<?=$row['cion']?>" class="exchange-btn">立即兑换</p>
	</div>
<?php } ?>
</div>