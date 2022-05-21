<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">点卡兑换</div>
	<div class="pageHead-right"></div>
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
				<div class="member-cent-name centerY" style="margin-bottom:0;">
					<span><?=$nickname?></span>
					<img src="<?=_tpldir_?>images/member-vip-<?=$vip?>.png" >
				</div>
				<div class="member-cent-tips">剩余金币：<?=$cion?>个<br>Vip到期时间：<?=$vip>0?date('Y-m-d H:i:s',$viptime):'未开通'?></div>
			</div>
		</div>
	</div>
</div>
<div class="member-head">点卡卡密</div>
<div style="width:92%;margin-left:4%;margin-top:10px;"><input type="text" id="pay-card-val" value="" class="layui-input" placeholder="请输入点卡卡密"></div>
<div class="member-pay" style="margin-top:20px;">确认兑换</div>
<div style="width:100%;margin-top:30px;">
	<div class="member-head">兑换记录</div>
	<div  class="collzt" id="pagejs">
	    <?php
	    foreach($list as $row){
	    	$type = $row['type'] == 1 ? $row['nums'].'天VIP' : $row['nums'].'个金币';
	        echo '<div class="record-list centerY betweenX"><div><div class="record-title" style="font-size: 12px;">'.$row['pass'].'</div><div class="record-item">'.date('Y-m-d H:i:s',$row['paytime']).'</div></div><div class="record-pirce" style="font-size: 12px;">+'.$type.'</div></div>';
	    } 
	    if(empty($list)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
	    ?>
	</div>
</div>
<script language="javascript" type="text/javascript">
	$('.member-pay').click(function(){
		var card = $('#pay-card-val').val();
		var index = layer.load();
		$.post('<?=links('user/pay/send')?>',{card:card,type:'card'},function(res){
			layer.close(index);
			if(res.code == 1){
				layer.msg(res.msg);
				setTimeout(function(){
                    window.location.reload();
                },1000);
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
	});
</script>