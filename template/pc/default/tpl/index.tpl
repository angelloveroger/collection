<div class="layui-main">
	<div class="bannerindex">
		<div id="bannerindex"></div>
		<script>
		$('#nav-index').addClass('on');
		<?php
		$banner = $this->mydb->get_select('vod',array('reco'=>1),'id,name,picx','rhits desc',6);
		$barr = [];
		foreach($banner as $k=>$row){
			$barr[$k] = array('img'=>getpic($row['picx']),'title'=>$row['name'],'url'=>links('info',$row['id']));
		}
		?>
		var banner_json = <?=json_encode($barr)?>;
		</script>
	</div>
</div>
<div class="layui-main">
	<div class="layui-container box1">
		<div class="ads"><script src="<?=_tpldir_?>adv/index1.js"></script></div>
		<div class="layui-row">
			<div class="class_list">
			<?php
			$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',4);
			foreach($class as $k=>$row){
				echo '<div class="item"><h3><a href="'.links('lists',$row['id']).'">'.$row['name'].'</a><i></i></h3><div class="list">';
				$type = $this->mydb->get_select('class',array('fid'=>$row['id']),'id,name','xid asc',7);
				foreach($type as $row2){
					echo '<a href="'.get_vod_url(array('cid'=>$row2['id'])).'">'.$row2['name'].'</a>';
				}
				if(count($type) > 6) echo '<a href="'.links('lists',$row['id']).'">更多</a>';
				echo '</div></div>';
			}
			?>
			</div>
		</div>
	</div>
	<div class="layui-container box7">
		<div class="layui-row">
			<h3><a href="<?=links('star')?>">热门明星 <i class="layui-icon">&#xe602;</i></a></h3>
			<div class="star">
				<ul>
				<?php
				$star = $this->mydb->get_select('star',array(),'id,name,pic','hits desc',27);
				foreach($star as $row){
					echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
				}
				?>
				</ul>
	            <div class="more-left"><i class="layui-icon layui-icon-left"></i></div>
	            <div class="more-right"><i class="layui-icon layui-icon-right"></i></div>
			</div>
		</div>
	</div>
	<div class="layui-container box3">
		<div class="layui-row">
			<h3>热门推荐<a href="javascript:;" class="right reco_huan"><i class="layui-icon">&#xe669;</i> 换一批</a></h3>
			<ul class="plist">
			<?php
			$vod = $this->mydb->get_select('vod',array('tid>'=>0),'id,name,pic,state,score','zhits desc',7);
			foreach($vod as $k=>$row){
				echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="name">'.$row['name'].'</div><div class="state">'.$row['state'].'<span><b>'.$row['score'].'</b>分</span></div></a></li>';
			}
			?>
			</ul>
		</div>
	</div>
	<?php
	$class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',4);
	foreach($class as $k=>$row){
		$cids = get_cid($row['id']);
		$vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,state,hits,text','yhits desc',3);
		$vod2 = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,state,hits,text','rhits desc',array(8,3));
	?>
	<div class="layui-container box2">
		<div class="layui-row">
			<div class="left">
				<h3><a href="<?=get_vod_url(array('cid'=>$row['id']))?>">热门<?=$row['name']?> <i class="layui-icon">&#xe602;</i></a></h3>
				<div class="reco_index">
					<div class="pics swiper3d">
					<?php
					foreach($vod as $kk=>$v){
						echo '<a href="'.links('info',$v['id']).'"><img alt="'.$v['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($v['pic']).'" index="'.$kk.'"></a>';
					}
					?>
					</div>
					<?php
					foreach($vod as $kk=>$v){
						$dis = $kk == 0 ? 'block' : 'none';
						echo '<div class="swiper3d_txt" style="display: '.$dis.'"><div class="title"><a href="'.links('info',$v['id']).'">'.$v['name'].'</a></div><div class="state">'.$v['state'].'</div><div class="hits"><b>'.get_wan($v['hits']).'</b>人气</div><div class="text"><b>简介：</b><br>'.$v['text'].'</div><div class="btn"><a href="'.links('play/'.$v['id']).'">立即播放</a></div></div>';
					}
					?>
				</div>
				<ul class="vodlist">
				<?php
				foreach($vod2 as $v){
					echo '<li><a href="'.links('info',$v['id']).'"><div class="pic"><img alt="'.$v['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($v['pic']).'"></div><div class="name">'.$v['name'].'</div><div class="state">'.$v['state'].'</div></a></li>';
				}
				?>
				</ul>
			</div>
			<div class="right">
				<h3>最新<?=$row['name']?></h3>
				<ul class="list_hot">
				<?php
				$vod = $this->mydb->get_select('vod',array('cid'=>$cids),'id,name,pic,state,hits,text','addtime desc',8);
				foreach($vod as $k2=>$v){
					if($k2 < 3){
						echo '<li><a href="'.links('info',$v['id']).'"><div class="pic left"><img alt="'.$v['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($v['pic']).'"></div><div class="right txt"><span class="name">'.$v['name'].'</span><span class="state">'.$v['state'].'</span></div></a></li>';
					}else{
						echo '<li><a href="'.links('info',$v['id']).'"><em>'.($k2+1).'</em><span class="name">'.$v['name'].'</span></a></li>';
					}
				}
				?>			
				</ul>
			</div>
		</div>
	</div>
	<?php } ?>
	<div class="layui-container box6">
		<div class="ads"><script src="<?=_tpldir_?>adv/index2.js"></script></div>
		<div class="layui-row">
			<h3><a href="<?=links('topic')?>">热门专题 <i class="layui-icon">&#xe602;</i></a></h3>
			<ul class="topic">
			<?php
			$topic = $this->mydb->get_select('topic',array(),'id,name,pic','hits desc',5);
			foreach($topic as $row){
				$nums = $this->mydb->get_nums('vod',array('ztid'=>$row['id']));
				echo '<li><a href="'.links('topicinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="text"><p>—— '.$nums.'个影片 ——</p><p>'.$row['name'].'</p></div></a></li>';
			}
			?>
			</ul>
		</div>
	</div>
	<div class="layui-container box5">
		<div class="layui-row">
			<div class="left">
				<ul>
					<h3><b>日榜</b><em class="day"></em><a href="<?=links('hot')?>">全部 <i class="layui-icon">&#xe602;</i></a></h3>
					<?php
					$vod = $this->mydb->get_select('vod',array(),'id,name,pic,state','rhits desc',10);
					foreach($vod as $k=>$row){
						$k++;
						if($k < 10) $k = '0'.$k;
						if($k < 4){
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><div class="left"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="right"><span class="name">'.$row['name'].'</span><span class="state">'.$row['state'].'</span></div></a></li>';
						}else{
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><em>'.$k.'</em>'.$row['name'].'</a></li>';
						}
					}
					?>	
					</ul>
				<ul>
					<h3><b>周榜</b><em class="zhou"></em><a href="<?=links('hot')?>">全部 <i class="layui-icon">&#xe602;</i></a></h3>
					<?php
					$vod = $this->mydb->get_select('vod',array(),'id,name,pic,state','zhits desc',10);
					foreach($vod as $k=>$row){
						$k++;
						if($k < 10) $k = '0'.$k;
						if($k < 4){
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><div class="left"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="right"><span class="name">'.$row['name'].'</span><span class="state">'.$row['state'].'</span></div></a></li>';
						}else{
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><em>'.$k.'</em>'.$row['name'].'</a></li>';
						}
					}
					?>
					</ul>
				<ul>
					<h3><b>月榜</b><em class="yue"></em><a href="<?=links('hot')?>">全部 <i class="layui-icon">&#xe602;</i></a></h3>
					<?php
					$vod = $this->mydb->get_select('vod',array(),'id,name,pic,state','yhits desc',10);
					foreach($vod as $k=>$row){
						$k++;
						if($k < 10) $k = '0'.$k;
						if($k < 4){
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><div class="left"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="right"><span class="name">'.$row['name'].'</span><span class="state">'.$row['state'].'</span></div></a></li>';
						}else{
							echo '<li class="len'.$k.'"><a href="'.links('info',$row['id']).'"><em>'.$k.'</em>'.$row['name'].'</a></li>';
						}
					}
					?>			
					</ul>
			</div>
			<div class="right">
				<h3>收藏榜<a class="right" href="<?=links('hot')?>">更多 <i class="layui-icon">&#xe602;</i></a></h3>
				<ul>
				<?php
				$vod = $this->mydb->get_select('vod',array(),'id,name,pic,state,shits','shits desc',5);
				foreach($vod as $k=>$row){
					if($k == 0){
						echo '<li class="li-'.($k+1).'"><a href="'.links('info',$row['id']).'"><div class="pic left"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="txt right"><span class="name">'.$row['name'].'</span><span class="state">'.$row['state'].'</span></div></a></li>';
					}else{
						echo '<li class="li-'.($k+1).'"><a href="'.links('info',$row['id']).'"><div class="pic left"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="txt right"><span class="name">'.$row['name'].'</span><span class="state">'.$row['state'].'</span><span class="hist">'.get_wan($row['shits']).'次收藏</span></div></a></li>';
					}
				}
				?>
				</ul>
			</div>
		</div>
	</div>
	<div class="layui-container box2">
		<div class="layui-row">
			<h3 style="border-left: 5px solid #333;margin-bottom: 20px;">友情链接</h3>
            <div class="friendly_link">
                <ul>
                <?php
				$links = $this->mydb->get_select('links',array(),'name,url','id asc',500);
				foreach($links as $row){
					echo '<li><a href="'.$row['url'].'" target="_blank">'.$row['name'].'</a></li>';
				}
				?>
                </ul>
            </div>
        </div>
        <div class="ads"><script src="<?=_tpldir_?>adv/index3.js"></script></div>
    </div>
</div>
<?php if(!empty($this->myconfig['notice2'])){ ?>
<style type="text/css">
.notice{z-index:99999;width:100%;height:100%;position:fixed;top:0;left:0;background-color:rgba(0,0,0,.5);display: none;}
.notice-bg{width:50%;height:100%;position:relative;top:30%;left:25%;z-index:2}
.notice-bg .notice-box{width:400px;max-height: 280px;background-color:#fff;border-radius:10px;margin:0 auto;padding-top: 1px;padding-bottom: 40px;}
.notice-bg .notice-box .title{width:80%;background-color:#aeaeae;height:2px;margin-left:10%;text-align:center;position:relative;margin-top: 80px;}
.notice-bg .notice-box .title text{position:absolute;background-color:#fff;width:100px;height:30px;text-align:center;bottom:-14px;left:50%;margin-left:-50px;font-size:20px;font-weight:600}
.notice-bg .notice-box .text{width: 80%;margin-left: 10%;margin-top: 30px;max-height: 150px;overflow-y: auto;padding-top: 5px;font-size: 15px;color:#666;line-height: 23px;}
.notice-bg .top{top:-80px;position:absolute;left:50%;z-index:3;width:110px;height:120px;margin-left:-55px}
.notice-bg .del{width:40px;height: 100px;text-align:center;margin: 0 auto;}
.notice-bg .del .line{margin:0 auto;width:2px;height:60px;background-color:#fff}
.notice-bg .del img{width:40px;height:40px;margin-top:-5px;cursor: pointer;}
</style>
<div class="notice">
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
<script>
	$(function() {
		$('.notice .del').click(function(){
			setcookie('notice','ok');
			$('.notice').remove();
		});
		if(!getcookie('notice') && $('.notice').length > 0){
			$('.notice').show();
		}
	});
</script>