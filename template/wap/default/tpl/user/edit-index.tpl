<style type="text/css">
html{background-color: #F9F9F9;}
img.uplogo{
	width: 25px;
    height: 25px;
    position: absolute;
    right: 20px;
    top: 15px;
    border-radius: 50%;
    border: 3px solid #E8E8E8;
}
</style>
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">编辑资料</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="upfrom">
	<div class="uplist centerY betweenX uppic" style="position:relative;">
		<div class="uplist-left">
			<span class="uplist-title">头像</span>
		</div>
		<div class="uplist-right">
			<img src="<?=_tpldir_?>images/right2.png">
		</div>
		<img class="uplogo" src="<?=getpic($pic)?>">
	</div>
	<a href="<?=links('user/edit/nickname')?>" class="uplist centerY betweenX">
		<div class="uplist-left">
			<span class="uplist-title">昵称</span>
		</div>
		<div class="uplist-right">
			<span class="uplist-right-text"><?=$nickname?></span>
			<img src="<?=_tpldir_?>images/right2.png" >
		</div>
	</a>
	<div class="uplist centerY betweenX" onclick="commDdelete()">
		<div class="uplist-left">
			<span class="uplist-title">性别</span>
		</div>
		<div class="uplist-right">
			<span class="uplist-right-text sex-text"><?=$sex==2?'女':'男'?></span>
			<img src="<?=_tpldir_?>images/right2.png">
		</div>
	</div>
</div>
<div class="comment-popup">
	<div class="comment-popup-bg" onclick="cancelDdelete()"></div>
	<div class="comment-popup-box">
		<p class="editdata-head" data-sex="1">男</p>
		<p class="editdata-head" data-sex="2">女</p>
		<p onclick="cancelDdelete()">取消</p>
	</div>
</div>
<script type="text/javascript">
	function commDdelete(){
		$(".comment-popup").show()
	} 
	function cancelDdelete(){
		$(".comment-popup").hide()
	} 
</script>