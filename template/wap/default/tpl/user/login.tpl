<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text"></div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="signin-title">
	<span>用户登录</span>
</div>
<div class="signin-form">
	<div class="signin-list centerY">
		<img class="signin-phone"  src="<?=_tpldir_?>images/icon_mobile_phone.png">
		<input id="tel" type="number" value="" autocomplete="off" placeholder="请输入手机号" />
	</div>
	<div class="signin-list centerY passlog">
		<img class="signin-paw" src="<?=_tpldir_?>images/icon_password.png">
		<input id="pass" type="password" value="" autocomplete="off" placeholder="请输入密码" />
	</div>
	<div class="signin-tips columnY betweenX">
		<a href="<?=links('user/reg')?>"><span>没有账号？去注册</span></a>
		<a href="<?=links('user/pass')?>"><span>忘记密码?</span></a>
	</div>
	<div class="signin login-btn">登录</div>
</div>
<form class="centerY agreement">
	<input type="checkbox" name="vehicle" id="check" value="Bike" checked><label for="check"></label>
	<label for="check" style="padding-left: 4px;">
		同意<a href="<?=links('opt/index/privacy')?>" class="agreement-t">《隐私政策》</a>
		<span class="agreement-c">和</text>
		<a href="<?=links('opt/index/agreement')?>" class="agreement-t">《用户协议》</a>
	</label>
</form>