<style type="text/css">html{background-color: #F9F9F9;}</style>
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">联系我们</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="contactUs">
	<img class="contactUs-logo" src="<?=_tpldir_?>images/logo.png" >
	<h2 class="contactUs-name"><?=WEBNAME?></h2>
	<div class="contactUs-li copy" data-clipboard-text="<?=$qq?>">
		<p>客服QQ</p>
		<p><?=$qq?></p>
	</div>
	<div class="contactUs-li copy" data-clipboard-text="<?=$email?>">
		<p>客服邮箱</p>
		<p><?=$email?></p>
	</div>
	<div class="contactUs-li copy" data-clipboard-text="<?=$telegram?>">
		<p>客服飞机</p>
		<p><?=$telegram?></p>
	</div>
</div>
<p class="contactUs-xy">
	<a href="<?=links('opt/index/agreement')?>">《用户协议》</a>｜
	<a href="<?=links('opt/index/privacy')?>">《隐私政策》</a>
</p>
<script src="/packs/jquery/clipboard.min.js"></script>
<script type="text/javascript">
    $(function() {
        var clipboard = new Clipboard('.copy');
        clipboard.on('success',function(e) {
            e.clearSelection();
            layer.msg('分享地址复制成功');
        });
    });
</script>