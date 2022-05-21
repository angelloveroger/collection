<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>Yhcms视频系统 - Powered by Yhcms</title>
<link rel="stylesheet" href="/packs/install/images/css.css" />
<script src="/packs/jquery/jquery.min.js"></script>
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
					<li class="current"><em>1</em>创建数据</li>
					<li class="on"><em>2</em>设置站点</li>
					<li class="on"><em>3</em>完成安装</li>
				</ul>
			</div>
			<form id="J_install_form" action="<?=links('install/index/2')?>" method="post">
			<div class="server">
				<table width="100%">
					<tr>
						<td class="td1" width="100">数据库信息</td>
						<td class="td1" width="200">&nbsp;</td>
						<td class="td1">&nbsp;</td>
					</tr>
					<tr>
						<td class="tar">数据库类型：</td>
						<td>
		                    <select class="select1" id="dbdriver" name="dbdriver">
	                           <option value="mysqli">Mysqli</option>
	                           <option value="mysql">Mysql</option>
		                    </select>
		                </td>
						<td><div id="J_dbdriver"><span class="gray">一般为Mysql，PHP5.6以上请选择Mysqli</span></div></td>
					</tr>
					<tr>
						<td class="tar">数据库服务器：</td>
						<td><input type="text" name="dbhost" id="dbhost" value="127.0.0.1" class="input"></td>
						<td><div id="J_dbhost"><span class="gray">数据库服务器地址，一般为127.0.0.1</span></div></td>
					</tr>
					<tr>
						<td class="tar">数据库用户名：</td>
						<td><input type="text" name="dbuser" id="dbuser" value="root" class="input"></td>
						<td><div id="J_dbuser"><span class="gray">数据库用户名</span></div></td>
					</tr>
					<tr>
						<td class="tar">数据库密码：</td>
						<td><input type="text" name="dbpwd" id="dbpwd" value="" class="input" autoComplete="off"></td>
						<td><div id="J_dbpwd"><span class="gray">数据库密码</span></div></td>
					</tr>
					<tr>
						<td class="tar">数据库名：</td>
						<td><input type="text" name="dbname" id="dbname" value="yhcms" class="input"></td>
						<td><div id="J_dbname"><span class="gray">数据库名称</span></div></td>
					</tr>
					<tr>
						<td class="tar">数据库表前缀：</td>
						<td><input type="text" name="dbprefix" id="dbprefix" value="yh_" class="input"></td>
						<td><div id="J_dbprefix"><span class="gray">建议使用默认，同一数据库安装多个Yhcms时需修改</span></div></td>
					</tr>
					<tr>
						<td class="tar">导入演员库：</td>
						<td><select class="select1" id="star" name="star">
	                           <option value="0">不导入</option>
	                           <option value="1">导入</option>
		                    </select></td>
						<td><div id="J_star"><span class="gray">确定导入时间较长，请耐心等候</span></div></td>
					</tr>
				</table>
				<div id="J_response_tips" style="display:none;"><div class="loading"><span>请稍后...</span></div></div>
			</div>
			<div class="tac">
				<button onClick="checkdb();return false;" type="botton" class="btn btn_submit J_install_btn">创建数据</button>
			</div>
			<p style="color:#f30;padding-top:20px;padding-left:20px;text-align:center;">PS:无法安装或者安装不成功，请点击查看<a style="padding-left:5px;color:#00f;" href="https://www.yhcms.net/bbs/info/444.html" target="_blank">安装教程</a></p>
		</form>
	</div>
	<div class="footer">
		&copy; 2021 <a href="http://www.yhcms.cc/" target="_blank">yhcms.cc</a>（英皇集团旗下品牌）
	</div>
	<script>
	function checkdb() {
		var msg = $('#star').val() == 1 ? '，正在导入演员库' : '';
		if($('#J_response_tips').css('display') == 'block') return false;
	    $('#J_response_tips').html('<div class="loading"><span>请稍后'+msg+'...</span></div>').show();
	    $.post('<?=links('install/dbtest')?>',{
	    	dbdriver: $('#dbdriver').val(),
	    	dbhost: $('#dbhost').val(),
	    	dbuser: $('#dbuser').val(),
	    	dbpwd: $('#dbpwd').val(),
	    	dbname: $('#dbname').val(),
	    	dbprefix: $('#dbprefix').val()
	    },function(d){
			if(d.code == 1) {
				if(d.msg == 'ok'){
					$('#J_install_form').submit();
				}else{
					if(confirm(d.msg)){
						$('#J_install_form').submit();
					}else{
						return false;
					}
				}
			}else{
				alert(d.msg);
				$('#J_response_tips').hide();
				return false;
			}
	    },'json');
	}
	</script>
</body>
</html>