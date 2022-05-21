<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采集配置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="/packs/admin/css/style.css">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script src="/packs/layui/layui.js"></script>
    <script src="/packs/admin/js/common.js"></script>
    <style type="text/css">
        .layui-form-radio{
            margin: 0; 
            padding-right: 0;
        }
        .layui-form-item{
            margin-bottom: 5px;
        }
        .layui-form-pane .layui-form-checkbox {
            margin: 4px 0 4px 1px;
        }
        .layui-form-checkbox[lay-skin=primary] span {
            padding-right: 5px;
        }
        .layui-form-checkbox[lay-skin=primary] i {
            left: 6px;
        }
    </style>
</head>
<body>
<div class="breadcrumb-nav">
    <span class="layui-breadcrumb">
        <a>采集管理</a>
        <a><cite>采集配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-form-pane" action="<?=links('caiji/setting')?>">
            <div class="layui-card-body">
                <div class="layui-text" style="max-width: 80%;padding-top: 25px;">
                    <div class="layui-row layui-col-space10">
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">同步封面图</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="tbpic" value="0" title="关闭"<?php if($tbpic == 0) echo 'checked';?>>
                                    <input type="radio" name="tbpic" value="1" title="开启"<?php if($tbpic == 1) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">入库时间</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="rktime" value="0" title="本机"<?php if($rktime == 0) echo 'checked';?>>
                                    <input type="radio" name="rktime" value="1" title="来源"<?php if($rktime == 1) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">更新规则</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="update" value="0" title="更新所有"<?php if($update == 0) echo 'checked';?>>
                                    <input type="radio" name="update" value="1" title="大于更新"<?php if($update == 1) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">随机人气</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="hits_rand" value="0" title="关闭"<?php if($hits_rand == 0) echo 'checked';?>>
                                    <input type="radio" name="hits_rand" value="1" title="开启"<?php if($hits_rand == 1) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item">
                                <label class="layui-form-label">人气范围</label>
                                <div class="layui-input-inline w100">
                                    <input type="number" name="min_hits" placeholder="随机人气最小值" autocomplete="off" class="layui-input" value="<?=$min_hits?>">
                                </div>
                                <div class="layui-form-mid">-</div>
                                <div class="layui-input-inline w100">
                                    <input type="number" name="max_hits" placeholder="随机人气最大值" autocomplete="off" class="layui-input" value="<?=$max_hits?>">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item">
                                <label class="layui-form-label">每次入库</label>
                                <div class="layui-input-block">
                                    <input type="number" name="ruku_size" placeholder="官采每次入库数量，可根据服务器性能调整" autocomplete="off" class="layui-input" value="<?=$ruku_size?>">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md12">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">更新内容</label>
                                <div class="layui-input-block">
                                    <input type="checkbox" name="upzd[state]" lay-skin="primary" title="状态" disabled checked>
                                    <input type="checkbox" name="upzd[addtime]" lay-skin="primary" title="时间" <?php if(in_array('addtime',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[cid]" lay-skin="primary" title="分类" <?php if(in_array('cid',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[tags]" lay-skin="primary" title="类型" <?php if(in_array('tags',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[director]" lay-skin="primary" title="导演" <?php if(in_array('director',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[actor]" lay-skin="primary" title="主演" <?php if(in_array('actor',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[area]" lay-skin="primary" title="地区" <?php if(in_array('area',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[lang]" lay-skin="primary" title="语言" <?php if(in_array('lang',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[year]" lay-skin="primary" title="年份" <?php if(in_array('year',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[pic]" lay-skin="primary" title="封面图" <?php if(in_array('pic',$upzd)) echo 'checked';?>>
                                    <input type="checkbox" name="upzd[text]" lay-skin="primary" title="介绍" <?php if(in_array('text',$upzd)) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md4">
                            <div class="layui-form-item" pane>
                                <label class="layui-form-label">入库重检测</label>
                                <div class="layui-input-block">
                                    <input type="checkbox" name="inspect[name]" lay-skin="primary" title="标题" disabled checked>
                                    <input type="checkbox" name="inspect[cid]" lay-skin="primary" title="分类" <?php if(in_array('cid',$inspect)) echo 'checked';?>>
                                    <input type="checkbox" name="inspect[year]" lay-skin="primary" title="年份" <?php if(in_array('year',$inspect)) echo 'checked';?>>
                                    <input type="checkbox" name="inspect[director]" lay-skin="primary" title="导演" <?php if(in_array('director',$inspect)) echo 'checked';?>>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md8">
                            <div class="layui-form-item">
                                <label class="layui-form-label">标题替换</label>
                                <div class="layui-input-block">
                                    <?php
                                    $name = array();
                                    if(!empty($replace_name)){
                                        foreach($replace_name as $key=>$val){
                                            $name[] = $key."->".$val;
                                        }
                                    }
                                    $replacename = !empty($name) ? implode("\n",$name) : '';
                                    ?>
                                    <textarea name="replace_name" placeholder="格式：采集标题->替换后名字,每行一条" class="layui-textarea"><?=$replacename?></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md12">
                            <div class="layui-form-item">
                                <label class="layui-form-label">标题过滤</label>
                                <div class="layui-input-block">
                                    <textarea name="filter_name" placeholder="每行一条, 过滤的数据将不会新增和更新" class="layui-textarea"><?=!empty($filter_name)? implode("\n",$filter_name) : ''?></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-md12">
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-filter="*" lay-submit>
                                        更新配置信息
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>