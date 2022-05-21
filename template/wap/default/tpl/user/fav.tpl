<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">收藏记录</div>
	<div class="pageHead-right">
		<a href="javascript:;" class="functions">编辑</a>
	</div>
</div>
<div class="pageHead-fu">
	<p class="activefu" data-type="vod">影视</p>
	<p data-type="topic">专题</p>
</div>
<div style="height: 89px;"></div>
<div class="pageHead-tab collection">
	<form class="cache-form cachetab1">
		<ul class="videoul" id="more-vod">
		<?php
		foreach($fav as $row){
			echo '<li class="videoul-li"><a href="'.links('info',$row['vid']).'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="'.getpic($row['pic']).'"><p class="videoul-tips pone"><span class="pone videoul-tips1">'.$row['state'].'</span></p></div><p class="pone videoul-title">'.$row['name'].'</p></a><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs-v'.$row['vid'].'" value="'.$row['vid'].'"><label for="checkboxs-v'.$row['vid'].'"></label></div></li>';
		}
        if(empty($fav)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
		?>
		</ul>
	</form>
	<form class="cache-form cachetab2">
		<ul class="specialul" id="more-topic">
		<?php
		foreach($topic as $row){
			echo '<li class="specialli"><a href="'.links('topicinfo',$row['tid']).'" class="special-li"><img src="'.getpic($row['pic']).'" ><p>合集>>'.$row['name'].'</p></a><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs-s'.$row['tid'].'" value="'.$row['tid'].'"><label for="checkboxs-s'.$row['tid'].'" ></label></div></li>';
		}
        if(empty($topic)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
		?>
		</ul>
	</form>
</div>
<div class="editChoice-box" style="height: 40px;"></div>
<div class="editChoice-box editChoice">
	<div class="editChoice-cent">
		<a href="javascript:get_xuan();">全选/反选</a>
		<a href="javascript:get_del();">删除</a>
	</div>
</div>
<script type="text/javascript">
var type = 'vod';
var tarr = {
	vod:{isloading:false,page:1},
	topic:{isloading:false,page:1}
};
$(".pageHead-fu p").click(function(){
	type = $(this).data('type');
	$(this).addClass('activefu').siblings().removeClass('activefu');
	$('.pageHead-tab form').eq($(this).index()).show().siblings().hide()
});
$(".functions").click(function(){
	console.log()
	var text=$(this).text()
	if(text=='编辑'){
		$(this).text('取消')
		$(".cache-form-checkbox").show()
		$(".editChoice-box").show()
		
	}
	if(text=='取消'){
		$(this).text('编辑')
		$(".cache-form-checkbox").hide()
		$(".editChoice-box").hide()
	}
});
$(window).bind("scroll", function () {
    if($(document).scrollTop() + $(window).height() 
          > $(document).height() - 10 && !tarr[type].isloading) {
    	tarr[type].page++;
        tarr[type].isloading = true;
    	var tindex = layer.load();
        $.get('<?=links('user/fav')?>/'+type+'/'+tarr[type].page, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var html = '';
                var data = type == 'vod' ? res.data.fav : res.data.topic;
                for (var i = 0; i < data.length; i++) {
                	if(type == 'vod'){
                		html+='<li class="videoul-li"><a href="'+data[i].link+'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="'+data[i].pic+'"><p class="videoul-tips pone"><span class="pone videoul-tips1">'+data[i].state+'</span></p></div><p class="pone videoul-title">'+data[i].name+'</p></a><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs-v'+data[i].vid+'" value="'+data[i].vid+'"><label for="checkboxs-v'+data[i].vid+'"></label></div></li>';
                	}else{
                		html+='<li class="specialli"><a href="'+data[i].link+'" class="special-li"><img src="'+data[i].pic+'" ><p>合集>>'+data[i].name+'</p></a><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs-s'+data[i].tid+'" value="'+data[i].tid+'"><label for="checkboxs-s'+data[i].tid+'" ></label></div></li>';
                	}
                }
                $('#more-'+type).append(html);
                if(res.data.page < res.data.pagejs){
                	tarr[type].isloading = false;
                }else{
                	layer.msg('没有更多了~!');
                }
            }
        },'json');
    }
});
function get_xuan(){
    if(!$('#more-'+type+' input').is(':checked')){
        $('#more-'+type+' input').attr('checked',true);
    }else{
        $('#more-'+type+' input').attr('checked',false);
    }
}
function get_del(){
    var did = [];
    $('#more-'+type+' input:checked').each(function(){
        did.push($(this).val());
    });
    if(did.length == 0){
        layer.msg('请选择要删除的记录',{shift:6});
    }else{
        layer.confirm('不可恢复，确定吗？', {
            title: false,
            closeBtn : 0,
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            layer.close(index);
            var tindex = layer.load();
            $.post('/index.php/ajax/delfav',{ids:did.join(','),type:type},function(res){
                layer.close(tindex);
                if(res.code == 1){
                    layer.msg(res.msg);
                    setTimeout(function(){
                        window.location.reload();
                    },1000);
                }else{
                    layer.msg(res.msg,{shift:6});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    }
}
</script>