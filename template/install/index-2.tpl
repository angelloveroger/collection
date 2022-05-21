<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Yhcms视频系统 - Powered by Yhcms</title>
<link rel="stylesheet" href="/packs/install/images/css.css" />
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
			<div class="install" id="log">
				<ul id="loginner">
				</ul>
			</div>
			<div class="bottom tac">
				<a href="javascript:;" class="btn_old"><img src="/packs/install/images/loading.gif" align="absmiddle" />&nbsp;正在安装...</a>
			</div>
		</div>
	</div>
	<div class="footer">
		&copy; 2021 <a href="http://www.yhcms.cc/" target="_blank">yhcms.cc</a>（英皇集团旗下品牌）
	</div>
	<script type="text/javascript"> 
	var log = <?=json_encode($table)?>;
	var n = 0;
	var timer = 0;
	function GoPlay(){
		if (n > log.length-1) {
			n=-1;
			clearIntervals();
		}
		if (n > -1) {
			postcheck(n);
			n++;
		}
	}
	function postcheck(n){
		document.getElementById('loginner').innerHTML += '<li><span class="correct_span">&radic;</span>创建数据表' + log[n] + '，完成</li>';
		document.getElementById('log').scrollTop = document.getElementById('log').scrollHeight;
	}
	function setIntervals(){
		timer = setInterval('GoPlay()',50);
	}
	function clearIntervals(){
		clearInterval(timer);
		window.location.href = "<?=links('install/index/3')?>";
	}
	setTimeout(setIntervals, 100);
	</script>
</body>
</html>

