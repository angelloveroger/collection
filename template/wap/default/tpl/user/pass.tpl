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
	<span>找回密码</span>
</div>
<div class="signin-form">
	<div class="signin-list centerY">
		<img class="signin-phone"  src="<?=_tpldir_?>images/icon_mobile_phone.png">
		<input id="tel" type="number" value="" autocomplete="off" placeholder="请输入手机号" />
	</div>
	<div class="signin-list centerY">
		<img class="signin-code" src="<?=_tpldir_?>images/icon_verification_code.png">
		<input id="code" maxlength="6" type="number" autocomplete="off" placeholder="请输入验证码" class="codeIput" />
		<input class="code telcode-btn" data-type="pass" type="button" value="获取验证码" />
	</div>
	<div class="signin-list centerY passlog">
		<img class="signin-paw" src="<?=_tpldir_?>images/icon_password.png">
		<input id="pass" type="password" value="" autocomplete="off" placeholder="请输入新密码" />
	</div>
	<div class="signin-tips columnY betweenX">
		<a href="<?=links('user/login')?>"><span>去登陆</span></a>
	</div>
	<div class="signin pass-btn">注册</div>
</div>