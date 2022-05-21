<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">充值金币</div>
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
				<img src="<?=getpic($pic)?>">
			</div>
			<div class="member-cent-user member-cent-user<?=$vip?>">
				<div class="member-cent-name centerY">
					<span><?=$nickname?></span>
					<img src="<?=_tpldir_?>images/member-vip-<?=$vip?>.png" >
				</div>
				<div class="member-cent-tips">剩余金币：<?=$cion?>个</div>
			</div>
		</div>
	</div>
</div>
<div class="member-head">充值金币<span style="float:right;font-size:12px;color:#f00;margin-top:3px;">1元=<?=$rmbtocion?>个金币</span></div>
<div class="member-package" style="padding-bottom:10px;">
	<?php foreach($list as $k=>$row){ ?>
	<div data-rmb="<?=$row['rmb']?>" class="member-package-list<?=$k==0?' member-package-active':'';?>">
		<div class="member-package-title"><?=$row['cion']?>金币</div>
		<div class="member-package-price"><span>￥</span><?=$row['rmb']?></div>
	</div>
	<?php } ?>
	<div data-rmb="0" class="member-package-list">
		<div class="member-package-title" style="padding-top: 50px;">自定义金额</div>
	</div>
	<div style="width:50px;"><div style="padding: 5px;"></div></div>
</div>
<div class="icon-box" style="width:100%;margin-bottom:10px;display:none;">
	<div class="member-head">充值金额</div>
	<div style="width:92%;margin-left:4%;margin-top:10px;"><input type="text" id="pay-rmb-val" value="10" class="layui-input" placeholder="请输入充值金额"></div>
</div>
<div class="member-pay" style="margin-top:10px;">确认支付:￥<font>10</font></div>
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
<script type="text/javascript">
	var rmbtocion = <?=$rmbtocion?>;
	$(".member-pay").click(function(){
		$(".member-pupop").show()
	})
	$(".member-pupop-bg,.member-pupop-pay").click(function(){
		$(".member-pupop").hide()
	});
	$('.member-pupop-pay').click(function(){
		var paytype = $('.pay:checked').attr('id');
		var cion = $('#pay-rmb-val').val();
		var index = layer.load();
		$.post('<?=links('user/pay/send')?>',{cion:cion,paytype:paytype,type:'cion'},function(res){
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
		if(rmb == 0){
			$('.icon-box').show();
		}else{
			$('.icon-box').hide();
			$('#pay-rmb-val').val(rmb);
			$('.member-pay font').html(rmb);
		}
	});
	$('#pay-rmb-val').bind("input propertychange",function(){
		var rmb = $(this).val();
		$('.member-pay font').html(rmb);
	});
</script>