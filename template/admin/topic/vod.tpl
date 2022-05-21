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
<div class="layui-fluid" style="padding:0;">
    <div class="layui-card" style="background-color: #fff;">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-bottom:0;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('topic/voddel')?>','vod')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('topic/vod/'.$tid.'/json')?>',limit:10,limits:[10,30,50,100],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'vod'}" lay-filter="vod">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'name',templet:'#nameTpl'}">视频名称</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'id',sort: true,width:70,align:'center'}">视频ID</th>
                    <th lay-data="{field:'pic',width:80,align:'center',templet:'#picTpl'}">缩略图</th>
                    <th lay-data="{field:'name',templet:'#nameTpl'}">视频名称</th>
                    <th lay-data="{field:'hits',width:80,align:'center'}">人气</th>
                    <th lay-data="{field:'pay',width:60,align:'center'}">收费</th>
                    <th lay-data="{field:'addtime',align:'center',width:160,sort: true}">更新日期</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="nameTpl">
    <a href="javascript:;">{{d.name}}<font style="padding-left:8px;color:#f60;">{{d.state}}</font></a>
</script>
<script type="text/html" id="picTpl">
    <div onclick="show_img(this)"><img src="{{d.pic}}" style="width: 100%;"></div>
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('topic/voddel')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script>
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
</script>
</body>
</html>