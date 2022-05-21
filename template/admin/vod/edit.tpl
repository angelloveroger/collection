<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>视频修改</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" href="/packs/admin/css/style.css">
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script src="/packs/admin/js/common.js"></script>
<style type="text/css">
.layui-form-item .layui-input-inline{
    width: auto;
    margin-left: 5px;
}
.layui-form-radio{
    margin: 0; 
    padding-right: 0;
}
.layui-form-pane .layui-form-checkbox {
    margin: 4px 0 4px 1px;
}
.layui-form-checkbox[lay-skin=primary] span {
    padding-right: 4px;
}
.layui-form-checkbox[lay-skin=primary] i {
    left: 6px;
}
.layui-form-radio>i{margin-right: 3px;font-size: 16px;}
.layui-form-pane .layui-form-radio, .layui-form-pane .layui-form-switch {
    margin-top: 2px;
}
.layui-ji-box{border: 1px solid #e6e6e6;height: 150px;overflow-y: auto;text-align: center;}
.layui-ji-box .layui-input{text-align: center;margin-left: 0px;padding-left:0;}
.name{height: 30px;line-height: 30px;text-align: center;background: #f1f1f1;border: 1px solid #e0e0e0;}
.zu-box:first-child .layui-zu,.zu-box:nth-child(2) .layui-zu{margin-top: -35px;}
.mglt5{margin-left:10px!important;margin-top:5px!important;}
@media screen and (max-width: 990px){
    .layui-form-item .layui-col-xs12:first-child{
        margin-top: 0px;
    }
    .layui-form-item{
        margin-bottom: 10px; 
    }
    .layui-form-item .layui-col-xs12{
        margin-top: 10px;
    }
    .name{display: none;}
    .layui-ji-box .layui-input{padding:0 10px;}
    .zu-box .layui-zu{margin-top: 10px;}
    .zu-box:first-child .layui-zu{margin-top: -35px;}
}
</style>
</head>
<body class="bsbg">
<div class="layui-fluid">
    <form class="layui-form layui-form-pane" action="<?=links('vod/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">视频分类</label>
                <div class="layui-input-block">
                    <select name="cid" required lay-verify="required">
                        <option value="">选择分类</option>
                    <?php
                    foreach($class as $row){
                        $sel = $row['id'] == $cid ? ' selected' : '';
                        echo '<option value="'.$row['id'].'"'.$sel.'>'.$row['name'].'</option>';
                        $type = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',50);
                        foreach($type as $row2){
                            $sel2 = $row2['id'] == $cid ? ' selected' : '';
                            echo '<option value="'.$row2['id'].'"'.$sel2.'>&nbsp;&nbsp;&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
                        }
                    }
                    ?>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">视频专题</label>
                <div class="layui-input-block">
                    <select name="ztid">
                        <option value="">选择专题</option>
                    <?php
                    foreach($topic as $row){
                        $sel = $row['id'] == $ztid ? ' selected' : '';
                        echo '<option value="'.$row['id'].'"'.$sel.'>'.$row['name'].'</option>';
                    }
                    ?>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">是否轮播图</label>
                <div class="layui-input-block">
                    <select name="reco">
                        <option value="0">否</option>
                        <option value="1"<?php if($reco == 1) echo 'selected';?>>是</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">是否推荐</label>
                <div class="layui-input-block">
                    <select name="tid">
                        <option value="0">未推</option>
                        <option value="1"<?php if($tid == 1) echo 'selected';?>>已推</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">收费观看</label>
                <div class="layui-input-block">
                    <select name="pay">
                        <option value="0">免费</option>
                        <option value="1"<?php if($pay == 1) echo 'selected';?>>VIP专属</option>
                        <option value="2"<?php if($pay == 2) echo 'selected';?>>金币点播</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">APP专属</label>
                <div class="layui-input-block">
                    <select name="app">
                        <option value="0">不是</option>
                        <option value="1"<?php if($app == 1) echo 'selected';?>>APP专属播放</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">视频标题</label>
                <div class="layui-input-block" id="vodlist">
                    <input type="text" id="name" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入视频标题">
                    <div class="layui-btn vodinfo" style="position: absolute;top: 0px;right: 0;">一键获取视频信息</div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">视频导演</label>
                <div class="layui-input-block">
                    <input type="text" id="director" name="director" class="layui-input" value="<?=$director?>" placeholder="请输入视频导演">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">视频主演</label>
                <div class="layui-input-block">
                    <input type="text" id="actor" name="actor" class="layui-input" value="<?=$actor?>" placeholder="请输入视频主演">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">评分</label>
                <div class="layui-input-block">
                    <input type="text" id="score" name="score" class="layui-input" value="<?=$score?>" placeholder="视频评分">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">竖版封面</label>
                <div class="layui-input-block">
                    <input type="text" id="pic" name="pic" class="layui-input" placeholder="请上传视频竖版封面或者输入图片URL" value="<?=$pic?>">
                    <div class="layui-btn layui-btn-normal uppic" style="position: absolute;top: 0px;right: 0;">封面上传</div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">横版封面</label>
                <div class="layui-input-block">
                    <input type="text" id="picx" name="picx" class="layui-input" placeholder="请上传视频横版封面或者输入图片URL" value="<?=$picx?>">
                    <div class="layui-btn layui-btn-normal uppicx" style="position: absolute;top: 0px;right: 0;">封面上传</div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">TAG标签</label>
                <div class="layui-input-block">
                    <input type="text" id="tags" name="tags" class="layui-input" placeholder="TAG标签，多个逗号隔开" value="<?=$tags?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">更新状态</label>
                <div class="layui-input-block">
                    <input type="text" id="state" name="state" class="layui-input" value="<?=$state?>" placeholder="更新状态">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">地区</label>
                <div class="layui-input-block">
                    <input type="text" id="area" name="area" class="layui-input" value="<?=$area?>" placeholder="地区">
                    <div class="select100" style="position: absolute;top: 0px;right: 0;">
                        <select name="area_on" lay-filter="area">
                        <option value="">快速选择</option>
                        <?php
                        foreach($area_list as $val){
                            echo '<option value="'.$val.'">'.$val.'</option>';
                        }
                        ?>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">语言</label>
                <div class="layui-input-block">
                    <input type="text" id="lang" name="lang" class="layui-input" value="<?=$lang?>" placeholder="语言">
                    <div class="select100" style="position: absolute;top: 0px;right: 0;">
                        <select name="lang_on" lay-filter="lang">
                        <option value="">快速选择</option>
                        <?php
                        foreach($lang_list as $val){
                            echo '<option value="'.$val.'">'.$val.'</option>';
                        }
                        ?>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">年份</label>
                <div class="layui-input-block">
                    <select id="year" name="year">
                    <?php
                    for($y=date('Y');$y>1984;$y--){
                        $sel = $y == $year ? ' selected' : '';
                        echo '<option value="'.$y.'"'.$sel.'>'.$y.'</option>';
                    }
                    ?>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">日人气</label>
                <div class="layui-input-block">
                    <input type="number" name="rhits" class="layui-input" value="<?=$rhits?>" placeholder="请输入视频日人气">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">周人气</label>
                <div class="layui-input-block">
                    <input type="number" name="zhits" class="layui-input" value="<?=$zhits?>" placeholder="请输入视频周人气">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">月人气</label>
                <div class="layui-input-block">
                    <input type="number" name="yhits" class="layui-input" value="<?=$yhits?>" placeholder="请输入视频月人气">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">总人气</label>
                <div class="layui-input-block">
                    <input type="hidden" name="id" value="<?=$id?>">
                    <input type="number" name="hits" class="layui-input" value="<?=$hits?>" placeholder="请输入视频总人气">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">视频简介</label>
            <div class="layui-input-block">
                <textarea id="text" name="text" placeholder="视频简介" class="layui-textarea" style="min-height:120px;"><?=$text?></textarea>
            </div>
        </div>
        <div class="layui-form-item" style="position: relative;">
            <a style="position: absolute;top: 50px;left:0;" class="layui-btn icon-btn layui-btn-sm layui-btn-normal" onclick="get_zu_add();"><i class="layui-icon">&#xe624;</i>新增一组</a>
            <label class="layui-form-label">播放地址</label>
            <div class="layui-input-block" style="border: 1px solid #e6e6e6;padding:0 0 0 10px;min-height: 100px;">
                <div class="layui-row layui-col-space10" style="padding-bottom:10px;" id="player">
                    <?php  foreach($zu as $k=>$row){ ?>
                    <div class="layui-col-xs12 layui-col-md6 zu-box" style="margin: 0px;" id="zu-<?=$k?>">
                        <div class="layui-row layui-zu" style="margin-bottom:5px;">
                            <div class="layui-col-xs12 layui-col-md2">
                                <div class="h30">
                                    <select name="zu[<?=$k?>][pid]">
                                    <?php
                                    foreach($player as $v){
                                        $sel = $row['pid'] == $v['id'] ? ' selected' : '';
                                        echo '<option value="'.$v['id'].'"'.$sel.'>'.$v['name'].'</option>';
                                    }
                                    ?>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-col-xs12 layui-col-md10">
                                <a class="layui-btn icon-btn layui-btn-xs mglt5" onclick="get_ji_add(<?=$k?>);"><i class="layui-icon">&#xe624;</i>新增一集</a>
                                <a class="layui-btn icon-btn layui-btn-xs layui-btn-primary mglt5" onclick="get_pay(<?=$k?>,0);">批量免费</a>
                                <a class="layui-btn icon-btn layui-btn-xs layui-btn-normal mglt5" onclick="get_pay(<?=$k?>,1);">批量vip</a>
                                <a class="layui-btn icon-btn layui-btn-xs mglt5" onclick="get_pay(<?=$k?>,2);">批量点播</a>
                                <a class="layui-btn icon-btn layui-btn-xs layui-btn-danger mglt5" onclick="get_zu_del(<?=$k?>);"><i class="layui-icon">&#xe640;</i>删除该组</a>
                            </div>
                        </div>
                        <div class="layui-row layui-ji-box">
                        <?php
                            if(!empty($row['ji'])) echo '<div class="layui-col-xs12 layui-col-md1 name">集数名称</div><div class="layui-col-xs12 layui-col-md5 name">播放地址</div><div class="layui-col-xs12 layui-col-md1 name">排序</div><div class="layui-col-xs12 layui-col-md3 name">收费状态</div><div class="layui-col-xs12 layui-col-md1 name">点播金币</div><div class="layui-col-xs12 layui-col-md1 name">操作</div>';
                            foreach($row['ji'] as $k2=>$ji){
                                $sel0 = $ji['pay'] == 0 ? ' checked' : '';
                                $sel1 = $ji['pay'] == 1 ? ' checked' : '';
                                $sel2 = $ji['pay'] == 2 ? ' checked' : '';
                                echo '<div class="layui-ji" id="ji-'.$k.'-'.$k2.'"><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['.$k.'][ji]['.$k2.'][name]" class="layui-input h30 jname" value="'.$ji['name'].'" placeholder="集数名称"></div><div class="layui-col-xs12 layui-col-md5"><input type="text" name="zu['.$k.'][ji]['.$k2.'][playurl]" class="layui-input h30" value="'.$ji['playurl'].'" placeholder="播放地址" onfocus="this.select();"></div><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['.$k.'][ji]['.$k2.'][xid]" class="layui-input h30" value="'.$ji['xid'].'" placeholder="排序ID，越小越靠前"></div><div class="layui-col-xs12 layui-col-md3 h30" style="border: 1px solid #eee;"><input class="pay pay0" type="radio" name="zu['.$k.'][ji]['.$k2.'][pay]" value="0" title="免费"'.$sel0.'><input class="pay pay1" type="radio" name="zu['.$k.'][ji]['.$k2.'][pay]" value="1" title="VIP"'.$sel1.'><input class="pay pay2" type="radio" name="zu['.$k.'][ji]['.$k2.'][pay]" value="2" title="点播"'.$sel2.'></div><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['.$k.'][ji]['.$k2.'][cion]" class="layui-input h30" value="'.$ji['cion'].'" placeholder="点播金币"></div><div class="layui-col-xs12 layui-col-md1 h30" style="border: 1px solid #eee;cursor: pointer;" onclick="get_ji_del('.$k.','.$k2.');"><i class="layui-icon" style="font-size:20px;margin-top:3px;display: block;">&#xe640;</i></div><input type="hidden" name="zu['.$k.'][ji]['.$k2.'][id]" value="'.$ji['id'].'"></div>';
                            }
                        ?>
                        </div>
                    </div>
                    <?php } ?>
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['form','upload'], function(){
    var upload = layui.upload,
        form = layui.form;
    upload.render({
        elem: '.uppic',
        url: '<?=links('ajax/uppic')?>',
        accept: 'file',
        acceptMime: 'image/*',
        exts: 'jpg|png|gif|bmp|jpeg',
        done: function(res){
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                $('#pic').val(res.url);
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        }
    });
    upload.render({
        elem: '.uppicx',
        url: '<?=links('ajax/uppic')?>',
        accept: 'file',
        acceptMime: 'image/*',
        exts: 'jpg|png|gif|bmp|jpeg',
        done: function(res){
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                $('#picx').val(res.url);
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        }
    });
    form.on('select(area)', function(data){
        $('#area').val(data.value);
    });
    form.on('select(lang)', function(data){
        $('#lang').val(data.value);
    });
    form.on('select(douban)', function(data){
        if(data.value > 0){
            var index = layer.load();
            $.post('<?=links('ajax/douban/info')?>',{id:data.value},function(res){
                layer.close(index);
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});
                    var obj = res.data;
                    for(let key in obj){
                        $('#'+key).val(obj[key]);
                    }
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
        }
    });
    $('.vodinfo').click(function(){
        var name = $('#name').val();
        if(name == ''){
            layer.msg('请先填写视频名字',{icon: 2});
        }else{
            var index = layer.load();
            $.post('<?=links('ajax/douban/search')?>',{name:name},function(res){
                layer.close(index);
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});
                    $('.vodinfo').remove();
                    $('#vodlist').append(res.html);
                    form.render('select');
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
        }
    });
});
var kk = <?=count($zu)?>;
var player_arr = <?=json_encode($player)?>;
var player = '';
for (var i = 0; i < player_arr.length; i++) {
    player += '<option value="'+player_arr[i].id+'">'+player_arr[i].name+'</option>';
}
function get_zu_add(){
    kk++;
    var zuhtml = '<div class="layui-col-xs12 layui-col-md6 zu-box" style="margin: 0px;" id="zu-'+kk+'"><div class="layui-row layui-zu" style="margin-bottom:5px;"><div class="layui-col-xs12 layui-col-md2"><div class="h30"><select name="zu['+kk+'][pid]">'+player+'</select></div></div><div class="layui-col-xs12 layui-col-md10"><a class="layui-btn icon-btn layui-btn-xs mglt5" onclick="get_ji_add('+kk+');"><i class="layui-icon">&#xe624;</i>新增一集</a><a class="layui-btn icon-btn layui-btn-xs layui-btn-primary mglt5" onclick="get_pay('+kk+',0);">批量免费</a><a class="layui-btn icon-btn layui-btn-xs layui-btn-normal mglt5" onclick="get_pay('+kk+',1);">批量vip</a><a class="layui-btn icon-btn layui-btn-xs mglt5" onclick="get_pay('+kk+',2);">批量点播</a><a class="layui-btn icon-btn layui-btn-xs layui-btn-danger mglt5" onclick="get_zu_del('+kk+');"><i class="layui-icon">&#xe640;</i>删除该组</a></div></div><div class="layui-row layui-ji-box"><div class="layui-col-xs12 layui-col-md1 name">集数名称</div><div class="layui-col-xs12 layui-col-md5 name">播放地址</div><div class="layui-col-xs12 layui-col-md1 name">排序</div><div class="layui-col-xs12 layui-col-md3 name">收费状态</div><div class="layui-col-xs12 layui-col-md1 name">点播金币</div><div class="layui-col-xs12 layui-col-md1 name">操作</div></div></div></div>';
    $('#player').append(zuhtml);
    form.render();
    $(document).scrollTop($(document).height());
}
function get_zu_del(k){
    $('#zu-'+k).remove();
}
function get_ji_add(k){
    var k2 = $('#zu-'+k+' .layui-ji').length;
    var yjname = $('#ji-'+k+'-0 .jname').val();
    var jname = yjname != undefined && yjname.indexOf('集') > -1 ? '第'+(k2+1)+'集' : k2+1;
    var html = '<div class="layui-ji" id="ji-'+k+'-'+k2+'"><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['+k+'][ji]['+k2+'][name]" class="layui-input h30 jname" value="'+jname+'" placeholder="集数名称"></div><div class="layui-col-xs12 layui-col-md5"><input type="text" name="zu['+k+'][ji]['+k2+'][playurl]" class="layui-input h30" value="" placeholder="播放地址" onfocus="this.select();"></div><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['+k+'][ji]['+k2+'][xid]" class="layui-input h30" value="" placeholder="排序ID，越小越靠前"></div><div class="layui-col-xs12 layui-col-md3 h30" style="border: 1px solid #eee;"><input class="pay pay0" type="radio" name="zu['+k+'][ji]['+k2+'][pay]" value="0" title="免费" checked><input class="pay pay1" type="radio" name="zu['+k+'][ji]['+k2+'][pay]" value="1" title="VIP"><input class="pay pay2" type="radio" name="zu['+k+'][ji]['+k2+'][pay]" value="2" title="点播"></div><div class="layui-col-xs12 layui-col-md1"><input type="text" name="zu['+k+'][ji]['+k2+'][cion]" class="layui-input h30" value="0" placeholder="点播金币"></div><div class="layui-col-xs12 layui-col-md1 h30" style="border: 1px solid #eee;cursor: pointer;" onclick="get_ji_del('+k+','+k2+');"><i class="layui-icon" style="font-size:20px;margin-top:3px;display: block;">&#xe640;</i></div><input type="hidden" name="zu['+k+'][ji]['+k2+'][id]" value="0">';
    $('#zu-'+k+' .layui-ji-box').append(html);
    form.render();
    var divscll = document.getElementById("zu-"+k).getElementsByClassName("layui-ji-box")[0];
    divscll.scrollTop = divscll.scrollHeight;
}
function get_ji_del(k,k2){
    $('#ji-'+k+'-'+k2).remove();
}
function get_pay(k,pay){
    $('#zu-'+k+' .layui-ji .pay').removeAttr('checked');
    $("#zu-"+k+" .layui-ji .pay"+pay).prop('checked','true');
    form.render();
}
</script>
</body>
</html>