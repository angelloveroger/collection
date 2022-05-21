<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>资源库</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>短视管理</a>
        <a><cite>定时任务</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief" lay-filter="setting">
                <ul class="layui-tab-title myopia-list">
                    <li data-url="<?=links('myopia/caiji')?>">资源库</li>
                    <li data-url="<?=links('myopia/timing')?>" class="layui-this">定时任务</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-form toolbar">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.open('添加任务','<?=links('myopia/timing_edit')?>',800,400);"><i class="layui-icon">&#xe654;</i>添加任务</button>
                                </div>
                            </div>
                        </div>
                        <table class="layui-table" lay-even lay-skin="row">
                            <colgroup>
                                <col class="hide" width="60">
                                <col>
                                <col class="hide" width="150">
                                <col class="hide" width="200">
                                <col width="><?=defined('IS_WAP') ? 100 : 220;?>">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="hide" style="text-align:center">序号</th>
                                    <th>任务标题</th>
                                    <th class="hide" style="text-align:center">采集方式</th>
                                    <th class="hide" style="text-align:center">最后执行时间</th>
                                    <th>操作</th>
                                </tr> 
                            </thead>
                            <tbody>
                            <?php 
                            if(empty($timing)){
                                echo '<tr><td align="center" colspan="5">没有找到相关记录!!!</td></tr>';
                            }
                            $i = 1;
                            foreach($timing as $k=>$row){
                                if($row['day'] == 1){
                                    $txt = '采集当天';
                                }elseif($row['day'] == 7){
                                    $txt = '采集本周';
                                }elseif($row['day'] == 30){
                                    $txt = '采集本月';
                                }else{
                                    $txt = '采集全部';
                                }
                                $color = date('Y-m-d') == date('Y-m-d',strtotime($row['time'])) ? ' style="color:red"' : '';
                                echo '<tr><td class="hide" align="center">'.$i.'</td><td>'.$row['name'].'</td><td class="hide" align="center"><span class="layui-btn layui-btn-xs layui-btn-normal">'.$txt.'</span></td><td class="hide" align="center"'.$color.'>'.$row['time'].'</td>';
                                if(defined('IS_WAP')){
                                    echo '<td><a style="margin-right: 5px;" href="javascript:;" onclick="Admin.open(\'任务地址\',\''.links('myopia/timing_url'.'/'.$k).'\',700,320);"><span class="layui-btn layui-btn-xs layui-btn-normal" title="任务地址">地址</span></a><a style="margin-right: 5px;" href="javascript:;" onclick="Admin.open(\'修改任务\',\''.links('myopia/timing_edit/'.$k).'\',800,400);" title="修改"><span class="layui-btn layui-btn-xs"><i class="layui-icon">&#xe642;</i></span></a><a href="javascript:;" onclick="get_del(\''.$k.'\',this);" title="删除"><span class="layui-btn layui-btn-xs layui-btn-danger" title="删除"><i class="layui-icon">&#xe640;</i></span></a></td></tr>';
                                }else{
                                    echo '<td><a style="margin-right: 5px;" href="javascript:;" onclick="Admin.open(\'任务地址\',\''.links('myopia/timing_url/'.$k).'\',700,320);"><span class="layui-btn layui-btn-xs layui-btn-normal" title="任务地址">任务地址</span></a><a style="margin-right: 5px;" href="javascript:;" onclick="Admin.open(\'修改任务\',\''.links('myopia/timing_edit/'.$k).'\',800,400);" title="修改"><span class="layui-btn layui-btn-xs"><i class="layui-icon">&#xe642;</i>修改</span></a><a href="javascript:;" onclick="get_del(\''.$k.'\',this);" title="删除"><span class="layui-btn layui-btn-xs layui-btn-danger" title="删除"><i class="layui-icon">&#xe640;</i>删除</span></a></td></tr>';
                                }
                                $i++;
                            } 
                            ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
    $('.myopia-list li').click(function(){
        var url = $(this).data('url');
        window.location.href = url;
    });
});
function get_del(ly,_this){
    layer.confirm('确定要删除吗', {
        title:'删除提示',
        btn: ['确定', '取消'], //按钮
        shade:0.001
    }, function(index) {
        var tindex = layer.load();
        $.post('<?=links('myopia/timing_del')?>', {ly:ly}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                layer.msg('删除成功...',{icon: 1});
                $(_this).parent().parent().remove();
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    }, function(index) {
        layer.close(index);
    });
}
</script>
</body>
</html>