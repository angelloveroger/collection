<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>设备统计</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style type="text/css">
.layui-table td, .layui-table th{
	text-align: center;
}
</style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>运营管理</a>
        <a><cite>广告变现</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
			<div class="layui-tab layui-tab-brief">
				<ul class="layui-tab-title">
				    <li data-type="index" class="layui-this">收益记录</li>
				    <li data-type="adunit">获取广告</li>
				    <li data-type="info">用户信息</li>
				    <li data-type="pay">结算记录</li>
				</ul>
				<div class="layui-tab-content">
				    <div class="layui-tab-item layui-show" style="max-width:800px;">
				    <?php if($open == 1){ ?>
				   		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
				  			<legend>收入概况</legend>
						</fieldset>
						<div class="layui-form">
							<table class="layui-table">
								<thead>
								    <tr>
								       	<th>今日累计</th>
								        <th>昨日</th>
								        <th>过去七天</th>
								        <th>本月</th>
								        <th>余额</th>
								    </tr> 
								</thead>
								<tbody>
								    <tr id="count">
								        <td>￥0</td>
								        <td>￥0</td>
								        <td>￥0</td>
								        <td>￥0</td>
								        <td>￥0</td>
								    </tr>
								</tbody>
							</table>
						</div>
						<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
				  			<legend>数据报表</legend>
						</fieldset>
						<div class="layui-form">
							<table class="layui-table">
								<thead>
								    <tr>
								       	<th>日期</th>
								        <th>浏览次数</th>
								        <th>结算数</th>
								        <th>媒体收益</th>
								    </tr> 
								</thead>
								<tbody id="daylist">
									<tr>
										<td align="center" colspan="4">
											<div style="width:50px;height:50px;margin:0 auto;line-height: 50px;">
												<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:30px;"></i>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					<?php }else{ ?>
						<div style="width:300px;height:100px;line-height:100px;">
							<button style="margin: 0 auto;" type="button" class="ads-btn layui-btn layui-btn-normal layui-btn-fluid">一键开通</button>
						</div>
					<?php } ?>
				    </div>
				    <div class="layui-tab-item" style="max-width:800px;">
						<div id="layerDemo" style="margin-bottom: 0;">
							<div class="layui-btn-container">
								<button type="button" class="layui-btn layui-btn-sm layui-btn-normal xinzengdm-btn">新增广告</button>
							</div>
				  		</div>
				  		<div class="layui-form">
							<table class="layui-table">
								<thead>
								    <tr>
								       	<th>ID</th>
								        <th>广告名称</th>
								        <th>广告格式</th>
								        <th>计费方式</th>
								        <th>获取代码</th>
								    </tr> 
								</thead>
								<tbody id="adunitlist">
									<tr>
										<td align="center" colspan="5">
											<div style="width:50px;height:50px;margin:0 auto;line-height: 50px;">
												<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:30px;"></i>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div style="margin-top: 15px"></div>
				    </div>
				    <div class="layui-tab-item" style="max-width:800px;">
						<form class="layui-form" action="<?=links('advertising/api/infosave')?>">
					   		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
					  			<legend>联系信息</legend>
							</fieldset>
							<div class="layui-form-item">
							    <label class="layui-form-label">用户ID：</label>
							    <div class="layui-input-block" id="userid" style="line-height:36px;"></div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">用户账号：</label>
							    <div class="layui-input-block" id="username" style="line-height:36px;"></div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">QQ：</label>
							    <div class="layui-input-block">
							      <input type="text" name="qq" id="userqq" lay-reqtext="请认真填写QQ号码" placeholder="请输入QQ" autocomplete="off" class="layui-input">
							    </div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">TG：</label>
							    <div class="layui-input-block">
							      <input type="text" name="mobile" id="usermobile" lay-reqtext="请认真填写TG号" placeholder="请输入TG号" autocomplete="off" class="layui-input">
							    </div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">网站统计：</label>
							    <div class="layui-input-block">
							    	<textarea name="description" id="description" placeholder="为了快速审核结算，请提供您的CNZZ或百度统计后台地址及密码" class="layui-textarea"></textarea>
							    </div>
							</div>
					   		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;">
					  			<legend>结算信息</legend>
							</fieldset>
							<div class="layui-form-item">
							    <label class="layui-form-label">选择银行：</label>
							    <div class="layui-input-block">
							      	<select name="bank" id="bank">
								        <option value=""></option>
							      </select>
							    </div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">开户地址：</label>
							    <div class="layui-input-block">
							      <input type="text" id="bank_branch" name="bank_branch" lay-reqtext="请认真填写开户行地址" placeholder="请输入开户行地址" autocomplete="off" class="layui-input">
							    </div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">收款账号：</label>
							    <div class="layui-input-block">
							      <input type="text" id="bank_account" lay-verify="required" name="bank_account" lay-reqtext="请认真填写账号" placeholder="请输入账号" autocomplete="off" class="layui-input">
							    </div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">收款名称：</label>
							    <div class="layui-input-block">
							      <input type="text" name="bank_name" id="bank_name" lay-verify="required" lay-reqtext="请认真填收款人真实姓名" placeholder="请输入收款人真实姓名" autocomplete="off" class="layui-input">
							    </div>
							</div>
							<div class="layui-btn-container">
								<button type="submit" lay-submit lay-filter="info" class="layui-btn" style="margin-left: 100px;">保存</button>
							</div>
						</form>
				    </div>
				    <div class="layui-tab-item" style="max-width:800px;">
						<fieldset class="layui-elem-field layui-field-title" style="border-width: 0;">
				  			<legend style="font-size: 16px;margin: 16px 0px 0px 20px;">
				  				<span>当前余额：<b id="balance" style="color:#080">￥0</b></span>    
				  				<span style="padding-left:20px;">最低支付标准：<b id="SmallDrawmoney" style="color:#ea0000">￥0</b></span>
				  				<p><br>结算方式：满100日结，usdt满500日结，每天下午3点结算打款</p>
				  				<p>如有疑问，请访问 <a href="https://t5wm.com/" target="_blank">https://t5wm.com/</a> 联系在线客服</p>
				  			</legend>
						</fieldset>
						<div class="layui-form">
							<table class="layui-table">
								<thead>
								    <tr>
								       	<th>日期</th>
								        <th>税前收入(元)</th>
								        <th>代扣税</th>
								        <th>实际金额</th>
								        <th>状态</th>
								    </tr> 
								</thead>
								<tbody id="paylist">
									<tr>
										<td align="center" colspan="5">
											<div style="width:50px;height:50px;margin:0 auto;line-height: 50px;">
												<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:30px;"></i>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
				    </div>
				</div>
			</div> 
		</div>
	</div>
</div>
<div class="xinzengdm-box" style="display:none;">
	<div style="padding: 10px 20px 20px 0;">
		<form class="layui-form" action="<?=links('advertising/api/adunitsave')?>">
			<div class="layui-form-item" style="margin: 20px auto;">
				<label class="layui-form-label">广告名称：</label>
				<div class="layui-input-block">
					<input type="text" name="name" lay-verify="required" lay-reqtext="请输入广告位名称" placeholder="请输入广告位名称" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">计费方式：</label>
			    <div class="layui-input-block">
			      	<select name="bidding_method" id="bidding_method">
				        <option value="coc" selected="">CPC</option>
				        <option value="cpm">CPM(CPV)</option>
			    	</select>
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">广告类型：</label>
			    <div class="layui-input-block">
			      	<select name="creative_tpl_id" id="creative_tpl_id">
				        <option value="0" selected="">顶部漂浮广告</option>
				        <option value="1">底部漂浮广告</option>
				        <option value="2">固定横幅广告</option>
			    	</select>
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">抖动动画：</label>
			    <div class="layui-input-block">
			      	<select name="show">
				        <option value="animation-on" selected="">开启</option>
				        <option value="animation-off">关闭</option>
			    	</select>
			    </div>
			</div>
			<div class="layui-btn-container">
				<button type="submit" lay-submit lay-filter="adunit" class="layui-btn" style="margin: 0px 140px;">新增</button>
			</div>
 		</form>
	</div>
</div>
<div class="huoquggdm-box" style="display:none;">
	<div style="width:600px;height:560px" id="adscode"></div>
</div>
<script type="text/javascript">
layui.use(['jquery','layer','form','element'],function() {
	var $ = layui.jquery,
		layer = layui.layer,
		form = layui.form,
		tindex = null;
	//新增广告
	form.on('submit(adunit)', function(data){
        var index = layer.load();
        $.post(data.form.action,data.field,function(res) {
            layer.close(index);
            if(res.code == 1){
            	layer.close(tindex);
                layer.msg(res.msg);
                get_type('adunit');
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
        return false;
    });
	//保存资料
	form.on('submit(info)', function(data){
        var index = layer.load();
        $.post(data.form.action,data.field,function(res) {
            layer.close(index);
            if(res.code == 1){
            	layer.close(tindex);
                layer.msg(res.msg);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
        return false;
    });
	$('.xinzengdm-btn').click(function(){
		$.get('<?=links('advertising/api/adunitadd')?>',function(res){
			var html ='';
			for (var i = 0; i < res.creative_tpl.list.length; i++) {
				html+='<option value="'+res.creative_tpl.list[i].id+'">'+res.creative_tpl.list[i].name+'</option>';
			}
			$('#creative_tpl_id').html(html);
			html ='';
			for (var i = 0; i < res.bidding_method.list.length; i++) {
				html+='<option value="'+res.bidding_method.list[i].id+'">'+res.bidding_method.list[i].name+'</option>';
			}
			$('#bidding_method').html(html);
			form.render('select');
			tindex = layer.open({
			  	type: 1, 
			  	title: '新增广告',
			  	content: $('.xinzengdm-box')
			});
		},'json');
	});
	$('body').on('click','.huoquggdm-btn',function(){
		var id = $(this).data('id');
		$.get('<?=links('advertising/api/adunitcode')?>?id='+id,function(res){
			var html ='';
			for (var i = 0; i < res.list.length; i++) {
				html+='<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;border-width: 0;"><legend style="margin-left: 5px;">'+res.list[i].name+'</legend></fieldset><div class="layui-input-block" style="margin: -15px 15px;height:100px;"><textarea onfocus="this.select();" class="layui-textarea" style="min-height:80px;">'+res.list[i].code+'</textarea></div>';
			}
			$('#adscode').html(html);
			tindex = layer.open({
			  	type: 1, 
			  	title: '广告代码',
			  	content: $('.huoquggdm-box')
			});
		},'json');
	});
	$('.ads-btn').click(function(){
		var index = layer.load();
		$.get('<?=links('advertising/api/open')?>',function(res){
			layer.close(index);
			if(res.code == 1){
				layer.msg('开通成功');
				setTimeout(function(){
	                Admin.get_load();
	            },1000);
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
	});
	if($('.ads-btn').length == 0){
		get_type('index');
	}
	$('.layui-tab-title li').click(function(){
		var type = $(this).data('type');
		get_type(type);
	});
	function get_type(type){
		$.get('<?=links('advertising/api')?>/'+type,function(res){
			if(res.code == 1){
				if(type == 'index'){
					$('#count td').eq(0).html(res.info.DayPay);
					$('#count td').eq(1).html(res.info.YesterdayPay);
					$('#count td').eq(2).html(res.info.Last7daysPay);
					$('#count td').eq(3).html(res.info.MonthPay);
					$('#count td').eq(4).html(res.info.balance);
					var html = '';
					for (var i = 0; i < res.list.length; i++) {
						html+='<tr><td>'+res.list[i].day+'</td><td>'+res.list[i].view+'</td><td>'+res.list[i].num+'</td><td>'+res.list[i].sumpay+'</td></tr>';
					}
					if(html == '') html = '<tr><td align="center" colspan="4">暂无数据~!</td></tr>';
					$('#daylist').html(html);
				}else if(type == 'adunit'){
					var html = '';
					for (var i = 0; i < res.list.length; i++) {
						html+='<tr><td>'+res.list[i].id+'</td><td>'+res.list[i].name+'</td><td>'+res.list[i].creative_tpl.name+'</td><td>'+res.list[i].bidding_method+'</td><td><span data-id="'+res.list[i].id+'" class="layui-btn layui-btn-xs huoquggdm-btn">获取代码</span></td></tr>';
					}
					if(html == '') html = '<tr><td align="center" colspan="5">暂无数据~!</td></tr>';
					$('#adunitlist').html(html);
				}else if(type == 'info'){
					$('#userid').html(res.info.id);
					$('#username').html(res.info.name);
					$('#userqq').val(res.info.qq);
					$('#usermobile').val(res.info.mobile);
					$('#description').val(res.info.description);
					var html ='';
					for (var i = 0; i < res.info.BankList.length; i++) {
						var cls = res.info.BankList[i] == 'USDT-TRC20' ? ' selected' : '';
						html+='<option value="'+res.info.BankList[i]+'"'+cls+'>'+res.info.BankList[i]+'</option>';
					}
					$('#bank').html(html);
					form.render('select');
					$('#bank_branch').val(res.info.bank_branch);
					$('#bank_account').val(res.info.bank_account);
					$('#bank_name').val(res.info.bank_name);
				}else if(type == 'pay'){
					$('#balance').html(res.info.balance);
					$('#SmallDrawmoney').html(res.info.SmallDrawmoney);
					var html = '';
					for (var i = 0; i < res.list.length; i++) {
						html+='<tr><td>'+res.list[i].updated_at+'</td><td>'+res.list[i].money+'</td><td>'+res.list[i].tax.name+'</td><td>'+res.list[i].amount+'</td><td>'+res.list[i].payment+'</td><td>'+(res.list[i].status?'<font color=#080>已结清<font>':'<font color=#f60>未支付</font>')+'</td></tr>';
					}
					if(html == '') html = '<tr><td align="center" colspan="6">暂无数据~!</td></tr>';
					$('#paylist').html(html);
				}
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
	}
});
</script>
</body>
</html>