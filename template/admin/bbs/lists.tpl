<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>分类列表</title>
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
        <a>社区管理</a>
        <a><cite>分类标签</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <for class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button lay-filter="del" lay-submit class="layui-btn layui-btn-sm layui-btn-danger layui-cmd"><i class="layui-icon">&#xe640;</i>删除选中</button>
                        <button class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="Admin.open('新增分类','<?=links('bbs/lists_edit')?>',500,360);"><i class="layui-icon">&#xe624;</i>新增分类</button>
                    </div>
                </div>
                <table class="layui-table" lay-skin="line">
                    <colgroup>
                        <col width="40">
                        <col class="hide" width="70">
                        <col>
                        <col class="hide" width="120">
                        <col class="hide" width="100">
                        <col class="hide" width="160">
                        <col class="hide" width="150">
                        <col width="150">
                    </colgroup>
                    <thead>
                        <tr>
                            <th style="text-align:center"><input lay-filter="qxuan" type="checkbox" name="qxuan" lay-skin="primary"></th>
                            <th class="hide" style="text-align:center">ID</th>
                            <th>标题</th>
                            <th class="hide" style="text-align:center">图片</th>
                            <th class="hide" style="text-align:center">是否显示</th>
                            <th class="hide" style="text-align:center">帖子数量</th>
                            <th class="hide" style="text-align:center">排序ID</th>
                            <th style="text-align:center">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php 
                    foreach($class as $row){
                        $show = $row['yid'] == 0 ? '<font color=#080>显示</font>' : '<font color=red>隐藏</font>';
                        $nums = $this->mydb->get_nums('bbs',array('cid'=>$row['id']));
                        $pic = !empty($row['pic']) ? '<img onclick="show_img(this)" style="max-height:30px;" src="'.getpic($row['pic']).'">' : '----';
                        echo '<tr><td align="center"><input class="xuan" type="checkbox" name="xuan" lay-skin="primary" value="'.$row['id'].'"></td><td class="hide" align="center">'.$row['id'].'</td><td>'.$row['name'].'</td><td class="hide" align="center">'.$pic.'</td><td class="hide" align="center">'.$show.'</td><td class="hide" align="center">'.$nums.'</td><td class="hide" align="center">'.$row['id'].'</td><td align="center"><div class="layui-table-cell laytable-cell-1-0-7"><button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open(\'分类编辑\',\''.links('bbs/lists_edit').'/'.$row['id'].'\',500,360)"><i class="layui-icon">&#xe642;</i>编辑</button><button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del(\''.links('bbs/lists_del').'\',\''.$row['id'].'\',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button></div></td></tr>';
                    } 
                    ?>
                    </tbody>
                </table>
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
    //批量删除
    form.on('submit(del)', function(data){
        var obj = $('.xuan');
        var ids = [];
        for (var i = 0; i < obj.length; i++) {
            if(obj[i].checked) ids.push(obj[i].value);
        }
        if(ids.length == 0){
            layer.msg('请选择要操作的数据',{icon: 2});
            return false;
        }
        layer.confirm('确定要删除吗', {
            title:'删除提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            $.post('<?=links('bbs/lists_del')?>', {id:ids}, function(res) {
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});
                    setTimeout(function() {
                        window.location.reload();
                    }, 1000);
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    });
});
function show_img(t) {
    var t = $(t);
    //页面层
    layer.open({
        type: 1,
        skin: 'none', //加上边框
        area: ['45%', '65%'], //宽高
        shadeClose: true, //开启遮罩关闭
        end: function (index, layero) {
            return false;
        },
        content: '<div style="text-align:center"><img style="max-width:100%;" src="' + $(t).attr('src') + '" /></div>'
    });
}
</script>
</body>
</html>