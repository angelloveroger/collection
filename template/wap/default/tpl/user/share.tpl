<style type="text/css">
html{background-image: url(<?=_tpldir_?>images/invitation-bg.png);}
</style>
<!-- tabhead -->
<div class="pageHead betweenX centerY">
    <div class="pageHead-left" onclick="returns()">
        <i class="iconfont icon-xiangzuo"></i>
    </div>
    <div class="pageHead-text">邀请好友</div>
    <div class="pageHead-right">
        <a href="javascript:;" class="invitation-guiz">活动规则</a>
    </div>
</div>
<div style="height: 54px;"></div>
<div class="invitation-notice">
    <ul>
    <?php
    foreach($list as $row){
        echo '<li>恭喜恭喜<span>'.$row['nickname'].'</span>用户邀请<span>'.$row['nums'].'</span>个好友，奖励<span>'.$row['vipday'].'</span>天VIP</li>';
    }
    ?>
    </ul>
</div>
<img src="<?=_tpldir_?>images/invitation-font.png" class="invitation-font">
<div class="sharePla">
    <p class="sharePla-head">分享到以下平台</p>
    <div class="sharePla-cent centerY copy" data-clipboard-text="<?=$share_text?>">
        <div class="sharePla-list">
            <img src="<?=_tpldir_?>images/share-wx.png">
            <p>微信</p>
        </div>
        <div class="sharePla-list">
            <img src="<?=_tpldir_?>images/share-qq.png">
            <p>QQ</p>
        </div>
        <div class="sharePla-list">
            <img src="<?=_tpldir_?>images/share-wb.png">
            <p>微博</p>
        </div>
        <div class="sharePla-list">
            <img src="<?=_tpldir_?>images/share-lj.png">
            <p>复制链接</p>
        </div>
    </div>
</div>
<div class="invitbox">
    <p class="sharePla-head">我的奖励</p>
    <div class="invitbox-cent">
    <?php
    foreach($my as $row){
        echo '<div class="invitbox-list centerY betweenX"><p>邀请好友'.$row['nickname'].'</p><p>奖励'.$row['vipday'].'天VIP</p></div>';
    }
    ?>
    </div>
</div>
<div class="invtpopup">
    <div class="invtpopup-bg"></div>
    <div class="invtpopup-cont">
        <p class="invtpopup-head">活动规则</p>
        <div class="invtpopup-info">
            <?=$share_rules?>
        </div>
        <p class="invtpopup-tips">——本活动最终解释权归<?=WEBNAME?>所有——</p>
        <a class="invtpopup-btn">我知道了</a>
    </div>
</div>
<script src="/packs/jquery/clipboard.min.js"></script>
<script type="text/javascript">
    $(function() {
        var clipboard = new Clipboard('.copy');
        clipboard.on('success',function(e) {
            e.clearSelection();
            layer.msg('分享地址复制成功');
        });
        //获得当前<ul>
        var $uList = $(".invitation-notice ul");
        var timer = null;
        //触摸清空定时器
        $uList.hover(function() {
                clearInterval(timer);
            },
            function() { //离开启动定时器
                timer = setInterval(function() {
                        scrollList($uList);
                    },
                    2000);
            }).trigger("mouseleave"); //自动触发触摸事件
        //滚动动画
        function scrollList(obj) {
            //获得当前<li>的高度
            var scrollHeight = $("ul li:first").height();
            //滚动出一个<li>的高度
            $uList.stop().animate({
                    marginTop: -scrollHeight
                },
                600,
                function() {
                    //动画结束后，将当前<ul>marginTop置为初始值0状态，再将第一个<li>拼接到末尾。
                    $uList.css({
                        marginTop: 0
                    }).find("li:first").appendTo($uList);
                });
        }
        isloading = false,page = 1;
        $(window).bind("scroll", function () {
            if($(document).scrollTop() + $(window).height() 
                  > $(document).height() - 10 && !isloading) {
                page++;
                isloading = true;
                var tindex = layer.load();
                $.post('<?=links('user/share/more')?>',{page:page}, function(res) {
                    layer.close(tindex);
                    if(res.code == 1){
                        var html = '';
                        for (var i = 0; i < res.data.list.length; i++) {
                            html+='<div class="invitbox-list centerY betweenX"><p>邀请好友'+res.data.list[i].nickname+'</p><p>奖励'+res.data.list[i].vipday+'天VIP</p></div>';
                        }
                        $('#pagejs').append(html);
                        isloading = false;
                    }
                },'json');
            }
        });
    });
    $(".invitation-guiz").click(function(){
        $(".invtpopup").show()
    });
    $(".invtpopup-bg,.invtpopup-btn").click(function(){
        $(".invtpopup").hide()
    });
</script>
