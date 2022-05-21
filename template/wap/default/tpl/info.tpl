<style>
.vod-info{padding-left:0;padding-right:0;position:relative;width:100%;height:210px;overflow:hidden}
.vod-info .vod-info-bg{position:absolute;top:0;left:0;height:100%;width:100%;-webkit-filter:blur(30px);-moz-filter:blur(30px);-ms-filter:blur(30px);filter:blur(30px);background-size:cover;background-position:center center;opacity:.88}
.vod-info .vod-info-box{position:relative;height:190px;padding:15px 12px;display:-moz-box;display:box;background-color:rgba(0,0,0,.5)}
.vod-info .vod-info-box .vod-info-pic{position:absolute;top:15px;left:12px;width:130px;height:180px;}
.vod-info .vod-info-box .vod-info-pic img{width:100%;height:100%;border-radius:2px;}
.vod-info .vod-info-box .vod-info-right{padding-left:140px;color:#fff}
.vod-info .vod-info-box .vod-info-right a{color:#fff;margin-right:8px}
.vod-info .vod-info-box .vod-info-right h3{width:100%;line-height:28px;font-weight:700;font-size:18px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;box-sizing:border-box}
.vod-info .vod-info-box .vod-info-right h3 span{margin-left:10px;height:15px;line-height:16px;overflow:hidden;font-size:12px;padding:0 2px;border-radius:1px;background-color:rgba(255,255,255,.15)}
.vod-info .vod-info-box .vod-info-right p{width:100%;height:26px;line-height:26px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.vod-info .vod-info-box .vod-info-right p span{padding-left:10px;color:#ff6201;font-weight:700;font-size:15px}
.play-btn{width:100px;height:35px;line-height:35px;box-sizing:border-box;text-align:center;border-radius:16px;font-weight:700;border:1px solid rgba(255,255,255,.5);display:block;margin-top:10px}
.vod-info-text{padding:12px;line-height:24px;color:#666;max-height:77px;overflow:hidden;border-bottom:2px solid #f7f7f7;padding-bottom:0;position: relative;}
.vod-info-text span{font-weight:700;color:#333;}
.vod-info-text .text-more{position: absolute;bottom: 0px;right: 0;width: 30px;line-height: 30px;height: 30px; text-align: center;background: #fff;}
</style>
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="window.location.href='/';">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text"><?=$name?></div>
	<div class="pageHead-right"></div>
</div>
<div style="height: 54px;"></div>
<div class="vod-info">
	<div class="vod-info-bg" style="background-image:url(<?=getpic($pic)?>);"></div>
	<div class="vod-info-box">
		<div class="vod-info-pic"><img src="/packs/images/load.gif" lay-src="<?=getpic($pic)?>"></div>
		<div class="vod-info-right">
			<h3><?=$name?><span><?=$cname?></span></h3>
			<p>热度：<?=get_wan($hits)?><span><?=$score?>分</span></p>
			<p><?=$year?> • <?=$area?> • <?=$lang?></p>
			<p>导演：
			<?php 
            foreach($director_arr as $v){
                echo '<a href="'.links('search').'?key='.$v.'">'.$v.'</a>';
            }
            ?>
            </p>
			<p class="actor">主演：
			<?php 
            foreach($actor_arr as $v){
                echo '<a href="'.links('search').'?key='.$v.'">'.$v.'</a>';
            }
            ?>
            </p>
            <a href="<?=links('play',$id,0)?>" class="play-btn">立即播放</a>
		</div>
	</div>
</div>
<div class="vod-info-text">
	<span>简介：</span>
	<?=$text?>
	<div class="text-more"><i class="layui-icon layui-icon-down"></i></div>
</div>
<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/info.js"></script></div>
<div class="play-info" style="padding-top:0;">
    <div id="play-zu-box">
    <?php
    if(count($play) > 1){
        echo '<h4>站源<span>如无法播放，请尝试更换线路</span></h4><ul class="play-zu-ul">';
        foreach($play as $i=>$rowz){
            $cls = 0 == $i ? 'on' : '';
            echo '<li data-id="'.$rowz['id'].'" class="'.$cls.'">'.$rowz['name'].'</li>';
        }
        echo '</ul>';
    }
    ?>
    </div>
    <div id="play-ji-box">
        <?php
        if($fid > 1) echo '<h4>选集<span class="ji-btn">'.$state.'</span></h4>';
        foreach($play as $i=>$rowz){
            $cls = 0 == $i ? 'on' : '';
            echo '<ul class="play-ji-ul '.$cls.'" id="zu-'.$rowz['id'].'">';
            foreach($rowz['ji'] as $k=>$row){
                $pay = '';
                if($row['pay'] > 0) $pay = $row['pay'] == 1 ? '<span class="pay1">VIP</span>' : '<span class="pay2">点播</span>';
                echo '<li><a href="'.links('play',$id,$row['id']).'">'.$row['name'].'</a>'.$pay.'</li>';
            }
            echo '</ul>';
        }
        ?>
    </div>
    <?php
    $sql = "SELECT id,cid,name,pic,constellation FROM "._DBPREFIX_."star where FIND_IN_SET(name,'".implode(',',$actor_arr)."') order by hits LIMIT 30";
    $star = $this->mydb->get_sql($sql);
    if(!empty($star)){
        echo '<h4>演员表</h4><ul class="starul">';
        foreach($star as $row){
            echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
        }
        echo '</ul>';
    }
    ?>
    <h4 style="margin-top:10px;">猜你喜欢</h4>
    <ul class="vod-love">
        <?php
        foreach($love as $row){
            $pay = '';
            if($row['pay'] > 0) $pay = $row['pay'] == 1 ? '<span class="pay1">VIP</span>' : '<span class="pay2">点播</span>';
            echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<div class="state">'.$row['state'].'</div></div><div class="info"><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div><div class="hits"><i class="layui-icon layui-icon-fire"></i>'.get_wan($row['hits']).'</div></div></a></li>';
        }
        ?>
    </ul>
</div>
<script>
$(function(){
    $('.vod-info-text').click(function(){
        $('.text-more').hide();
        $(this).attr('style','max-height:100%;');
    });
    $('.play-zu-ul li').click(function(){
            $('.play-zu-ul li').removeClass('on');
            $(this).addClass('on');
            var zid = $(this).data('id');
            $('.play-ji-ul').hide();
            $('#zu-'+zid).show();
        });
});
</script>