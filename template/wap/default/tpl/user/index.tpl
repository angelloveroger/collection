<div class="myhead">
	<div class="centerX betweenX myhead-user">
		<a href="<?=links('user/info')?>" class="centerY myhead-user-info">
			<img class="myhead-user-head" src="<?=getpic($pic)?>">
			<div class="myhead-user-name"><?=$nickname?></div>
			<?php if($viptime > 0) echo '<img class="myhead-user-vip" src="'._tpldir_.'images/my-vip3.png">';?>
		</a>
		<a href="<?=links('user/pay/cion')?>" class="centerY myhead-user-integral">
			<img src="<?=_tpldir_?>images/my-money.png">
			<div><?=$cion?></div>
		</a>
	</div>
	<div class="myhead-vip">
		<img class="myhead-vipbg" src="<?=_tpldir_?>images/my-bg.png">
		<div class="myhead-vip-cont centerY betweenX">
			<div class="myhead-vip-tc centerY">
				<img class="myhead-vip-tc1" src="<?=_tpldir_?>images/my-vip2.png">
				<img class="myhead-vip-tc2" src="<?=_tpldir_?>images/my-vip.png">
			</div>
			<a href="<?=links('user/pay')?>" class="myhead-vip-bt">
				立即开通
			</a>
		</div>
	</div>
</div>
<div style="height: 175px;"></div>
<?php if(!empty($watch)){ ?>
<div class="lookhistory mybox">
	<a href="<?=links('user/read')?>" class="my-head watchr  centerX betweenX">
		<div>观看历史</div>
		<img src="<?=_tpldir_?>images/right2.png">
	</a>
	<div class="lookhistory-box">
	<?php
	foreach($watch as $k=>$row){
		echo '<a href="'.links('play',$row['vid'],$row['jid']).'" class="lookhistory-list"><img src="'.getpic($row['pic']).'"><div class="line1 lookhistory-title">'.$row['name'].'</div></a>';
	}
	?>
	</div>
</div>
<?php } ?>
<div class="myfunt mybox">
	<div class="my-head">常用功能</div>
	<div class="myfunt-box centerY">
		<a href="<?=links('user/share')?>" class="myfunt-list">
			<img src="<?=_tpldir_?>images/my-lx.png">
			<div>分享有礼</div>
		</a>
		<a href="<?=links('user/fav')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-sc.png">
			<div>我的收藏</div>
		</a>
		<a href="<?=links('user/task')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-rw.png">
			<div>任务中心</div>
		</a>
		<a href="<?=links('user/exchange')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-duih.png">
			<div>兑换中心</div>
		</a>
	</div>
</div>
<div class="myfunt myfunt1 mybox">
	<div class="my-head">其他功能</div>
	<div class="myfunt-box centerY">
		<a href="<?=links('user/info')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-shez.png" >
			<div>设置</div>
		</a>
		<a href="<?=links('user/feedback')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-fank.png" >
			<div>我要反馈</div>
		</a>
		<a href="<?=links('user/comment')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-pinl.png" >
			<div>我的评论</div>
		</a>
		<a href="<?=links('user/pay/card')?>" class="myfunt-list" >
			<img src="<?=_tpldir_?>images/my-card.png" >
			<div>点卡兑换</div>
		</a>
		<a href="<?=links('user/contact')?>" class="myfunt-list">
			<img src="<?=_tpldir_?>images/my-lianx.png" >
			<div>联系我们</div>
		</a>
	</div>
</div>


<!-- tabbat -->
<div style="height:50px;"></div>
<div class="centerY tabbat">
	<a href="/">
		<img src="<?=_tpldir_?>images/index.png">
		<p>首页</p>
	</a>
	<a href="<?=links('topic')?>">
		<img src="<?=_tpldir_?>images/special.png" >
		<p>专题</p>
	</a>
	<a href="<?=links('vod/hot')?>">
		<img src="<?=_tpldir_?>images/ranking.png" >
		<p>排行</p>
	</a>
	<a href="<?=links('user')?>" class="tabbat-active">
		<img src="<?=_tpldir_?>images/my-r.png" >
		<p>我的</p>
	</a>
</div>