<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>缓存配置</title>
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
        <a>系统配置</a>
        <a><cite>缓存配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <form class="layui-form" action="<?=links('setting/caches_save')?>" style="padding-top: 20px;max-width: 700px;">
                <div class="layui-form-item w120">
                    <label class="layui-form-label">缓存存储方式:</label>
                    <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                        <input lay-filter="mode" type="radio" name="type" value="0" title="关闭缓存"<?php if($caches['type'] == 0) echo ' checked';?>>
                        <input lay-filter="mode" type="radio" name="type" value="1" title="文件缓存"<?php if($caches['type'] == 1) echo ' checked';?>>
                        <input lay-filter="mode" type="radio" name="type" value="2" title="Memcache"<?php if($caches['type'] == 2) echo ' checked';?>>
                        <input lay-filter="mode" type="radio" name="type" value="3" title="Redis"<?php if($caches['type'] == 3) echo ' checked';?>>
                    </div>
                </div>
                <div class="layui-form-item w120">
                    <label class="layui-form-label">缓存安全字符:</label>
                    <div class="layui-input-block">
                        <input id="rand" type="text" name="rand" placeholder="同台服务器多网站使用memcache、redis时需区分开" value="<?=$caches['rand']?>" class="layui-input" lay-verify="required" required/>
                        <div class="layui-btn layui-btn-danger" onclick="Admin.get_rand('rand');" style="position: absolute;top: 0px;right: 0;">随机生成</div>
                    </div>
                </div>
                <div id="Memcache"<?php if($caches['type'] != 2) echo ' style="display: none;"';?>>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">Mem缓存主机:</label>
                        <div class="layui-input-block">
                            <input id="mem_ip" type="text" name="memcache[ip]" placeholder="缓存主机一般为：127.0.0.1" value="<?=$caches['memcache']['ip']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">Mem缓存端口:</label>
                        <div class="layui-input-block">
                            <input id="mem_port" type="text" name="memcache[port]" placeholder="Memcache缓存端口一般为：11211" value="<?=$caches['memcache']['port']?>" class="layui-input"/>
                            <div class="layui-btn layui-btn-normal" onclick="get_cache(2);" style="position: absolute;top: 0px;right: 0;">测试链接</div>
                        </div>
                    </div>
                </div>
                <div id="Redis"<?php if($caches['type'] != 3) echo ' style="display: none;"';?>>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">Redis缓存主机:</label>
                        <div class="layui-input-block">
                            <input id="reads_ip" type="text" name="redis[ip]" placeholder="缓存主机一般为：127.0.0.1" value="<?=$caches['redis']['ip']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">Redis缓存端口:</label>
                        <div class="layui-input-block">
                            <input id="reads_port" type="text" name="redis[port]" placeholder="Redis缓存端口一般为：6379" value="<?=$caches['redis']['port']?>" class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-form-item w120">
                        <label class="layui-form-label">Redis缓存密码:</label>
                        <div class="layui-input-block">
                            <input id="reads_pass" type="text" name="redis[pass]" placeholder="没有密码可留空" value="<?=$caches['redis']['pass']?>" class="layui-input"/>
                            <div class="layui-btn layui-btn-normal" onclick="get_cache(3);" style="position: absolute;top: 0px;right: 0;">测试链接</div>
                        </div>
                    </div>
                </div>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                    <legend>缓存时间</legend>
                </fieldset>
                <div class="layui-tab layui-tab-brief" lay-filter="setting">
                    <ul class="layui-tab-title">
                        <li class="layui-this">视频</li>
                        <li>专题</li>
                        <li>明星</li>
                        <li>其他</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">网站主页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[index]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['index']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">视频列表页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[lists]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['lists']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">视频详情页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[info]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['info']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">视频播放页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[play]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['play']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">专题页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[topic]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['topic']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">专题详情页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[topicinfo]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['topicinfo']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">明星主页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[star]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['star']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">专题分类页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[starlists]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['starlists']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">专题详情页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[starinfo]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['starinfo']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">视频排行:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[hot]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['hot']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">明星排行页:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[starhot]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['starhot']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">视频自定义:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[opt]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['opt']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                            <div class="layui-form-item w120">
                                <label class="layui-form-label">RSS地图:</label>
                                <div class="layui-input-block">
                                    <input type="text" name="time[rss]" placeholder="单位秒，数据更新时缓存数据会同步，0不缓存。" value="<?=$caches['time']['rss']?>" class="layui-input" lay-verify="number" required/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-filter="*" lay-submit>
                            更新配置信息
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
layui.use(['form'],function() {
    form = layui.form;
    //监听radio
    form.on('radio(mode)', function (data) {
        if(data.value == 2){
            $('#Memcache').show();
            $('#Redis').hide();
        } else if(data.value == 3){
            $('#Redis').show();
            $('#Memcache').hide();
        } else{
            $('#Memcache').hide();
            $('#Redis').hide();
        }
    });
    var tps = '';
    $('.layui-input,.layui-textarea').click(function(){
        if($(this).attr('placeholder') != tps){
            tps = $(this).attr('placeholder');
            layer.tips(tps, $(this),{tips:1});    
        }
    });
});
function get_cache(sign){
    var index = layer.load();
    if(sign == 2){
        var ip = $('#mem_ip').val();
        var port = $('#mem_port').val();
    }else{
        var ip = $('#reads_ip').val();
        var port = $('#reads_port').val();
        var pass = $('#reads_pass').val(); 
    }
    $.post('<?=links('ajax/caches')?>', {'id':sign,'ip':ip,'port':port,'pass':pass}, function(res) {
        layer.close(index);
        if(res.code == 1){
            layer.msg(res.msg,{icon: 1});
        }else{
            layer.msg(res.msg,{icon: 2});
        }
    },'json');
}
</script>
</body>
</html>