<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>站群列表</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style>td input{text-align: center;}.layui-input, .layui-textarea{padding-left: 0;}.layui-table td{padding: 5px 15px;}</style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>站群管理</a>
        <a><cite>站群列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <for class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增站群','<?=links('site/edit')?>',800,550);"><i class="layui-icon">&#xe624;</i>新增站群</button>
                    </div>
                </div>
                <table class="layui-table" lay-skin="line">
                    <colgroup>
                        <col class="hide" width="70">
                        <col>
                        <col>
                        <col class="hide" width="200">
                        <col class="hide" width="200">
                        <col width="150">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="hide" style="text-align:center">序</th>
                            <th>站点名字</th>
                            <th class="hide" style="text-align:center">站点域名</th>
                            <th class="hide" style="text-align:center">PC模板</th>
                            <th class="hide" style="text-align:center">WAP模板</th>
                            <th style="text-align:center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    if(empty($site)) echo '<tr><td colspan="6" align="center" style="padding:20px;">暂无记录~!</td></tr>';
                    foreach($site as $k=>$row){
                        if(empty($row['pc_tpl'])) $row['pc_tpl'] = '默认模板';
                        if(empty($row['wap_tpl'])) $row['wap_tpl'] = '默认模板';
                        $kk = $k+1;
                        echo '<tr style="background-color: #f6f6f6;"><td class="hide" align="center">'.$kk.'</td><td><b>'.$row['name'].'</b></td><td class="hide" align="center"><a target="_blank" href="http://'.$row['host'].'">'.$row['host'].'</a></td><td class="hide" align="center">'.$row['pc_tpl'].'</td><td class="hide" align="center">'.$row['wap_tpl'].'</td><td align="center"><div class="layui-table-cell laytable-cell-1-0-7"><button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open(\'分类编辑\',\''.links('site/edit').'/'.$kk.'\',800,550)"><i class="layui-icon">&#xe642;</i>编辑</button><button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs site-del" data-id="'.$kk.'"><i class="layui-icon">&#xe640;</i>删除</button></div></td></tr>';
                    } 
                    ?>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>
<script>
layui.use(['form','layer'],function() {
    var layer = layui.layer,
        form = layui.form;
    //监听switch全反选
    form.on('checkbox(qxuan)', function(data){
        var val = data.value;
        var obj = $('.xuan');
        for (var i = 0; i < obj.length; i++) {
            obj[i].checked = (obj[i].checked) ? false : true;
        }
        form.render('checkbox');
    });
    //删除
    $('.site-del').click(function(){
        var id = $(this).data('id');
        layer.confirm('确定要删除吗', {
            title:'删除提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            layer.close(index);
            $.post('<?=links('site/del')?>', {id:id}, function(res) {
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});
                    setTimeout(function() {
                        window.location.reload();
                    }, 500);
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    });
})
</script>
</body>
</html>