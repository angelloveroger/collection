<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>视频列表</title>
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
        <a>视频管理</a>
        <a><cite>重复视频列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('vod/del')?>','vod')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                    <div class="layui-inline select120 mr0 topic">
                        <div class="layui-input-inline h30">
                            <select name="ztid" id="topic">
                            <option value="">视频专题</option>
                            <?php
                            foreach($topic as $row){
                                echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                            }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select120 mr0">
                        <div class="layui-input-inline h30">
                            <select name="cid">
                            <option value="">视频分类</option>
                            <?php
                            $chtml = '';
                            foreach($class as $row){
                                $chtml .= '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                                echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                                $type = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',50);
                                foreach($type as $row2){
                                    $chtml .= '<option value="'.$row2['id'].'">&nbsp;&nbsp;&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
                                    echo '<option value="'.$row2['id'].'">&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
                                }
                            }
                            ?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="name">视频名称</option>
                                <option value="id">视频ID</option>
                                <option value="director">视频导演</option>
                                <option value="actor">视频主演</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="">
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="year">
                                <option value="">年份</option>
                                <?php
                                for($y=date('Y');$y>2001;$y--){
                                    echo '<option value="'.$y.'">'.$y.'</option>';
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="area">
                                <option value="">地区</option>
                                <?php
                                foreach($area as $val){
                                    echo '<option value="'.$val.'">'.$val.'</option>';
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="lang">
                                <option value="">语言</option>
                                <?php
                                foreach($lang as $val){
                                    echo '<option value="'.$val.'">'.$val.'</option>';
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="pay">
                                <option value="">收费</option>
                                <option value="1">免费</option>
                                <option value="2">VIP</option>
                                <option value="3">点播</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="tid">
                                <option value="">推荐</option>
                                <option value="2">是</option>
                                <option value="1">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="reco">
                                <option value="">轮播图</option>
                                <option value="2">是</option>
                                <option value="1">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="app">
                                <option value="">APP专属</option>
                                <option value="2">是</option>
                                <option value="1">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline select70 mr0">
                        <div class="layui-input-inline h30">
                            <select name="order">
                                <option value="">排序方式</option>
                                <option value="addtime">更新时间</option>
                                <option value="id">最新入库</option>
                                <option value="hits">总人气</option>
                                <option value="yhits">月人气</option>
                                <option value="zhits">周人气</option>
                                <option value="rhits">日人气</option>
                                <option value="sohits">搜索人气</option>
                                <option value="shits">收藏人气</option>
                                <option value="score">评分最高</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="vod" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('vod/repeat/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'vod'}" lay-filter="vod">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'name',templet:'#nameTpl'}">视频名称</th>
                    <th lay-data="{align:'center',width:150,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">视频ID</th>
                    <th lay-data="{field:'pic',width:80,align:'center',templet:'#picTpl'}">缩略图</th>
                    <th lay-data="{field:'name',templet:'#nameTpl'}">视频名称</th>
                    <th lay-data="{field:'cname',align:'center',width:100,templet:'#cidTpl'}">视频分类</th>
                    <th lay-data="{field:'actor'}">视频主演</th>
                    <th lay-data="{field:'score',width:80,align:'center'}">评分</th>
                    <th lay-data="{field:'hits',width:80,align:'center'}">人气</th>
                    <th lay-data="{field:'reco',width:60,align:'center',templet:'#recoTpl'}">轮播图</th>
                    <th lay-data="{field:'tid',width:60,align:'center',templet:'#tjTpl'}">推荐</th>
                    <th lay-data="{field:'pay',width:60,align:'center'}">收费</th>
                    <th lay-data="{field:'app',width:70,align:'center',templet:'#appTpl'}">APP专属</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">更新日期</th>
                    <th lay-data="{align:'center',width:150,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="nameTpl">
    <a href="javascript:;" onclick="Admin.open('视频编辑','<?=links('vod/edit')?>/{{d.id}}',0,0,1)">{{d.name}}<font style="padding-left:8px;color:#f60;">{{d.state}}</font></a>
</script>
<script type="text/html" id="picTpl">
    <div onclick="show_img(this)"><img src="{{d.pic}}" style="width: 100%;"></div>
</script>
<script type="text/html" id="cidTpl">
    <div class="bind" data-id="{{d.id}}">{{d.cname}} <i class="layui-icon layui-icon-triangle-d"></i></div>
</script>
<script type="text/html" id="tjTpl">
    {{#  if(d.tid == 1){ }}
        <div style="color:#080;cursor: pointer;" class="layui-icon tid" data-id="{{d.id}}" data-tid="0" title="已推荐，点击取消推荐">&#xe605;</div>
    {{#  } else { }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon tid" data-id="{{d.id}}" data-tid="1" title="未推荐，点击推荐">&#x1006;</div>
    {{#  } }}
</script>
<script type="text/html" id="appTpl">
    {{#  if(d.app == 1){ }}
        <div style="color:#080;cursor: pointer;" class="layui-icon app" data-id="{{d.id}}" data-app="0" title="APP专属播放，点击取消">&#xe605;</div>
    {{#  } else { }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon app" data-id="{{d.id}}" data-app="1" title="点击设置为APP专属播放">&#x1006;</div>
    {{#  } }}
</script>
<script type="text/html" id="recoTpl">
    {{#  if(d.reco == 1){ }}
        <div style="color:#080;cursor: pointer;" class="layui-icon reco" data-id="{{d.id}}" data-tid="0" title="已上轮播图，点击取消">&#xe605;</div>
    {{#  } else { }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon reco" data-id="{{d.id}}" data-tid="1" title="未上，点击上轮播图">&#x1006;</div>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('视频编辑','<?=links('vod/edit')?>/{{d.id}}',0,0,1)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('vod/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
$(function(){
    $(document).on('click','.reco',function(){
        var _this = $(this);
        var tid = $(this).attr('data-tid');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('vod/init/reco')?>', {id:id,tid:tid}, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                if(tid == 1){
                    _this.html('&#xe605;').attr('data-tid','0').css('color','#080');
                }else{
                    _this.html('&#x1006;').attr('data-tid','1').css('color','#f30');
                }
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    })
    $(document).on('click','.tid',function(){
        var _this = $(this);
        var tid = $(this).attr('data-tid');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('vod/init/tid')?>', {id:id,tid:tid}, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                if(tid == 1){
                    _this.html('&#xe605;').attr('data-tid','0').css('color','#080');
                }else{
                    _this.html('&#x1006;').attr('data-tid','1').css('color','#f30');
                }
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    })
    $(document).on('click','.app',function(){
        var _this = $(this);
        var app = $(this).attr('data-app');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('vod/init/app')?>', {id:id,tid:app}, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                if(app == 1){
                    _this.html('&#xe605;').attr('data-app','0').css('color','#080');
                }else{
                    _this.html('&#x1006;').attr('data-app','1').css('color','#f30');
                }
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        },'json');
    })
    //更换分类
    $(document).on('click','.bind',function(){
        var left = event.clientX+document.body.scrollLeft-150;
        if(left < 0) left = 10;
        var top = event.clientY+document.body.scrollTop+20;
        var h = document.documentElement.clientHeight - 100;
        if(top > h) top = top - 120;
        var id = $(this).attr('data-id');
        var _this = $(this);
        layer.open({
            title: false,
            area: ['280px','120px'],
            offset: [top+'px', left+'px'],
            zIndex:99,
            closeBtn:0,
            shade:0,
            content: '<div style="display:inline-block;">选择分类：</div><select name="cid" id="cid" style="cursor: pointer;height: 30px;width:150px;"><?=$chtml?></select>',
            btn: ['转移', '取消'],
            yes: function(index) {
                var cid = $('#cid').val();
                var tindex = layer.load();
                $.post('<?=links('vod/transfer')?>',{cid:cid,id:id}, function(res) {
                    layer.close(tindex);
                    if(res.code == 1){
                        _this.html(res.name);
                        layer.msg(res.msg,{icon: 1});
                        layer.close(index);
                    }else{
                        layer.msg(res.msg,{icon: 2});
                    }
                },'json');
            },
            btn2: function(index, layero) {
                layer.close(index);
            }
        });
    });
});
function show_img(t) {
    var t = $(t).find("img");
    //页面层
    layer.open({
        type: 1,
        skin: 'none', //加上边框
        area: ['45%', '65%'], //宽高
        shadeClose: true, //开启遮罩关闭
        end: function (index, layero) {
            return false;
        },
        content: '<div style="text-align:center"><img src="' + $(t).attr('src') + '" /></div>'
    });
}
function get_topic(){
    var ids = [];
    var ztid = $('#topic').val();
    var checkStatus = table.checkStatus('vod');
    checkStatus.data.forEach(function(n,i){
        ids.push(n.id);
    });
    if(ids.length ==0){
        layer.msg('请选择要操作的数据',{icon: 2});
    }else if(ztid == ''){
        layer.msg('请选择专题',{icon: 2});
        layer.tips('请选择专题',$('.topic'),{time:0,tips:1});
    }else{
        layer.confirm('确定要操作吗', {
            title:'操作提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            $.post('<?=links('vod/init/ztid')?>', {'id':ids,tid:ztid}, function(res) {
                if(res.code == 1){
                    layer.msg('设置成功...',{icon: 1});
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    }
}
</script>
</body>
</html>