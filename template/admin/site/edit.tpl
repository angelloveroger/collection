<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>站群修改</title>
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
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form" action="<?=links('site/save/'.$kk)?>">
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
                            <div class="layui-text" style="padding-top: 25px;">
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">网站名称:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="name" placeholder="网站名称" value="<?=$name?>" class="layui-input" lay-verify="required" required/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label layui-form-required">网站域名:</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="host" placeholder="网站域名，如：www.yhcms.cc" value="<?=$host?>" class="layui-input" lay-verify="required" required/>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">PC模板目录:</label>
                                    <div class="layui-input-block select200">
                                        <select name="pc_tpl">
                                        <?php
                                        foreach($pctpl as $dir){
                                            $sel = $dir == $pc_tpl ? ' selected' : '';
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
                                            $sel = $dir == $wap_tpl ? ' selected' : '';
                                            echo '<option value="'.$dir.'"'.$sel.'>'.$dir.'</option>';
                                        }
                                        ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-form-item w120">
                                    <label class="layui-form-label">统计代码:</label>
                                    <div class="layui-input-block">
                                        <textarea name="stat" placeholder="网站统计代码" class="layui-textarea"><?=$stat?></textarea>
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
                            <div class="layui-text">
                                <div class="layui-tab layui-tab-brief" style="margin-top: 10px;">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">视频路由</li>
                                        <li>专题路由</li>
                                        <li>明星路由</li>
                                        <li>其他路由</li>
                                    </ul>
                                    <div class="layui-tab-content" style="margin-top: 10px;">
                                        <div class="layui-tab-item layui-show">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频分类:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[lists]" placeholder="视频分类页，可用标签[id],[page]" value="<?=$uri['lists']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[info]" placeholder="视频详情页，可用标签[id]" value="<?=$uri['info']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频播放:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[play]" placeholder="视频播放页，可用标签[id],[jid]" value="<?=$uri['play']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">专题列表:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[topic]" placeholder="专题列表页，可用标签[page]" value="<?=$uri['topic']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">专题详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[topicinfo]" placeholder="专题详情页，可用标签[id]" value="<?=$uri['topicinfo']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星首页:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[star]" placeholder="明星首页" value="<?=$uri['star']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星分类:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starlists]" placeholder="明星分类页，可用标签[id]，[page]" value="<?=$uri['starlists']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星详情:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starinfo]" placeholder="明星详情页，可用标签[id]" value="<?=$uri['starinfo']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频排行:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[hot]" placeholder="视频排行页，可用标签[type]" value="<?=$uri['hot']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">视频自定义:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[opt]" placeholder="视频自定义页，可用标签[type]" value="<?=$uri['opt']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">明星排行:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[starhot]" placeholder="明星排行页，可用标签[type]" value="<?=$uri['starhot']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">RSS地图:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="uri[rss]" placeholder="RSS地图页，可用标签[type]" value="<?=$uri['rss']?>" class="layui-input"/>
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
                                                    <input type="text" name="seo[index][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$seo['index']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[index][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['index']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[index][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['index']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[type][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" value="<?=$seo['type']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[type][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$seo['type']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[type][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$seo['type']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[info][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" value="<?=$seo['info']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[info][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$seo['info']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[info][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$seo['info']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[play][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" value="<?=$seo['play']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[play][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$seo['play']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[play][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[cname]，视频标题：[name]，视频状态：[state]，视频年份：[year]，视频地区：[area]，视频介绍：[text]，更多请看官方文档" class="layui-textarea"><?=$seo['play']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[hot][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$seo['hot']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[hot][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['hot']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[hot][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['hot']['description']?></textarea>
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
                                                    <input type="text" name="seo[topic][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$seo['topic']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topic][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['topic']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topic][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['topic']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[topicinfo][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" value="<?=$seo['topicinfo']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topicinfo][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" class="layui-textarea"><?=$seo['topicinfo']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[topicinfo][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，专辑名：[name]，专辑介绍：[text]" class="layui-textarea"><?=$seo['topicinfo']['description']?></textarea>
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
                                                    <input type="text" name="seo[star][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]" value="<?=$seo['star']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[star][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['star']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[star][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]" class="layui-textarea"><?=$seo['star']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[starlist][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" value="<?=$seo['starlist']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starlist][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$seo['starlist']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starlist][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，分类名：[name]" class="layui-textarea"><?=$seo['starlist']['description']?></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">标题:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="seo[starinfo][title]" placeholder="标题，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" value="<?=$seo['starinfo']['title']?>" class="layui-input"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">关键词:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starinfo][keywords]" placeholder="关键词，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" class="layui-textarea"><?=$seo['starinfo']['keywords']?></textarea>
                                                </div>
                                            </div>
                                            <div class="layui-form-item w120">
                                                <label class="layui-form-label">描述:</label>
                                                <div class="layui-input-block">
                                                    <textarea name="seo[starinfo][description]" placeholder="描述，可用标签，网站名字：[webname]，网站地址：[weburl]，明星名字：[name]，分类名：[cname]，明星介绍：[text]" class="layui-textarea"><?=$seo['starinfo']['description']?></textarea>
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
layui.use(['form'], function () {
    var form = layui.form;
    form.on('radio(web)', function (d) {
        if(d.value == 0){
            $('#web').show();
        }else{
            $('#web').hide();
        }
    });
});
</script>
</body>
</html>