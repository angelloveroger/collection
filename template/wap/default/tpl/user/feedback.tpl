<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="window.location.href='<?=links('user')?>'">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">意见反馈</div>
	<div class="pageHead-right">
		<a href="<?=links('user/feedback/my')?>">我的反馈</a>
	</div>
</div>
<div style="height: 54px;"></div>
<div class="feedback">
	<div class="feedback-problem">
		<p class="feedback-head">请选择您在使用过程中遇到的问题</p>
		<div class="problem-cent">
		<?php
		foreach($list as $v){
			echo '<span data-type="'.$v.'" class="">'.$v.'</span>';
		}
		?>
		</div>
	</div>
	<div class="feedback-describe">
		<p class="feedback-head">反馈描述<span style="color: #E02020;">*</span><span style="color: #999999;font-size: 24rpx;">(必填)</span></p>
		<textarea name="text" id="text" value="" placeholder="请填写15字以上的描述，以便我们更好的为您提供帮助～"></textarea>
	</div>
	<div class="feedback-image">
		<p class="feedback-head">上传图片<span style="color: #999999;font-size: 24rpx;">(选填，最多3张)</span></p>
		<div class="image-cent">
			<div class="feedback-file">
				<img src="<?=_tpldir_?>images/addimg.png">
			</div>
		</div>
	</div>
	<button class="feedsub">提交</button>
</div>
<script type="text/javascript">
	var pics = [];
	$(".problem-cent span").click(function(){
		 $(this).addClass('actice').siblings().removeClass('actice');
	});
	$('.feedsub').click(function(){
		var text = $('#text').val();
		var type = $('.problem-cent .actice').data('type');
		if($('.problem-cent .actice').length == 0){
			layer.msg('请选择反馈类型',{shift:6});
		}else if(text == ''){
			layer.msg('请填写反馈内容',{shift:6});
		}else{
			$.post('<?=links('user/feedback/send')?>',{type:type,text:text,pics:pics.join(',')},function(res){
				if(res.code == 1){
					layer.msg(res.msg);
					$('#text').val('');
					pics = [];
					setTimeout(function(){
		                window.location.href = '<?=links('user/feedback/my')?>';
		            },1000);
				}else{
					layer.msg(res.msg,{shift:6});
				}
			},'json');
		}
	});
</script>