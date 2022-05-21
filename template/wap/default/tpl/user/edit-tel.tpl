<style type="text/css">
html{background-color: #F9F9F9;}
</style>
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">更换手机号</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="signin-form">
	<div class="signin-phonetitle"><?=$tel?></div>
	<div class="signin-list up-list centerY" style="display:none;">
		<input id="tel" type="text" value="" placeholder="请输入新手机号" />
	</div>
	<div class="signin-list centerY up-list">
		<input maxlength="6" id="code" type="text" style="width:74%; flex: inherit;" placeholder="请输入验证码" class="codeIput" />
		<input class="code telcode-btn" data-type="tel" type="button" value="获取验证码" />
	</div>
	<div class="signin pagebtn teledit-btn" data-sid="0" style="margin-top: 30px;">提交</div>
</div>