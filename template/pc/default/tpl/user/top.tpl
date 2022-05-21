<div class="layui-row">
    <div class="user-box">
        <div class="user-info-box">
            <div class="pic"><img src="<?=getpic($pic)?>"></div>
            <div class="nickname"><?=$nickname?></div>
            <div class="vip">
            <?php if($viptime > 0){ ?>
                <img src="<?=_tpldir_?>images/vip.png">
                <?=date('Y-m-d',$viptime)?>到期
            <?php }else{ ?>
                未开通VIP
            <?php } ?>
            </div>
            <div class="pay-btn" onclick="user.pay('vip');">购买VIP</div>
        </div>
    </div>
</div>
<div class="user-tab-box">
    <div class="layui-container">
        <div class="layui-row">
            <div class="user-tab-row">
                <a<?php if($op=='index') echo ' class="on"';?> href="<?=links('user')?>">观看历史<em></em></a>
                <a<?php if($op=='fav') echo ' class="on"';?> href="<?=links('user/fav')?>">我的收藏<em></em></a>
                <a<?php if($op=='comment') echo ' class="on"';?> href="<?=links('user/comment')?>">我的评论<em></em></a>
                <a<?php if($op=='info') echo ' class="on"';?> href="<?=links('user/info')?>">修改资料<em></em></a>
            </div>
        </div>
    </div>
</div>