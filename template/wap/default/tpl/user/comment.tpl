<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">我的评论</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="comment-li">
	<?php foreach($comment as $k=>$row){ ?>
	<div class="comment-ulist betweenX" id="comment-<?=$row['id']?>">
		<div class="comment-head">
			<img src="<?=$row['upic']?>">
		</div>
		<div class="comment-info">
			<div class="centerY betweenX comment-li1">
				<p class="comment-name"><?=$row['nickname']?></p>
				<div class="comment-more" onclick="commDdelete(<?=$row['id']?>)">
					<img class="" src="<?=_tpldir_?>images/more.png">
				</div>
			</div>
			<div class="comment-cont">
				<?=$row['text']?>
			</div>
			<div class="centerY betweenX comment-li2">
				<p class="comment-item"><?=$row['addtime']?></p>
				<div class="comment-like centerY">
					<img src="<?=_tpldir_?>images/like<?=$row['is_zan']==1?'-r':''?>.png">
					<span><?=$row['zan']?></span>
				</div>
			</div>
			<a class="centerY comment-tv" href="<?=$row['vlink']?>">
				<img src="<?=_tpldir_?>images/TV.png">
				<span><?=$row['vname']?></span>
			</a>
			<?php
			if($row['reply_num'] > 0) echo '<div class="comment-reply">';
			foreach($row['reply'] as $row2){
				echo '<div class="reply-list"><span>'.$row2['nickname'].'：</span><span>'.$row2['text'].'</span></div>';
			}
			if($row['reply_num'] > 3) echo '<div class="centerXY reply-more"><span>查看共'.$row['reply_num'].'条回复</span><img src="'._tpldir_.'images/bottom.png" ></div>';
			if($row['reply_num'] > 0) echo '</div>';
			?>
		</div>
	</div>
	<?php } ?>
</div>
<div class="comment-popup">
	<div class="comment-popup-bg" onclick="cancelHide()"></div>
	<div class="comment-popup-box">
		<p onclick="cancelDdelete()">删除</p>
		<p onclick="cancelHide()">取消</p>
	</div>
</div>
<script type="text/javascript">
var _id = 0;
function commDdelete(id){
	_id = id;
	$(".comment-popup").show()
} 
function cancelHide(){
	$(".comment-popup").hide();
}
function cancelDdelete(){
	layer.confirm('确定要删除吗？', {
        title: false,
        closeBtn : 0,
        btn: ['确定', '取消'], //按钮
        shade:0.001
    }, function(index) {
        layer.close(index);
		$(".comment-popup").hide();
		var index = layer.load();
		$.post('<?=links('ajax/comment_del')?>',{id:_id},function(res){
			layer.close(index);
			if(res.code == 1){
				layer.msg(res.msg);
				$('#comment-'+_id).remove();
			}else{
				layer.msg(res.msg,{shift:6});
			}
		},'json');
    }, function(index) {
        layer.close(index);
    });
}
isloading = false,page = 1;
$(window).bind("scroll", function () {
    if($(document).scrollTop() + $(window).height() 
          > $(document).height() - 10 && !isloading) {
    	page++;
        isloading = true;
    	var tindex = layer.load();
        $.get('<?=links('user/comment/index')?>/'+page,function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.comment.length; i++) {
					html+='<div class="comment-ulist betweenX" id="comment-'+res.data.comment[i].id+'"><div class="comment-head"><img src="'+res.data.comment[i].upic+'"></div><div class="comment-info"><div class="centerY betweenX comment-li1"><p class="comment-name">'+res.data.comment[i].nickname+'</p><div class="comment-more" onclick="commDdelete('+res.data.comment[i].id+')"><img class="" src="'+_tpldir_+'images/more.png"></div></div><div class="comment-cont">'+res.data.comment[i].text+'</div><div class="centerY betweenX comment-li2"><p class="comment-item">'+res.data.comment[i].addtime+'</p><div class="comment-like centerY"><img src="'+_tpldir_+'images/like.png"><span>'+res.data.comment[i].zan+'</span></div></div><a class="centerY comment-tv" href="'+res.data.comment[i].vlink+'"><img src="'+_tpldir_+'images/TV.png"><span>'+res.data.comment[i].vname+'</span></a>';
					if(res.data.comment[i].reply_num > 0){
						html+='<div class="comment-reply">';
						for (var i2 = 0; i2 < res.data.comment[i].reply.length; i2++) {
							html+='<div class="reply-list"><span>'+res.data.comment[i].reply[i2].nickname+'：</span><span>'+res.data.comment[i].reply[i2].text+'</span></div>';
						}
						if(res.data.comment[i].reply_num > 3) html+='<div class="centerXY reply-more"><span>查看共'+res.data.comment[i].reply_num+'条回复</span><img src="'+_tpldir_+'images/bottom.png" ></div>';
						html+='</div>';
					}
					html+='</div></div>';
                }
                $('.comment-li').append(html);
                if(res.data.page < res.data.pagejs) isloading = false;
            }
        },'json');
    }
});
</script>