<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>帖子图片列表</title>
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
        <a><cite>帖子图片</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="Admin.get_load();" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item" style="margin-top: 10px;">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="Admin.del('<?=links('bbs/pic_del')?>','bbs')"><i class="layui-icon">&#xe640;</i>删除</button>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input name="times" class="layui-input date-icon h30" type="text" placeholder="请选择日期范围" autocomplete="off"/>
                        </div>
                    </div>
                    <div class="layui-inline select100 mr0">
                        <div class="layui-input-inline h30">
                            <select name="zd">
                                <option value="bid">帖子ID</option>
                                <option value="uid">用户ID</option>
                                <option value="url">图片Url</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <div class="layui-input-inline mr0">
                            <input type="text" name="key" placeholder="请输入关键字" autocomplete="off" class="layui-input h30" value="">
                        </div>
                    </div>
                    <div class="layui-inline mr0">
                        <button class="layui-btn layui-btn-sm" data-id="bbs" lay-submit lay-filter="table-sreach">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                    </div>
                </div>
            </div>
            <table class="layui-table" lay-even lay-skin="row" lay-data="{url:'<?=links('bbs/pic/json')?>?bid=<?=$bid?>',limit:20,limits:[20,30,50,100,500],page:{layout:['count','prev','page','next','refresh','skip','limit']},id:'bbs'}" lay-filter="bbs">
              <thead>
                <tr>
                <?php if(defined('IS_WAP')){ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'pic',width:80,align:'center',templet:'#picTpl'}">缩略图</th>
                    <th lay-data="{field:'url'}">图片地址</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php }else{ ?>
                    <th lay-data="{field:'id',type:'checkbox',width:40,align:'center'}"></th>
                    <th lay-data="{field:'pic',width:80,align:'center',templet:'#picTpl'}">缩略图</th>
                    <th lay-data="{field:'url'}">图片地址</th>
                    <th lay-data="{field:'id',width:100,align:'center'}">帖子ID</th>
                    <th lay-data="{field:'bname'}">帖子标题</th>
                    <th lay-data="{field:'uid',width:100,align:'center'}">用户ID</th>
                    <th lay-data="{field:'addtime',align:'center',width:160}">上传时间</th>
                    <th lay-data="{align:'center',width:100,templet:'#cmdTpl'}">操作</th>
                <?php } ?>
                </tr>
              </thead>
            </table>
        </div>
    </div>
</div>
<script type="text/html" id="picTpl">
    <div onclick="show_img(this)"><img src="{{d.url}}" style="width: 100%;"></div>
</script>
<script type="text/html" id="cmdTpl">
    <button style="margin-left:5px;" title="删除" class="layui-btn-danger layui-btn layui-btn-xs" onclick="Admin.del('<?=links('bbs/pic_del')?>','{{d.id}}',this)" href="javascript:;" ><i class="layui-icon">&#xe640;</i>删除</button>
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
        content: '<div style="text-align:center"><img style="max-width:100%;" src="' + $(t).attr('src') + '" /></div>'
    });
}
</script>
</body>
</html>