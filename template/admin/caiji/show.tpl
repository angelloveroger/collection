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
<style type="text/css">
.layui-card{
    margin-bottom: 8px;
}
.layui-card-header{
    border-bottom: 1px solid #eaeaea;
}
.layui-layer-dialog {
    min-width: 220px!important;
}
</style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>采集管理</a>
        <a><cite>资源库</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <?php if(empty($vod_list)){ ?>
    <div class="layui-card">
        <div class="layui-card-body">
            获取资源列表失败，请稍后再试......
            <a style="margin-right:20px;" href="<?=links('caiji/zyk')?>" onclick="layer.load();">返回资源库列表</a>
        </div>
    </div>
    <?php }else{ ?>
    <div class="layui-card">
        <div class="layui-card-header">
            资源分类
            <button style="margin-left: 10px;" type="button" class="layui-btn layui-btn-xs layui-btn-danger delbind">一键解绑所有分类</button>
            <a style="margin-right:20px;float: right;" href="<?=links('caiji/zyk')?>" onclick="layer.load();">返回资源库列表</a>
        </div>
        <div class="layui-card-body">
            <div class="layui-row layui-col-space15">
                <?php 
                foreach($vod_list as $row){
                    $bname = isset($bind[$row['id']]) ? '<i class="layui-icon" style="color:#080">&#xe605;</i>' : '<i class="layui-icon" style="color:red">&#x1006;</i>';
                    $bdstr = '<a title="点击绑定分类" href="javascript:;" class="bind" data-id="'.$row['id'].'">'.$bname.'</a>';
                    $name = $cid == $row['id'] ? '<b style="color:red">'.$row['name'].'</b>' : $row['name'];
                    echo '<div class="layui-col-xs4 layui-col-sm3 layui-col-md2"><a onclick="layer.load();" href="'.links('caiji/show').'?ly='.$ly.'&apiurl='.urlencode($apiurl).'&type='.$type.'&cid='.$row['id'].'">'.$name.' '.$bdstr.'</a></div>';
                } 
                ?>
                <div class="layui-col-xs4 layui-col-sm3 layui-col-md2"><a onclick="layer.load();" href="<?=links('caiji/show')?>?ly=<?=$ly?>&type=<?=$type?>&apiurl=<?=urlencode($apiurl)?>"><?=($cid == 0 ? '<b style="color:red">全部分类</b>' : '全部分类')?></a></div>
            </div>
        </div>
    </div>
    <div class="layui-card" style="margin-top: 12px;">
        <div class="layui-row layui-col-space15" style="padding:10px 15px 5px;">
            <div class="layui-col-xs12 layui-col-md6">
                <button type="button" class="layui-btn layui-btn-sm layui-btn-normal caiji-btn" data-id="1">采集选中</button>
                <?php if($cid > 0){ ?>
                <button type="button" class="layui-btn layui-btn-sm caiji-btn" data-id="2">采集本类</button>
                <?php } ?>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-danger caiji-btn" data-id="3">采集当天</button>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-warm caiji-btn" data-id="5">采集所有</button>
            </div>
            <div class="layui-col-xs12 layui-col-md6">
                <div style="float:right;margin-right: 20px;">
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline">
                            <input id="key" type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="<?=$key?>">
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm caiji-btn" data-id="4">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-card-body layui-form" style="padding-top:0;">
            <table class="layui-table" lay-even lay-skin="row">
                <colgroup>
                    <col width="40">
                    <col class="hide" width="90">
                    <col>
                    <col width="100">
                    <col class="hide" width="200">
                    <col width="180">
                </colgroup>
                <thead>
                    <tr>
                        <th style="text-align:center"><input lay-filter="qxuan" type="checkbox" name="qxuan" lay-skin="primary"></th>
                        <th class="hide" style="text-align:center">视频ID</th>
                        <th>视频标题</th>
                        <th class="hide" style="text-align:center">视频分类</th>
                        <th class="hide" style="text-align:center">更新状态</th>
                        <th style="text-align:center">更新时间</th>
                    </tr> 
                </thead>
                <tbody>
                <?php 
                if(empty($vod)){
                    echo '<tr><td align="center" colspan="6">没有找到相关记录!!!</td></tr>';
                }else{
                    foreach($vod as $k=>$v){ 
                        if(date('Y-m-d') == date('Y-m-d',strtotime($v['addtime']))) $v['addtime'] = '<font color=red>'.$v['addtime'].'</font>';
                        echo '<tr><td align="center"><input class="xuan" type="checkbox" name="xuan" lay-skin="primary" value="'.$v['zyid'].'"></td><td class="hide" align="center">'.$v['zyid'].'</td><td>'.$v['name'].'</td><td class="hide" align="center">'.$v['tags'].'</td><td class="hide" align="center">'.$v['state'].'</td><td align="center">'.$v['addtime'].'</td></tr>';
                    }
                }
                ?>
                </tbody>
            </table>
            <div id="page"></div>
        </div>
    </div>
    <?php } ?>
</div>
<script>
var cid = '<?=$cid?>';
layui.use(['form','layer','laypage'],function() {
    var layer = layui.layer,
        form = layui.form,
        laypage = layui.laypage;
    //分页
    laypage.render({
        elem: 'page',
        count: <?=(int)$nums?>,
        pages: <?=(int)$pagejs?>,
        curr:  <?=(int)$page?>,
        limit: <?=(int)$size?>,
        layout: ['count', 'prev', 'page', 'next', 'skip'],
        jump: function(obj,first){
            if(!first) {
                layer.load();
                window.location.href = "<?=links('caiji/show')?>?apiurl=<?=urlencode($apiurl)?>&ly=<?=$ly?>&type=<?=$type?>&cid=<?=$cid?>&page="+obj.curr;
            }
        }
    });
    //监听switch全反选
    form.on('checkbox(qxuan)', function(data){
        var val = data.value;
        var obj = $('.xuan');
        for (var i = 0; i < obj.length; i++) {
            obj[i].checked = (obj[i].checked) ? false : true;
        }
        form.render('checkbox');
    });
    //采集开始
    $('.caiji-btn').click(function(){
        var id = $(this).attr('data-id');
        var cjurl = '<?=links('caiji/ruku')?>?apiurl=<?=urlencode($apiurl)?>&ly=<?=$ly?>&type=<?=$type?>';
        if(id == 1){ //选中
            var obj = $('.xuan');
            var ids = [];
            for (var i = 0; i < obj.length; i++) {
                if(obj[i].checked) ids.push(obj[i].value);
            }
            if(ids.length == 0){
                layer.msg('请选择要采集的数据',{shift:6});
                return false;
            }
            cjurl+='&ids='+ids.join(",");
        } else if(id == 2){ //分类
            if(cid == '0'){
                layer.msg('当前未选择分类',{shift:6});
                return false;
            }
            cjurl+='&cid=<?=$cid?>';
        } else if(id == 3){ //当天
            cjurl+='&day=1';
        } else if(id == 4){ //搜索
            var key = $('#key').val();
            if(key == ''){
                layer.msg('请输入要搜索的关键字',{shift:6});
                return false;
            }else{
                cjurl = '<?=links('caiji/show')?>?apiurl=<?=urlencode($apiurl)?>&ly=<?=$ly?>&type=<?=$type?>&key='+encodeURI(key);
            }
        }
        layer.load();
        window.location.href = cjurl;
    });
    <?php 
    $chtml='';
    foreach($class as $row){
        $chtml .= '<option value="'.$row['id'].'">'.$row['name'].'</option>';
        $type = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',100);
        foreach($type as $row2){            
            $chtml .= '<option value="'.$row2['id'].'">&nbsp;&nbsp;&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
        }
    }
    ?>
    //绑定分类
    $('.bind').click(function(event){
        var left = event.clientX+document.body.scrollLeft-150;
        if(left < 0) left = 10;
        var top = event.clientY+document.body.scrollTop+20;
        var zycid = $(this).attr('data-id');
        var _this = $(this);
        layer.open({
            title: false,
            area: ['220px','120px'],
            offset: [top+'px', left+'px'],
            zIndex:99,
            closeBtn:0,
            shade:0,
            content: '<div style="display:inline-block;">选择分类：</div><select name="cid" id="cid" style="cursor: pointer;height: 30px;width:100px;"><?=$chtml?><option value="0">取消绑定</option></select>',
            btn: ['绑定', '取消'],
            yes: function(index) {
                var cid = $('#cid').val();
                var tindex = layer.load();
                $.post('<?=links('caiji/bind')?>',{ly:'<?=$ly?>',cid:cid,zycid:zycid}, function(res) {
                    layer.close(tindex);
                    if(res.code == 1){
                        if(cid == 0){
                            _this.html('<i class="layui-icon" style="color:red">&#x1006;</i>');
                        }else{
                            _this.html('<i class="layui-icon" style="color:#080">&#xe605;</i>');
                        }
                        layer.msg(res.msg,{icon: 1});
                        layer.close(index);
                    }else{
                        layer.msg(res.msg,{shift:6});
                    }
                },'json');
            },
            btn2: function(index, layero) {
                layer.close(index);
            }
        });
    });
    //一键解除所有绑定
    $('.delbind').click(function(){
        layer.confirm('确定要解除所有分类吗', {
            title:'解除提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            layer.load();
            $.post('<?=links('caiji/bind')?>', {ly:'<?=$ly?>',op:'delall'}, function(res) {
                if(res.code == 1){
                    layer.msg('全部解除成功...',{icon: 1});
                    setTimeout(function() {
                        window.location.reload();
                    }, 1000);
                }else{
                    layer.msg(res.msg,{shift:6});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    })
})
</script>
</body>
</html>