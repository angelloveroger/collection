<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Yhcms视频系统 - Powered by Yhcms</title>
<link rel="stylesheet" href="/packs/install/images/css.css" />
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
</head>
<body>
<div class="wrap">
	<div class="header">
		<h1 class="logo">logo</h1>
		<div class="icon_install">安装向导</div>
		<div class="version">yhcms v1</div>
	</div>
	<div class="section">
		<div class="step">
			<ul>
				<li class="on"><em>1</em>创建数据</li>
				<li class="current"><em>2</em>设置站点</li>
				<li class="on"><em>3</em>完成安装</li>
			</ul>
		</div>
		<form class="layui-form" id="J_install_form" action="<?=links('install/index/4')?>" method="post">
		<div class="server">
			<table width="100%">
				<tr>
					<td class="td1" width="100">站点信息</td>
					<td class="td1" width="200">&nbsp;</td>
					<td class="td1">&nbsp;</td>
				</tr>
				<tr>
					<td class="tar">站点名称：</td>
					<td><input type="text" name="webname" value="英皇影视" class="input" autoComplete="off" lay-verify="required"></td>
					<td><div id="J_admin_name"><span class="gray">您的站点名称</span></div></td>
				</tr>
				<tr>
					<td class="tar">站点域名：</td>
					<td><input type="text" name="weburl" value="<?=$_SERVER['HTTP_HOST']?>" class="input" autoComplete="off" lay-verify="required"></td>
					<td><div id="J_admin_pass"><span class="gray">一般不用修改</span></div></td>
				</tr>
			</table>
		</div>
		<div class="server">
			<table width="100%">
				<tr>
					<td class="td1" width="100">后台管理员信息</td>
					<td class="td1" width="200">&nbsp;</td>
					<td class="td1">&nbsp;</td>
				</tr>
				<tr>
					<td class="tar">管理员帐号：</td>
					<td><input type="text" name="admin_name" class="input" autoComplete="off" lay-verify="required"></td>
					<td><div><span class="gray">登入后台的用户名</span></div></td>
				</tr>
				<tr>
					<td class="tar">密码：</td>
					<td><input type="text" name="admin_pass" class="input" autoComplete="off" lay-verify="required"></td>
					<td><div><span class="gray">登入后台的密码</span></div></td>
				</tr>
				<tr>
					<td class="tar">认证码：</td>
					<td><input type="text" name="admin_code" class="input" autoComplete="off" lay-verify="required"></td>
					<td><div><span class="gray">登入后台的认证码</span></div></td>
				</tr>
			</table>
		</div>
		<div class="bottom tac">
			<button type="submit" lay-submit lay-filter="install" class="btn btn_submit J_install_btn">完成安装</button>
		</div>
		</form>
	</div>
</div>
<div class="footer">
	&copy; 2021 <a href="http://www.yhcms.cc/" target="_blank">yhcms.cc</a>（英皇集团旗下品牌）
</div>
<script>
layui.use(['layer','form','element'],function() {
    layer = layui.layer;
    form = layui.form;
    element = layui.element;
    form.on('submit(install)', function (data) {
       	var index = layer.load();
        $.post(data.form.action, data.field, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                setTimeout(function() {
                    window.location.href = '<?=links('install/index/5')?>';
                }, 1000);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
        return false;
    });
});
</script>
</body>
</html>

