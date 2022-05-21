<!DOCTYPE html>
<!--[if lte IE 6 ]>
<html class="ie ie6 lte_ie7 lte_ie8 lte_ie9 " lang="zh-CN"> <![endif]-->
<!--[if IE 7 ]>
<html class="ie ie7 lte_ie7 lte_ie8 lte_ie9 " lang="zh-CN"> <![endif]-->
<!--[if IE 8 ]>
<html class="ie ie8 lte_ie8 lte_ie9 " lang="zh-CN"> <![endif]-->
<!--[if IE 9 ]>
<html class="ie ie9 lte_ie9 " lang="zh-CN"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="zh-CN">
<!--<![endif]-->
<head>
    <meta name="format-detection" content="telephone=no">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?=$title?></title>
    <meta name='keywords' content='<?=$keywords?>'/>
    <meta name='description' content='<?=$description?>'/>
    <meta name="applicable-device" content="pc">
    <meta name="mobile-agent" content="format=html5; url=<?=get_replace_url()?>">
    <link rel="shortcut icon" href="/favicon.ico"/>
    <link href="/packs/layui/css/layui.css" rel="stylesheet">
    <link href="<?=_tpldir_?>css/style.css" rel="stylesheet">
    <script src="/packs/jquery/jquery.min.js"></script>
    <script>var _tpldir_ = '<?=_tpldir_?>',_regcode_ = '<?=_REGCODE_?>';</script>
</head>
<body>
<div class="header">
    <div class="header_con">
        <a href="/" class="logo"><img src="<?=_tpldir_?>images/logo.png" width="200" height="45" alt=""></a>
        <div class="channel_links">
            <a id="nav-index" href="/">首页<i></i></a>
            <?php
            $class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',5);
            foreach($class as $row){
                echo '<a id="nav-'.$row['id'].'" href="'.links('lists',$row['id']).'">'.$row['name'].'<i></i></a>';
            }
            ?>
            <a id="nav-star" href="<?=links('star')?>">明星库<i></i></a>
            <a id="nav-hot" href="<?=links('hot')?>">排行榜<i></i></a>
        </div>
        <div class="search" action="<?=links('search')?>">
            <span class="input">
                <input type="text" class="jheader_search_input search_key" placeholder="请输入影片名称" style="color: rgb(102, 102, 102);">
                <a href="javascript:void(0);" class="search_btn"><i class="layui-icon">&#xe615;</i></a>
            </span>
        </div>
        <div class="user_box">
            <div class="item js-read">
                <a href="<?=links('user')?>" target="_blank"><i class="layui-icon">&#xe68d;</i>历史</a>
                <div class="dialog js-read-box hide">
                    <div class="read-dialog">
                        <div class="header-read">
                            <div class="dialog-top-border"></div>
                            <div class="login-notice">
                                主人，登录可以同步各端数据 
                                <a href="javascript:;" class="login loginbtn">去登录&gt;</a>
                            </div>
                        </div>
                        <div class="read-item-box">
                            <div class="item-container"></div>
                            <div class="read-empty">
                                <p>你暂时还没有浏览记录</p>
                                <a href="/" class="link">「 先去追一部 」</a>
                            </div>
                        </div>
                        <a href="<?=links('user')?>" class="check-all hide" style="display: none;" target="_blank">查看全部历史</a>
                    </div>
                </div>
            </div>
            <div class="item js-cases">
                <a href="<?=links('user/fav')?>" target="_blank"><i class="layui-icon">&#xe68c;</i>收藏</a>
                <div class="dialog js-cases-box hide">
                    <div class="header-case">
                        <div class="dialog-top-border"></div>
                        <div class="case-item-box">
                            <div class="item-container"></div>
                            <div class="nologin">
                                <p>同步收藏，实时追更</p>
                                <a href="javascript:;" class="login-btn">立即登录</a>
                            </div>
                            <div class="case-empty hide">
                                <p>你暂时还没有收藏记录</p>
                                <a href="<?=links('vod')?>" class="link" target="_blank">「 先去追一部 」</a>
                            </div>
                        </div>
                        <a href="<?=links('user/fav')?>" class="check-all hide" style="display: none;" target="_blank">查看全部收藏</a>
                    </div>
                </div>
            </div>
            <div class="item js-appdown">
                <a href="<?=links('appdown')?>" target="_blank"><i class="layui-icon">&#xe665;</i>APP下载</a>
                <div class="dialog js-appdown-box hide">
                    <div class="appdown-item-box">
                        <div class="dialog-top-border"></div>
                        <div class="qrcode"><img src="<?=links('ajax/qrcode')?>"></div>
                        <div class="text">
                            <p class="title"><?=WEBNAME?>APP</p>
                            <p class="tip">超前点播永久免费</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item js-user">
                <a class="pic js-ulink" href="<?=links('user/login')?>"><img class="js-upic" src="<?=_tpldir_?>images/user.png"></a>
                <div class="dialog js-uinfo hide">
                    <div class="header-user">
                        <div class="dialog-top-border"></div>
                        <a href="javascript:;" class="login-btn">登录/注册</a>
                        <div class="user-info">
                            <a class="js-ulink" href="<?=links('user/login')?>"><img class="js-upic" src="<?=_tpldir_?>images/user.png"></a>
                            <div class="user-name">
                                <a href="<?=links('user/login')?>" class="js-unichen js-ulink">游客</a>
                                <i class="mkz-icon js-uvip"></i>
                                <span class="logout js-logout hide">退出</span>
                            </div>
                            <div class="vip-expired">
                                <span class="js-uviptime">会员到期</span>
                                <a class="hl js-ubuyvip" href="javascript:user.pay('vip');">购买&gt;</a>
                                <a class="hl js-uaginvip hide" href="javascript:user.pay('vip');">续费&gt;</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="header_h"></div>