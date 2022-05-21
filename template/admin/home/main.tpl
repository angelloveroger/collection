<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台首页</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css?v=1.12">
	<script src="/packs/jquery/jquery.min.js"></script>
	<script src="/packs/layui/layui.js"></script>
	<script src="/packs/admin/js/common.js"></script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-xs12 layui-col-md12">
        	<div class="layui-row layui-col-space15">
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    安卓用户<span class="layui-badge layui-badge-green pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span class="android_day">0</span> <span style="font-size:24px;line-height: 1;">位</span></p>
		                    <p style="font-size:12px;">合计<span class="pull-right"><span class="android_num">0</span> 人</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    IOS用户<span class="layui-badge layui-badge-red pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span class="ios_day">0</span> <span style="font-size:24px;line-height: 1;">位</span></p>
		                    <p style="font-size:12px;">合计<span class="pull-right"><span class="ios_num">0</span> 人</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    活跃用户<span class="layui-badge layui-badge-pink pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span class="active_day">0</span> <span style="font-size:24px;line-height: 1;">位</span></p>
		                    <p style="font-size:12px;">合计<span class="pull-right"><span class="active_num">0</span> 人</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    订单量<span class="layui-badge layui-badge-red pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font order_day">0</p>
		                    <p style="font-size:12px;">总订单<span class="pull-right"><span class="order_num">0</span> 单</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    充值额<span class="layui-badge layui-badge-blue pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span style="font-size:25px;line-height: 1;">¥</span> <b class="rmb_day">0</b></p>
		                    <p style="font-size:12px;">总金额<span class="pull-right"><span class="rmb_num">0</span> 元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    注册用户<span class="layui-badge layui-badge-pink pull-right">今日</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span class="user_day">0</span> <span style="font-size:24px;line-height: 1;">位</span></p>
		                    <p style="font-size:12px;">总注册<span class="pull-right"><span class="user_num">0</span> 人</span></p>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="layui-row layui-col-space15">
			    <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
			        <div class="layui-card">
			            <div class="layui-card-header">最近七天活跃用户<a style="float:right;font-size: 13px;" href="javascript:;" onclick="parent.Admin.add_tab('增长趋势','<?=links('home/echat')?>');">更多<i class="layui-icon layui-icon-right"></i></a></div>
			            <div class="layui-card-body">
							<div class="chat_user" style="width:100%; height: 350px;background: #fff;margin-top:5px;padding-bottom: 10px;">
								<div style="width:50px;height:50px;margin:0 auto;line-height: 350px;">
									<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:40px;"></i>
								</div>
							</div>
			            </div>
			        </div>
			    </div>
			    <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
			        <div class="layui-card">
			            <div class="layui-card-header">最近七天充值趋势<a style="float:right;font-size: 13px;" href="javascript:;" onclick="parent.Admin.add_tab('增长趋势','<?=links('home/echat')?>');">更多<i class="layui-icon layui-icon-right"></i></a></div>
			            <div class="layui-card-body">
							<div class="chat_pay" style="width:100%; height: 350px;background: #fff;margin-top:5px;padding-bottom: 10px;">
								<div style="width:50px;height:50px;margin:0 auto;line-height: 350px;">
									<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:40px;"></i>
								</div>
							</div>
			            </div>
			        </div>
			    </div>
		    </div>
		    <div class="layui-row layui-col-space15">
			    <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
			        <div class="layui-card">
			            <div class="layui-card-header">系统信息</div>
			            <div class="layui-card-body">
			                <table class="layui-table">
			                	<colgroup>
								    <col width="100">
								    <col>
								</colgroup>
			                    <tbody>
			                        <tr>
			                            <th>系统名称</th>
			                            <td>Video app management system</td>
			                        </tr>
			                        <tr>
			                            <th>运行域名</th>
			                            <td><?=$_SERVER["HTTP_HOST"]?></td>
			                        </tr>
			                        <tr>
			                            <th>服务器IP</th>
			                            <td><?=GetHostByName($_SERVER['SERVER_NAME'])?></td>
			                        </tr>
			                        <tr>
			                            <th>操作系统</th>
			                            <td><?php $os = explode(" ", php_uname()); echo $os[0];?></td>
			                        </tr>
			                        <tr>
			                            <th>运行环境</th>
			                            <td><?php if('/'==DIRECTORY_SEPARATOR){echo $os[2];}else{echo $os[1];} ?> /   <?php echo $_SERVER['SERVER_SOFTWARE'];?></td>
			                        </tr>
			                        <tr>
			                            <th>PHP版本</th>
			                            <td><?=PHP_VERSION?></td>
			                        </tr>
			                        <tr>
			                            <th>系统时间</th>
			                            <td><?=date('Y-m-d H:i:s')?></td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			        </div>
			    </div>
			    <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
					<div class="layui-card">
			            <div class="layui-card-header">官方公告</div>
			            <div class="layui-card-body">
			                <div class="communique">
								<div style="width:50px;height:50px;margin:0 auto;line-height: 270px;">
									<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop" style="display: inline-block;font-size:40px;"></i>
								</div>
							</div>
			            </div>
			        </div>
			    </div>
		    </div>
    	</div>
    </div>
</div>
<script src="/packs/admin/js/echarts.min.js"></script>
<script type="text/javascript">
var config = <?=$config;?>,option1,option2,myChart1,myChart2;
$(function(){
	Admin.get_main();
	get_echat({time:1});
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
                itemStyle: {color: '#2A75ED'}
            },
        	{
                name: '充值金额',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#F4667C'}
            }
        ]
    };
    get_echat({type:'user_nums'});
    get_echat({type:'user_order'});
});
function get_echat(_post){
    $.post('<?=links('ajax/echat')?>',_post,function(res){
    	if(res.code == 1){
    		if(_post.type == 'user_nums'){
    			myChart1 = echarts.init(document.querySelector('.chat_user'));
    			option1.xAxis.data = res.week;
    			option1.series[0].data = res.user.android;
    			option1.series[1].data = res.user.ios;
    			myChart1.setOption(option1,true);
    		}else if(_post.type == 'user_order'){
				myChart2 = echarts.init(document.querySelector('.chat_pay'));
    			option2.xAxis.data = res.week;
    			option2.series[0].data = res.pay.count;
    			option2.series[1].data = res.pay.rmb;
    			myChart2.setOption(option2,true);
    		}else{
    			for(let key  in res.data){
    				$('.'+key).html(res.data[key]);
    			}
    		}
    	}
    },'json');
}
</script>
</body>
</html>