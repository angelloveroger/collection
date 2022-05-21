<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>视频批量操作</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/md5.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <style type="text/css">
    .layui-form-select dl dd.layui-this {
        background-color: #fff;
        color: #333;
    }
    @media screen and (min-width: 1024px){
        .layui-form-item .layui-input-inline{
            width: auto;
            max-width: 190px;
        }
    }
    </style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>视频管理</a>
        <a><cite>视频批量操作</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card" style="padding: 20px;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend style="font-size:15px;">视频批量修改</legend>
        </fieldset>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按分类:</label>
                <div class="layui-input-inline select150">
                    <select name="cid" lay-verify="required" lay-reqText="请选择操作的分类">
                        <option value="">请选择分类</option>
                        <?php
                        foreach($class as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                            $array = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',100);
                            foreach($array as $row2){
                                echo '<option value="'.$row2['id'].'">&nbsp;&nbsp;&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
                            }
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-input-inline select150">
                    <select name="field" data-type="class" lay-filter="field" lay-verify="required" lay-reqText="请选择操作的对象">
                        <option value="">选择修改对象</option>
                        <option value="cid">分类ID</option>
                        <option value="ztid">专题ID</option>
                        <option value="tid">推荐状态</option>
                        <option value="reco">幻灯图状态</option>
                        <option value="pay">收费状态</option>
                        <option value="app">APP专属</option>
                        <option value="year">视频年份</option>
                        <option value="area">视频地区</option>
                        <option value="lang">视频语言</option>
                        <option value="score">视频评分</option>
                    </select>
                </div>
                <div class="layui-input-inline" id="edit_val_class"></div>
                <div class="layui-inline">
                    <button class="layui-btn" data-type="cid" lay-filter="edit" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按播放器:</label>
                <div class="layui-input-inline select150">
                    <select name="pid" lay-verify="required" lay-reqText="请选择操作的播放器">
                        <option value="">请选择播放器</option>
                        <?php
                        foreach($player as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-input-inline select150">
                    <select name="field" data-type="player" lay-filter="field" lay-verify="required" lay-reqText="请选择操作的对象">
                        <option value="">选择修改对象</option>
                        <option value="cid">分类ID</option>
                        <option value="ztid">专题ID</option>
                        <option value="tid">推荐状态</option>
                        <option value="reco">幻灯图状态</option>
                        <option value="pay">收费状态</option>
                        <option value="app">APP专属</option>
                        <option value="year">视频年份</option>
                        <option value="area">视频地区</option>
                        <option value="lang">视频语言</option>
                        <option value="score">视频评分</option>
                    </select>
                </div>
                <div class="layui-input-inline" id="edit_val_player"></div>
                <div class="layui-inline">
                    <button class="layui-btn" data-type="pid" lay-filter="edit" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按专题:</label>
                <div class="layui-input-inline select150">
                    <select name="ztid" lay-verify="required"  lay-reqText="请选择操作的专题">
                        <option value="">请选择专题</option>
                        <?php
                        foreach($topic as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-input-inline select150">
                    <select name="field" data-type="topic" lay-filter="field" lay-verify="required" lay-reqText="请选择操作的对象">
                        <option value="">选择修改对象</option>
                        <option value="cid">分类ID</option>
                        <option value="ztid">专题ID</option>
                        <option value="tid">推荐状态</option>
                        <option value="reco">幻灯图状态</option>
                        <option value="pay">收费状态</option>
                        <option value="app">APP专属</option>
                        <option value="year">视频年份</option>
                        <option value="area">视频地区</option>
                        <option value="lang">视频语言</option>
                        <option value="score">视频评分</option>
                    </select>
                </div>
                <div class="layui-input-inline" id="edit_val_topic"></div>
                <div class="layui-inline">
                    <button class="layui-btn" data-type="ztid" lay-filter="edit" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按时间:</label>
                <div class="layui-input-inline select150">
                    <select name="day" lay-verify="required" lay-reqText="请选择操作的时间">
                        <option value="">请选择时间</option>
                        <option value="1">1天内</option>
                        <option value="2">2天内</option>
                        <option value="3">3天内</option>
                        <option value="5">5天内</option>
                        <option value="7">7天内</option>
                        <option value="10">10天内</option>
                        <option value="20">20天内</option>
                        <option value="30">30天内</option>
                        <option value="60">60天内</option>
                        <option value="180">180天内</option>
                        <option value="365">365天内</option>
                        <option value="0">全部视频</option>
                    </select>
                </div>
                <div class="layui-input-inline select150">
                    <select name="field" data-type="day" lay-filter="field" lay-verify="required" lay-reqText="请选择操作的对象">
                        <option value="">选择修改对象</option>
                        <option value="cid">分类ID</option>
                        <option value="ztid">专题ID</option>
                        <option value="tid">推荐状态</option>
                        <option value="reco">幻灯图状态</option>
                        <option value="pay">收费状态</option>
                        <option value="app">APP专属</option>
                        <option value="year">视频年份</option>
                        <option value="area">视频地区</option>
                        <option value="lang">视频语言</option>
                        <option value="score">视频评分</option>
                    </select>
                </div>
                <div class="layui-input-inline" id="edit_val_day"></div>
                <div class="layui-inline">
                    <button class="layui-btn" data-type="day" lay-filter="edit" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按视频ID:</label>
                <div class="layui-input-inline select150">
                    <input type="text" name="vid" lay-verify="required" class="layui-input" placeholder="视频ID，多个逗号分隔">
                </div>
                <div class="layui-input-inline select150">
                    <select name="field" data-type="vid" lay-filter="field" lay-verify="required" lay-reqText="请选择操作的对象">
                        <option value="">选择修改对象</option>
                        <option value="cid">分类ID</option>
                        <option value="ztid">专题ID</option>
                        <option value="tid">推荐状态</option>
                        <option value="reco">幻灯图状态</option>
                        <option value="pay">收费状态</option>
                        <option value="app">APP专属</option>
                        <option value="year">视频年份</option>
                        <option value="area">视频地区</option>
                        <option value="lang">视频语言</option>
                        <option value="score">视频评分</option>
                    </select>
                </div>
                <div class="layui-input-inline" id="edit_val_vid"></div>
                <div class="layui-inline">
                    <button class="layui-btn" data-type="vid" lay-filter="edit" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend style="font-size:15px;">视频批量删除</legend>
        </fieldset>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按分类:</label>
                <div class="layui-input-inline select150">
                    <select name="cid" lay-verify="required" lay-reqText="请选择操作的分类">
                        <option value="">请选择分类</option>
                        <?php
                        foreach($class as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                            $array = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',100);
                            foreach($array as $row2){
                                echo '<option value="'.$row2['id'].'">&nbsp;&nbsp;&nbsp;&nbsp;├─&nbsp;'.$row2['name'].'</option>';
                            }
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-danger" data-type="cid" lay-filter="del" lay-submit>一键删除</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按播放器:</label>
                <div class="layui-input-inline select150">
                    <select name="pid" lay-verify="required" lay-reqText="请选择操作的播放器">
                        <option value="">请选择播放器</option>
                        <?php
                        foreach($player as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-danger" data-type="pid" lay-filter="del" lay-submit>一键删除</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按专题:</label>
                <div class="layui-input-inline select150">
                    <select name="ztid" lay-verify="required" lay-reqText="请选择操作的专题">
                        <option value="">请选择专题</option>
                        <?php
                        foreach($topic as $row){
                            echo '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                        }
                        ?>
                    </select>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-danger" data-type="ztid" lay-filter="del" lay-submit>一键删除</button>
                </div>
            </div>
        </form>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">按时间:</label>
                <div class="layui-input-inline select150">
                    <select name="day" lay-verify="required" lay-reqText="请选择操作的时间">
                        <option value="">请选择时间</option>
                        <option value="1">1天内</option>
                        <option value="2">2天内</option>
                        <option value="3">3天内</option>
                        <option value="5">5天内</option>
                        <option value="7">7天内</option>
                        <option value="10">10天内</option>
                        <option value="20">20天内</option>
                        <option value="30">30天内</option>
                        <option value="60">60天内</option>
                        <option value="180">180天内</option>
                        <option value="365">365天内</option>
                        <option value="0">全部视频</option>
                    </select>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-danger" data-type="day" lay-filter="del" lay-submit>一键删除</button>
                </div>
            </div>
        </form>
    </div>
</div>
<?php
$year = $lang = $area = '<option value="">请选择</option>';
for($y=date('Y');$y>2006;$y--) $year .= '<option value="'.$y.'">'.$y.'</option>';
foreach($this->myconfig['lang'] as $v) $lang .= '<option value="'.$v.'">'.$v.'</option>';
foreach($this->myconfig['area'] as $v) $area .= '<option value="'.$v.'">'.$v.'</option>';
?>
<script type="text/javascript">
layui.use(['form', 'layer'], function() {
    var form = layui.form,
        layer = layui.layer;
    form.on('select(field)', function (data) {
        var type = $(data.elem).data('type');
        var html = '';
        if(data.value == 'pay'){
            html = '<div class="select120"><select name="val" lay-filter="pay"><option value="0">免费播放</option><option value="1">VIP播放</option><option value="2">点播播放</option></select><div class="layui-input-inline" id="cion_val"></div></div>';
        }else if(data.value == 'app'){
            html = '<div class="select100"><select name="val"><option value="0">取消专属</option><option value="1">设为专属</option></select></div>';
        }else if(data.value == 'reco'){
            html = '<div class="select100"><select name="val"><option value="1">设为幻灯</option><option value="0">取消幻灯</option></select></div>';
        }else if(data.value == 'tid'){
            html = '<div class="select100"><select name="val"><option value="1">设为推荐</option><option value="0">取消推荐</option></select></div>';
        }else if(data.value == 'year'){
            html = '<div class="select100"><select name="val" lay-verify="required"><?=$year?></select></div>';
        }else if(data.value == 'lang'){
            html = '<div class="select100"><select name="val" lay-verify="required"><?=$lang?></select></div>';
        }else if(data.value == 'area'){
            html = '<div class="select100"><select name="val" lay-verify="required"><?=$area?></select></div>';
        }else{
            var text = $(data.elem).children("option:selected").text();
            html = '<input type="text" name="val" lay-verify="required" class="layui-input" placeholder="请输入修改后的'+text+'">';
        }
        $('#edit_val_'+type).html(html);
        form.render('select');
        return false;
    });
    form.on('select(pay)', function (data) {
        var html = '';
        if(data.value == 2){
            html = '<input lay-verify="required" type="text" name="xid" class="layui-input" placeholder="从第几集开始收费"><input type="text" name="cion" class="layui-input" lay-verify="required" placeholder="点播金币数量">';
        }else if(data.value == 1){
            html = '<input lay-verify="required" type="text" name="xid" class="layui-input" placeholder="从第几集开始需要VIP">';
        }
        $('#cion_val').html(html);
        return false;
    });
    //修改
    form.on('submit(edit)', function (data) {
        data.field.op = 'edit';
        layer.confirm('不可逆转，确定要操作吗', {
            title:'操作提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            var tindex = layer.load();
            $.post('<?=links('vod/batch_save')?>', data.field, function(res) {
                layer.close(tindex);
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});       
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
            layer.close(index);
        }, function(index) {
            layer.close(index);
        });
        return false;
    });
    //删除
    form.on('submit(del)', function (data) {
        data.field.op = 'del';
        layer.confirm('不可逆转，确定要删除吗', {
            title:'删除提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            var tindex = layer.load();
            $.post('<?=links('vod/batch_save')?>', data.field, function(res) {
                layer.close(tindex);
                if(res.code == 1){
                    layer.msg(res.msg,{icon: 1});       
                }else{
                    layer.msg(res.msg,{icon: 2});
                }
            },'json');
            layer.close(index);
        }, function(index) {
            layer.close(index);
        });
        return false;
    });
});
</script>
</body>
</html>