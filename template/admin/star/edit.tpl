<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>演员修改</title>
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
    <form class="layui-form layui-form-pane" action="<?=links('star/save')?>">
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">中文名</label>
                <div class="layui-input-block">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" value="<?=$name?>" placeholder="请输入演员中文名">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md5">
                <label class="layui-form-label">封面头像</label>
                <div class="layui-input-block">
                    <input type="text" id="pic" name="pic" class="layui-input" placeholder="请上传演员封面头像或者输入图片URL" value="<?=$pic?>">
                    <div class="layui-btn layui-btn-normal uppic" style="position: absolute;top: 0px;right: 0;">封面上传</div>
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md2">
                <label class="layui-form-label">演员分类</label>
                <div class="layui-input-block">
                    <select name="cid" required lay-verify="required">
                        <option value="">选择分类</option>
                    <?php
                    foreach($class as $row){
                        $sel = $row['id'] == $cid ? ' selected' : '';
                        echo '<option value="'.$row['id'].'"'.$sel.'>'.$row['name'].'</option>';
                        $type = $this->mydb->get_select('star_class',array('fid'=>$row['id']),'id,name','xid asc',50);
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
                <label class="layui-form-label">是否推荐</label>
                <div class="layui-input-block">
                    <select name="tid">
                        <option value="0">未推</option>
                        <option value="1"<?php if($tid == 1) echo 'selected';?>>已推</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">英文名</label>
                <div class="layui-input-block">
                    <input type="text" name="yname" class="layui-input" value="<?=$yname?>" placeholder="请输入演员英文名">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">别名</label>
                <div class="layui-input-block">
                    <input type="text" name="alias" class="layui-input" value="<?=$alias?>" placeholder="请输入演员别名">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">演员身高</label>
                <div class="layui-input-block">
                    <input type="text" name="height" class="layui-input" value="<?=$height?>" placeholder="请输入演员身高">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">演员体重</label>
                <div class="layui-input-block">
                    <input type="text" name="weight" class="layui-input" value="<?=$weight?>" placeholder="请输入演员体重">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">国籍</label>
                <div class="layui-input-block">
                    <input type="text" name="nationality" class="layui-input" value="<?=$nationality?>" placeholder="请输入演员国籍">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">民族</label>
                <div class="layui-input-block">
                    <input type="text" name="ethnic" class="layui-input" value="<?=$ethnic?>" placeholder="请输入演员民族">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">职业</label>
                <div class="layui-input-block">
                    <input type="text" name="professional" class="layui-input" value="<?=$professional?>" placeholder="请输入演员职业">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">血型</label>
                <div class="layui-input-block">
                    <input type="text" name="blood_type" class="layui-input" placeholder="请上传演员血型" value="<?=$blood_type?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">生日</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" class="layui-input" value="<?=$birthday?>" placeholder="请输入演员生日">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">地区</label>
                <div class="layui-input-block">
                    <input type="text" name="city" class="layui-input" value="<?=$city?>" placeholder="请输入演员地区">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">星座</label>
                <div class="layui-input-block">
                    <input type="text" name="constellation" class="layui-input" value="<?=$constellation?>" placeholder="请输入演员星座">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <label class="layui-form-label">经纪公司</label>
                <div class="layui-input-block">
                    <input type="text" name="company" class="layui-input" placeholder="请上传演员经纪公司" value="<?=$company?>">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">代表作品</label>
                <div class="layui-input-block">
                    <input type="text" name="production" class="layui-input" value="<?=$production?>" placeholder="请输入演员代表作品">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">毕业院校</label>
                <div class="layui-input-block">
                    <input type="text" name="academy" class="layui-input" value="<?=$academy?>" placeholder="请输入演员毕业院校">
                </div>
            </div>
            <div class="layui-col-xs12 layui-col-md4">
                <label class="layui-form-label">浏览人气</label>
                <div class="layui-input-block">
                    <input type="number" name="hits" class="layui-input" value="<?=$hits?>" placeholder="浏览人气">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">演员简介</label>
            <div class="layui-input-block">
                <textarea lay-verify="editor1" id="editor1" name="text" placeholder="演员简介" class="layui-textarea" style="min-height:120px;"><?=$text?></textarea>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-filter="*" lay-submit>保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<script>
layui.use(['form','upload','layedit'], function(){
    var upload = layui.upload,
        form = layui.form,
        layedit = layui.layedit;
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
    layedit.set({
        tool: [
            'html', 'code', 'strong', 'italic', 'underline', 'del', 'addhr', '|', 'fontFomatt', 'colorpicker'
            , 'left', 'center', 'right', '|', 'link', 'unlink', 'anchors'
            , '|','table', 'fullScreen'
        ]
        ,height: '500px'
    });
    var editor1 = layedit.build('editor1');
    form.verify({
        editor1: function(value) {
            layedit.sync(editor1);
        }
    });
});
</script>
</body>
</html>