<div class="layui-row">
    <div class="user-box">
        <div class="user-info-box">
            <div class="pic"><img src="<?=getpic('')?>"></div>
            <div class="nickname"><?=$nickname?></div>
            <div class="vip">
                未开通VIP
            </div>
            <div class="pay-btn" onclick="user.pay('vip');">购买VIP</div>
        </div>
    </div>
</div>
<div class="user-tab-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="user-tab-row">
                <a class="on" href="<?=links('user')?>">观看历史<em></em></a>
                <a href="<?=links('user/fav')?>">我的收藏<em></em></a>
                <a href="<?=links('user/comment')?>">我的评论<em></em></a>
                <a href="<?=links('user/info')?>">修改资料<em></em></a>
            </div>
        </div>
    </div>
</div>
<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="js-data">
                <div class="nodata"><img src="<?=_tpldir_?>images/nodata.png"><p>暂无记录~!</p></div>
            </div>
        </div>
    </div>
</div>