<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网站配置</title>
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
        <a><cite>网站配置</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('setting/web_save')?>">
            <div class="layui-card-body">
                <div class="layui-tab layui-tab-brief" lay-filter="setting">
                    <ul class="layui-tab-title">
                        <li class="layui-this">基础配置</li>
                        <li>路由配置</li>
                        <li>视频SEO配置</li>
                        <li>专辑SEO配置</li>
                        <li>明星SEO配置</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div class="layui-text" style="max-width: 700px;padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">网站域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="url" placeholder="网站域名" value="<?=$url?>" class="layui-input" lay-verify="required" required/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">手机站域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wapurl" placeholder="手机网站域名，留空则使用网站域名" value="<?=$wapurl?>" class="layui-input"/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">网站开关:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" lay-filter="web" name="open" value="0" title="关闭"<?php if($web['open']==0) echo ' checked';?>>
                                        <input type="radio" lay-filter="web" name="open" value="1" title="开启"<?php if($web['open']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div id="web" class="layui-form-item w120"<?php if($web['open'] == 1) echo ' style="display:none;"';?>>
                                    <label class="layui-form-label">关闭提示:</label>
                                    <div class="layui-input-block">
                                        <textarea name="open_text" placeholder="关闭提示，内容" class="layui-textarea"><?=$web['open_text']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">网页评论开关:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="comment" value="0" title="关闭"<?php if($web['comment']==0) echo ' checked';?>>
                                        <input type="radio" name="comment" value="1" title="开启"<?php if($web['comment']==1) echo ' checked';?>>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">PC模板目录:</label>
                                    <div class="layui-input-block select200">
                                        <select name="pc_tpl">
                                        <?php
                                        foreach($pctpl as $dir){
                                            $sel = $dir == $web['pc_tpl'] ? ' selected' : '';
                                            echo '<option value="'.$dir.'"'.$sel.'>'.$dir.'</option>';
                                        }
                                        ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">WAP模板目录:</label>
                                    <div class="layui-input-block select200">
                                        <select name="wap_tpl">
                                        <?php
                                        foreach($waptpl as $dir){
                                            $sel = $dir == $web['wap_tpl'] ? ' selected' : '';
                                            echo '<option value="'.$dir.'"'.$sel.'>'.$dir.'</option>';
                                        }
                                        ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">统计代码:</label>
                                    <div class="layui-input-block">
                                        <textarea name="stat" placeholder="网站统计代码" class="layui-textarea"><?=$web['stat']?></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-filter="*" lay-submit>
                                            更新配置信息
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text" style="max-width: 700px;">
                                <div class="layui-tab layui-tab-brief" style="margin-top: 10px;">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">基础配置</li>
                                        <li>视频路由</li>
                                        <li>专题路由</li>
                                        <li>明星路由</li>
                                        <li>其他路由</li>
                                    </ul>
                                    <div class="layui-tab-content" style="margin-top: 10px;">
                                        <div class="layui-tab-item layui-show">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">路由后缀:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[ext]" placeholder="路由后缀，建议使用.html" value="<?=$web['uri']['ext']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">去除index.php:</label>
                                                <div class="layui-input-inline" style="display: block;width: auto;float: none;">
                                                    <input type="radio" lay-filter="proved" name="uri[delindex]" value="0" title="关闭"<?php if($web['uri']['delindex']==0) echo ' checked';?>>
                                                    <input type="radio" lay-filter="proved" name="uri[delindex]" value="1" title="开启"<?php if($web['uri']['delindex']==1) echo ' checked';?>>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">自定义页面:</label>
                                                <div class="layui-input-block">
                                                    <table class="layui-table" style="margin-bottom:20px;">
                                                        <tbody id="page-box">
                                                            <tr>
                                                                <th>网页标题</th>
                                                                <td>模板文件名</td>
                                                                <td class="page-add" style="cursor: pointer;" title="增加一个"><i style="font-size:20px;" class="layui-icon layui-icon-add-1"></i></td>
                                                            </tr>
                                                            <?php
                                                            $kk = 0;
                                                            $pages = isset($web['pages']) ? $web['pages'] : array(array('title'=>'电视直播','tpl'=>'tv'));
                                                            foreach($pages as $kk=>$row){
                                                                echo '<tr id="page-td-'.$kk.'"><td><input type="text" name="pages['.$kk.'][title]" placeholder="网页标题" value="'.$row['title'].'" class="layui-input"/></td><td><input type="text" name="pages['.$kk.'][tpl]" lay-verify="tpl" placeholder="模板文件名，字母或数字且字母开头" value="'.$row['tpl'].'" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'page-td-'.$kk.'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
                                                            }
                                                            ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120"><label class="layui-form-label"></label>
                                                <div class="layui-input-block" style="color:red;">访问方法：<?=str_replace(SELF,'index.php',links('opt/页面名')).$web['uri']['ext']?></div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频分类:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[lists]" placeholder="视频分类页，可用标签[id],[page]" value="<?=$web['uri']['lists']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120" style="display:none;">
                                                <label class="layui-form-label">视频筛选:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[vod]" placeholder="视频筛选页，可用标签[cid],[lang],[area],[year],[sort]" value="<?=$web['uri']['vod']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[info]" placeholder="视频详情页，可用标签[id]" value="<?=$web['uri']['info']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频播放:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[play]" placeholder="视频播放页，可用标签[id],[jid]" value="<?=$web['uri']['play']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">专题列表:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[topic]" placeholder="专题列表页，可用标签[page]" value="<?=$web['uri']['topic']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">专题详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[topicinfo]" placeholder="专题详情页，可用标签[id]" value="<?=$web['uri']['topicinfo']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星首页:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[star]" placeholder="明星首页" value="<?=$web['uri']['star']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星分类:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starlists]" placeholder="明星分类页，可用标签[id]，[page]" value="<?=$web['uri']['starlists']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starinfo]" placeholder="明星详情页，可用标签[id]" value="<?=$web['uri']['starinfo']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频排行:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[hot]" placeholder="视频排行页，可用标签[type]" value="<?=$web['uri']['hot']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频自定义:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[opt]" placeholder="视频自定义页，可用标签[type]" value="<?=$web['uri']['opt']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星排行:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starhot]" placeholder="明星排行页，可用标签[type]" value="<?=$web['uri']['starhot']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">RSS地图:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[rss]" placeholder="RSS地图页，可用标签[type]" value="<?=$web['uri']['rss']?>" class="layui-input"/>
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
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text">
                                <div class="layui-tab layui-tab-brief" style="margin-top: 10px;">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">网站首页</li>
                                        <li>分类页</li>
                                        <li>详情页</li>
                                        <li>播放页</li>
                                        <li>排行榜页</li>
                                    </ul>
                                    <div class="layui-tab-content" style="margin-top: 10px;">
                                        <div class="layui-tab-item layui-show">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[index][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$web['seo']['index']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[index][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['index']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[index][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['index']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[type][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" value="<?=$web['seo']['type']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[type][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$web['seo']['type']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[type][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$web['seo']['type']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[info][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" value="<?=$web['seo']['info']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[info][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$web['seo']['info']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[info][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$web['seo']['info']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[play][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" value="<?=$web['seo']['play']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[play][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$web['seo']['play']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[play][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$web['seo']['play']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[hot][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$web['seo']['hot']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[hot][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['hot']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[hot][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['hot']['description']?></textarea>
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
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text">
                                <div class="layui-tab layui-tab-brief" style="margin-top: 10px;">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">专辑首页</li>
                                        <li>专辑详情页</li>
                                    </ul>
                                    <div class="layui-tab-content" style="margin-top: 10px;">
                                        <div class="layui-tab-item layui-show">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[topic][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$web['seo']['topic']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topic][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['topic']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topic][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['topic']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[topicinfo][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" value="<?=$web['seo']['topicinfo']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topicinfo][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" class="layui-textarea"><?=$web['seo']['topicinfo']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topicinfo][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" class="layui-textarea"><?=$web['seo']['topicinfo']['description']?></textarea>
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
                            </div>
                        </div>
                        <div class="layui-tab-item">
                            <div class="layui-text">
                                <div class="layui-tab layui-tab-brief" style="margin-top: 10px;">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">明星首页</li>
                                        <li>明星分类页</li>
                                        <li>明星详情页</li>
                                    </ul>
                                    <div class="layui-tab-content" style="margin-top: 10px;">
                                        <div class="layui-tab-item layui-show">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[star][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$web['seo']['star']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[star][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['star']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[star][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$web['seo']['star']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[starlist][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" value="<?=$web['seo']['starlist']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starlist][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$web['seo']['starlist']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starlist][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$web['seo']['starlist']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[starinfo][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" value="<?=$web['seo']['starinfo']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starinfo][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" class="layui-textarea"><?=$web['seo']['starinfo']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starinfo][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" class="layui-textarea"><?=$web['seo']['starinfo']['description']?></textarea>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
var k = <?=$kk?>;
layui.use(['form'], function () {
    var form = layui.form;
    form.on('radio(web)', function (d) {
        if(d.value == 0){
            $('#web').show();
        }else{
            $('#web').hide();
        }
    });
    form.verify({
        tpl: function(value, item){
            if(value == 'index'){
                return '模板文件名不能用index';
            }
            if(!new RegExp("^[a-zA-Z][A-Za-z0-9]+$").test(value)){
                return '模板文件名只能是字母或数字且字母开头';
            }
        }
    });
    $('.page-add').click(function(){
        k++;
        var html = '<tr id="page-td-'+k+'"><td><input type="text" name="pages['+k+'][title]" placeholder="页面标题" value="" class="layui-input"/></td><td><input type="text" name="pages['+k+'][tpl]" lay-verify="tpl" placeholder="模板文件名，字母或数字且字母开头" value="" class="layui-input"/></td><td style="cursor: pointer;" onclick="get_del(\'page-td-'+k+'\');" title="删除"><i style="font-size:20px;" class="layui-icon layui-icon-delete"></i></td></tr>';
        $('#page-box').append(html);
    });
});
function get_del(_id){
    $('#'+_id).remove();
}
</script>
</body>
</html>