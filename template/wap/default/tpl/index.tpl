<link rel="stylesheet" href="<?=_tpldir_?>css/swiper-bundle.min.css" />
<!-- 首页头部 -->
<div class="index-head">
	<!-- 搜索栏 -->
	<div class="centerY search">
		<a href="<?=links('search/opt')?>" class="centerY search-input flex1">
			<img src="<?=_tpldir_?>images/search.png">
			<input type="text" name="" id="" value="" placeholder="搜索影片、明星" />
		</a>
		<a href="<?=links('user/read')?>" class="search-history">
			<img src="<?=_tpldir_?>images/history.png">
		</a>
		<a href="<?=links('appdown')?>" class="search-history">
			<img src="<?=_tpldir_?>images/app_down.png">
		</a>
	</div>
	<!-- nav导航栏 -->
	<div class="index-nav">
		<a class="index-nav-active" href="/">推荐</a>
		<?php
		$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',20);
		foreach($class as $k=>$row){
			echo '<a href="'.links('lists',$row['id']).'">'.$row['name'].'</a>';
		}
		?>
		<a href="<?=links('star')?>">明星库</a>
	</div>
</div>
<div style="height: 91px;"></div>
<ul>
	<li>
		<!-- 轮播 -->
		<div class="swiper-container">
			<div class="swiper-wrapper">
			<?php
			$banner = $this->mydb->get_select('vod',array('reco'=>1),'id,name,picx','rhits desc',6);
			foreach($banner as $k=>$row){
				echo '<div class="swiper-slide"><a href="'.links('info',$row['id']).'"><img src="'.getpic($row['picx']).'"></a></div>';
			}
			?>
			</div>
			<div class="swiper-pagination"></div>
		</div>
		<!-- 消息滚动 -->
		<div class="centerY index-notice">
			<img class="index-notice-img" src="<?=_tpldir_?>images/notice.png" >
			<div id="indexnews" style="width:100%; position:relative; white-space:nowrap; overflow:hidden; height:35px; margin-left: 10px;">
				<div id="noticeList" style="position:absolute; top:7px; height:20px;">
					<span><?=$this->myconfig['notice']?></span>
				</div>
			</div>
		</div>
		<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/index1.js"></script></div>
		<div class="index-boxhead centerY betweenX">
			<div>热门明星</div>
			<a href="<?=links('starhot')?>" class="centerY">
				<span>查看更多</span>
				<i class="iconfont icon-xiangyou"></i>
			</a>
		</div>
		<div class="starbox">
			<ul class="starul">
				<?php
				$star = $this->mydb->get_select('star',array(),'id,name,pic','hits desc',30);
				foreach($star as $row){
					echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
				}
				?>
			</ul>
		</div>
		<div class="index-boxhead centerY betweenX">
			<div>热门推荐</div>
			<a href="<?=links('opt','reco')?>" class="centerY">
				<span>查看更多</span>
				<i class="iconfont icon-xiangyou"></i>
			</a>
		</div>
		<ul class="videoul">
		<?php
		$vod = $this->mydb->get_select('vod',array('tid>'=>0),'id,name,pic,state,pay','zhits desc',6);
		foreach($vod as $k=>$row){
			$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
			echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
		}
		?>
		</ul>
		<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/index2.js"></script></div>
		<?php
		$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',6);
		foreach($class as $rowc){
			echo '<div class="index-boxhead centerY betweenX"><div>最新'.$rowc['name'].'</div><a href="'.links('lists',$rowc['id']).'" class="centerY"><span>查看更多</span><i class="iconfont icon-xiangyou"></i></a></div><ul class="videoul">';
			$cids = get_cid($rowc['id']);
			$vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,state,pay','addtime desc',6);
			foreach($vod as $row){
				$pay = $row['pay'] > 0 ? '<img class="videoul-vip" src="'._tpldir_.'images/pay'.$row['pay'].'.png">' : '';
				echo '<li class="videoul-li"><a href="'.links('info',$row['id']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'">'.$pay.'<p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a></li>';
			}
			echo '</ul>';
		}
		?>
		<div class="advertisement"><span>广告</span><script src="<?=_tpldir_?>adv/index3.js"></script></div>
	</li>
</ul>
<!-- tabbat -->
<div style="height:50px;"></div>
<div class="centerY tabbat">
	<a href="/" class="tabbat-active">
		<img src="<?=_tpldir_?>images/index-r.png">
		<p>首页</p>
	</a>
	<a href="<?=links('topic')?>">
		<img src="<?=_tpldir_?>images/special.png" >
		<p>专题</p>
	</a>
	<a href="<?=links('hot')?>">
		<img src="<?=_tpldir_?>images/ranking.png" >
		<p>排行</p>
	</a>
	<a href="<?=links('user')?>">
		<img src="<?=_tpldir_?>images/my.png" >
		<p>我的</p>
	</a>
</div>
<?php if(!empty($this->myconfig['notice2'])){ ?>
<style type="text/css">
.notice2{z-index:99999;width:100%;height:100%;position:fixed;top:0;left:0;background-color:rgba(0,0,0,.3);display: none;}
.notice-bg{width:100%;height:100%;position:relative}
.notice-bg .notice-box{width:70%;height:40%;position:absolute;top:25%;left:15%;background-color:#fff;border-radius:10px;z-index:2}
.notice-bg .notice-box .title{width:80%;background-color:#aeaeae;height:2px;margin-top: 30%;margin-left:10%;text-align:center;position:relative;}
.notice-bg .notice-box .title text{position:absolute;background-color:#fff;width:100px;height:30px;text-align:center;bottom:-14px;left:50%;margin-left:-50px;font-size:20px;font-weight:600}
.notice-bg .notice-box .text{width: 80%;margin-left: 10%;margin-top: 6%;height: 55%;overflow-y: auto;padding-top: 5px;font-size: 15px;color:#666;line-height: 23px;}
.notice-bg .top{top:14%;position:absolute;left:50%;z-index:3;width:110px;height:120px;margin-left:-55px}
.notice-bg .del{top:65%;position:absolute;left:50%;z-index:3;width:40px;height:400px;margin-left:-20px;text-align:center}
.notice-bg .del .line{margin:0 auto;width:2px;height:60px;background-color:#fff}
.notice-bg .del img{width:40px;height:40px;margin-top:-5px}
</style>
<div class="notice2">
	<div class="notice-bg">
		<img class="top" src="<?=_tpldir_?>images/notice_top.png">
		<div class="notice-box">
			<div class="title"><text>温馨提示</text></div>
			<div class="text"><?=$this->myconfig['notice2']?></div>
		</div>
		<div class="del">
			<div class="line"></div>
			<img src="<?=_tpldir_?>images/del.png">
		</div>
	</div>
</div>
<?php } ?>
<script src="<?=_tpldir_?>js/roll.js"></script>
<script src="<?=_tpldir_?>js/swiper-bundle.min.js"></script>
<script>
	var swiper = new Swiper('.swiper-container', {
		loop: true,
		pagination: {
			el: '.swiper-pagination',
		},
		autoplay: true,
	});
	$(function() {
		$("#indexnews").textScroll();
		$('.notice2 .del').click(function(){
			setcookie('notice','ok');
			$('.notice2').remove();
		});
		if(!getcookie('notice') && $('.notice2').length > 0){
			$('.notice2').show();
		}
	});
</script>