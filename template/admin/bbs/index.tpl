<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>帖子列表</title>
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
        <a><cite>帖子列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief" lay-filter="setting">
                <ul class="layui-tab-title bbs-list">
                    <li data-url="<?=links('bbs')?>"<?php if($yid == 1) echo ' class="layui-this"';?>>已审帖子</li>
                    <li data-url="<?=links('bbs/index/2')?>"<?php if($yid == 2) echo ' class="layui-this"';?>>待审帖子</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-form toolbar">
                            <div class="layui-form-item" style="margin-top: 10px;">
                                <div class="layui-inline">
                                    <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('bbs/del')?>','bbs')"><i class="layui-icon">&#xe640;</i>删除</button>
                                    <?php if($yid == 2){ ?>
                                    <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="get_yid()">批量审核</button>
                                    <?php } ?>
                                </div>
                                <div class="layui-inline select120 mr0">
                                    <div class="layui-input-inline h30">
                                        <select name="cid">
                                        <option value="">标签分类</option>
                                        <?php
                                        $chtml = '';
                                        foreach($class as $row){
                                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
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
                                            <option value="name">帖子标题</option>
                                            <option value="text">帖子内容</option>
                                            <option value="id">帖子ID</option>
                                            <option value="uid">用户ID</option>
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
                                        <select name="ding">
                                            <option value="">置顶</option>
                                            <option value="2">是</option>
                                            <option value="1">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline select70 mr0">
                                    <div class="layui-input-inline h30">
                                        <select name="reco">
                                            <option value="">推荐</option>
                                            <option value="2">是</option>
                                            <option value="1">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline select100 mr0">
                                    <div class="layui-input-inline h30">
                                        <select name="order">
                                            <option value="">排序方式</option>
                                            <option value="id">最新入库</option>
                                            <option value="hits">浏览人气</option>
                                            <option value="zan">点赞次数</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline mr0">
                                    <button class="layui-btn layui-btn-sm" data-id="bbs" lay-submit lay-filter="table-sreach">
                                        <i class="layui-icon">&#xe615;</i>搜索
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('bbs/index/'.$yid.'/json')?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'bbs'}" lay-filter="bbs">
                          <thead>
                            <tr>
                            <?php if(defined('IS_WAP')){ ?>
                                <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                                <th lay-data="{field:'name',templet:'#nameTpl'}">帖子标题</th>
                                <th lay-data="{field:'ding',width:70,align:'center',templet:'#dingTpl'}">置顶</th>
                                <th lay-data="{align:'center',width:150,templet:'#cmdTpl'}">操作</th>
                            <?php }else{ ?>
                                <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                                <th lay-data="{field:'id',width:70,align:'center'}">帖子ID</th>
                                <th lay-data="{field:'name',templet:'#nameTpl'}">帖子标题</th>
                                <th lay-data="{field:'text'}">帖子内容</th>
                                <th lay-data="{field:'uid',width:70,align:'center'}">用户ID</th>
                                <th lay-data="{field:'cname',align:'center',width:150}">标签分类</th>
                                <th lay-data="{field:'hits',width:80,align:'center'}">浏览次数</th>
                                <th lay-data="{field:'zan',width:80,align:'center'}">点赞次数</th>
                                <th lay-data="{field:'ding',width:70,align:'center',templet:'#dingTpl'}">置顶</th>
                                <th lay-data="{field:'reco',width:60,align:'center',templet:'#recoTpl'}">推荐</th>
                                <th lay-data="{field:'addtime',align:'center',width:160}">发布时间</th>
                                <th lay-data="{align:'center',width:150,templet:'#cmdTpl'}">操作</th>
                            <?php } ?>
                            </tr>
                          </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="nameTpl">
    <a href="javascript:;" onclick="Admin.open('帖子编辑','<?=links('bbs/edit')?>?id={{d.id}}',1000,460)">{{d.name}}</a>
    {{#  if(d.ispic == 1){ }}
    <a href="javascript:;" onclick="parent.Admin.add_tab('帖子图片','<?=links('bbs/pic')?>?bid={{d.id}}')"><font style="color:#f60;">有图片</font></a>
    {{#  } }}
</script>
<script type="text/html" id="recoTpl">
    {{#  if(d.reco == 1){ }}
        <div style="color:#080;cursor: pointer;" class="layui-icon reco" data-id="{{d.id}}" data-tid="0" title="已推荐，点击取消推荐">&#xe605;</div>
    {{#  } else { }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon reco" data-id="{{d.id}}" data-tid="1" title="未推荐，点击推荐">&#x1006;</div>
    {{#  } }}
</script>
<script type="text/html" id="dingTpl">
    {{#  if(d.ding == 1){ }}
        <div style="color:#080;cursor: pointer;" class="layui-icon ding" data-id="{{d.id}}" data-tid="0" title="已置顶，点击取消">&#xe605;</div>
    {{#  } else { }}
        <div style="color:#f30;cursor: pointer;" class="layui-icon ding" data-id="{{d.id}}" data-tid="1" title="未置顶，点击置顶">&#x1006;</div>
    {{#  } }}
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="编辑" class="layui-btn layui-btn-xs" onclick="Admin.open('帖子编辑','<?=links('bbs/edit')?>?id={{d.id}}',1000,460)"><i class="layui-icon">&#xe642;</i>编辑</button>
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('bbs/del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
$(function(){
    $('.bbs-list li').click(function(){
        var url = $(this).data('url');
        window.location.href = url;
    });
    $(document).on('click','.reco',function(){
        var _this = $(this);
        var tid = $(this).attr('data-tid');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('bbs/init/reco')?>', {id:id,tid:tid}, function(res) {
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
    });
    $(document).on('click','.ding',function(){
        var _this = $(this);
        var tid = $(this).attr('data-tid');
        var id = $(this).attr('data-id');
        var index = layer.load();
        $.post('<?=links('bbs/init/ding')?>', {id:id,tid:tid}, function(res) {
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
    });
});
function get_yid(){
    var ids = [];
    var checkStatus = table.checkStatus('bbs');
    checkStatus.data.forEach(function(n,i){
        ids.push(n.id);
    });
    if(ids.length ==0){
        layer.msg('请选择要操作的帖子',{icon: 2});
    }else{
        layer.confirm('确定要操作吗', {
            title:'操作提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            var index2 = layer.load();
            $.post('<?=links('bbs/audit')?>', {'id':ids}, function(res) {
                layer.close(index2);
                if(res.code == 1){
                    layer.msg('审核成功...',{icon: 1});
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