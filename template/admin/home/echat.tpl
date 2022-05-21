<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户统计趋势</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css?v=1.12">
	<script src="/packs/jquery/jquery.min.js"></script>
	<script src="/packs/layui/layui.js"></script>
	<script src="/packs/admin/js/common.js"></script>
	<style>
	.layui-table td, .layui-table th{padding: 6px 15px;}
	.chat_img{width:100%; height: 350px;background: #fff;margin-top:5px;padding-bottom: 10px;}
	.load{width:50px;height:50px;margin:0 auto;line-height: 350px;}
	.load i{font-size: 40px;}
	.layui-form{float:right;margin-top:-11px;}
	.chat_user_city{width:100%; height: 353px;background: #fff;margin-top:5px;padding-bottom: 10px;}
	.tdload{width:100%;height:318px;background:#fff;}
	.tdload .w30{width:30px;height:30px;margin:0 auto;}
	.tdload .w30 i{font-size:30px;}
	</style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>后台管理</a>
        <a><cite>增长趋势</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
    	<div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
	        <div class="layui-card">
	            <div class="layui-card-header">活跃用户增长趋势
	            	<div class="layui-form">
	            		<div class="layui-form-item">
	            			<div class="layui-inline select100">
								<label class="layui-form-label">时间筛选:</label>
							</div>
	            			<div class="layui-inline select100">
								<div class="layui-input-inline h30">
		                            <select name="date_type" lay-filter="date_type_user_nums">
		                                <option value="day">按天显示</option>
		                                <option value="month">按月显示</option>
		                            </select>
		                        </div>
		                    </div>
	            			<div class="layui-inline mr0">
		                        <div class="layui-input-inline mr0 select200">
		                            <input name="time" id="time_user_nums" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
		                        </div>
		                    </div>
						</div>
	            	</div>
	            </div>
	            <div class="layui-card-body">
					<div class="chat_user chat_img">
						<div class="load">
							<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
						</div>
					</div>
	            </div>
	        </div>
	    </div>
    	<div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
	        <div class="layui-card">
	            <div class="layui-card-header">新增用户增长趋势
	            	<div class="layui-form">
	            		<div class="layui-form-item">
	            			<div class="layui-inline select100">
								<label class="layui-form-label">时间筛选:</label>
							</div>
	            			<div class="layui-inline select100">
								<div class="layui-input-inline h30">
		                            <select name="date_type" lay-filter="date_type_user_add">
		                                <option value="day">按天显示</option>
		                                <option value="month">按月显示</option>
		                            </select>
		                        </div>
		                    </div>
	            			<div class="layui-inline mr0">
		                        <div class="layui-input-inline mr0 select200">
		                            <input name="time" id="time_user_add" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
		                        </div>
		                    </div>
						</div>
	            	</div>
	            </div>
	            <div class="layui-card-body">
					<div class="chat_user_add chat_img">
						<div class="load">
							<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
						</div>
					</div>
	            </div>
	        </div>
	    </div>
	</div>
    <div class="layui-row layui-col-space15">
    	<div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
	        <div class="layui-card">
	            <div class="layui-card-header">充值增长趋势
	            	<div class="layui-form">
	            		<div class="layui-form-item">
	            			<div class="layui-inline select100">
								<label class="layui-form-label">时间筛选:</label>
							</div>
	            			<div class="layui-inline select100">
								<div class="layui-input-inline h30">
		                            <select name="date_type" lay-filter="date_type_user_pay">
		                                <option value="day">按天显示</option>
		                                <option value="month">按月显示</option>
		                            </select>
		                        </div>
		                    </div>
	            			<div class="layui-inline mr0">
		                        <div class="layui-input-inline mr0 select200">
		                            <input name="time" id="time_user_pay" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
		                        </div>
		                    </div>
						</div>
	            	</div>
	            </div>
	            <div class="layui-card-body">
					<div class="chat_pay chat_img">
						<div class="load">
							<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
						</div>
					</div>
	            </div>
	        </div>
	    </div>
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">注册用户终端分布</div>
                <div class="layui-card-body">
                    <div class="chat_user_facility chat_img">
                        <div class="load">
                            <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">付费用户分布</div>
                <div class="layui-card-body">
                    <div class="chat_user_vip chat_img">
                        <div class="load">
                            <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/packs/admin/js/echarts.min.js"></script>
<script type="text/javascript">
var option1,option2,option3,option4,option5,option6;
layui.use(['layer','form','laydate'],function() {
    var layer = layui.layer,
    form = layui.form,
    laydate = layui.laydate,
    post = [
    	{type:'user_nums',day:10},
    	{type:'user_add',day:10},
    	{type:'user_order',day:10},
    	{type:'user_facility'},
        {type:'user_vip'}
    ];
	option1 = {
        tooltip: {trigger: 'axis'},
        grid:{left:50,right:50},
        legend: {
            data: ['安卓用户', '苹果用户'],
            orient: 'horizontal',
            icon: "circle",
            itemWidth: 12,
            show: true,
            bottom: 0,
            textStyle: {color: '#999999'}
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            axisTick: {show: false},
            nameTextStyle: {fontSize:25},
            axisLine: {lineStyle: {color: '#999999'}},
            axisLabel: {fontSize: 10},
            data: []
        },
        yAxis: {
            type: 'value',
            default: false,
            axisTick: {show: false},
            splitLine: {lineStyle: {type: 'dashed'}},
            axisLabel: {showMinLabel: false,},
            axisLine: {lineStyle: {color: '#999999'}}
        },
        series: [
        	{
                name: '安卓用户',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#F4667C'}
            },
        	{
                name: '苹果用户',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#2FCE63'}
            }
        ]
    };
	option2 = {
        tooltip: {trigger: 'axis'},
        grid:{left:50,right:50},
        legend: {
            data: ['充值订单', '充值金额'],
            orient: 'horizontal',
            icon: "circle",
            itemWidth: 12,
            show: true,
            bottom: 0,
            textStyle: {color: '#999999'}
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            axisTick: {show: false},
            nameTextStyle: {fontSize:25},
            axisLine: {lineStyle: {color: '#999999'}},
            axisLabel: {fontSize: 10},
            data: [],
        },
        yAxis: {
            type: 'value',
            default: false,
            axisTick: {show: false},
            splitLine: {lineStyle: {type: 'dashed'}},
            axisLabel: {showMinLabel: false,},
            axisLine: {lineStyle: {color: '#999999'}}
        },
        series: [
        	{
                name: '充值订单',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#9B6BE6'}
            },
        	{
                name: '充值金额',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#37CCCC'}
            }
        ]
    };
    option3 = {
        color: ['#9B6BE6', '#0095FF', '#FD9644'],
        tooltip: {trigger: 'item',formatter: '{b}: {c} ({d}%)'},
        legend: {
            orient: 'vertical',
            icon: "circle",
            right: 10,
            top: 'center',
            data: ['Android', 'iOS', '未知']
        },
        series: [
            {
                type: 'pie',
                radius: ['40%', '50%'],
                avoidLabelOverlap: false,
                label: {show: false,},
                emphasis: {label: {fontSize: '30',fontWeight: 'bold'}},
                labelLine: {show: false},
                data: []
            }
        ]
    };
    option4 = {
        color: ['#F75F78', '#0095FF'],
        tooltip: {trigger: 'item',formatter: '{b}: {c} ({d}%)'},
        legend: {
            orient: 'vertical',
            icon: "circle",
            right: 10,
            top: 'center',
            data: ['VIP用户', '普通用']
        },
        series: [
            {
                type: 'pie',
                radius: ['40%', '50%'],
                avoidLabelOverlap: false,
                label: {show: false,},
                emphasis: {label: {fontSize: '30',fontWeight: 'bold'}},
                labelLine: {show: false},
                data: []
            }
        ]
    };
    // 时间范围选择
    var time_user_nums = laydate.render({
        elem: '#time_user_nums',
        type: 'date',
        range: true,
        done: function(value, date, endDate){
		    var tarr = value.split(' - ');
		    post[0].kstime = tarr[0];
		    post[0].jstime = tarr[1];
		    get_echat(post[0]);
		}
    });
    //选择类型
    form.on('select(date_type_user_nums)', function(data){
        post[0].date_type = data.value;
    	post[0].kstime = '';
    	post[0].jstime = '';
    	$('#time_user_nums').val('');
	    time_user_nums.config.type = data.value == 'day' ? 'date' : 'month';
		get_echat(post[0]);
    });
    // 时间范围选择
    var time_user_add = laydate.render({
        elem: '#time_user_add',
        type: 'date',
        range: true,
        done: function(value, date, endDate){
		    var tarr = value.split(' - ');
		    post[1].kstime = tarr[0];
		    post[1].jstime = tarr[1];
		    get_echat(post[1]);
		}
    });
    //选择类型
    form.on('select(date_type_user_add)', function(data){
        post[1].date_type = data.value;
    	post[1].kstime = '';
    	post[1].jstime = '';
    	$('#time_user_add').val('');
	    time_user_add.config.type = data.value == 'day' ? 'date' : 'month';
		get_echat(post[1]);
    });
    // 时间范围选择
    var time_user_pay = laydate.render({
        elem: '#time_user_pay',
        type: 'date',
        range: true,
        done: function(value, date, endDate){
		    var tarr = value.split(' - ');
		    post[2].kstime = tarr[0];
		    post[2].jstime = tarr[1];
		    get_echat(post[2]);
		}
    });
    //选择类型
    form.on('select(date_type_user_pay)', function(data){
        post[2].date_type = data.value;
    	post[2].kstime = '';
    	post[2].jstime = '';
    	$('#time_user_pay').val('');
	    time_user_pay.config.type = data.value == 'day' ? 'date' : 'month';
		get_echat(post[2]);
    });
    for (var i = 0; i < post.length; i++) {
    	get_echat(post[i]);
    }
});
function get_echat(_post){
    $.post('<?=links('ajax/echat')?>',_post,function(res){
    	if(res.code == 1){
    		if(_post.type == 'user_nums'){
    			var myChart = echarts.init(document.querySelector('.chat_user'));
    			option1.xAxis.data = res.week;
    			option1.series[0].data = res.user.android;
    			option1.series[1].data = res.user.ios;
    			myChart.setOption(option1,true);
    		}else if(_post.type == 'user_add'){
    			var myChart = echarts.init(document.querySelector('.chat_user_add'));
    			option1.xAxis.data = res.week;
    			option1.series[0].data = res.user.android;
    			option1.series[1].data = res.user.ios;
    			myChart.setOption(option1,true);
    		}else if(_post.type == 'user_order'){
				var myChart = echarts.init(document.querySelector('.chat_pay'));
    			option2.xAxis.data = res.week;
    			option2.series[0].data = res.pay.count;
    			option2.series[1].data = res.pay.rmb;
    			myChart.setOption(option2,true);
    		}else if(_post.type == 'user_facility'){
    			var myChart = echarts.init(document.querySelector('.chat_user_facility'));
    			option3.series[0].data = res.facility;
    			myChart.setOption(option3,true);
            }else if(_post.type == 'user_vip'){
                var myChart = echarts.init(document.querySelector('.chat_user_vip'));
                option4.series[0].data = res.vip;
                myChart.setOption(option4,true);
    		}else{
    			for(let key  in res.data){
    				$('.'+key).html(res.data[key]);
    			}
    		}
    	}else{
    		layer.msg(res.msg);
    	}
    },'json');
}
</script>
</body>
</html>