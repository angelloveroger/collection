<style type="text/css">html{background-color: #F9F9F9;}</style>
<div class="pageHead betweenX centerY" style="background:  none;">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">任务中心</div>
	<div class="pageHead-right">
	</div>
</div>
<!-- <div style="height: 54px;"></div> -->
<img class="taskbox-bg" src="<?=_tpldir_?>images/task-bg.png">
<div style="padding-top: 75px;">
	<div class="task-jnum">
		 <img src="<?=_tpldir_?>images/task-bg2.png">
		 <div class="task-jnumjb centerXY">
			 <p><?=$cion?></p>
			 <p>金币</p>
		 </div>
		 <?php if(!empty($day_cion)){
		 	echo '<p class="task-jnumtips">今日已+'.$day_cion.'</p>';
		 }
		 ?>
	</div>
</div>
<div class="tasksign">
	<p class="tasksign-title">已连续签到<span><?=$qdnum?></span>天</p>
	<div class="tasksign-box">
		<div class="tasksign-gold centerY">
		<?php
		foreach($signin as $cion) echo '<p><span>+'.$cion.'</span></p>';
		?>
		</div>
		<div class="tasksign-qnum centerY">
		<?php
		foreach($signin as $k=>$cion){
			if(($k+1) == $qdnum){
				echo '<div class="tasksign-qnum-list"><img src="'._tpldir_.'images/task-qd.png"></div>';
			}elseif($k == 6){
				echo '<div class="tasksign-qnum-list"><img src="'._tpldir_.'images/task-bx.png" ></div>';
			}else{
				echo '<div class="tasksign-qnum-list"><p></p></div>';
			}
		}
		?>
			<div class="tasksign-jdt" style="width: <?=$qdnum>0?($qdnum/7*100):0;?>%;">
				<img class="" src="<?=_tpldir_?>images/task-jdt.png">
			</div>
		</div>
		<div class="tasksign-days centerY">
		<?php
		foreach($signin as $k=>$cion) echo '<p>第'.($k+1).'天</p>';
		?>
		</div>
	</div>
</div>
<div class="taskcent">
	<h2 class="taskcent-title">做任务赢积分</h2>
	<div class="taskcent-box">
	<?php
	foreach($list as $row){
		if($row['state'] == 1){
			$ok = '<p class="taskcent-hbtn taskcent-hbtn3">已完成</p>';
		}else{
			$ok = $row['type'] == 'signin' ? '<p class="taskcent-hbtn taskcent-hbtn2">领取任务</p>' : '<p class="taskcent-hbtn taskcent-hbtn1">马上完成</p>';
		}
		echo '<div class="taskcent-list"><div class="taskcent-head centerY betweenX"><div  class="taskcent-hinfo centerY"><img class="taskcent-himg" src="'._tpldir_.'images/task-icon-'.$row['type'].'.png"><div class="taskcent-hcont"><p class="taskcent-ht">'.$row['name'].'</p><p class="taskcent-hx centerY">'.$row['text'].'</p></div></div>'.$ok.'</div></div>';
	}
	?>
	</div>
</div>
<div class="task-popup">
	<div class="task-popup-bg"></div>
	<div class="task-popup-box">
		<img class="task-popup-img" src="<?=_tpldir_?>images/task-qd2.png">
		<p class="task-popup-title">签到任务奖励</p>
		<p class="task-popup-tips">恭喜您完成签到任务获得奖励</p>
		<div class="task-popup-cont centerXY">
			<img src="<?=_tpldir_?>images/task-jb.png">
			<span>+<?=$qdcion?>金币</span>
		</div>
		<a class="task-popup-but">确认</a>
	</div>
</div>
<script type="text/javascript">
	$(window).scroll(function() {
	   var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
		if(scrollTop==0){
			 $(".pageHead").css("background","none");
		}else{
			 $(".pageHead").css("background-color","#ffffff");
		}
	})
	$(".taskcent-hx").click(function(){
		$(this).toggleClass("taskcent-hx2");
		$(this).parents(".taskcent-head").siblings(".taskcent-show").toggle();
	})
	$(".taskcent-hbtn2").click(function(){
		var _this = $(this);
		var index = layer.load();
		$.get('<?=links('user/task/send')?>?type=signin',function(res){
			layer.close(index);
			if(res.code == 1){
				$(".task-popup").show();
				_this.removeClass('taskcent-hbtn2').addClass('taskcent-hbtn3').html('已完成');
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
	})
	$(".task-popup-bg,.task-popup-but").click(function(){
		$(".task-popup").hide()
	})
	$(".taskcent-hbtn1").click(function(){
		window.location.href = '/';
	});
</script>