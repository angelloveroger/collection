<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台首页</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <link rel="stylesheet" href="/packs/admin/css/agent.css">
	<script src="/packs/jquery/jquery.min.js"></script>
	<script src="/packs/layui/layui.js"></script>
	<script src="/packs/admin/js/common.js"></script>
    <script src="/packs/jquery/clipboard.min.js"></script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-xs12 layui-col-md12">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">你的推广链接：</div>
                        <div class="layui-card-body">
                            <p><?=get_ff_url(0,0,$agent['id'])?><span data-clipboard-text="<?=get_ff_url(0,0,$agent['id'])?>" class="layui-btn layui-btn-xs copy" style="background-color: #1E9FFF;margin-left:10px;">复制</span></p>
                        </div>
                    </div>
                </div>
            </div>
        	<div class="layui-row layui-col-space15">
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    账户余额<span class="layui-badge-red pull-right tixian-btn" style="cursor: pointer;padding: 5px 10px;line-height: 1;margin-top: 10px;border-radius: 2px;">提现</span>
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span id="trmb"><?=$agent['rmb']?></span> <span style="font-size:24px;line-height: 1;">元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    今日收入
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><?=number_format($rmb['day'],2)?> <span style="font-size:24px;line-height: 1;">元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    本周收入
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><?=number_format($rmb['zhou'],2)?> <span style="font-size:24px;line-height: 1;">元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    本月收入
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><?=number_format($rmb['yue'],2)?> <span style="font-size:24px;line-height: 1;">元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    总收入
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><?=number_format($rmb['nums'],2)?> <span style="font-size:24px;line-height: 1;">元</span></p>
		                </div>
		            </div>
		        </div>
		        <div class="layui-col-xs6 layui-col-sm6 layui-col-md2 lay-hits">
		            <div class="layui-card">
		                <div class="layui-card-header">
		                    注册用户
		                </div>
		                <div class="layui-card-body">
		                    <p class="lay-big-font"><span class="user_day"><?=$user['nums']?></span> <span style="font-size:24px;line-height: 1;">人</span></p>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="layui-row layui-col-space15">
			    <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
			        <div class="layui-card">
			            <div class="layui-card-header">最近七天卡密充值</div>
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
			            <div class="layui-card-header">最近七天充值趋势</div>
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
    	</div>
    </div>
</div>
<script src="/packs/admin/js/echarts.min.js"></script>
<script type="text/javascript">
var option1,option2,myChart1,myChart2,payname = '<?=$agent['pay_name']?>';
$(function(){
	option1 = {
        tooltip: {trigger: 'axis'},
        grid:{left:50,right:50},
        legend: {
            data: ['卡密订单', '卡密金额'],
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
                name: '卡密订单',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#2A75ED'}
            },
        	{
                name: '卡密金额',
                type: 'line',
                smooth: true,
                data: [],
                itemStyle: {color: '#F4667C'}
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
    get_echat({type:'user_card'});
    get_echat({type:'user_order'});
    $('.tixian-btn').click(function(){
    	if(payname == ''){
            Admin.open('完善结算信息','<?=links('agent/withdrawal/info')?>',400,350);
    	}else{
            layer.prompt({
                formType: 0,
                value: '',
                title: '请输入提现金额',
                area: ['800px', '350px']
            }, function(value, index, elem){
                var tindex = layer.load();
                $.post('<?=links('agent/withdrawal/send')?>',{rmb:value},function(res){
                    layer.close(tindex);
                    if(res.code == 1){
                        $('#trmb').html(res.data.rmb);
                        layer.msg(res.msg);
                        layer.close(index);
                    }else{
                        layer.msg(res.msg,{shift:6});
                    }
                },'json');
            });
    	}
    });
    var clipboard = new Clipboard('.copy');
    clipboard.on('success',function(e) {
        layer.msg('复制成功');
        e.clearSelection();
    });
});
function get_echat(_post){
    $.post('<?=links('agent/ajax/echat')?>',_post,function(res){
    	if(res.code == 1){
    		if(_post.type == 'user_card'){
    			myChart1 = echarts.init(document.querySelector('.chat_user'));
    			option1.xAxis.data = res.data.week;
    			option1.series[0].data = res.data.pay.count;
    			option1.series[1].data = res.data.pay.rmb;
    			myChart1.setOption(option1,true);
    		}else if(_post.type == 'user_order'){
				myChart2 = echarts.init(document.querySelector('.chat_pay'));
    			option2.xAxis.data = res.data.week;
    			option2.series[0].data = res.data.pay.count;
    			option2.series[1].data = res.data.pay.rmb;
    			myChart2.setOption(option2,true);
    		}
    	}
    },'json');
}
</script>
</body>
</html>