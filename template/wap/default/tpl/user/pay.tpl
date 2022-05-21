<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">开通会员</div>
	<div class="pageHead-right">
		<a href="<?=links('user/pay/lists')?>">充值记录</a>
	</div>
</div>
<div style="height: 54px;"></div>
<div class="member-box">
	<img class="member-bg" src="<?=_tpldir_?>images/member-bg.png">
	<div class="member-cent centerX betweenX">
		<div class="member-cent-info centerY">
			<div class="member-cent-head">
				<img src="<?=_tpldir_?>images/my-duih.png">
			</div>
			<div class="member-cent-user member-cent-user<?=$vip?>">
				<div class="member-cent-name centerY">
					<span><?=$nickname?></span>
					<img src="<?=_tpldir_?>images/member-vip-<?=$vip?>.png" >
				</div>
				<div class="member-cent-tips"><?=$viptime> time() ? '到期时间：'.date('Y-m-d') : '您还不是会员～';?></div>
			</div>
		</div>
		<a href="<?=links('user/exchange')?>" class="member-cent-btn">立即兑换</a>
	</div>
</div>
<div class="member-head">会员权益</div>
<div class="centerY member-rights">
	<div class="member-rights-list">
		<img src="<?=_tpldir_?>images/member-icon1.png">
		<div>新人礼包</div>
	</div>
	<div class="member-rights-list">
		<img src="<?=_tpldir_?>images/member-icon2.png"">
		<div>广告限免</div>
	</div>
	<div class="member-rights-list">
		<img src="<?=_tpldir_?>images/member-icon3.png">
		<div>专属视频</div>
	</div>
	<div class="member-rights-list">
		<img src="<?=_tpldir_?>images/member-icon4.png">
		<div>签到奖励</div>
	</div>
</div>
<div class="member-head">超值套餐</div>
<div class="member-package">
	<?php foreach($list as $k=>$row){ ?>
	<div data-rmb="<?=$row['rmb']?>" data-day="<?=$row['day']?>" class="member-package-list<?=$k==0?' member-package-active':'';?>">
		<div class="member-package-title"><?=$row['name']?></div>
		<div class="member-package-price"><span>￥</span><?=$row['rmb']?></div>
	</div>
	<?php } ?>
</div>
<div class="member-pay">确认支付:￥<font><?=$list[0]['rmb']?></font></div>
<div class="member-pupop">
	<div class="member-pupop-bg"></div>
	<div class="member-pupop-cont">
		<p class="member-pupop-title">选择支付方式</p>
		<form class="member-pupop-box">
			<div class="member-pupop-li">
				<input class="pay" type="radio" name="pay" id="wxpay" value=""><label for="wxpay" class="member-pupop-text"><img src="<?=_tpldir_?>images/wxpay.png" > 微信支付</label><label class="member-pupop-icon" for="wxpay"></label>
			</div>
			<div class="member-pupop-li">
				<input class="pay" type="radio" name="pay" id="alipay" value="" checked><label for="alipay" class="member-pupop-text"><img src="<?=_tpldir_?>images/alipay.png" > 支付宝</label><label class="member-pupop-icon" for="alipay"></label>
			</div>
		</form>
		<div class="member-pupop-pay">立即支付</div>
	</div>
</div>
<script language="javascript" type="text/javascript">
	$(".member-pay").click(function(){
		$(".member-pupop").show()
	})
	$(".member-pupop-bg,.member-pupop-pay").click(function(){
		$(".member-pupop").hide()
	});
	$('.member-pupop-pay').click(function(){
		var paytype = $('.pay:checked').attr('id');
		var day = $('.member-package-active').data('day');
		var index = layer.load();
		$.post('<?=links('user/pay/send')?>',{day:day,paytype:paytype},function(res){
			layer.close(index);
			if(res.code == 1){
				window.location.href = res.data.payurl;
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
	});
	$('.member-package-list').click(function(){
		$('.member-package-list').removeClass('member-package-active');
		$(this).addClass('member-package-active');
		var rmb = $(this).data('rmb');
		$('.icon-box').hide();
		$('#pay-rmb-val').val(rmb);
		$('.member-pay font').html(rmb);
	});
</script>